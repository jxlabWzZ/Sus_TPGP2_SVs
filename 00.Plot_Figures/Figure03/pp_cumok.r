
###
a<-read.table("/Users/wuzhongzi/Desktop/svok_num.txt",header=F)
plot(a$V1,a$V2+a$V3+a$V4+a$V5,type="h",col="#975AA4",ylim=c(0,120000))
points(a$V1,a$V2+a$V3+a$V4,type="h",col="#D96161")
points(a$V1,a$V2+a$V3,type="h",col="#75A140")
points(a$V1,a$V2,type="h",col="#F5AA42")


###bb
a<-read.table("/Users/wuzhongzi/Desktop/svok_numbb.txt",header=F)
plot(a$V1,a$V2+a$V3+a$V4+a$V5,type="h",col="#975AA4",ylim=c(0,130000))
points(a$V1,a$V2+a$V3+a$V4,type="h",col="#D96161")
points(a$V1,a$V2+a$V3,type="h",col="#75A140")
points(a$V1,a$V2,type="h",col="#F5AA42")
