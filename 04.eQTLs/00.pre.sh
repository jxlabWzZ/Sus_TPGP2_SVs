###
#for i in {1..18} X
#do
#plink --make-bed --out tmp${i} --vcf ../ff${i}.vcf.gz
#done
#plink --make-bed --out tmpsv --vcf ../svgt.recode.vcf.gz
###
rm ids_cc.txt
echo "/home/qianzhupigs/AllFlash/wzz_tmp/20.GuiLu_SV/20.merge2383SV/30.eQTL/01.liver/all/tmpsv" > ids_cc.txt
for i in {1..18} X
do
echo "/home/qianzhupigs/AllFlash/wzz_tmp/20.GuiLu_SV/20.merge2383SV/30.eQTL/01.liver/all/tmp${i}" >> ids_cc.txt
done
###
gcta64 --mbfile ids_cc.txt --make-grm --thread-num 10 --out geno_grm
gcta64 --grm geno_grm --make-bK-sparse 0.05 --out sp_grm

###prepare for fastGWAS
cut -f 2- ../sv/cov2ok.txt | datamash transpose | cut -f 1-25 | awk '{print $1"\t"$0}' > qqcov.txt
cut -f 2- ../sv/cov2ok.txt | datamash transpose | cut -f 1,26 | awk '{print $1"\t"$0}' > bbcov.txt
###Phenotype
less -S ../sv/t8.txt.gz  | cut -f 7- | datamash transpose | awk '{print $1"\t"$1"\t0\t0\t0\t"$0}' | cut -f 1-5,7- > t9.pheotype.txt
less -S ../sv/t8.txt.gz | grep -v "#" | cut -f 1-5 | sed 's/^chr//g;s/^X/23/g' > t8.phe.txt