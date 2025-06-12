#!/bin/bash
#SBATCH -J fastGWA
#SBATCH -N 1 -n 10
#SBATCH --mem=20Gb
#SBATCH -e /home/qianzhupigs/AllFlash/wzz_tmp/20.GuiLu_SV/20.merge2383SV/30.eQTL/01.liver/all/log/job-%j_%a.err
#SBATCH -o /home/qianzhupigs/AllFlash/wzz_tmp/20.GuiLu_SV/20.merge2383SV/30.eQTL/01.liver/all/log/job-%j_%a.log
#SBATCH -p cu36
#SBATCH -a 0-999

PBS_ARRAYID=${SLURM_ARRAY_TASK_ID}
array_jobid=${SLURM_ARRAY_JOB_ID}
jobid=${SLURM_JOB_ID}
job_name=${SLURM_JOB_NAME}
workdir=${SLURM_SUBMIT_DIR}
pid=${SLURM_TASK_PID}
#nprocs=${SLURM_JOB_CPUS_PER_NODE}
nproc=120

uid="wzz02"
ls_date=`date +m%d%H%M%S`
temp=/tmpdisk/${uid}_${ls_date}_${PBS_ARRAYID}
mkdir ${temp}
cd ${temp}

OUTPUT=/home/qianzhupigs/AllFlash/wzz_tmp/20.GuiLu_SV/20.merge2383SV/30.eQTL/01.liver/all/ok01
INPUT=/home/qianzhupigs/AllFlash/wzz_tmp/20.GuiLu_SV/20.merge2383SV/30.eQTL/01.liver/all
#############working directory setting###########
###############################################################

#####################################Script#########################
#####           Scripts           ##################################
####################################################################
n=$1
PheNum=$((PBS_ARRAYID+n))
#1.extra phenotype
cat ${INPUT}/t9.pheotype.txt |tr " " "\t" |cut -f 1,2,$((PheNum+5)) >Phe$PheNum.txt
#2.fastaGWAS
#gcta64 --bfile ${INPUT}/F2_SV  --grm-sparse $INPUT/sp_grm --fastGWA-mlm --pheno Phe$PheNum.txt --covar $INPUT/bbcov.txt --qcovar $INPUT/qqcov.txt --thread-num 10 --out Phe$PheNum
gcta64 --mbfile ${INPUT}/ids_cc.txt  --grm-sparse $INPUT/sp_grm --fastGWA-mlm --pheno Phe$PheNum.txt --covar $INPUT/bbcov.txt --qcovar $INPUT/qqcov.txt --thread-num 10 --out Phe$PheNum
#3.extra -logPvalue great 6 
h=`sed -n "${PheNum},${PheNum}p" ${INPUT}/t8.phe.txt | cut -f 1`
s=`sed -n "${PheNum},${PheNum}p" ${INPUT}/t8.phe.txt | cut -f 2`
e=`sed -n "${PheNum},${PheNum}p" ${INPUT}/t8.phe.txt | cut -f 3`

awk -v h=$h -v s=$s -v e=$e '{if((-log($NF)/log(10))>=6 && $1==h && $3>s-1000000 && $3<e+1000000 ) print $0}' Phe$PheNum.fastGWA | grep -v "nan" >Phe$PheNum.great6.fastGWA
sort -gk 10 -S 20% --parallel=10 Phe$PheNum.great6.fastGWA |pigz -p 20 -k - >Phe$PheNum.great6.assoc.txt.gz
mv Phe$PheNum.log Phe$PheNum.her.log
cp Phe$PheNum.great6.assoc.txt.gz Phe$PheNum.her.log ${OUTPUT}

awk '{if($10<=1/1000000) print $0}' Phe$PheNum.fastGWA | grep -v "nan" | grep -E "DEL|INS|INV|DUP" > Phe$PheNum.great8.fastGWA
sort -gk 10 -S 20% --parallel=10 Phe$PheNum.great8.fastGWA |pigz -p 20 -k - > Phe$PheNum.great8.assoc.txt.gz
cp Phe$PheNum.great8.assoc.txt.gz ${INPUT}/ok02/Phe$PheNum.great8.assoc.txt.gz
######REMOVE tmp directory #################################
rm -rf ${temp}
#conda deactivate
echo "Job finished at:" `date`

