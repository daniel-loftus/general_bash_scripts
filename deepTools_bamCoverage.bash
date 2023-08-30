#!/bin/bash
#SBATCH -n 16 # Number of cores
#SBATCH -N 1 # Ensure that all cores are on one machine
#SBATCH -t 0-04:00 # Runtime in D-HH:MM
#SBATCH -p whipple # Partition to submit to
#SBATCH --mem=8G # Memory pool for all cores (see also --mem-per-cpu)
#SBATCH -o %x%j.out # File to which STDOUT will be written
#SBATCH -e %x%j.err # File to which STDERR will be written
#SBATCH --mail-type=ALL
#SBATCH --mail-user="danielloftus@g.harvard.edu"

module load python/3.10.9-fasrc01

source activate py2023

for file in *sorted.bam; do 

bamCoverage -b $file -o ${file%.bam}.bw \
	--binSize 10 \
	--numberOfProcessors 16 \
	--ignoreDuplicates 
	
done 