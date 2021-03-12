#!/bin/bash
#SBATCH -n 1 # Number of cores
#SBATCH -N 1 # Ensure that all cores are on one machine
#SBATCH -t 0-05:00 # Runtime in D-HH:MM
#SBATCH -p whipple # Partition to submit to
#SBATCH --mem=32G # Memory pool for all cores (see also --mem-per-cpu)
#SBATCH -o output%j.out # File to which STDOUT will be written
#SBATCH -e error%j.err # File to which STDERR will be written
#SBATCH --mail-type=ALL
#SBATCH --mail-user="danielloftus@g.harvard.edu"

module load jdk/1.8.0_172-fasrc01

echo MODULE LOADED 
date 

#The gatk zip file only has to be downloaded once. The export step is required to use gatk tools after that. 

#wget https://github.com/broadinstitute/gatk/releases/download/4.1.3.0/gatk-4.1.3.0.zip
#unzip gatk-4.1.3.0.zip

gatkDir=/n/holylfs03/LABS/whipple_lab/Users/dloftus/software
export PATH=${gatkDir}/gatk-4.1.3.0:$PATH

vcfFile=/n/holylfs03/LABS/whipple_lab/Users/dloftus/vcf_files/CAST_EiJ.mgp.v5.snps.dbSNP142.vcf.gz
refFile=/n/holylfs03/LABS/whipple_lab/Users/dloftus/genome_references_indices/no_chr_mm10_reference.fasta

for file in *.sortedByCoord.out_addRG.bam; do 

gatk ASEReadCounter -I $file -V $vcfFile -R $refFile --output-format CSV -O ${file%.bam}_gatk_ASEReadCounter_results.csv

done 

echo FINISHED 
date
