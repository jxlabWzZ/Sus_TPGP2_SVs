

 bedtools makewindows -g g.txt -w 500000 -s 250000 > windows.bed

bedtools coverage -a windows.bed -b sv.bed > bkpt.depth.txt

## top 1% as hotspot region
cat bkpt.depth.txt | sort -nrk4 | sed -n '1,95p' | sort -k1,1 -k2,2n | bedtools merge -i - > hot.bed
bedtools intersect -a hot.bed -b bkpt.depth.txt -wa -wb | awk '{if($2<=$5 && $3>=$6) print $0}' > hot.bed.info

