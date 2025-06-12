# merge

singularity exec -B /home/qianzhupigs/AllFlash/wzz_tmp/20.GuiLu_SV/11.47TGS_SV/00.paragraph/11.vcf2383:/home/qianzhupigs/AllFlash/wzz_tmp/20.GuiLu_SV/11.47TGS_SV/00.paragraph/11.vcf2383 /home/qianzhupigs/AllFlash/wzz_tmp/20.GuiLu_SV/11.47TGS_SV/00.paragraph/11.vcf2383/094.bcftools.sif bcftools merge -Oz -o ddok.vcf.gz -l ids2383.txt

# filter
singularity exec /home/guilu/software/087.vcftools.sif vcftools --gzvcf ddok.vcf.gz --max-missing 0.2 --minDP 5 --mac 1 --recode --maf 0.0001 --recode-INFO-all --out cc1ok

/home/jxlabgdp/01.Biosoft/bin/bcftools view -c 0 -S hd2383.txt --no-version -Ov -o cc2ok.recode.vcf cc1ok.recode.vcf

##
grep "#" cc2ok.recode.vcf > hd0
grep -v "#" cc2ok.recode.vcf | awk '{print $1"_"$2}'| uniq -u > uid
grep -v "#" cc2ok.recode.vcf | awk '{for(i=10;i<=NF;i++){if($i!~"PASS") $i="./."}; print $0}' | sed 's/ /\t/g'| awk '{print $1"_"$2"\t"$0}
'| awk 'NR==FNR{a[$1]=$0;next}NR>FNR{if($1 in a)print $0"\t"a[$1]}' - uid | cut -f 3- | cat hd0 - > cc4ok.vcf

##
#grep "INS" ../info.INFO | awk '{print $1"\t"$2-100"\t"$2+100}' > ins.bed
#bedtools subtract -a cc3ok.vcf -b ins.bed -A | cat hd0 - > cc4ok.vcf

#bgzip cc4ok.vcf
#tabix -p vcf cc4ok.vcf.gz
#bed2vcf
singularity exec /home/guilu/software/087.vcftools.sif vcftools --vcf cc4ok.vcf --get-INFO END  --get-INFO SVTYPE --get-INFO SVLEN  --out info
singularity exec /home/guilu/software/087.vcftools.sif vcftools --vcf cc4ok.vcf --extract-FORMAT-info GT --out gt

grep "#" cc4ok.vcf > hd
grep "CHROM" hd | cut -f 1-9 > hd9
grep -v -E "_NW|chrUn" hd | grep -E "##file|##con|##INFO=<ID=END|##INFO=<ID=SVLEN|##INFO=<ID=SVTYPE" > hd0

##
sed 's/:/\t/g' info.INFO | awk '{print $1"\t"$2"\tpp_"$1"_"$2"_"$6"\t"$3"\t<"$6">\t.\tPASS\tEND="$2+length($3)-1";SVTYPE="$6";SVSIZE="$7"\
tGT"}' | sed 's/SVSIZE/SVLEN/g' |  grep -v "CHROM" | cat hd9 - | paste - gt.GT.FORMAT | cut -f 1-9,12- | cat hd0 - > gt2.vcf

###
singularity exec /home/guilu/software/087.vcftools.sif vcftools --vcf gt2.vcf --max-missing 0.3 --mac 3 --recode --maf 0.001 --recode-INFO-all --out gt3
###  #FORMAT=<ID=GT,Number=1,Type=String,Description="The genotype of the variant">
/home/jxlabgdp/01.Biosoft/bin/bcftools view -c 0 -S hd2383.txt --no-version -Ov -o gt4.vcf gt3.recode.vcf

### merge two vcf
### get bed format
grep -v "##" ../11.vcf2383/gt4.vcf | paste ../11.vcf2383/info.INFO - | cut -f 1-2,5,8- | grep -v "POS" > pp.gt
grep -v "##" ../12.manta/hdok_gt2.vcf | paste ../12.manta/info.INFO - | cut -f 1-2,5,8- | grep -v "POS" > gg.gt

### for paragraph SV
grep "=DEL" pp.gt > pp.delgt
grep "=INS" pp.gt > pp.insgt

### for graphtyper SV
grep "=DEL" gg.gt > gg.delgt
grep "=DUP" gg.gt > gg.dupgt
grep "=INV" gg.gt > gg.invgt
grep "=INS" gg.gt > gg.insgt

####DEL
cut -f 1-3 pp.delgt | bedtools intersect -a - -b gg.delgt -f 0.5 -F 0.5 -wa -wb | cut -f 4- > a1.bed
cat gg.delgt a1.bed | sort -k1,1 -k2,2n | uniq -u > a2.bed
# pp.delgt a2.bed

####INS
awk '{print $1"\t"$2-100"\t"$3+100}' pp.insgt | bedtools intersect -a - -b gg.insgt -wa -wb | cut -f 4- > b1.bed
cat gg.insgt b1.bed | sort -k1,1 -k2,2n | uniq -u > b2.bed
# pp.insgt b2.bed
### DUP
### INV
### merge
grep "#" ../11.vcf2383/gt4.vcf > hdok.txt
cat pp.delgt a2.bed pp.insgt b2.bed gg.invgt gg.dupgt | sort -k1,1 -k2,2n | cut -f 4- | cat hdok.txt - > mm_hdok.vcf


