#!/bin/bash
#SBATCH -n 16 # Number of cores
#SBATCH -N 1 # Ensure that all cores are on one machine
#SBATCH -t 0-05:00 # Runtime in D-HH:MM
#SBATCH -p whipple # Partition to submit to
#SBATCH --mem=32G # Memory pool for all cores (see also --mem-per-cpu)
#SBATCH -o %x%j.out # File to which STDOUT will be written
#SBATCH -e %x%j.err # File to which STDERR will be written
#SBATCH --mail-type=ALL
#SBATCH --mail-user="danielloftus@g.harvard.edu"

module load rsem/1.2.29-fasrc03
#module load GCC/7.3.0-2.30 OpenMPI/3.1.1 STAR/2.7.1a

tissue=liver

index=/n/holylfs03/LABS/whipple_lab/Users/dloftus/genome_references_indices/star_rsem_mm10/mm10_Gencode.vM24_rsem
input=${tissue}_Aligned.toTranscriptome.out.bam


rsem-calculate-expression -p 16 --bam --paired-end $input $index ${tissue}_rsem