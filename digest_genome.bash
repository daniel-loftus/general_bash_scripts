#!/bin/bash
#SBATCH -n 1 # Number of cores
#SBATCH -N 1 # Ensure that all cores are on one machine
#SBATCH -t 0-03:00 # Runtime in D-HH:MM
#SBATCH -p whipple # Partition to submit to
#SBATCH --mem=16G # Memory pool for all cores (see also --mem-per-cpu)
#SBATCH -o %x%j.out # File to which STDOUT will be written
#SBATCH -e %x%j.err # File to which STDERR will be written
#SBATCH --mail-type=ALL
#SBATCH --mail-user="danielloftus@g.harvard.edu"

export PATH=$PATH:/n/whipple_lab/Users/dloftus/software/HiC_Pro/installation/HiC-Pro_3.0.0/bin/utils

module load Anaconda3/2020.11

input_fasta=/n/whipple_lab/Users/dloftus/genome_references_indices/mm10_autosomes_N-masked_PASS_bedtools_maskfasta/no_chr_mm10_autosomes_N_masked_bedtools_maskfasta_ordered.fasta

/n/whipple_lab/Users/dloftus/software/HiC_Pro/installation/HiC-Pro_3.0.0/bin/utils/digest_genome.py \
-r ^GATC G^ANTC \
-o restriction_fragments_mm10_n-masked_autosomes.bed \
$input_fasta
