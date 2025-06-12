#!/bin/bash

ls *.vcf.gz > alls
ls dipcall.vcf.gz >> alls

~/miniconda3/bin/python ~/00.bin/svimmer-0.1/svimmer --threads 32 alls chr1 chr2 chr3 chr4 chr5 chr6 chr7 chr8 chr9 chr10 chr11 chr12 chr13 chr14 chr15 chr16 chr17 chr18 chrX chrY > merge_manta_dipcall.gt
grep -E -v "Warning|SVLEN=[0-9][0-9][0-9][0-9][0-9][0-9][0-9]|SVLEN=-[0-9][0-9][0-9][0-9][0-9][0-9][0-9]" merge_manta_dipcall.gt > merge_manta_dipcal
l.ok.vcf
/home/wuzhongzi209/miniconda3/bin/bgzip merge_manta_dipcall.ok.vcf
/home/wuzhongzi209/miniconda3/bin/tabix -p vcf merge_manta_dipcall.ok.vcf.gz
