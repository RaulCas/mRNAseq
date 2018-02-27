#!/bin/bash -l

#SBATCH --nodes=1
#SBATCH --ntasks=12
#SBATCH --mem=12G 
#SBATCH --time=0-06:00:00
#SBATCH --output=STAR.out
#SBATCH --job-name=STAR

module load STAR

cd $SLURM_SUBMIT_DIR


STAR --genomeDir /bigdata/castaneralab/rcastanera/small_RNA_WT_2015/PIPELINE_v3.0/databases/STAR --runThreadN 12 --outReadsUnmapped Fastx --outFilterMismatchNoverLmax 0.04 --outFilterMultimapNmax 1 --outSAMtype BAM SortedByCoordinate --readFilesIn $1 $2

