#!/bin/bash

ref_fa=/home/jxlabgdp/AllFlash/wzz_tmp/11.SV/14.manta/3.recall/10.ref/susScr11.fa
output=/home/jxlabgdp/AllFlash/wzz_tmp/99.qianzhu/sus_tmp/14.manta/01.raw
manta=/home/jxlabgdp/01.Biosoft/manta-1.6.0.centos6_x86_64/bin/configManta.py
### run manta
cd $output
$manta  --referenceFasta=$ref_fa --bam=$BAM --runDir=${output}/${ID}_manta
cd ${output}/${ID}_manta
./runWorkflow.py
cp ${output}/${ID}_manta/results/variants/diploidSV.vcf.gz ${output}/$ID.manta.SV.vcf.gz
cp ${output}/${ID}_manta/results/variants/diploidSV.vcf.gz.tbi ${output}/$ID.manta.SV.vcf.gz.tbi
rm -rf ${output}/${ID}_manta
### convert INV
/usr/bin/python2 /home/jxlabgdp/01.Biosoft/manta-1.6.0.centos6_x86_64/libexec/convertInversion.py /home/jxlabgdp/01.Biosoft/bin/samtools /home/jxlabgdp/AllFlash/wzz_tmp/11.SV/14.manta/3.recall/10.ref/susScr11.fa /home/jxlabgdp/AllFlash/wzz_tmp/99.qianzhu/sus_tmp/14.manta/01.raw/${output}.manta.SV.vcf.gz > ${output}.vcf
grep "#" ${output}.vcf > ${output}.vcf_hd
awk '{if($6>=30 && $7=="PASS") print $0}' ${output}.vcf > ${output}.vcf_gt
cat ${output}.vcf_hd ${output}.vcf_gt > v2_${output}.vcf
rm ${output}.vcf_hd ${output}.vcf_gt ${output}.vcf
/home/jxlabgdp/01.Biosoft/bin/bgzip v2_${output}.vcf
/home/jxlabgdp/01.Biosoft/bin/tabix v2_${output}.vcf.gz

