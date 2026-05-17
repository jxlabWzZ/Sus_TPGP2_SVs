#!/bin/bash
ref_fa=/home/jxlabgdp/AllFlash/wzz_tmp/11.SV/14.manta/3.recall/10.ref/susScr11.fa
output=/home/sgtpyangb/wzz_STR_tmp/tmp/70.bam/15.lumpy
### smoove
singularity exec -B /home/sgtpyangb/wzz_STR_tmp/tmp/70.bam:/mydat -B /home/jxlabgdp/AllFlash/wzz_tmp/11.SV/14.manta/3.recall/10.ref:/myref /home/guilu/software/smoove:latest.sif smoove call --outdir /mydat/15.lumpy --name ${ID} --fasta /myref/susScr11.fa -p 10 --genotype /mydat/01bamok/${ID}.sorted.bam
### insurveyor
singularity exec -B /home/sgtpyangb/wzz_STR_tmp/tmp/70.bam:/mydat -B /home/jxlabgdp/AllFlash/wzz_tmp/11.SV/14.manta/3.recall/10.ref:/myref /home/sgtpyangb/AllFlash/wzz_tmp/00.bin/bin/insurveyor_1.1.2.sif python/usr/local/bin/insurveyor.py --threads 20 /mydat/01bamok/${ID}.sorted.bam /mydat/15.lumpy/ins_${ID} /myref/susScr11.fa
