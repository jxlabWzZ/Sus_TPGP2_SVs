#!/bin/bash
#SBATCH -J SNP_18
#SBATCH -N 1 -n 20
#SBATCH -e /home/qianzhupigs/AllFlash/wzz_tmp/99.qianzhu/sus_tmp/14.manta/03.recall/02.SNP/job-%j_%a.err
#SBATCH -o /home/qianzhupigs/AllFlash/wzz_tmp/99.qianzhu/sus_tmp/14.manta/03.recall/02.SNP/job-%j_%a.log
#SBATCH -p cpcu
#SBATCH --mem=100Gb
#SBATCH -a 1-18 ### 1-18,X

cd /home/qianzhupigs/AllFlash/wzz_tmp/99.qianzhu/sus_tmp/14.manta/03.recall/02.SNP
n=${SLURM_ARRAY_TASK_ID}
#ulimit -n 6000

/home/jxlabgdp/01.Biosoft/bin/plink2 \
--threads 16 \
--memory 90000 \
--vcf /bak/wzz_1kpig/01.susv11_bams/13.graphtyper_SNP/raw_snp_chr${n}.vcf.gz \
--max-alleles 2 \
--make-pgen \
--geno 0.05 \
--vcf-min-dp 5 \
--vcf-min-gq 20 \
--maf 0.001 \
--chr chr${n} \
--indiv-sort natural \
--export vcf bgz \
--out SNP${n}

###
/home/jxlabgdp/01.Biosoft/bin/bcftools filter  -i 'FILTER=="PASS" && AAScore>0.5'  --no-version  -Oz -o SNP${n}ok.vcf.gz SNP${n}.vcf.gz
###
#sed -i 's/VCFv4\.3/VCFv4\.2/' P1P${n}.vcf
#bgzip P1P${n}.vcf
#tabix -p vcf P1P${n}.vcf.gz

