#!/bin/bash
#SBATCH -n 16 # Number of cores
#SBATCH -N 1 # Ensure that all cores are on one machine
#SBATCH -t 1-00:00 # Runtime in D-HH:MM
#SBATCH -p whipple # Partition to submit to
#SBATCH --mem=32G # Memory pool for all cores (see also --mem-per-cpu)
#SBATCH -o %x%j.out # File to which STDOUT will be written
#SBATCH -e %x%j.err # File to which STDERR will be written
#SBATCH --mail-type=ALL
#SBATCH --mail-user="danielloftus@g.harvard.edu"

#this script takes a text file of SRR accessions and downloads the fastq files, followed by alignment to mm10 using STAR. Currently set for paired end. 

#download fastq from srr 
module load sratoolkit/2.8.0-fasrc01
module load parallel/20180522-fasrc01
module load GCC/7.3.0-2.30 OpenMPI/3.1.1 STAR/2.7.1a
module load fastqc/0.11.8-fasrc01

echo MODULES LOADED 
date

parallel -j 8 fastq-dump --skip-technical  --readids --read-filter pass --dumpbase --split-3 --clip --gzip ::: $(cat SRR_Acc_List.txt)

echo FASTQ DUMP COMPLETED 
date

parallel -j 8 fastqc --threads 8 {}_pass_*.fastq.gz ::: $(cat SRR_Acc_List.txt)

mkdir fastqc
mv *_fastqc* fastqc

echo FASTQC COMPLETED 



module load TrimGalore/0.5.0-fasrc01
module load Anaconda3/5.0.1-fasrc02 #trimgalore uses cutadapt, which is a conda installed python package
source activate py36 #activate the python environment to use cutadapt commands 

parallel -j 8 trim_galore --gzip --paired {}_pass_1.fastq.gz {}_pass_2.fastq.gz ::: $(cat SRR_Acc_List.txt) 

mkdir trim_galore_reports
mv *trimming_reports* trim_galore_reports

# #align reads using STAR 

genome=/n/whipple_lab/Users/dloftus/genome_references_indices/star_mm10_N-masked_129_cast

parallel -j 1 STAR \
--genomeDir $genome \
--runThreadN 16 \
--readFilesCommand zcat \
--readFilesIn {}_pass_1_val_1.fq.gz {}_pass_2_val_2.fq.gz \
--outFileNamePrefix {} \
--outSAMtype BAM SortedByCoordinate \
--alignIntronMax 1 \
--alignEndsType EndToEnd \
--outSAMattributes NH HI NM MD ::: $(cat SRR_Acc_List.txt)

echo COMPLETED
date 
module load samtools/1.5-fasrc02

#index bam files 
parallel -j 8 samtools index {}Aligned.sortedByCoord.out.bam {}Aligned.sortedByCoord.out.bam.bai ::: $(cat SRR_Acc_List.txt) 
