#!/bin/bash
#SBATCH -J runGWA
#SBATCH -N 1 -n 1
#SBATCH --mem=2Gb
#SBATCH -e /home/qianzhupigs/AllFlash/wzz_tmp/20.GuiLu_SV/20.merge2383SV/30.eQTL/01.liver/all/log/job-%j_%a.err
#SBATCH -o /home/qianzhupigs/AllFlash/wzz_tmp/20.GuiLu_SV/20.merge2383SV/30.eQTL/01.liver/all/log/job-%j_%a.log
#SBATCH -p cpcu
#SBATCH -a 0

cd /home/qianzhupigs/AllFlash/wzz_tmp/20.GuiLu_SV/20.merge2383SV/30.eQTL/01.liver/all

#sleep 360m

for i in `seq 2001 1000 14835`
do 
	sbatch  fatGWAs_batch.sh  $i
	while true
	  do 
		process=`squeue |grep "fastGWA"`;
                if [ "$process" == "" ]; then
                        sleep 1;
                        echo "process exit";
                        break;
                else
                        sleep 5;
                        echo "qstat exists";
                fi
	  done
done
