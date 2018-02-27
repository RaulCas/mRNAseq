#!/usr/bin/python

import commands, os, sys


# Set the PATH of the pipeline scripts
## Read infiles (fastq)
scripts_path='/rhome/rcastanera/bigdata/small_RNA_WT_2015/PIPELINE_v3.0/scripts/polyA'
infile1=sys.argv[1]
infile2=sys.argv[2]

# STEP1: submit the first job: FastQC

cmd1 = "sbatch -p short %s/fastqc.sh %s %s" % (scripts_path, infile1, infile2)
print "Submitting FastQC job with command: %s" % cmd1
status, jobnum = commands.getstatusoutput(cmd1)
if (status == 0 ):
    print "FastQC job is %s" % jobnum
else:
    print "Error submitting FastQC"

# STEP2: submit the second job: BBduk to filter adapters

cmd2 = "sbatch %s/trim_adapters_polyA.sh %s %s" % (scripts_path, infile1, infile2)
print "Submitting BBDuk job with command: %s" % cmd2
status,jobnum = commands.getstatusoutput(cmd2)
if (status == 0 ):
    print "BBDuk job is %s" % jobnum
else:
    print "Error submitting BBDuk"

newjobnum=str(jobnum).replace("Submitted batch job ", "")

# STEP3: Submit FastQC again to verify 

cmd3 = "sbatch -p short --depend=afterany:%s %s/fastqc.sh trimmed_reads_1.fq trimmed_reads_2.fq" % (newjobnum, scripts_path)
print "Submitting rep-FastQC with command: %s" % cmd3
status,jobnum = commands.getstatusoutput(cmd3)
if (status == 0 ):
    print "rep-FastQC job is %s" % jobnum
else:
    print "Error submitting rep-FastQC"

newjobnum=str(jobnum).replace("Submitted batch job ", "")


# STEP4: Map to PC15 Genome using STAR

cmd4 = "sbatch --depend=afterany:%s %s/STAR.sh trimmed_reads_1.fq trimmed_reads_2.fq" % (newjobnum, scripts_path)
print "Submitting STAR job with command: %s" % cmd4
status,jobnum = commands.getstatusoutput(cmd4)
if (status == 0 ):
    print "STAR job is %s" % jobnum
else:
    print "Error submitting STAR"







