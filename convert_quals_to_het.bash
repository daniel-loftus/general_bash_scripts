#!/bin/bash
#SBATCH -n 1 # Number of cores
#SBATCH -N 1 # Ensure that all cores are on one machine
#SBATCH -t 0-03:00 # Runtime in D-HH:MM
#SBATCH -p whipple # Partition to submit to
#SBATCH --mem=10000 # Memory pool for all cores (see also --mem-per-cpu)
#SBATCH -o %x%j.out # File to which STDOUT will be written
#SBATCH -e %x%j.err # File to which STDERR will be written
#SBATCH --mail-type=ALL
#SBATCH --mail-user="danielloftus@g.harvard.edu"

awk 'BEGIN{OFS="\t"} {print $1, $2, $3, $4, $5, $6, $7="Het", $8, $9, $10}' CAST_EiJ.mgp.v5.snps.dbSNP142.sorted.all_PASS.vcf > CAST_EiJ.mgp.v5.snps.dbSNP142.sorted.all_PASS.qual_to_het.no_header.vcf

cat vcf_header.txt CAST_EiJ.mgp.v5.snps.dbSNP142.sorted.all_PASS.qual_to_het.no_header.vcf > CAST_EiJ.mgp.v5.snps.dbSNP142.sorted.all_PASS.qual_to_het.vcf
