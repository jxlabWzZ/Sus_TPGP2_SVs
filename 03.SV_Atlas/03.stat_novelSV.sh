#bed2vcf
#!/bin/bash
input=$1

###header
echo "##fileformat=VCFv4.1" > h1a
echo "##ALT=<ID=DEL,Description="Deletion">" >> h1a
echo "##ALT=<ID=DUP,Description="Duplication">" >> h1a
echo "##ALT=<ID=INV,Description="Inversion">" >> h1a
echo "##ALT=<ID=BND,Description="Translocation">" >> h1a
echo "##ALT=<ID=INS,Description="Insertion">" >> h1a
echo "##INFO=<ID=SVTYPE,Number=1,Type=String,Description="Type of the SV.">" >> h1a
echo "##INFO=<ID=END,Number=1,Type=Integer,Description="position END">" >> h1a
echo "##INFO=<ID=SVLEN,Number=1,Type=Integer,Description="Length of the SV">" >> h1a
echo "##FORMAT=<ID=GT,Number=1,Type=String,Description="Genotype">"  >> h1a
echo -e "#CHROM\tPOS\tID\tREF\tALT\tQUAL\tFILTER\tINFO\tFORMAT\t"${input} >> h1a

### vcf body
awk '{print $1"\t"$2"\t"$1"_"$2"_"$5"\tN\t<"$5">\t.\tPASS\tSVTYPE="$5";SVLEN="$4";END="$3"\tGT\t1/1"}' ${input}.bed | sort -k1,1  -k2,2n | cat h1a - > vcf_${input}.vcf

### overlap with previous SV
singularity exec /home/qianzhupigs/AllFlash/wzz_tmp/00.bin/bin/jasminesv_1.1.5.sif jasmine file_list=alls4 out_file=merged4sv.vcf --min_overlap 0.5 max_dist_linear=1.0 --output_genotypes
cut -f 1-10 ../mmff_hdok.vcf | sed 's/\.\/\./1\/1/g;s/0\//1\//g;s/\/0/\/1/g;s/chr//g' > sv3ok_merge.vcf
grep "#" sv3ok_merge.vcf > sv3ok.hd
grep -v "#" sv3ok_merge.vcf | awk '{$4="N"; print $0}' | sed 's/ /\t/g' | cat sv3ok.hd - > sv4ok_merge.vcf
singularity exec /home/qianzhupigs/AllFlash/wzz_tmp/00.bin/bin/jasminesv_1.1.5.sif jasmine file_list=mm2.txt out_file=mm2sv.vcf --min_overlap 0.5 max_dist_linear=1.0 --output_genotypes

### novel SV
# get vcf of the novel_sv
grep "SUPP=1;" mm2sv.vcf  | awk '{if($10~"1/1") print $0}' | sed 's/\;STARTVARIANCE/\t/g' | awk '{print $1"_"$2"_"$8}' > ids_novel
grep -v "#" ../mmff_hdok.vcf  | sed 's/chr//g'| awk '{print $1"_"$2"_"$8"\t"$0}' | awk 'NR==FNR{a[$1]=$0;next}NR>FNR{if($1 in a)print $0"\t"a[$1]}' - ids_novel | cut -f 3- > novel.gt
grep "#" ../mmff_hdok.vcf | cat - novel.gt > novel.gt.vcf

