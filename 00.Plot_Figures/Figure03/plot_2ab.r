library(ggsci)
library(ggplot2)
library(beeswarm)
#colo = pal_npg(alpha=0.6)(15)
#colo =c("#75A140","grey","#1AAAC2","grey","#975AA4","grey","#715227","grey","#F5AA42","grey","#2C3284","grey","#D96161")
#colo =c("#75A140","#975AA4","#715227","#F5AA42","#2C3284","#D96161")
#colo =c("#75A140绿","grey","#1AAAC2蓝","grey","#975AA4紫","grey","#715227踪","grey","#F5AA42黄","grey","#D96161红")
colo =c("#1AAAC2","grey","#715227","grey","#F5AA42","grey","#75A140","grey","#D96161","grey","#975AA4")
b<-read.table("/Users/wuzhongzi/Desktop/pp.mrr",header=F)
b$ID<-factor(b$V1,levels=c("snp","p2","indel","p3","del","p5","ins","p6","dup","p7","inv"))
pdf(file="/Users/wuzhongzi/Desktop/myppp.pdf", width=6.0, height=5.0)
beeswarm(V2 ~ ID, data = b,
         method = 'swarm', spacing=0.1,
         pch = 16,cex=1.5,col=colo,
         xlab = '', ylab = 'gene expression',
         labels = c("snp","p2","indel","p3","del","p5","ins","p6","dup","p7","inv"))
                  
boxplot(V2 ~ ID, data = b, add = T, names = c("","","","","","","","","","",""), width=rep(0.5,11),col=colo,cex=0.2)
dev.off()

####
library(ggsci)
colo =c("#1AAAC2","#715227","#F5AA42","#75A140","#D96161","#975AA4")
name <- c("SNP","InDel","DEL","INS","DUP","INV")
average <-as.numeric(c("8.022821096","7.100680404","5.138157383","5.289918784","4.383204771","3.494711025"))
number <- as.numeric(c("105395264","12608993","137454","194948","24166","3124"))
data <- data.frame(name,average,number)
attach(data)
par(mgp=c(4,0.5,0),mar=c(4,4,1,0))
pdf(file="/Users/wuzhongzi/Desktop/myttt.pdf", width=6.0, height=5.0)
my_bar <- barplot(average , border=F , xaxt="n", las=2, space=0.5, col=colo , ylim=c(0,9) , ylab="Count of SV Loci", cex.lab=1.3, main="")
text(my_bar, average+1 , paste("",number,sep="") ,cex=0.8, srt=90)
text(cex=1, x=my_bar, y=-1, name, xpd=TRUE, srt=90)
legend("topleft", legend = c("SNP","InDel","DEL","INS","DUP","INV") ,
       col = pal_npg(alpha=0.6)(5) ,
       bty = "n", pch=20 , pt.cex = 1.5, cex = 1.1, horiz = FALSE, inset = c(0.05, 0.05))
dev.off()
detach(data)





