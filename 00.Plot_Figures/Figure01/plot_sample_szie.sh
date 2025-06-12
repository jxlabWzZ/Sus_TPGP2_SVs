library(ggplot2)
library(Cairo)
library(ggsci)
a<-read.table("/Users/wuzhongzi/Desktop/pp1.txt",header=F)
### fig01
library(ggplot2)
a<-read.table("/Users/wuzhongzi/Desktop/pp1.txt",header=F)
colo=c("darkorange","darkgreen","darkred")
ggplot(a,aes(x=factor(V2,levels=c("ASW","ASD","CEC","EUD","EUW","OUT")),y=V3,fill=factor(V1,levels=c("NC","GB","ThisStudy"))))+
  geom_bar(stat = 'identity', 
           #柱状图位置并排:
           position = 'dodge', #使用position=position_dodge(width=0.9),可使组内柱子间隔,自行试一下。
           width = 0.75,      #设置柱子宽度,使变量之间分开
           color="black")+      #  scale_y_continuous(trans = 'log2')+
  geom_text(aes(label=V3),size=3,
           position = position_dodge(width = 0.8), #相应的注释宽度也调整
           color="red",
          vjust=-0.3)+    #调节注释高度    
  labs(x=NULL,y="Sub-population count")+ 
  theme_bw(base_size = 18)+    scale_fill_manual(values=colo) + 
  theme(axis.text = element_text(colour = 'black'), legend.title = element_blank())
### fig02
library(ggplot2)
a<-read.table("/Users/wuzhongzi/Desktop/pp1.txt",header=F)
colo=c("darkorange","darkgreen","darkred")
ggplot(a,aes(x=factor(V2,levels=c("ASW","ASD","CEC","EUD","EUW","OUT")),y=V4,fill=factor(V1,levels=c("NC","GB","ThisStudy"))))+
  geom_bar(stat = 'identity', 
           #柱状图位置并排:
           position = 'dodge', #使用position=position_dodge(width=0.9),可使组内柱子间隔,自行试一下。
           width = 0.75,      #设置柱子宽度,使变量之间分开
           color="black")+      #  scale_y_continuous(trans = 'log2')+
  geom_text(aes(label=V4),size=3,
           position = position_dodge(width = 0.8), #相应的注释宽度也调整
           color="red",
          vjust=-0.3)+    #调节注释高度    
  labs(x=NULL,y="Sample size")+ 
  theme_bw(base_size = 18)+    scale_fill_manual(values=colo) + 
  theme(axis.text = element_text(colour = 'black'), legend.title = element_blank())
