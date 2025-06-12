library(ggplot2)
a<-read.table("/Users/wuzhongzi/Desktop/ppsv14ok.txt",header=F)

#小提琴&箱线图
p3=ggplot(a,aes(x=V1,y=V2,fill=V1)) +
  geom_violin(trim=F,color="white",width=0.75) + #绘制小提琴图, “color=”设置小提琴图的轮廓线的颜色(#不要轮廓可以设为white以下设为背景为白色，其实表示不要轮廓线)
  #"trim"如果为TRUE(默认值),则将小提琴的尾部修剪到数据范围。如果为FALSE,不修剪尾部。
  geom_boxplot(width=0.2,position=position_dodge(0.9),outlier.colour="grey",outlier.size=1)+ #绘制箱线图，此处width=0.1控制小提琴图中箱线图的宽窄
  scale_fill_manual(values= c("#00FFAAFF", "#FF2E2E","#E69F00"))+ #设置填充的颜色
  labs(title="", x="Genotype", y = "Gene Expression",size=20) +
  theme_bw()+#把背景设置为白底
  theme(plot.title = element_text(hjust =0.5,colour="black",face="bold",size=18), # 将图表标题居中
       axis.text.x=element_text(colour="black",face="bold",size=14), 
       # axis.text.x=element_text(angle=0,hjust=1,colour="black",face="bold",size=14), #设置x轴刻度标签的字体显示倾斜角度为45度，并向下调整1(hjust = 1)，字体大小为14
        axis.text.y=element_text(hjust=0.5,colour="black",face="bold",size=14), #设置y轴刻度标签的字体簇，字体大小，字体样式为plain
        axis.title.x=element_text(size=16,face="bold"),#设置x轴标题的字体属性
        axis.title.y=element_text(size=16,face="bold"), #设置y轴标题的字体属性
        #legend.text=element_text(face="italic", hjust = 0.5,colour="black", size=12), #设置图例的子标题的字体属性
        #legend.title=element_text(face="italic", colour="black", size=12),#设置图例的总标题的字体属性
       # legend.justification=c(-0.1,1.2), #可调整图例的位置。##(1,1)第一个1是调整图例在图的内外(左右移动)，第二个1是在图中上下移动。
        #legend.position=c(0, 1), #legend.position=c(0,1)左上角，(1,1)是在右上角。
        panel.grid.major = element_blank(), #不显示网格线
        panel.grid.minor = element_blank()) #不显示网格线
p3