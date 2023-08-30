#!/bin/bash
#SBATCH -n 1 # Number of cores
#SBATCH -N 1 # Ensure that all cores are on one machine
#SBATCH -t 0-00:15 # Runtime in D-HH:MM
#SBATCH -p whipple # Partition to submit to
#SBATCH --mem=1000 # Memory pool for all cores (see also --mem-per-cpu)
#SBATCH -o output%j.out # File to which STDOUT will be written
#SBATCH -e error%j.err # File to which STDERR will be written
#SBATCH --mail-type=ALL
#SBATCH --mail-user="danielloftus@g.harvard.edu"

tabixDir=/n/whipple_lab/Users/dloftus/software

export PATH=${tabixDir}/tabix-master:$PATH

module load samtools/1.5-fasrc02

for file in CAST_EiJ.mgp.v5.snps.dbSNP142.sorted.no_PASS.with_header.vcf ; do 

bgzip -c $file > ${file}.gz
tabix -f -p vcf ${file}.gz > ${file}.gz.tbi

done 

