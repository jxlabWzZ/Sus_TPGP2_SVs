# plink IBS + phangorn 画进化树
# plink --bfile ../f1 --cluster --matrix --out dd_all3
# IBS2nwk
library(ape)
library(phangorn)
library(seqinr)
m<-as.matrix(read.table("/Users/wuzhongzi/Desktop/dd_all3.mibs"))
dimnames(m)<-list(1:2386,1:2386)
g=matrix(1,nrow=2386,ncol=2386,byrow=FALSE)
D=g-m
ID_number<-read.table("/Users/wuzhongzi/Desktop/dd_all3.mibs.id")
rownames(D)<-ID_number$V1
tr2<-bionj(D)
write.tree(tr2,file="/Users/wuzhongzi/Desktop/dd_all3.nwk")
# 用figture打开，设定root后，另存为新的nwk
# 上传到itol优化





