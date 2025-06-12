##
a<-read.table("/Users/wuzhongzi/Desktop/pp04.txt",header=F)
# 分割数据：对角线上方（红色）和其他区域（青色）
a_cyan <- a[a$V2 <= a$V1, ]  # 对角线和下方
a_red  <- a[a$V2 > a$V1, ]   # 对角线上方
# 先绘制青色点（底层）xlim=c(6,60),ylim=c(6,60),
plot(a_cyan$V1, a_cyan$V2, 
     col = "cyan3", 
     pch = 19, 
     cex = 0.4,
     xlab = "V1",
     ylab = "V2")
# 再叠加红色点（顶层）
points(a_red$V1, a_red$V2, 
       col = "red", 
       pch = 19, 
       cex = 0.5)
# 添加对角线参考线
abline(a = 0, b = 1, col = "gray", lty = 2)
##
