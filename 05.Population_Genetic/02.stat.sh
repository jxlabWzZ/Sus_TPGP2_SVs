#

singularity exec /home/guilu/software/087.vcftools.sif vcftools --vcf all4.recode.vcf --get-INFO END  --get-INFO SVTYPE --get-INFO SVLEN  --out info

grep -v "##" all4.recode.vcf | cut -f 3 | paste info.INFO - fst_idsL271.txt_idsDLYP.txt.weir.fst  | cut -f 1,2,5- | grep -v -E "nan|POS" | awk '{if($9<0) $9=0; print $0}' | sed 's/ /\t/g' > ff_fst.txt

sort -grk9 ff_fst.txt  | sed -n '1,1884p' | sed 's/chr//g' | awk '{if($2>100000){print $1"\t"$2-100000"\t"$3+100000"\t"$0} else print $1"\t1\t"$3+100000"\t"$0 }' | cut -f 1-3,7- |  bedtools intersect -a - -b ~/03.Hujianchao/00.ref/sus11.1/Sus_scrofa.Sscrofa11.1.110.gff3 -wa -wb | awk '{if($12=="gene") print $0}' > top_fst_gene.txt

cut -f 18 top_fst_gene.txt  | sort | uniq | grep "Name=" | sed 's/;Name=/\t/g;s/;biotype=/\t/g' | cut -f 2 > gg_SS.txt

