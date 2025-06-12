#!/bin/bash
#SBATCH -J 1h_SV_manta
#SBATCH -N 1 -c 2
#SBATCH -e /home/qianzhupigs/AllFlash/wzz_tmp/20.GuiLu_SV/20.merge2383SV/01.del/job-%j_%a.err
#SBATCH -o /home/qianzhupigs/AllFlash/wzz_tmp/20.GuiLu_SV/20.merge2383SV/01.del/job-%j_%a.log
#SBATCH -p cu40
#SBATCH --mem=2Gb

cd /home/qianzhupigs/AllFlash/wzz_tmp/20.GuiLu_SV/20.merge2383SV/01.del
singularity exec /home/guilu/software/087.vcftools.sif vcftools --vcf ${1}.vcf --extract-FORMAT-info GT --out gt

for i in {3..2385}
do
b=`cut -f ${i} gt.GT.FORMAT | sed -n '2,$p' | grep -v -E "0/0|\." | wc -l`
echo -e $i"\t"$b >> bbb.txt
done
