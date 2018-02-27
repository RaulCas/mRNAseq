#!/bin/sh
#SBATCH --nodes=1
#SBATCH --ntasks=12
#SBATCH --mem=12G
#SBATCH --time=6:00:00   
#SBATCH --job-name="RPKM"
 

module load samtools
module load bedtools

cd $SLURM_SUBMIT_DIR

python /rhome/rcastanera/bigdata/small_RNA_WT_2015/PIPELINE_v3.0/scripts/polyA/rpkmforgenes.py -i $1 -o results.out -readcount -sortpos -rmnameoverlap -limitcollapse -p 6


