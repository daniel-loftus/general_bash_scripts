#!/bin/bash
#SBATCH -n 1 # Number of cores
#SBATCH -N 1 # Ensure that all cores are on one machine
#SBATCH -t 0-04:00 # Runtime in D-HH:MM
#SBATCH -p whipple # Partition to submit to
#SBATCH --mem=16G # Memory pool for all cores (see also --mem-per-cpu)
#SBATCH -o %x_%j.out # File to which STDOUT will be written
#SBATCH -e %x_%j.err # File to which STDERR will be written
#SBATCH --mail-type=ALL
#SBATCH --mail-user="danielloftus@g.harvard.edu"

module load macs2/2.1.1.20160309-fasrc02

macs2 callpeak \
--treatment SRR7685829_N-masked_Aligned.sortedByCoord.out.bam \
--name SRR7685829_N-masked
--outdir /n/holylfs03/LABS/whipple_lab/Users/dloftus/allelic_counts_test_expt_comp2/N-masked/macs2_test
--format BAM
--gsize mm
--tsize 151 
--broad 
