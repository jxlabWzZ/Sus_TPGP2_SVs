#!/bin/bash
#SBATCH -J hipSTR_18
#SBATCH -N 1 -n 4
#SBATCH -e /home/qianzhupigs/AllFlash/wzz_tmp/99.qianzhu/sus_tmp/14.manta/04.recall_dipcall/02.SNP/02.PPcallrate95maf001/snp/LD/job-%j_%a.err
#SBATCH -o /home/qianzhupigs/AllFlash/wzz_tmp/99.qianzhu/sus_tmp/14.manta/04.recall_dipcall/02.SNP/02.PPcallrate95maf001/snp/LD/job-%j_%a.log
#SBATCH -p cu36
#SBATCH --mem=8Gb
#SBATCH -a 1-18 ### 1-18

cd /home/qianzhupigs/AllFlash/wzz_tmp/99.qianzhu/sus_tmp/14.manta/04.recall_dipcall/02.SNP/02.PPcallrate95maf001/snp/LD/sv

#exclude=/home/qianzhupigs/AllFlash/wzz_tmp/11.SV/14.manta/3.recall/10.ref/tmp/step01/vcf_for_phasing/TE809_biallelic.bed.gz

n=${SLURM_ARRAY_TASK_ID}

#ulimit -n 6000
mkdir /home/qianzhupigs/AllFlash/wzz_tmp/99.qianzhu/sus_tmp/14.manta/04.recall_dipcall/02.SNP/02.PPcallrate95maf001/snp/LD/sv/chr${n}
cd /home/qianzhupigs/AllFlash/wzz_tmp/99.qianzhu/sus_tmp/14.manta/04.recall_dipcall/02.SNP/02.PPcallrate95maf001/snp/LD/sv/chr${n}
###
grep -E "DEL|INS|INV|DUP" ../../SNPok_SV${n}.bim | cut -f 2 > id_sv18.txt

awk 'NR==FNR {sv_ids[$1]=1; next} $2 in sv_ids {print $1, $4, $2}' id_sv18.txt ../../SNPok_SV${n}.bim > sv_positions.txt

while read chr pos sv_id; do
    start=$((pos - 100000))
    end=$((pos + 100000))
    if [ $start -lt 1 ]; then
        start=1
    fi
    echo -e "$chr\t$start\t$end\t$sv_id"
done < sv_positions.txt > ranges.txt

while read chr start end sv_id; do
    # 提取区域内的变异
    plink --bfile ../../SNPok_SV${n} --chr $chr --from-bp $start --to-bp $end --make-bed --out temp_${sv_id}

    # 计算SV与周围SNP的LD（使用PLINK 1.9+）
    plink --bfile temp_${sv_id} \
          --r2 \
          --ld-snp $sv_id \
          --ld-window-kb 1000 \
          --ld-window 99999 \
          --ld-window-r2 0 \
          --out ld_${sv_id}

    # 清理临时文件
    cat ld_*.ld >> all_ld_results.txt
    rm temp_${sv_id}.bed temp_${sv_id}.bim temp_${sv_id}.fam ld_*.ld ld_*.log ld_*.nosex temp_${sv_id}.log temp_${sv_id}.nosex
done < ranges.txt

#cat ld_*.ld > all_ld_results.txt

