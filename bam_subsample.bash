#!/bin/bash
#SBATCH -n 1 # Number of cores
#SBATCH -N 1 # Ensure that all cores are on one machine
#SBATCH -t 0-08:00 # Runtime in D-HH:MM
#SBATCH -p whipple # Partition to submit to
#SBATCH --mem=16G # Memory pool for all cores (see also --mem-per-cpu)
#SBATCH -o %x%j.out # File to which STDOUT will be written
#SBATCH -e %x%j.err # File to which STDERR will be written
#SBATCH --mail-type=ALL
#SBATCH --mail-user="danielloftus@g.harvard.edu"


module load samtools/1.5-fasrc02

for file in *aternal.bam; do 

samtools view -b -s 0.1 -o ${file%bam}_subsample.bam $file 

done 


for file in *subsample.bam; do 

samtools sort $file > ${file%bam}sorted.bam

done 



for file in *subsample.sorted.bam; do 

samtools index $file 

done 
