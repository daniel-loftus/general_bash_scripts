#!/bin/bash
#SBATCH -n 1 # Number of cores
#SBATCH -N 1 # Ensure that all cores are on one machine
#SBATCH -t 0-01:00 # Runtime in D-HH:MM
#SBATCH -p whipple # Partition to submit to
#SBATCH --mem=32G # Memory pool for all cores (see also --mem-per-cpu)
#SBATCH -o output%j.out # File to which STDOUT will be written
#SBATCH -e error%j.err # File to which STDERR will be written
#SBATCH --mail-type=ALL
#SBATCH --mail-user="danielloftus@g.harvard.edu"

module load bedtools2/2.26.0-fasrc01

myvcf=/n/whipple_lab/Users/dloftus/vcf_files/CAST_EiJ.mgp.v5.snps.dbSNP142.sorted.all_PASS.with_header.vcf 
mybed=/n/whipple_lab/Users/dloftus/vcf_files/filtered_real_SNPs/chr_renamed.sorted.129CastTrack_mm10.bed


bedtools intersect -sorted -a $mybed -b $myvcf > 129_cast_snps_PASS.bed
