## sniffles25
singularity exec -B /home/qianzhupigs/AllFlash/wzz_tmp/30.T2T_DRC/01.DRC/01.SV/02.T2T_sus:/myref -B /home/qianzhupigs/AllFlash/wzz_tmp/30.T2T_DRC/01.DRC/01.SV/01.T2T_FaHap/02.TGS/sus/ss_${sample}:/myout -B /bak/wzz_1kpig/00.data/00.bamok:/bak/wzz_1kpig/00.data/00.bamok /home/qianzhupigs/AllFlash/wzz_tmp/00.bin/bin/sniffles25.sif sniffles --input  /bak/wzz_1kpig/00.data/00.bamok/${sample}_*.bam --reference /myref/sus11.fa -t 30 --minsvlen 50 --combine-pctseq 0 --mapq 10 --min-alignment-length 500 --minsupport ${cov} --vcf /myout/ssv2_${sample}_sv2.vcf

##iris
singularity exec -B /home/qianzhupigs/AllFlash/wzz_tmp/30.T2T_DRC/01.DRC/01.SV/02.T2T_sus:/myref -B /home/qianzhupigs/AllFlash/wzz_tmp/30.T2T_DRC/01.DRC/01.SV/01.T2T_FaHap/02.TGS/sus/ss_${sample}:/myout -B /bak/wzz_1kpig/00.data/00.bamok:/bak/wzz_1kpig/00.data/00.bamok /home/qianzhupigs/AllFlash/wzz_tmp/00.bin/bin/irissv_1.0.5.sif iris \
 genome_in=/myref/sus11.fa \
 vcf_in=/myout/ssv2_${sample}_sv2.vcf \
 reads_in=/bak/wzz_1kpig/00.data/00.bamok/${sample}_*.bam \
 vcf_out=/myout/ssv2_${sample}_irisok.vcf
 
 ###merge
 singularity exec /home/qianzhupigs/AllFlash/wzz_tmp/00.bin/bin/jasminesv_1.1.5.sif jasmine file_list=mm47.txt out_file=merged47.vcf --min_overlap 0.5 max_dist_linear=1.0 --output_genotypes


