#!/bin/bash
#SBATCH -n 16 # Number of cores
#SBATCH -N 1 # Ensure that all cores are on one machine
#SBATCH -t 0-05:00 # Runtime in D-HH:MM
#SBATCH -p whipple # Partition to submit to
#SBATCH --mem=32G # Memory pool for all cores (see also --mem-per-cpu)
#SBATCH -o %x%j.out # File to which STDOUT will be written
#SBATCH -e %x%j.err # File to which STDERR will be written
#SBATCH --mail-type=ALL
#SBATCH --mail-user="danielloftus@g.harvard.edu"

module load kallisto/0.45.1-fasrc01
module load parallel/20180522-fasrc01

echo MODULES LOADED
date 

index=/n/whipple_lab/Users/dloftus/genome_references_indices/kallisto_mm10/mm10_gencode_transcripts.idx
input_dir=/n/whipple_lab/Users/dloftus/mo_etal_2015_neuronal_subtypes_mouse_rnaseq_chipseq_atacseq_raw/rnaseq/
output_dir=/n/whipple_lab/Users/dloftus/mo_etal_2015_neuronal_subtypes_mouse_rnaseq_chipseq_atacseq_raw/rnaseq/kallisto/


parallel -j 1 kallisto quant --threads=16 --single -l 250 -s 50 -i $index -o ${output_dir}{} ${input_dir}{}_pass.fastq.gz ::: $(cat ${input_dir}SRR_Acc_List.txt)

echo COMPLETED
date 