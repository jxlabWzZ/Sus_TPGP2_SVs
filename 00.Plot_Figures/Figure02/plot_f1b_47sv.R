library(ggplot2)
a<-read.table("/Users/wuzhongzi/Desktop/pp01.txt",header=F)
a$V6<-factor(a$V2,levels=c("SRR24561059_AWB","SRR24561053_BMX","SRR9851973_BMX","BMXmo_BMX","SAMN14409107_WZS","CRR307873_WZS","CNS0254251_LC","CRR1232679_Banna","CRR810333_Tunc","SAMN14409105_TT","SRR24561055_TT","CRR307872_TT","CRR874585_MS","MSjxau_MS","SAMN14422843_MS","CRR307869_MS","CRR810332_SWT","JHT2T_JH","CRR307867_JH","CRR874571_Laiw","CRR307868_Laiw","CRR1088118_Huai","CRR874598_TC","SAMN12123497_NX","SRR25031164_Lant","CRR307865_AQLB","CRR307871_RC","CRR307870_Min","SAMN34578002_Nanc","SAMN41069951_Kore","CRR502433_TB1","CRR502439_TB2","CRR502444_BT1","CRR502449_BT2","DRCmo_Du","SAMN15501053_Du","SAMN07325927_DLY","SAMN14409106_LW","SRR24561047_LW","CRR307874_LW","SAMN35524429_LR","SAMN37151398_Babr","SRR24561057_PT","SRR24561051_BKS","CNP0001681_Oss","SAMN30220629_Yucatan","CRR307866_EWB"))
a$V7<-factor(a$V3,levels=c("DUP","INV","INS","DEL"))
p=ggplot(a,aes(x = V6,y = V4,fill = V7))  # 数据来源Bar，x轴为Score，y轴为Mortality，将分类变量映射给fill参数，后面运行position = "dodge"绘制分组条形图
#windowsFonts(myFont1 = windowsFont("Times New Roman"))  # 设定文字字体"Times New Roman"
p+geom_bar(stat = "identity", position = "stack", width=0.6) +  # identity表示条形的高度是变量值，"dodge"表示条形图并列，width表示柱子宽度，默认值是0.9
  xlab("Genomes") + ylab("SV counts") +  # 设置x轴、y轴标题
  theme_bw()+ # 移除背景
  theme(panel.grid=element_blank(),panel.border=element_blank(),axis.line=element_line(size=1,colour="black")) + # 去除网格线，添加坐标线
  scale_y_continuous(expand = c(0,0))+ # y轴起点从0开始
  #scale_fill_manual(values = c("darkorange","darkgreen"))+
 scale_fill_manual(values = c("#7900D7","#C99B98","#6DA08C","#96B683"))+
  #geom_text(aes(label = Mortality), size= 3.5, color = "black", family = "myFont1", position = position_dodge(0.5), vjust = 1.5) +  # 柱子添加文字数据标签
  theme(axis.text.x = element_text(size = 10, color = "black", face = "bold",angle = 45,hjust=1)) +  # X、Y坐标轴文字格式
  theme(axis.title.x = element_text(size = 10, color = "black", face = "bold")) +
  theme(axis.text.y = element_text(size = 10, color = "black", face = "bold")) +
  theme(axis.title.y = element_text(size = 10, color = "black", face = "bold")) +
  theme(legend.title = element_blank()) +   # 图例的标题
  theme(legend.text = element_text(face="bold", colour="black",size=10)) + # 图例字体格式、颜色和大小
  theme(legend.position = c(0.8,0.9), legend.background = element_blank()) # 设置图例位置和背景



