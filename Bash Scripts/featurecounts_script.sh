#!/bin/bash -l
#SBATCH --partition=angsd_class
#SBATCH --nodes=1#SBATCH --ntasks=1
#SBATCH --job-name="featurecounts"
#SBATCH --time=7:0:00 # HH/MM/SS
#SBATCH --mem=35G # memory requested, units available: K,M,G,T
#SBATCH --mail-user=yuc4017@med.cornell.edu
#SBATCH --mail-type=ALL
#SBATCH --requeue
#SBATCH --output=/home/yuc4017/slurm/slurm-%j.out

mamba activate angsd

featureCounts -M --minOverlap 1 -a /athena/angsd/scratch/yuc4017/genome/Homo_sapiens.GRCh38.109.gtf -o featureCounts.txt /athena/angsd/scratch/yuc4017/alignments/*.bam
