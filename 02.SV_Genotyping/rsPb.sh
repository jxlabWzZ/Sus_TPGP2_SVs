#!/bin/bash
#SBATCH -J 6h_manta
#SBATCH -N 1 -c 100
#SBATCH -e /home/qianzhupigs/AllFlash/wzz_tmp/30.T2T_DRC/01.DRC/01.SV/01.T2T_FaHap/02.TGS/sus/job-%j_%a.err
#SBATCH -o /home/qianzhupigs/AllFlash/wzz_tmp/30.T2T_DRC/01.DRC/01.SV/01.T2T_FaHap/02.TGS/sus/job-%j_%a.log
#SBATCH -p all
#SBATCH --mem=200Gb
#SBATCH -a 2

work_dir="/home/qianzhupigs/AllFlash/wzz_tmp/30.T2T_DRC/01.DRC/01.SV/01.T2T_FaHap/02.TGS/sus"
cd ${work_dir}
all=(`cat pb4.txt`)
PBS_ARRAYID=${SLURM_ARRAY_TASK_ID}
sample=${all[$PBS_ARRAYID]}
##sample="lc"

#sleep 120m

dir=/tmpdisk/${sample}_Pb
mkdir -p $dir
##ref=/home/qianzhupigs/AllFlash/wzz_tmp/30.T2T_DRC/01.DRC/01.SV/01.T2T_FaHap/00.ref/DRC.MotherHap.fa
ref=/home/qianzhupigs/AllFlash/wzz_tmp/30.T2T_DRC/01.DRC/01.SV/02.T2T_sus/sus11.fa
reads_pool=/home/qianzhupigs/AllFlash/wzz_tmp/30.T2T_DRC/01.DRC/01.SV/01.T2T_FaHap/02.TGS/sus/TGS/${sample}.fq.gz
cd $dir
ln -s ../$ref $reads_pool .
#Winnowmap=/home/guilu/software/dipcall.kit
#$Winnowmap/meryl count k=15 output merylDB $ref
#$Winnowmap/meryl print greater-than distinct=0.9998 merylDB > repetitive_k15.txt
#$Winnowmap/winnowmap --MD  -W repetitive_k15.txt  -ax map-pb-clr $ref $reads_pool  > DRCMale_Pb_all.sam
/home/jxlabgdp/01.Biosoft/bin/minimap2 -t 64 --MD -x map-pb -a $ref $reads_pool  > DRCMale_Pb_all.sam
samtools sort -@20 -m 2G -o DRCMale_Pb_sorted.bam DRCMale_Pb_all.sam
samtools index DRCMale_Pb_sorted.bam 
rm DRCMale_Pb_all.sam

singularity exec -B /tmpdisk/${sample}_Pb:/wzz_tmpok /home/qianzhupigs/AllFlash/wzz_tmp/00.bin/bin/sniffles2.sif sniffles --input /wzz_tmpok/DRCMale_Pb_sorted.bam -t 20 --vcf ssv_${sample}_Pb.vcf

cp /tmpdisk/${sample}_Pb/DRCMale_Pb_sorted.bam /home/qianzhupigs/AllFlash/wzz_tmp/30.T2T_DRC/01.DRC/01.SV/01.T2T_FaHap/02.TGS/sus/${sample}_Pb.bam
cp /tmpdisk/${sample}_Pb/DRCMale_Pb_sorted.bam.bai /home/qianzhupigs/AllFlash/wzz_tmp/30.T2T_DRC/01.DRC/01.SV/01.T2T_FaHap/02.TGS/sus/${sample}_Pb.bam.bai
cp /tmpdisk/${sample}_Pb/ssv_${sample}_Pb.vcf /home/qianzhupigs/AllFlash/wzz_tmp/30.T2T_DRC/01.DRC/01.SV/01.T2T_FaHap/02.TGS/sus/
cd ..
rm -rf /tmpdisk/${sample}_Pb/

#rm /home/qianzhupigs/AllFlash/wzz_tmp/30.T2T_DRC/01.DRC/01.SV/01.T2T_FaHap/02.TGS/sus/TGS/${sample}.fq.gz

#samtools view -F0x104 -h DRCMale_Pb_sorted.bam -@60   |samtools sort -@60  - >DRCMale_Pb_sorted_primary.bam
#samtools index -@20  DRCMale_Pb_sorted_primary.bam
#samtools view -h -@20 DRCMale_Pb_sorted_primary.bam  |/gxn/Mzhou2/1.Biosoft/k8-0.2.4/k8-Linux  /gxn/Mzhou2/1.Biosoft/minimap2/misc/paftools.js sam2paf -  >  DRCMale_Pb_sorted_primary.paf
#rm DRCMale_Pb_all.bam

#sed "s/DRC_ULPb/${sample}_Pb/g;s/DRCMale_ULPb_sorted/DRCMale_Pb_sorted/g" /home/qianzhupigs/AllFlash/wzz_tmp/30.T2T_DRC/01.DRC/01.SV/01.T2T_FaHap/02.TGS/b4.sh > bb_${sample}.sh
#cp /home/qianzhupigs/AllFlash/wzz_tmp/30.T2T_DRC/01.DRC/01.SV/01.T2T_FaHap/02.TGS/DRC_ULPb/ids.txt ./
#qsub bb_${sample}.sh




#singularity exec -B /home/qianzhupigs/AllFlash/wzz_tmp/30.T2T_DRC/01.DRC/01.SV/01.T2T_FaHap:/wzz_tmpok /home/guilu/software/174.cute.sif cuteSV /wzz_tmpok/02.TGS/${sample}_Pb/DRCMale_Pb_sorted.bam /wzz_tmpok/00.ref/DRC.MotherHap.fa csv_pb /wzz_tmpok/02.TGS/${sample}_Pb/ --genotype --max_cluster_bias_INS 100 \
# --diff_ratio_merging_INS 0.3 \
# --max_cluster_bias_DEL 200 \
# --diff_ratio_merging_DEL 0.5
#singularity exec -B /home/qianzhupigs/AllFlash/wzz_tmp/30.T2T_DRC/01.DRC/01.SV/02.T2T_sus:/myref -B /home/qianzhupigs/AllFlash/wzz_tmp/30.T2T_DRC/01.DRC/01.SV/01.T2T_FaHap:/wzz_tmpok -B /bak/wzz_1kpig/99.asm/01.DRCv20/03.TGS/02.refsus:/myvcf /home/qianzhupigs/AllFlash/wzz_tmp/00.bin/bin/sniffles2.sif sniffles --input /myvcf/${sample}_Pb/DRCMale_Pb_sorted.bam --reference /myref/sus11.fa --output-rnames -t 20 --vcf ssv_${sample}_Pb.vcf

#singularity exec -B /home/qianzhupigs/AllFlash/wzz_tmp/30.T2T_DRC/01.DRC/01.SV/02.T2T_sus:/myref -B /home/qianzhupigs/AllFlash/wzz_tmp/30.T2T_DRC/01.DRC/01.SV/01.T2T_FaHap:/wzz_tmpok -B /bak/wzz_1kpig/99.asm/01.DRCv20/03.TGS/02.refsus:/myvcf /home/qianzhupigs/AllFlash/wzz_tmp/00.bin/bin/irissv_1.0.5.sif iris\
#  genome_in=/myref/sus11.fa \
#  vcf_in=/wzz_tmpok/02.TGS/sus/${sample}_Pb/ssv_${sample}_Pb.vcf \
#  reads_in=/myvcf/${sample}_Pb/DRCMale_Pb_sorted.bam \
#  vcf_out=${sample}_ss_iris.vcf 



