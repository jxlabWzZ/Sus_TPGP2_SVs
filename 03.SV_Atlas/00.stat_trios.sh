#!/bin/bash

singularity exec /home/guilu/software/087.vcftools.sif vcftools --vcf ${1}.vcf --get-INFO END  --get-INFO SVTYPE --get-INFO SVLEN  --out info
singularity exec /home/guilu/software/087.vcftools.sif vcftools --vcf ${1}.vcf --extract-FORMAT-info GT --out gt

head -n 1 gt.GT.FORMAT | datamash transpose > hd01
for i in {1..47}
do
x=`sed -n "${i}p" trios.txt | cut -f 3`
m=`grep -n ${x} hd01  | sed 's/\:/\t/g' | cut -f 1`
y=`sed -n "${i}p" trios.txt | cut -f 2`
n=`grep -n ${y} hd01  | sed 's/\:/\t/g' | cut -f 1`
z=`sed -n "${i}p" trios.txt | cut -f 1`
j=`grep -n ${z} hd01  | sed 's/\:/\t/g' | cut -f 1`

#a=`awk -v m=$m -v n=$n -v j=$j '{print $j"\t"$n"\t"$m}' gt.GT.FORMAT  | grep -v "\." | grep -E "/1|1/" | awk '{if(($3~"0/1" || $3~"1/0")&& ($1=="1/1" && $2=="1/1")) print $0}' | wc -l`
#b=`awk -v m=$m -v n=$n -v j=$j '{print $j"\t"$n"\t"$m}' gt.GT.FORMAT   | grep -v "\." | grep -E "/1|1/" | awk '{if(($3~"0/1" || $3~"1/0")&& ($1=="0/0" && $2=="0/0")) print $0}' | wc -l`
c=`awk -v m=$m -v n=$n -v j=$j '{print $j"\t"$n"\t"$m}' gt.GT.FORMAT   | grep -v "\." |  sed 's/\//\t/g' | awk '{if(($1!=$3 && $1!=$4 && $1!=$5 && $1!=$6) && ($2!=$3 && $2!=$4 && $2!=$5 && $2!=$6)) print $0}' | wc -l`
d=`awk -v m=$m -v n=$n -v j=$j '{print $j"\t"$n"\t"$m}' gt.GT.FORMAT   | grep -v "\." |  sed 's/\//\t/g' | awk '{if(($1!=$3 && $1!=$4 && $1!=$5 && $1!=$6) || ($2!=$3 && $2!=$4 && $2!=$5 && $2!=$6)) print $0}' | wc -l`
e=`awk -v m=$m -v n=$n -v j=$j '{print $j"\t"$n"\t"$m}' gt.GT.FORMAT   | grep -v "\." | wc -l`
echo -e $i"\t"$c"\t"$d"\t"$e >> aaa.txt
done
###

awk '{print $2/$4"\t"$3/$4"\t"$0}' aaa*.txt | datamash mean 1
awk '{print $2/$4"\t"$3/$4"\t"$0}' aaa*.txt | datamash mean 2


