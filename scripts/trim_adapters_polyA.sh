#!/bin/bash -l

#SBATCH --nodes=1
#SBATCH --ntasks=8
#SBATCH --mem=12G 
#SBATCH --time=0-01:00:00
#SBATCH --output=BBduk_out.txt
#SBATCH --job-name="BBduk"

module load BBMap

# k -------kmer size
# mink --- allow shorter kmer at the end of the read 
# tpe --- trim pair 1 and pair 2 to same lenght
# tbo --- trim adapters based on pair overlap detection (which does not require known adapter sequences)

cd $SLURM_SUBMIT_DIR

bbduk.sh in1=$1 in2=$2 out1=trimmed_reads_1.fq out2=trimmed_reads_2.fq ref=/opt/linux/centos/7.x/x86_64/pkgs/BBMap/37.76/resources/truseq.fa.gz,/opt/linux/centos/7.x/x86_64/pkgs/BBMap/37.76/resources/truseq_rna.fa.gz,/opt/linux/centos/7.x/x86_64/pkgs/BBMap/37.76/resources/nextera.fa.gz,/opt/linux/centos/7.x/x86_64/pkgs/BBMap/37.76/resources/sequencing_artifacts.fa.gz,/opt/linux/centos/7.x/x86_64/pkgs/BBMap/37.76/resources/phix_adapters.fa.gz ktrim=r k=23 mink=11 hdist=1 qtrim=r trimq=10 tpe tbo

