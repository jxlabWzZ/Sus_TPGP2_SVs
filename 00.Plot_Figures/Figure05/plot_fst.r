manhattanPlot = function(chrs = 1:19,trait="",dat = dat,main="",ylab="Fst/(1-Fst)")
{				
  
  CHR = as.character(dat$chr)
  CHR[CHR=="X"]=19
  CHR = as.numeric(as.character(CHR))
  POS = as.numeric(dat$pos)
  if(max(POS) > 1000){
    POS = POS/1e6 # change the bp to Mb
  } 
  chrLen <- tapply(POS,CHR,max) # a vector to store the length of each chromosome
  chrmk <- numeric() # a vector to store the numbers that markers the positions where the chromsome labels should be put
  for(i in 1:length(chrLen)){
    chrmk[i] <- sum(as.numeric(chrLen[1:i]))
  }
  mkrPos = numeric(length(POS)) # a vector to store the position of each SNP across the entire genome
  
  for(i in as.numeric(unique(CHR))){
    if(i == 1)
      mkrPos[CHR == i] = POS[CHR == i]
    else 
      mkrPos[CHR == i] = POS[CHR == i] + chrmk[i-1]
  }
  
  #============================ Start Plotting ===================================
  color <- rep(c("orange","darkgreen"),12)
  #color <- rep(c("grey","black"),12)
  #color <- c("darkred","darkgreen","cyan","red", "darkblue", "brown",
  #             "black","orange","darkred","darkgreen","cyan",
  #			   "red", "darkblue", "brown","black","orange","darkred",
  #			   "darkgreen","cyan","red","blue","brown","black","orange")   
  color2 <- color          
  idx = which(dat[,"chr"] %in% chrs)
  positions = mkrPos
  chridx = which(CHR %in% chrs[1])
  plot(positions[chridx], dat[chridx, trait],lwd = 1, col = color2[1], 
       type = "p", pch = 19,ylab = ylab,xlab ="Chromosome",
       xlim = c(0,max(positions,na.rm=T)),main=main,xaxt="n",cex.lab=3,cex.axis = 2,
       ylim = c(0,70),
       xaxs = "i",yaxs = "i",cex=1,bty="n")
  for(chrom in 2:19){
    chridx = which(CHR %in% chrs[chrom])
    points(positions[chridx],dat[chridx, trait],lwd = 1,cex=1,col=color2[chrom],pch = 19)
  }
  #    abline(h=-log10(0.05/nrow(dat)),lty=2,lwd=2)
 #abline(h=2,lty=2,lwd=2,col="red")
 abline(h=059/(1-0.59),lty=2,lwd=2,col="red")
 #abline(h=0.477/(1-0.477),lty=2,lwd=2,col="red")
 #abline(h=0.285/(1-0.285),lty=2,lwd=2,col="red")
#abline(h=0.381/(1-0.381),lty=2,lwd=2,col="red")
  #  abline(h=-log10(1E-10),lty=1,lwd=2)
  axis(side=1,at=(chrmk-(chrLen/2)),labels=unique(CHR),cex.axis = 2) 
  positions<-as.numeric(positions)
  dat<-as.data.frame(dat)
  aaa<-as.numeric(dat$logp)
  tmpdat<-cbind(positions,aaa)
  tmpdat<-as.data.frame(tmpdat)
  tmpdat<-tmpdat[which(tmpdat$aaa >= 5.5),]
  bb<-tmpdat$positions
  #arrows(x0=bb,y0=25,y1=23,x1=bb,length=0.08,col=rgb(255,140,0,65, maxColorValue=255))
}

b<-read.table("/Users/wuzhongzi/Desktop/fst01.txt",header=T)
chr=b$chr;pos=b$pos;lop=b$fst/(1-b$fst)
plotb = data.frame(chr,pos,lop)
plotb<-plotb[which( plotb$chr != "Y" & plotb$lop > 0),]
plotb$logp<-plotb$lop

#png("/Users/wuzhongzi/Desktop/ppSS.fst.png",height=1200,width=5400,res=300)
#par(mai=c(1,1.2,0.5,0.3))
#manhattanPlot(dat=plotb,trait="logp")
#dev.off()
pdf("/Users/wuzhongzi/Desktop/ppSS.fst.pdf",height=4,width=16)
par(mai=c(1,1.2,0.5,0.3))
manhattanPlot(dat=plotb,trait="logp")
dev.off()


