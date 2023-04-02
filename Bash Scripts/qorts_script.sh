#!/bin/bash -l
#SBATCH --partition=angsd_class
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --job-name="qorts"
#SBATCH --time=24:0:00 # HH/MM/SS
#SBATCH --mem=40G # memory requested, units available: K,M,G,T
#SBATCH --mail-user=yuc4017@med.cornell.edu
#SBATCH --mail-type=ALL
#SBATCH --requeue
#SBATCH --output=/home/yuc4017/slurm/slurm-%j.out

mamba activate qorts

for SAMPLE in /athena/angsd/scratch/yuc4017/alignments/*.bam; do

	ID=`echo $SAMPLE | egrep -o 'SRR[0-9]*'`
	qorts -Xmx18G QC --singleEnded --stranded --generatePlots ${SAMPLE} /athena/angsd/scratch/yuc4017/genome/Homo_sapiens.GRCh38.109.gtf /athena/angsd/scratch/yuc4017/qorts/${ID}/

done
