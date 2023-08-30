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

module load GCC/7.3.0-2.30 OpenMPI/3.1.1 BCFtools/1.9

bcftools view -f PASS -o mgp.v5.merged.snps_all.dbSNP142.all_PASS.vcf -O z mgp.v5.merged.snps_all.dbSNP142.vcf.gz  