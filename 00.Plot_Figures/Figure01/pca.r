library(ggplot2)
library(Cairo)
library(ggsci)
colo=c("#000000","#8B0000","#FF0000","#FF69B4","#FFD700","#FFFF00","#8A2BE2","#0000FF","#008000","#00FF00","#00FFFF")
#colo<- c(pal_npg(alpha=0.8)(10)[10:1],"grey")
#colo<-pal_npg(alpha=1)(10)
#CairoPNG(filename = "118.png", width = 5000, height = 2600, res = 400)
par(mgp=c(4.2,1,0),mar=c(5,5,3,2))

data_pca<-read.table("/Users/wuzhongzi/Desktop/all3.eigenvec",header=T)
data_val<-read.table("/Users/wuzhongzi/Desktop/all3.eigenval",header=F)

p<-ggplot(data=data_pca, aes(x=PC1, y=PC2,  color = factor(Region,levels=c("OUT","NAW","SAW","EWB","EDP","ECP","CTP","SAD","NAD","KND","CEC")))) +
  geom_point()  + 
  theme_bw()+
  theme(legend.position='none')+#,legend.title=element_blank(),
  #      legend.position=c(0.1,0.8),
  #      legend.spacing.x = unit(0.4, 'cm'),
  #      legend.key.size=unit(0.4, 'cm'),
  #      legend.text = element_text(size = 14,face = "bold"),
   #    axis.text.x = element_text(size = 14,face = "bold", angle = 0),
      #  axis.text.y = element_text(size = 14,face = "bold"),
       # axis.title.y = element_text(size = 17,face = "bold"),
       # axis.title.x = element_text(size = 17,face = "bold")) +
  scale_color_manual(values=colo) + 
  xlab("PC1") + 
  ylab("PC2")

#画图
p
##保存为pdf
pdf(file="/Users/wuzhongzi/Desktop/pca12.pdf",width=4,height=5)
p
dev.off()
##保存为png、jpg
png(filename="/Users/wuzhongzi/Desktop/pca12.png",width=1800,height=2400,res=300)
p
dev.off()


p2<-ggplot(data=data_pca, aes(x=PC1, y=PC3,  color = factor(Region,levels=c("OUT","NAW","SAW","EWB","EDP","ECP","CTP","SAD","NAD","KND","CEC")))) +
  geom_point()  + 
  theme_bw()+
  theme(legend.position='none')+#,legend.title=element_blank(),
  #      legend.position=c(0.1,0.8),
  #      legend.spacing.x = unit(0.4, 'cm'),
  #      legend.key.size=unit(0.4, 'cm'),
  #      legend.text = element_text(size = 14,face = "bold"),
  #    axis.text.x = element_text(size = 14,face = "bold", angle = 0),
  #  axis.text.y = element_text(size = 14,face = "bold"),
  # axis.title.y = element_text(size = 17,face = "bold"),
  # axis.title.x = element_text(size = 17,face = "bold")) +
  scale_color_manual(values=colo) + 
  xlab("PC1") + 
  ylab("PC3")

#画图
p2
##保存为pdf
pdf(file="/Users/wuzhongzi/Desktop/pca13.pdf",width=4,height=5)
p2
dev.off()
##保存为png、jpg
png(filename="/Users/wuzhongzi/Desktop/pca13.png",width=1800,height=2400,res=300)
p2
dev.off()