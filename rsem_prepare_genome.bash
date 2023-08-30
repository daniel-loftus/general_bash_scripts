#!/bin/bash
#SBATCH -n 8 # Number of cores
#SBATCH -N 1 # Ensure that all cores are on one machine
#SBATCH -t 0-05:00 # Runtime in D-HH:MM
#SBATCH -p shared # Partition to submit to
#SBATCH --mem=8G # Memory pool for all cores (see also --mem-per-cpu)
#SBATCH -o output%j.out # File to which STDOUT will be written
#SBATCH -e error%j.err # File to which STDERR will be written
#SBATCH --mail-type=ALL
#SBATCH --mail-user="danielloftus@g.harvard.edu"

module load rsem/1.2.29-fasrc03

mygtf=/n/holylfs03/LABS/whipple_lab/Users/dloftus/genome_references_indices/gencode.vM24.annotation.gtf
mygenome=/n/holylfs03/LABS/whipple_lab/Users/dloftus/genome_references_indices/mm10_reference.fasta

rsem-prepare-reference --star -p 8 --gtf $mygtf $mygenome rsem_mm10/mm10_Gencode.vM24_rsem