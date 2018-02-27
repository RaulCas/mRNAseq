#!/bin/bash -l

#SBATCH --nodes=1
#SBATCH --ntasks=12
#SBATCH --mem=12G 
#SBATCH --time=0-00:30:00
#SBATCH --output=FastQC_out.txt
#SBATCH --job-name="Fastqc"

module load fastqc

cd $SLURM_SUBMIT_DIR

fastqc $1

