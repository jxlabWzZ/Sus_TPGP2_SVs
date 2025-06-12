# to download WGS from NCBI #(.fq file)
for i in `cat ids2386.txt`
do
singularity exec /home/tmp/kingfisher_0.4.1.sif kingfisher get -r ${id} -m ena-ascp aws-http prefetch ena-ftp
done

# align to SusScrofa11.1 reference genome #(.bam file)
Samtools=/home/jxlabgdp/01.Biosoft/bin/samtools
ref=/home/jxlabgdp/AllFlash/wzz_tmp/11.SV/14.manta/3.recall/10.ref/susScr11.fa
output=/home/jxlabgdp/AllFlash/wzz_tmp/99.qianzhu/sus_tmp/01.download/
input=/home/jxlabgdp/AllFlash/wzz_tmp/99.qianzhu/sus_tmp/01.download/
sambamba=/home/jxlabgdp/01.Biosoft/bin/sambamba
samblaster=/home/jxlabgdp/01.Biosoft/bin/samblaster
Bwa=/home/jxlabgdp/01.Biosoft/bin/bwa
ID="aaaa"
fq1=${input}/aaaa_1.fq.gz
fq2=${input}/aaaa_2.fq.gz
RG="@RG\\tID:${ID}\\tPL:ILLUMINA\\tSM:${ID}\\tLB:${ID}\\tPU:1"
# bwa mem and markPCRdup
$Bwa mem -t $nproc -R ${RG} ${ref} ${fq1} ${fq2} \
| $samblaster --excludeDups --ignoreUnmated --addMateTags --maxSplitCount 2 --minNonOverlap 20 \
| $Samtools view -@ 10 -Shb -o ${ID}.raw.bam -
# samtools sort and index
$Samtools sort -@ 10 -m 2G -o ${ID}.sorted.markdup.bam ${ID}.raw.bam
$Samtools index ${ID}.sorted.markdup.bam
 # stat depth and coverage
 export MOSDEPTH_PRECISION=5
/home/jxlabgdp/01.Biosoft/bin/mosdepth -n -x -t 4 stat_${ID}.txt ${ID}.sorted.markdup.bam


