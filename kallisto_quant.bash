#!/bin/bash
#SBATCH -n 1 # Number of cores
#SBATCH -N 1 # Ensure that all cores are on one machine
#SBATCH -t 0-05:00 # Runtime in D-HH:MM
#SBATCH -p shared # Partition to submit to
#SBATCH --mem=10000 # Memory pool for all cores (see also --mem-per-cpu)
#SBATCH -o output%j.out # File to which STDOUT will be written
#SBATCH -e error%j.err # File to which STDERR will be written
#SBATCH --mail-type=ALL
#SBATCH --mail-user="danielloftus@g.harvard.edu"

module load kallisto/0.45.1-fasrc01

index=/n/holylfs03/LABS/whipple_lab/Users/dloftus/genome_references_indices/kallisto/mm10_transcripts.idx

kallisto quant -i $index -o kallisto_output SRR5273634_pass_1.fastq.gz SRR5273634_pass_2.fastq.gz
