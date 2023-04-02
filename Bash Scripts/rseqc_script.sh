#!/bin/bash -l
#SBATCH --partition=angsd_class
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --job-name="rseqc"
#SBATCH --time=10:0:00 # HH/MM/SS
#SBATCH --mem=40G # memory requested, units available: K,M,G,T
#SBATCH --mail-user=yuc4017@med.cornell.edu
#SBATCH --mail-type=ALL
#SBATCH --requeue
#SBATCH --output=/home/yuc4017/slurm/slurm-%j.out


mamba activate rseqc

for SAMPLE in /athena/angsd/scratch/yuc4017/alignments/*.bam; do
  
  ID=`echo $SAMPLE | egrep -o 'SRR[0-9]*'`

	geneBody_coverage.py -i ${SAMPLE} -r /athena/angsd/scratch/yuc4017/hg38.nochr.bed -o /athena/angsd/scratch/yuc4017/rseqc/${ID}.rseqc_geneBody_coverage.out
	read_distribution.py -i ${SAMPLE} -r /athena/angsd/scratch/yuc4017/hg38.nochr.bed > /athena/angsd/scratch/yuc4017/rseqc/${ID}.rseqc_read_distribution.out

done
