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

out_dir=/n/whipple_lab/Users/dloftus/vcf_files/cast_129_split_by_chromosome_only_PASS

for chromosome in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 X Y; do

bcftools view -r $chromosome CAST_EiJ.mgp.v5.snps.dbSNP142.sorted.all_PASS.with_header.vcf.gz > ${out_dir}/CAST_EiJ.mgp.v5.snps.dbSNP142.sorted.all_PASS.with_header.chr${chromosome}.vcf

done 
