#!/bin/bash
#SBATCH -n 1 # Number of cores
#SBATCH -N 1 # Ensure that all cores are on one machine
#SBATCH -t 0-12:00 # Runtime in D-HH:MM
#SBATCH -p whipple # Partition to submit to
#SBATCH --mem=32G # Memory pool for all cores (see also --mem-per-cpu)
#SBATCH -o %x%j.out # File to which STDOUT will be written
#SBATCH -e %x%j.err # File to which STDERR will be written
#SBATCH --mail-type=ALL
#SBATCH --mail-user="danielloftus@g.harvard.edu"

module load Anaconda3/2020.11

python allelic_read_prob.py > probs_range_20_151_reps_1000.txt 
