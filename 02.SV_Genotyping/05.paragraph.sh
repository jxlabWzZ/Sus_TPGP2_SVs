#!/bin/bash
#SBATCH -J hipSTR_18
#SBATCH -N 1 -n 6
#SBATCH --exclude=node27
#SBATCH -e /home/qianzhupigs/AllFlash/wzz_tmp/20.GuiLu_SV/11.47TGS_SV/00.paragraph/job-%j_%a.err
#SBATCH -o /home/qianzhupigs/AllFlash/wzz_tmp/20.GuiLu_SV/11.47TGS_SV/00.paragraph/job-%j_%a.log
#SBATCH -p cu36
#SBATCH --mem=15Gb
#SBATCH -a 1-62 ### 1-18

cd /home/qianzhupigs/AllFlash/wzz_tmp/20.GuiLu_SV/11.47TGS_SV/00.paragraph

n=${SLURM_ARRAY_TASK_ID}
id="aaaa"

mkdir /home/qianzhupigs/AllFlash/wzz_tmp/20.GuiLu_SV/11.47TGS_SV/00.paragraph/log_${id}_${n}/
export TMP=/home/qianzhupigs/AllFlash/wzz_tmp/20.GuiLu_SV/11.47TGS_SV/00.paragraph/log_${id}_${n}/

singularity exec -B /home/qianzhupigs/AllFlash/wzz_tmp/20.GuiLu_SV/11.47TGS_SV/00.paragraph:/mypwd -B /home/jxlabgdp/AllFlash/wzz_tmp/11.SV/14.manta/3.recall/10.ref:/home/jxlabgdp/AllFlash/wzz_tmp/11.SV/14.manta/3.recall/10.ref /home/qianzhupigs/AllFlash/wzz_tmp/00.bin/bin/paragraph_2.3.sif multigrmpy.py -i /mypwd/03.vcf/cc${n}.vcf -m /mypwd/02.samples/${id}.txt -r /home/jxlabgdp/AllFlash/wzz_tmp/11.SV/14.manta/3.recall/10.ref/susScr11.fa -o out_${id}_${n} -M bbbb --scratch-dir /mypwd/log_${id}_${n}

rm -rf /home/qianzhupigs/AllFlash/wzz_tmp/20.GuiLu_SV/11.47TGS_SV/00.paragraph/log_${id}_${n}

mv /home/qianzhupigs/AllFlash/wzz_tmp/20.GuiLu_SV/11.47TGS_SV/00.paragraph/out_${id}_${n} /home/qianzhupigs/AllFlash/wzz_tmp/20.GuiLu_SV/11.47TGS_SV/00.paragraph/04ok.output/${id}/

