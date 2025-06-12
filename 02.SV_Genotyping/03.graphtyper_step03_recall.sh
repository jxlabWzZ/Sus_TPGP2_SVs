#!/bin/bash
#SBATCH -J 1h_manta
#SBATCH -N 1 -c 24
#SBATCH -e /home/jxlabgdp/AllFlash/wzz_tmp/99.qianzhu/sus_tmp/14.manta/04.recall_dipcall/job-%j_%a.err
#SBATCH -o /home/jxlabgdp/AllFlash/wzz_tmp/99.qianzhu/sus_tmp/14.manta/04.recall_dipcall/job-%j_%a.log
#SBATCH -p cpcu
#SBATCH --mem=30Gb
#SBATCH -a 0-255

cd /home/jxlabgdp/AllFlash/wzz_tmp/99.qianzhu/sus_tmp/14.manta/04.recall_dipcall

all=(`cat id.txt`)
PBS_ARRAYID=${SLURM_ARRAY_TASK_ID}
id=${all[$PBS_ARRAYID]}
export TMPDIR=/home/jxlabgdp/AllFlash/wzz_tmp/99.qianzhu/sus_tmp/14.manta/04.recall_dipcall/log
/home/jxlabgdp/01.Biosoft/bin/graphtyper genotype_sv /home/jxlabgdp/AllFlash/wzz_tmp/11.SV/14.manta/3.recall/10.ref/susScr11.fa merge_manta_dipcall.ok.vcf.gz --sams=bamlist.txt --region=${id} --threads=24 --output=sv_${id} --verbose --max_files_open=128

