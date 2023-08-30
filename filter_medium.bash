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


module load jdk/10.0.1-fasrc01 

PATH=$PATH:/n/whipple_lab/Users/dloftus/software/juicer/juicer-master/SLURM/scripts



for file in *medium.sorted.txt; do

awk '{ if($3=="chr15" && $4>71850000 && $4<73350000 && $7=="chr15" && $8>71850000 && $8<73350000) print}' $file > ${file%.txt}.locus.txt

juicer_tools pre -d ${file%.txt}.locus.txt ${file%.txt}.locus.hic mm10

done 

