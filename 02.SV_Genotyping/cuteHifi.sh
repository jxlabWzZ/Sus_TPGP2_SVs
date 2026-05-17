#!/bin/bash
#SBATCH -J 1h_SV_manta
#SBATCH -N 1 -c 24
#SBATCH -e /home/qianzhupigs/AllFlash/wzz_tmp/30.T2T_DRC/01.DRC/01.SV/01.T2T_FaHap/02.TGS/sus/job-%j_%a.err
#SBATCH -o /home/qianzhupigs/AllFlash/wzz_tmp/30.T2T_DRC/01.DRC/01.SV/01.T2T_FaHap/02.TGS/sus/job-%j_%a.log
#SBATCH -p cpcu
#SBATCH --mem=50Gb
#SBATCH -a 0-9 ###0-45

cd /home/qianzhupigs/AllFlash/wzz_tmp/30.T2T_DRC/01.DRC/01.SV/01.T2T_FaHap/02.TGS/sus

all=(`cat Hifi.txt`)
PBS_ARRAYID=${SLURM_ARRAY_TASK_ID}
sample=${all[$PBS_ARRAYID]}

singularity exec -B /home/qianzhupigs/AllFlash/wzz_tmp/30.T2T_DRC/01.DRC/01.SV/02.T2T_sus:/myref -B /home/qianzhupigs/AllFlash/wzz_tmp/30.T2T_DRC/01.DRC/01.SV/01.T2T_FaHap/02.TGS/sus:/myout -B /bak/wzz_1kpig/00.data/00.bamok:/bak/wzz_1kpig/00.data/00.bamok /home/guilu/software/174.cute.sif cuteSV /bak/wzz_1kpig/00.data/00.bamok/${sample}_Hifi.bam /myref/sus11.fa csv_hifi_${sample} /myout/cc_${sample} --genotype --max_cluster_bias_INS 1000 \
 --diff_ratio_merging_INS 0.9 \
 --max_cluster_bias_DEL 1000 \
 --diff_ratio_merging_DEL 0.5 \
 --min_support 5 \
 --min_size 50 \
 --threads 20


#singularity exec -B /home/qianzhupigs/AllFlash/wzz_tmp/30.T2T_DRC/01.DRC/01.SV/02.T2T_sus:/myref -B /home/qianzhupigs/AllFlash/wzz_tmp/30.T2T_DRC/01.DRC/01.SV/01.T2T_FaHap/02.TGS/sus:/myout -B /bak/wzz_1kpig/00.data/00.bamok:/bak/wzz_1kpig/00.data/00.bamok /home/qianzhupigs/AllFlash/wzz_tmp/00.bin/bin/sniffles_1.0.8--hd4ff3c4_0 sniffles -m /bak/wzz_1kpig/00.data/00.bamok/${sample}_*.bam -t 20 -s 6 -v /myout/raw0_${sample}_sv2.vcf


