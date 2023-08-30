#!/bin/bash
#SBATCH -n 1 # Number of cores
#SBATCH -N 1 # Ensure that all cores are on one machine
#SBATCH -t 2-00:00 # Runtime in D-HH:MM
#SBATCH -p shared # Partition to submit to
#SBATCH --mem=10000 # Memory pool for all cores (see also --mem-per-cpu)
#SBATCH -o output%j.out # File to which STDOUT will be written
#SBATCH -e error%j.err # File to which STDERR will be written
#SBATCH --mail-type=ALL
#SBATCH --mail-user="danielloftus@g.harvard.edu"

#srr="SRR5139830"

module load bowtie2/2.3.2-fasrc02

#bowtie2-build all_chr.N-masked.fa mm10_N-masked_index


bowtie2 --fast-local -x /n/holylfs03/LABS/whipple_lab/Users/dloftus/li_etal_2014_mesc_allelic_f123_chipseq_raw/mm10_index -1 "${srr}_pass_1.fastq" -2 "${srr}_pass_2.fastq" -S "${srr}.sam"

#module load samtools/1.5-fasrc02

#samtools view -bS "${srr}.sam" > "${srr}.bam"
#samtools sort "${srr}.bam" -o "${srr}.sorted.bam"
#samtools index "${srr}.sorted.bam" "${srr}.sorted.bam.bai"