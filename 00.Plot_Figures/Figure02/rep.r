library(ggplot2)
library(Cairo)
library(ggsci)
#colo=c("#BA55D3","#8A2BE2","#800080","#3CB371","#00FF00","#008000","#FFC0CB","#FF69B4","#FF1493","#FF0000","#DAA520")
#colo=c("#BA55D3","#8A2BE2","#800080","#3CB371","#00FF00","#008000","#FFC0CB","#FF69B4","#FF0000","#DAA520")
colo=c("#7900D7","#C99B98","#6DA08C","#96B683")
#colo<- c(pal_npg(alpha=0.8)(10)[10:1],"grey")
#colo<-pal_npg(alpha=1)(10)
#CairoPNG(filename = "118.png", width = 5000, height = 2600, res = 400)
par(mgp=c(4.2,1,0),mar=c(5,5,3,2))

data_sv_repeat<-read.table("/Users/wuzhongzi/Desktop/pp_svlen.txt",header=T)
p<-ggplot(data=data_sv_repeat, aes(x=abs(SVLEN), fill = factor(SVTYPE,levels=c("DUP","INV","INS","DEL")))) +
#p<-ggplot(data=data_sv_repeat, aes(x=abs(SVLEN), fill = factor(RepClass,levels=c("Low","Simple","Satellite","SINE","LINE","LTR","DNA","RNA","UN","NR")))) +
  geom_histogram(bins = 100) +
  scale_x_continuous(trans = 'log2',breaks = c(100,300,2000,6000,20000),
                     labels = c('100bp','300bp','2kb','6kb','20kb'),limits = c(50,100000)) + 
  theme_bw()+scale_fill_manual(values=colo)+
  xlab('') + 
  ylab("SV Count")

#画图
p
##保存为pdf
pdf(file="/Users/wuzhongzi/Desktop/rep.plot.pdf",width=10,height=5)
p
dev.off()
##保存为png、jpg
#png(filename="/Users/wuzhongzi/Desktop/rep.plot.png",width=2000,height=2400,res=300)
#p
#dev.off()