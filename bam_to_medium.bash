#!/bin/bash
#SBATCH -n 1 # Number of cores
#SBATCH -N 1 # Ensure that all cores are on one machine
#SBATCH -t 0-08:00 # Runtime in D-HH:MM
#SBATCH -p whipple # Partition to submit to
#SBATCH --mem=16G # Memory pool for all cores (see also --mem-per-cpu)
#SBATCH -o %x%j.out # File to which STDOUT will be written
#SBATCH -e %x%j.err # File to which STDERR will be written
#SBATCH --mail-type=ALL
#SBATCH --mail-user="danielloftus@g.harvard.edu"


module load samtools/1.5-fasrc02

for file in *bam; do 

samtools view -o ${file%bam}sam $file 

done 


for mysam in *sam; do 
#separate odds and evens 
awk '{if(NR%2==0) print $1, $3, $4, $5}' $mysam > evens_temp.txt
awk '{if(NR%2!=0) print $1, $3, $4, $5}' $mysam > odds_temp.txt

awk 'BEGIN{OFS="\t"} FNR==NR { a[FNR""] = $0; next } { print a[FNR""], $0 }' evens_temp.txt odds_temp.txt > combined_temp.txt 

awk 'BEGIN{OFS="\t"} {print $1, 0, "chr"$2, $3, 0, 0, "chr"$6, $7, 1, $4, $8}' combined_temp.txt > ${mysam%.sam}.medium.txt

sort -k3,3 -k4,4n ${mysam%.sam}.medium.txt > ${mysam%.sam}.medium.sorted.txt

rm evens_temp.txt
rm odds_temp.txt
rm combined_temp.txt 

done 