#!/bin/bash
#SBATCH -n 1 # Number of cores
#SBATCH -N 1 # Ensure that all cores are on one machine
#SBATCH -t 0-01:00 # Runtime in D-HH:MM
#SBATCH -p serial_requeue # Partition to submit to
#SBATCH --mem=20000 # Memory pool for all cores (see also --mem-per-cpu)
#SBATCH -o out%j.out # File to which STDOUT will be written
#SBATCH -e error%j.err # File to which STDERR will be written
#SBATCH --mail-type=ALL
#SBATCH --mail-user="danielloftus@g.harvard.edu"


#this code takes two bedgraph files as inputs and outputs a single bedgraph file that is the average of the inputs 

bedgraphone="sorted.GSM828040_F1i_RNA_Seq_Cast.bed.bedgraph"
bedgraphtwo="sorted.GSM828041_F1r_RNA_Seq_129.bed.bedgraph"

module load bedtools2/2.26.0-fasrc01

bedtools unionbedg -i $bedgraphone $bedgraphtwo | awk '{sum=0; for (col=4; col<=NF; col++) sum += $col; print $0"\t"sum/(NF-4+1); }' | awk '{$4=$5=""; print $0}'
