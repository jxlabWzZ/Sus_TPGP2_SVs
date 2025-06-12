#!/bin/bash
#SBATCH -J SNP_18
#SBATCH -N 1 -c 8
#SBATCH -e /home/qianzhupigs/AllFlash/wzz_tmp/20.GuiLu_SV/20.merge2383SV/30.eQTL/01.liver/all/02.herit/job-%j_%a.err
#SBATCH -o /home/qianzhupigs/AllFlash/wzz_tmp/20.GuiLu_SV/20.merge2383SV/30.eQTL/01.liver/all/02.herit/job-%j_%a.log
#SBATCH -p cu40
#SBATCH --mem=20Gb
#SBATCH -a 1


cd /home/qianzhupigs/AllFlash/wzz_tmp/20.GuiLu_SV/20.merge2383SV/30.eQTL/01.liver/all/02.herit

###
chr=18
###
#for i in {1..18} X; do
grep "chr${chr}_" ../../../10.all_cisSV/cis_01.liver.txt  | cut -f 1 | sort -u > ids${chr}.txt
#done

#for i in {1..18} X; do awk -v i=$i '{if($2==i) print $1}' ../ok4169_boforoni.txt > ids${i}.txt; done
#chr=18
for i in `cat ids${chr}.txt`
do
awk -v i=$i '{if($1==i) print $3}' ../m1m_ok1.txt | grep -E "DEL|INS|INV|DUP" > idTE_${i}.txt
awk -v i=$i '{if($1==i) print $3}' ../m1m_ok1.txt | grep -E -v "DEL|INS|INV|DUP" > idSNP_${i}.txt
#awk -v i=$i '{if($1==i) print $8}' /home/qianzhupigs/AllFlash/wzz_tmp/20.GuiLu_SV/20.merge2383SV/30.eQTL/01.liver/all/ok4169_boforoni.txt > idTE_${i}.txt
plink --bfile ../tmpsv --extract idTE_${i}.txt --make-bed --out idTE_${i}
plink --bfile ../tmp${chr} --extract idSNP_${i}.txt --make-bed --out idSNP_${i}
#plink --bfile extracted_idTE_${i} --recode vcf --out 

#awk -v i=$i '{if($1==i) print $0}' /home/qianzhupigs/AllFlash/wzz_tmp/20.GuiLu_SV/20.merge2383SV/30.eQTL/01.liver/all/00.snv_te/nominal_sv_${chr} | grep -v "TE" | sed 's/ /\t/g' | awk '{if($12<=0.01) print $0}' | sort -gk12 | head -n 1000 | cut -f 8 > idSNP_${i}.txt

#singularity exec /home/guilu/software/087.vcftools.sif vcftools --gzvcf ME266ok.vcf.gz --snps idTE_${i}.txt --recode --recode-INFO-all --out idTE_${i}
#singularity exec -B /home/qianzhupigs/AllFlash/wzz_tmp/20.GuiLu_SV/20.merge2383SV/30.eQTL/01.liver/all/00.snv_te:/mysnp  /home/guilu/software/087.vcftools.sif vcftools --gzvcf /mysnp/SNP_SV${chr}ok.vcf.gz --snps idSNP_${i}.txt --recode --recode-INFO-all --out idSNP_${i}
#grep -v -E "DEL|INS|INV|DUP" idSNP_${i}.recode.vcf > idSNP_${i}.recode2.vcf
#plink2 --vcf idTE_${i}.recode.vcf --make-bed --out idTE_${i}
#plink2 --vcf idSNP_${i}.recode2.vcf --make-bed --out idSNP_${i}
gcta64 --bfile idTE_${i} --make-grm --out TE_${i}
gcta64 --bfile idSNP_${i} --make-grm --out SNP_${i}
echo "SNP_${i}" > ${i}_mgrm.txt
echo "TE_${i}" >> ${i}_mgrm.txt
#less -S ../t8.txt.gz | awk -v i=$i '{if($4==i || $4=="pid") print $0}' |cut -f 7- | datamash transpose | awk '{print "0\t"$1"\t"$2}' > ${i}.phen
p=`sed 's/\t/_/g' ../t8.phe.txt | grep -n "ACTR10" | sed 's/:/\t/g' | awk '{print $1+5}'`
cut -f 1,2,${p} ../t9.pheotype.txt > ${i}.phen
##
gcta64 --reml --mgrm ${i}_mgrm.txt --pheno ${i}.phen --out test_${i}_he.txt

rm idTE_${i}.txt idSNP_${i}.txt idTE_${i}.* idSNP_${i}.* ${i}_mgrm.txt ${i}.phen TE_${i}.* SNP_${i}.*
rm test_${i}_he.txt.log
done


