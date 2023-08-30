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

module load Anaconda3/2020.11

export PATH=$PATH:/n/whipple_lab/Users/dloftus/software/HiC_Pro/installation/HiC-Pro_3.0.0/bin/utils

input_vcf=/n/whipple_lab/Users/dloftus/vcf_files/all_snps/mgp.v5.merged.snps_all.dbSNP142.all_PASS.vcf.gz

extract_snps.py \
-i $input_vcf \
-r 129S1_SvImJ \
-a CAST_EiJ \
> snps_129S1_SvImJ_CAST-EiJ.vcf 
