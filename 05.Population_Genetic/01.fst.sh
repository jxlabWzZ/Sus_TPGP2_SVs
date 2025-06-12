a=$1
b=$2

cat $a $b > all.txt

singularity exec -B /home/qianzhupigs/AllFlash/wzz_tmp/20.GuiLu_SV/20.merge2383SV:/mm /home/guilu/software/087.vcftools.sif vcftools --vcf /mm/mmff_hdok.vcf --keep all.txt --max-missing 0.5 --mac 10 --recode --maf 0.01 --recode-INFO-all --out all

singularity exec -B /home/qianzhupigs/AllFlash/wzz_tmp/20.GuiLu_SV/20.merge2383SV:/mm /home/guilu/software/087.vcftools.sif vcftools --vcf all.recode.vcf --keep $a --max-missing 0.5 --recode --recode-INFO-all --out all2

singularity exec -B /home/qianzhupigs/AllFlash/wzz_tmp/20.GuiLu_SV/20.merge2383SV:/mm /home/guilu/software/087.vcftools.sif vcftools --vcf all.recode.vcf --keep $b --max-missing 0.5 --recode --recode-INFO-all --out all3

grep -v "#" all2.recode.vcf | cut -f 3 > aid
grep -v "#" all3.recode.vcf | cut -f 3 > bid
cat aid bid | sort | uniq -d > abid.txt

bcftools view --include "ID=@abid.txt" -Ov -o all4.recode.vcf all.recode.vcf

singularity exec -B /home/qianzhupigs/AllFlash/wzz_tmp/20.GuiLu_SV/20.merge2383SV:/mm /home/guilu/software/087.vcftools.sif vcftools --vcf all4.recode.vcf --weir-fst-pop ${a} --weir-fst-pop ${b} --out fst_${a}_${b}

rm aid bid abid.txt all.recode.vcf all2.recode.vcf all3.recode.vcf
