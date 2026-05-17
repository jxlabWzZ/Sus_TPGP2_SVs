#!/bin/bash
cd /home/sgtpyangb/wzz_STR_tmp/tmp/70.bam2383
n=${SLURM_ARRAY_TASK_ID}
a=`sed -n "${n},${n}p" dd3.txt2 | cut -f 1`
b=`sed -n "${n},${n}p" dd3.txt2 | cut -f 3`
java -jar /home/jxlabgdp/01.Biosoft/bin/picard.jar DownsampleSam 
      I=${a}.sorted.bam \
      O=pp_${a}.bam \
      P=${b} \
      R=999 \
      STRATEGY=ConstantMemory
samtools sort -@ 16 -m 2G -o ppok_${a}.sorted.bam pp_${a}.bam
samtools index -@ 16 ppok_${a}.sorted.bam

