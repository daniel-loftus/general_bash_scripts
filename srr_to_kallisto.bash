#!/bin/bash
#SBATCH -n 16 # Number of cores
#SBATCH -N 1 # Ensure that all cores are on one machine
#SBATCH -t 1-00:00 # Runtime in D-HH:MM
#SBATCH -p shared # Partition to submit to
#SBATCH --mem=32G # Memory pool for all cores (see also --mem-per-cpu)
#SBATCH -o output%j.out # File to which STDOUT will be written
#SBATCH -e error%j.err # File to which STDERR will be written
#SBATCH --mail-type=ALL
#SBATCH --mail-user="danielloftus@g.harvard.edu"

#this script takes a text file of SRR accessions and downloads the fastq files, followed by transcript quantification through kallisto 

#download fastq from srr 
module load sratoolkit/2.8.0-fasrc01
module load parallel/20180522-fasrc01
module load kallisto/0.45.1-fasrc01

echo MODULES LOADED 
date

parallel -j 8 fastq-dump --skip-technical  --readids --read-filter pass --dumpbase --split-3 --clip --gzip ::: $(cat SRR_Acc_List.txt)

echo FASTQ DUMP COMPLETED 
date

index=/n/holylfs03/LABS/whipple_lab/Users/dloftus/genome_references_indices/kallisto_mm10/mm10_gencode_transcripts.idx
mkdir kallisto 

#quantify expression using kallisto 
parallel -j 8 kallisto quant --threads=16 --single -l 175 -s 25 -i $index -o kallisto/{} {}_pass.fastq.gz ::: $(cat SRR_Acc_List.txt)

echo COMPLETED
date 