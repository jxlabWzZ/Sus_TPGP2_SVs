#!/bin/bash
#SBATCH -J 1h_SV_manta
#SBATCH -N 1 -c 24
#SBATCH -e /home/sgtpyangb/wzz_STR_tmp/tmpSV2486/90.TGS/job-%j_%a.err
#SBATCH -o /home/sgtpyangb/wzz_STR_tmp/tmpSV2486/90.TGS/job-%j_%a.log
#SBATCH -p cu40
#SBATCH --mem=50Gb
#SBATCH -a 0-22 ###0-45

cd /home/sgtpyangb/wzz_STR_tmp/tmpSV2486/90.TGS

all=(`cat ont23.txt2 | cut -f 1`)
PBS_ARRAYID=${SLURM_ARRAY_TASK_ID}
sample=${all[$PBS_ARRAYID]}

dep=(`cat ont23.txt2 | cut -f 3`)
cov=${dep[$PBS_ARRAYID]}

singularity exec -B /home/sgtpyangb/AllFlash/wzz_tmp/30.T2T_DRC/01.DRC/01.SV/02.T2T_sus:/myref -B /home/sgtpyangb/wzz_STR_tmp/tmpSV2486/90.TGS:/home/sgtpyangb/wzz_STR_tmp/tmpSV2486/90.TGS /home/guilu/software/174.cute.sif cuteSV /home/sgtpyangb/wzz_STR_tmp/tmpSV2486/90.TGS/01_ONT/${sample}_*.bam /myref/sus11.fa csv_ont_${sample} /home/sgtpyangb/wzz_STR_tmp/tmpSV2486/90.TGS/cc_${sample} --genotype --max_cluster_bias_INS 100 \
 --diff_ratio_merging_INS 0.3 \
 --max_cluster_bias_DEL 100 \
 --diff_ratio_merging_DEL 0.3 \
 --min_support ${cov} \
 --min_size 50 \
 --threads 20


#singularity exec -B /home/qianzhupigs/AllFlash/wzz_tmp/30.T2T_DRC/01.DRC/01.SV/02.T2T_sus:/myref -B /home/qianzhupigs/AllFlash/wzz_tmp/30.T2T_DRC/01.DRC/01.SV/01.T2T_FaHap/02.TGS/sus:/myout -B /bak/wzz_1kpig/00.data/00.bamok:/bak/wzz_1kpig/00.data/00.bamok /home/qianzhupigs/AllFlash/wzz_tmp/00.bin/bin/sniffles_1.0.8--hd4ff3c4_0 sniffles -m /bak/wzz_1kpig/00.data/00.bamok/${sample}_*.bam -t 20 -s 6 -v /myout/raw0_${sample}_sv2.vcf


