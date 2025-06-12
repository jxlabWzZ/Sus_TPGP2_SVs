
library(ggsci)
colo<- pal_npg(alpha=0.6)(6)
par(mar=c(5,5,4,4))
pdf(file="/Users/wuzhongzi/Desktop/NcGbJgg_SV.pdf",width=6,height=5)
### plot
plot(1:200, 1:200, ylim = c(0,200), xlim = c (-20,210), type = "n",,bty="n",xaxt="n",yaxt="n",xlab="Proportion of all SV Loci",ylab="",cex.lab=1.2)
axis(side=1,at=c(0,10,20,30,40,50,60,70,80,90,100,110,120,130,140,150,160,170,180,190,200),labels=c("100%","","","","","50%","","","","","0%","","","","","50%","","","","","100%"),cex.axis=1,font.axis=1,las=1)
### All SVs
rect(ybottom = 0, xleft = 0, ytop = 20, xright = 100,col=colo[1])
rect(ybottom = 0, xleft = 100, ytop = 20, xright = 200,col=colo[2])
rect(ybottom = 0, xleft = 53.004, ytop = 20, xright = 153.985, angle = 45, density =10,lwd=2 )
#abline(v=100)
### legend
legend("topleft", legend = c("Specific SVs in this study","SVs overlaped with public dataset","Specific SVs in public dataset","SVs overlaped with this study") ,
	fill = c(colo[1],colo[1],colo[2],colo[2]) ,
    bty = "n" ,horiz = FALSE, inset = c(0.05, 0.05))
legend("topleft", legend = c("Specific SVs in this study","SVs overlaped with public dataset","Specific SVs in public dataset","SVs overlaped with this study") ,
	 density=c(0,30,0,30),angle=c(0,45,0,45),, bty = "n" ,horiz = FALSE, inset = c(0.05, 0.05))
### DEL
rect(ybottom = 30, xleft = 0, ytop = 50, xright = 100,col=colo[1])
rect(ybottom = 30, xleft = 100, ytop = 50, xright = 200,col=colo[2])
rect(ybottom = 30, xleft = 36.546 , ytop = 50, xright = 156.994 ,angle = 45, density =10,lwd=2 )
### INS 
rect(ybottom = 60, xleft = 0, ytop = 80, xright = 100,col=colo[1])
rect(ybottom = 60, xleft = 100, ytop = 80, xright = 200,col=colo[2])
rect(ybottom = 60, xleft = 64.982 , ytop = 80, xright = 166.628 ,angle = 45, density =10,lwd=2 )
### DUP
rect(ybottom = 90, xleft = 0, ytop = 110, xright = 100,col=colo[1])
rect(ybottom = 90, xleft = 100, ytop = 110, xright = 200,col=colo[2])
rect(ybottom = 90, xleft = 52.255 , ytop = 110, xright = 131.216 ,angle = 45, density =10,lwd=2 )
###INV
rect(ybottom = 120, xleft = 0, ytop = 140, xright = 100,col=colo[1])
rect(ybottom = 120, xleft = 100, ytop = 140, xright = 200,col=colo[2])
rect(ybottom = 120, xleft = 35.403 , ytop = 140, xright = 109.761 ,angle = 45, density =10,lwd=2 )

abline(v=100)
dev.off()