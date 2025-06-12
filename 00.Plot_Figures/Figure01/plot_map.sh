library(ggplot2) # Create Elegant Data Visualisations Using the Grammar of Graphics
library(tidyr) # Flexibly Reshape Data: A Reboot of the Reshape Package
library(ggh4x)
library(maps)
library(reshape2)

df_map <- map_data("world")
 a<-read.table("/Users/wuzhongzi/Desktop/pp.txt",header=T)
b<-read.table("/Users/wuzhongzi/Desktop/pp2.txt",header=T)
site=cbind(a,b)
site$group=factor(site$Breed,levels=c("GDSCW","AHSCW","FJSCW","ZJSCW","SCW","VIE","JXSCW","HLNCW","NARSW","HBNCW","JLNCW","NCW","NMNCW","KRW","ARSW","YNT","SCT","TT","GST","GZT","Jeju","KNP","Woori","Nanc","NY","HT","MAS","BAM","MIN","YN","LWU","LGS","GLGS","LL","GuiS","ES","HN","GDSE","TC","YDB","GZS","HUAI","MSP","PUT","RC","DHB","DNXE","SB","Yacha","WA","XSBN","QSH","TG","SZL","DWZ","LT","JH","MS","HC","NX","BAS","WZS","LA","DB","NJ","LUC","LJ","BMX","EHL","DxNA","BxT","F3","F1","F2","SUT","SH","F6","DU","LW","DLY","SWLW","FLW","LR","WDU","USLW","LY","PLR","PT","YCT","Goett","Ossa","KNDP","NGDP","EWE","MGC","BKS","AGDP","CRO","IBR","GOS","LB","HP","HRP","GYP","LCM","TPJ","NS","HA","AM","MLM","KK","NTLW","ITAW","ERSW","EWB","NRSW","SPAW","GWB","FRWB","TNSW","Pha","Por","Potp","Pot","Phae","S.ceb","S.ver","S.bar","S.cel"))
ggplot()+geom_polygon(data=df_map,aes(long,lat,group=group),fill="white")+geom_point(site,mappin=aes(Longitude,Latitude,fill=group),color="grey40",size=2,shape=21,show.legend=F)+theme_void()+
theme(plot.background=element_rect(fill="#76daff"))+
scale_fill_manual(values=site$Col)

####
ggplot(site,aes(x=group))+
geom_col(aes(y=Total+10,fill=group))+
coord_polar()+
theme_void()+
 scale_y_continuous(limits=c(-400,400))+ 
 geom_text_aimed(aes(y=-30,label=group,group=group),nudge_y=1,size=1.1)+
 geom_text_aimed(aes(y=Total+25,label=Total,group=group),nudge_y=1,size=1.3,col=site$Col)+
labs(fill=NULL)+
scale_fill_manual(values=site$Col)

