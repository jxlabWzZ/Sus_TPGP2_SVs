#!/bin/bash
#SBATCH -J 3h_1Mb
#SBATCH --nodelist=copy-node02 -c 24
#SBATCH -e /home/qianzhupigs/AllFlash/wzz_tmp/99.qianzhu/12.SNP/02.graphtyper/log/job-%j_%a.err
#SBATCH -o /home/qianzhupigs/AllFlash/wzz_tmp/99.qianzhu/12.SNP/02.graphtyper/log/job-%j_%a.log
#SBATCH -p batch
#SBATCH --mem=40Gb
#SBATCH -a 0-255

cd /home/qianzhupigs/AllFlash/wzz_tmp/99.qianzhu/12.SNP/02.graphtyper/tmp

all=(`cat id1mb.txt`)
PBS_ARRAYID=${SLURM_ARRAY_TASK_ID}
id=${all[$PBS_ARRAYID]}
### prepare for GT
# echo ref.fa.fai | sed 's/:/\t/g;s/-/\t/g' | awk '{print $1"\t"$2"\t"$3+1}'> g.txt
# /home/jxlabgdp/01.Biosoft/bin/bedtools makewindows -w 1000000 -s 1000000 -b g.txt | awk '{print $1":"$2"-"$3-1}' > id1mb.txt
### graphtyper2
export TMPDIR=/home/qianzhupigs/AllFlash/wzz_tmp/99.qianzhu/12.SNP/02.graphtyper/log
/home/jxlabgdp/01.Biosoft/bin/graphtyper genotype /home/jxlabgdp/AllFlash/wzz_tmp/11.SV/14.manta/3.recall/10.ref/susScr11.fa --sams=bam2386list.txt --region=${id} --threads=24 --output=snp_${id} --verbose --max_files_open=128


