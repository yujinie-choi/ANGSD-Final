#!/bin/bash -l
#SBATCH --partition=angsd_class
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --job-name="multiqc"
#SBATCH --time=10:0:00 # HH/MM/SS
#SBATCH --mem=40G # memory requested, units available: K,M,G,T
#SBATCH --mail-user=yuc4017@med.cornell.edu
#SBATCH --mail-type=ALL
#SBATCH --requeue
#SBATCH --output=/home/yuc4017/slurm/slurm-%j.out

mamba activate multiqc

multiqc -o /athena/angsd/scratch/yuc4017/multiqc/all_qc/ /athena/angsd/scratch/yuc4017/
