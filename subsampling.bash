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

module load Anaconda3/5.1.0

source activate py36

#D4-2 rep1
for file in D4-2_rep1_maternal.medium.sorted.cast_del_removed.peg13_locus.txt; do 

python subsampling.py -m $file \
-s 0.968195368 \
-o ${file%.txt}.subsampled.txt

done 


#D4-2 rep2
for file in D4-2_rep2_maternal.medium.sorted.cast_del_removed.peg13_locus.txt; do 

python subsampling.py -m $file \
-s 0.97115477 \
-o ${file%.txt}.subsampled.txt

done 

#DEL1 42.4
for file in DMR_DEL1_42-4_maternal.medium.sorted.cast_del_removed.peg13_locus.txt; do 

python subsampling.py -m $file \
-s 0.96162532 \
-o ${file%.txt}.subsampled.txt

done 


#DEL2 42.10
for file in DMR_DEL2_42-10_maternal.medium.sorted.cast_del_removed.peg13_locus.txt; do 

python subsampling.py -m $file \
-s 0.948797066 \
-o ${file%.txt}.subsampled.txt

done 





#Juicer pre

module load jdk/10.0.1-fasrc01 

PATH=$PATH:/n/whipple_lab/Users/dloftus/software/juicer/juicer-master/SLURM/scripts


for file in *subsampled.txt; do 

juicer_tools pre -d $file ${file%txt}hic mm10

done 