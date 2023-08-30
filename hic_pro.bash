#!/bin/bash
#SBATCH -n 32 # Number of cores
#SBATCH -N 1 # Ensure that all cores are on one machine
#SBATCH -t 0-03:00 # Runtime in D-HH:MM
#SBATCH -p whipple # Partition to submit to
#SBATCH --mem=16G # Memory pool for all cores (see also --mem-per-cpu)
#SBATCH -o %x%j.out # File to which STDOUT will be written
#SBATCH -e %x%j.err # File to which STDERR will be written
#SBATCH --mail-type=ALL
#SBATCH --mail-user="danielloftus@g.harvard.edu"

export PATH=$PATH:/n/whipple_lab/Users/dloftus/software/HiC_Pro/installation/HiC-Pro_3.0.0/bin

input_folder=/n/whipple_lab/Users/dloftus/capture_hic/results_run1/hic_pro/rawdata
output_folder=/n/whipple_lab/Users/dloftus/capture_hic/results_run1/hic_pro/results
config_file=/n/whipple_lab/Users/dloftus/capture_hic/results_run1/hic_pro/config-hicpro.txt

HiC-Pro -i $input_folder -o $output_folder -c $config_file -p 32