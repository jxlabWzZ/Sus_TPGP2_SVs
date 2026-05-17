#!/bin/bash
#SBATCH -J 1h_SV_manta
#SBATCH -N 1 -c 30
#SBATCH -e /home/sgtpyangb/wzz_STR_tmp/tmpSV2486/90.TGS/job-%j_%a.err
#SBATCH -o /home/sgtpyangb/wzz_STR_tmp/tmpSV2486/90.TGS/job-%j_%a.log
#SBATCH -p all
#SBATCH --mem=70Gb
#SBATCH -a 9 ###0-45

cd /home/sgtpyangb/wzz_STR_tmp/tmpSV2486/90.TGS

all=(`cat ids_depth.txt | cut -f 1`)
dep=(`cat ids_depth.txt | cut -f 3`)

PBS_ARRAYID=${SLURM_ARRAY_TASK_ID}
sample=${all[$PBS_ARRAYID]}
cov=${dep[$PBS_ARRAYID]}
##cp /bak/wzz_1kpig/02.drcv20_bams/ONT/${sample}.fq.gz ./ 

## sniffles25
singularity exec -B /home/sgtpyangb/AllFlash/wzz_tmp/30.T2T_DRC/01.DRC/01.SV/02.T2T_sus:/myref -B /home/sgtpyangb/wzz_STR_tmp/tmpSV2486/90.TGS:/myout /home/qianzhupigs/AllFlash/wzz_tmp/00.bin/bin/sniffles25.sif sniffles --input /home/sgtpyangb/wzz_STR_tmp/tmpSV2486/90.TGS/0*/${sample}_*.bam --reference /myref/sus11.fa -t 30 --minsvlen 50 --combine-pctseq 0 --mapq 10 --min-alignment-length 500 --minsupport ${cov} --vcf /myout/ssv2_${sample}_sv2.vcf


## svim2.0
singularity exec -B /home/sgtpyangb/AllFlash/wzz_tmp/30.T2T_DRC/01.DRC/01.SV/02.T2T_sus:/myref -B /home/sgtpyangb/wzz_STR_tmp/tmpSV2486/90.TGS:/myout /home/sgtpyangb/AllFlash/wzz_tmp/00.bin/svim_2.0.sif svim alignment --min_sv_size 50 --minimum_depth ${cov} --max_sv_size 1000000 SVIM_${sample} /home/sgtpyangb/wzz_STR_tmp/tmpSV2486/90.TGS/0*/${sample}_*.bam /myref/sus11.fa


