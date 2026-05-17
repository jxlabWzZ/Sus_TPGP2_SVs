#!/bin/bash
#SBATCH -J 6h_manta
#SBATCH -N 1 -c 80
#SBATCH -e /home/sgtpyangb/wzz_STR_tmp/tmpSV2486/90.TGS/sus/job-%j_%a.err
#SBATCH -o /home/sgtpyangb/wzz_STR_tmp/tmpSV2486/90.TGS/job-%j_%a.log
#SBATCH -p cu40
#SBATCH --mem=200Gb
#SBATCH -a 0-5

work_dir="/home/sgtpyangb/wzz_STR_tmp/tmpSV2486/90.TGS"
cd ${work_dir}
all=(`cat ont6.txt`)
PBS_ARRAYID=${SLURM_ARRAY_TASK_ID}
sample=${all[$PBS_ARRAYID]}
##sample="lc"

#sleep 120m

dir=${sample}_ONT
mkdir -p $dir
##ref=/home/qianzhupigs/AllFlash/wzz_tmp/30.T2T_DRC/01.DRC/01.SV/01.T2T_FaHap/00.ref/DRC.MotherHap.fa
ref=/home/sgtpyangb/AllFlash/wzz_tmp/30.T2T_DRC/01.DRC/01.SV/02.T2T_sus/sus11.fa
reads_pool=/home/sgtpyangb/wzz_STR_tmp/tmpSV2486/90.TGS/${sample}.fq.gz
cd $dir
ln -s ../$ref $reads_pool .
#Winnowmap=/home/guilu/software/dipcall.kit
#$Winnowmap/meryl count k=15 output merylDB $ref
#$Winnowmap/meryl print greater-than distinct=0.9998 merylDB > repetitive_k15.txt
#$Winnowmap/winnowmap --MD  -W repetitive_k15.txt  -ax map-ont $ref $reads_pool  > DRCMale_ONT_all.sam

/home/jxlabgdp/01.Biosoft/bin/minimap2 -t 64 --MD -x map-ont -a $ref $reads_pool  > DRCMale_ONT_all.sam

samtools sort -@20 -m 2G -o ${sample}_ONT_sorted.bam DRCMale_ONT_all.sam
samtools index ${sample}_ONT_sorted.bam 
rm DRCMale_ONT_all.sam

#singularity exec -B /home/sgtpyangb/wzz_STR_tmp/tmpSV2486/90.TGS/${sample}_ONT:/wzz_tmpok /home/sgtpyangb/AllFlash/wzz_tmp/00.bin/bin/sniffles25.sif sniffles --input /wzz_tmpok/${sample}_ONT_sorted.bam -t 20 --vcf ssv_${sample}_ONT.vcf

