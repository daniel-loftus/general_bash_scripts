#!/bin/bash
#SBATCH -n 1 # Number of cores
#SBATCH -N 1 # Ensure that all cores are on one machine
#SBATCH -t 0-01:00 # Runtime in D-HH:MM
#SBATCH -p whipple # Partition to submit to
#SBATCH --mem=4G # Memory pool for all cores (see also --mem-per-cpu)
#SBATCH -o %x%j.out # File to which STDOUT will be written
#SBATCH -e %x%j.err # File to which STDERR will be written
#SBATCH --mail-type=ALL
#SBATCH --mail-user="danielloftus@g.harvard.edu"


module load Java/1.8

input_bam_picard=/n/whipple_lab/Users/dloftus/capture_hic/results_run1/hicup/WASP/alignment_output/bam_to_fastq_for_wasp_single_end/single_end_realignment/find_intersecting_snps_output_PASS_ONLY/realignment_output/reads_to_keep_bams/C1_S1_R1_2_001.hicup.good_to_keep.merged.filtered.sorted_by_name.bam
output_fastq=/n/whipple_lab/Users/dloftus/capture_hic/results_run1/hicup/WASP/alignment_output/bam_to_fastq_for_wasp_single_end/single_end_realignment/find_intersecting_snps_output_PASS_ONLY/realignment_output/reads_to_keep_bams/n_masked_alignment/C1_S1_R1_2_001.hicup.good_to_keep.merged.filtered.sorted_by_name.picard.fastq

java -jar /n/whipple_lab/Users/dloftus/software/picard/picard.jar SamToFastq \
--INPUT $input_bam_picard \
--FASTQ $output_fastq

