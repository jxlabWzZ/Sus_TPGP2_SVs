#!/bin/bash
#SBATCH -J 1h_manta
#SBATCH -N 1 -c 24
#SBATCH -e /home/qianzhupigs/AllFlash/wzz_tmp/99.qianzhu/sus_tmp/14.manta/04.recall_dipcall/00.gt/tmp2/job-%j_%a.err
#SBATCH -o /home/qianzhupigs/AllFlash/wzz_tmp/99.qianzhu/sus_tmp/14.manta/04.recall_dipcall/00.gt/tmp2/job-%j_%a.log
#SBATCH -p all
#SBATCH --mem=30Gb
#SBATCH -a 0

### filter PASS，AGGREGATED and AN<1000
cd /home/qianzhupigs/AllFlash/wzz_tmp/99.qianzhu/sus_tmp/14.manta/04.recall_dipcall/00.gt/tmp2
 less -S sv_chrY:1-10000000/chrY/000000001-001000000.vcf.gz | grep "#" > hd
less -S sv_chr*/chr*/*.vcf.gz | grep -v -E "#|SVTYPE=BND;" | awk '{if($7=="PASS") print $0}'| grep -E "AGGREGATED|INV" > gt
grep -v -E "AF=0;|AF=1;|;AN=[0-9];|;AN=[0-9][0-9];|;AN=[0-9][0-9][0-9];" gt > gt2
sort -k1,1 -k2,2n gt2 | cat hd - > f1.vcf
### pass ratio >0.5
 singularity exec -B /home/jxlabgdp/01.Biosoft/bin:/home/jxlabgdp/01.Biosoft/bin /home/guilu/software/072.samtools.sif /home/jxlabgdp/01.Biosoft/bin/vcffilter -f "( SVTYPE = DEL & SVMODEL = AGGREGATED & QD > 5 & PASS_AC > 0 & PASS_ratio > 0.5 & ( ABHet > 0.25 | ABHet < 0 )) | ( SVTYPE = DUP & SVMODEL = AGGREGATED & QD > 5 &  PASS_AC > 0 & PASS_ratio > 0.5 ) |  ( SVTYPE = INS & SVMODEL = AGGREGATED &  PASS_AC > 0 & PASS_ratio > 0.5 & ( ABHet > 0.25 | ABHet < 0 ) & MaxAAS > 4 ) | ( SVTYPE = INV &  PASS_AC > 0 & PASS_ratio > 0.5 & ( ABHet > 0.25 | ABHet < 0 ) & MaxAAS > 4 )" f1.vcf > f2.vcf
### filter call rate/ GQ
singularity exec /home/guilu/software/087.vcftools.sif vcftools --vcf f2.vcf --max-missing 0.5 --minGQ 20 --minDP 5 --mac 3 --recode --maf 0.001 --recode-INFO-all --out ff2ok
#singularity exec /home/guilu/software/087.vcftools.sif vcftools --vcf ff2ok.recode.vcf --max-missing 0.9 --minGQ 20 --minDP 5 --maf 0.01 --recode --recode-INFO-all --out pp2ok
###bed2vcf
singularity exec /home/guilu/software/087.vcftools.sif vcftools --vcf ff2ok.recode.vcf --get-INFO END  --get-INFO SVTYPE --get-INFO SVLEN  --out info
singularity exec /home/guilu/software/087.vcftools.sif vcftools --vcf ff2ok.recode.vcf --extract-FORMAT-info GT --out gt
grep "CHROM" hd | cut -f 1-9 > hd9
grep -v -E "_NW|chrUn" hd | grep -E "##file|##con|##INFO=<ID=END|##INFO=<ID=SVLEN|##INFO=<ID=SVTYPE" > hd0
sed 's/:/\t/g' info.INFO | awk '{print $1"\t"$2"\t"$1"_"$2"_"$8"\t"$3"\t"$4":"$5":"$6"\t.\tPASS\tEND="$7";SVTYPE="$8";"$5"\tGT"}' | sed 's/SVSIZE/SVLEN/g' | grep -v "CHROM" | cat hd9 - | paste - gt.GT.FORMAT | cut -f 1-9,12- |cat hd0 - > gt.vcf
sed 's/:/\t/g' info.INFO | awk '{print $1"\t"$2"\t"$1"_"$2"_"$8"\t"$3"\t<"$8">\t.\tPASS\tEND="$7";SVTYPE="$8";"$5"\tGT"}' | sed 's/SVSIZE/SVLEN/g' |  grep -v "CHROM" | cat hd9 - | paste - gt.GT.FORMAT | cut -f 1-9,12- |cat hd0 - > gt2.vcf

