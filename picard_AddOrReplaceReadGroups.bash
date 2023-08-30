#!/bin/bash
#SBATCH -n 1 # Number of cores
#SBATCH -N 1 # Ensure that all cores are on one machine
#SBATCH -t 0-01:00 # Runtime in D-HH:MM
#SBATCH -p whipple # Partition to submit to
#SBATCH --mem=4G # Memory pool for all cores (see also --mem-per-cpu)
#SBATCH -o %x%j.out # File to which STDOUT will be written
#SBATCH -e %x%j.err # File to which STDERR will be written
#SBATCH --mail-type=ALL
#SBATCH --mail-user="danielloftus@g.harvard.edu"

module load jdk/1.8.0_172-fasrc01

gatkDir=/n/whipple_lab/Users/dloftus/software
export PATH=${gatkDir}/gatk-4.1.3.0:$PATH

echo PACKAGE LOADED 

rm gatk_readgroup_added
mkdir gatk_readgroup_added 

for bam in *.sortedByCoord.out.bam; do

gatk AddOrReplaceReadGroups \
    -INPUT ${bam} \
    -OUTPUT gatk_readgroup_added/${bam%.bam}_addRG.bam \
    -RGID H0164.2 \
    -RGLB library1 \
    -RGPL illumina \
    -RGPU H0164ALXX140820.2 \
    -RGSM sample1 \
	
done 
