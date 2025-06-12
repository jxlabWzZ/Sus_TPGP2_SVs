library(ggplot2)
library(ggbeeswarm)

a <- read.table("/Users/wuzhongzi/Desktop/okpp_plag1_ld.txt", header=F)

# 小提琴&箱线图 + 蜜蜂图
p3 <- ggplot(a, aes(x=V2, y=V4, fill=V2)) +
  geom_violin(trim=F, color="white", width=0.75) + # 绘制小提琴图
  geom_boxplot(width=0.3, position=position_dodge(0.9), outlier.colour="grey", outlier.size=1,fill="white") + # 绘制箱线图
  geom_beeswarm(size=0.5, alpha=0.5, color="black", cex=2) + # 添加蜜蜂图散点
  scale_fill_manual(values= c("#00FFAAFF", "#FF2E2E","#E69F00")) + # 设置填充的颜色
  labs(title="", x="Genotype", y = "Gene Expression", size=20) +
  theme_bw() + # 把背景设置为白底
  theme(plot.title = element_text(hjust=0.5, colour="black", face="bold", size=18), # 将图表标题居中
        axis.text.x=element_text(colour="black", face="bold", size=14), 
        axis.text.y=element_text(hjust=0.5, colour="black", face="bold", size=14), # 设置y轴刻度标签的字体簇，字体大小，字体样式为plain
        axis.title.x=element_text(size=16, face="bold"), # 设置x轴标题的字体属性
        axis.title.y=element_text(size=16, face="bold"), # 设置y轴标题的字体属性
        panel.grid.major = element_blank(), # 不显示网格线
        panel.grid.minor = element_blank()) # 不显示网格线

p3