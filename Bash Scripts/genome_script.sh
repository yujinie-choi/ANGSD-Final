#!/bin/bash -l
#SBATCH --partition=angsd_class
#SBATCH --nodes=1#SBATCH --ntasks=1
#SBATCH --job-name="genome_index"
#SBATCH --time=10:0:00 # HH/MM/SS
#SBATCH --mem=40G # memory requested, units available: K,M,G,T
#SBATCH --mail-user=yuc4017@med.cornell.edu
#SBATCH --mail-type=ALL
#SBATCH --requeue

mamba activate angsd

STAR --runMode genomeGenerate --runThreadN 1 \
	--genomeDir /athena/angsd/scratch/yuc4017/genome/index \
	--genomeFastaFiles /athena/angsd/scratch/yuc4017/genome/Homo_sapiens.GRCh38.dna_sm.primary_assembly.fa \
	--sjdbGTFfile /athena/angsd/scratch/yuc4017/genome/Homo_sapiens.GRCh38.109.gtf \
	--sjdbOverhang 74 
