#!/bin/bash -l
#SBATCH --partition=angsd_class
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --job-name="download-align"
#SBATCH --time=10:0:00 # HH/MM/SS
#SBATCH --mem=40G # memory requested, units available: K,M,G,T
#SBATCH --mail-user=yuc4017@med.cornell.edu
#SBATCH --mail-type=ALL
#SBATCH --requeue
#SBATCH --output=/home/yuc4017/slurm/slurm-%j.out

IFS=" "
SRR_IDS=$(cat SRR_accession_IDs.txt)
read -a SRR_IDS <<< $(cat SRR_accession_IDs.txt)

mamba activate angsd

for ID in "${SRR_IDS[@]}"; do
	echo "==================================="
	echo "Now downloading sample ${ID}"
	if [ ! -r  /athena/angsd/scratch/yuc4017/fastq/${ID}.fastq.gz ]; then
		url="ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR709/00${ID: -1}/${ID}/${ID}.fastq.gz"
		echo $url
		curl -L $url -o /athena/angsd/scratch/yuc4017/fastq/${ID}.fastq.gz
	fi
done

for file in /athena/angsd/scratch/yuc4017/fastq/*.fastq.gz; do
	echo "==================================="
	ID=`echo $file | egrep -o 'SRR[0-9]*'`
	echo "FastQC on ${ID}"
	if [ ! -r  /athena/angsd/scratch/yuc4017/fastqc/${ID}_fastqc.html ]; then
		fastqc -o /athena/angsd/scratch/yuc4017/fastqc/ "$file" --extract;
		echo  "/athena/angsd/scratch/yuc4017/fastqc/${ID}_fastqc.html"
	fi
	echo "==================================="
	echo "Alignment on ${ID}"
	if [ ! -r  /athena/angsd/scratch/yuc4017/alignments/${ID}.Log.final.out ]; then
                STAR --runMode alignReads \
			--runThreadN 1 \
			--genomeDir /athena/angsd/scratch/yuc4017/genome/index \
			--readFilesIn /athena/angsd/scratch/yuc4017/fastq/${ID}.fastq.gz \
			--readFilesCommand zcat \
 			--outFileNamePrefix /athena/angsd/scratch/yuc4017/alignments/${ID}. \
			--outSAMtype BAM SortedByCoordinate

		samtools index /athena/angsd/scratch/yuc4017/alignments/${ID}.Aligned.sortedByCoord.out.bam
                echo  "/athena/angsd/scratch/yuc4017/alignments/${ID}.Aligned.sortedByCoord.out.bam.bai"
        fi
done
