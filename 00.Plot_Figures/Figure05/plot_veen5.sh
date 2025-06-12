# 读取数据（假设第五个文件为 ven.bwp，对应变量BWP）
lv <- read.table("/Users/wuzhongzi/Desktop/eg01.txt", header=F)
im <- read.table("/Users/wuzhongzi/Desktop/eg02.txt", header=F)
ld <- read.table("/Users/wuzhongzi/Desktop/eg03.txt", header=F)
bc <- read.table("/Users/wuzhongzi/Desktop/eg04.txt", header=F)
BWP <- read.table("/Users/wuzhongzi/Desktop/ft04.txt", header=F)  # 新增第五个数据集

# 创建列表（包含5个集合）
mydata <- list(
 BWP = BWP$V1,
  lv = lv$V1,
  ld = ld$V1,
  im = im$V1,
  bc = bc$V1  # 添加第五个集合
)

# 安装并加载ggVennDiagram包（若未安装）
# install.packages("VennDiagram")
library(VennDiagram)
#library(ggplot2)

# 绘制五元韦恩图
venn_plot <- venn.diagram(
  x=mydata,  # 指定每个集合的元素范围
  filename = NULL,  # 指定保存图像文件的文件名
  col = "black",  # 设置维恩图的边界线颜色为黑色
  fill = c("dodgerblue", "goldenrod1", "darkorange1", "seagreen3", "orchid3"),  # 设置维恩图每个区域的填充颜色
  alpha = 0.50,  # 设置维恩图每个区域的透明度
cex=1,
 # cex = c(1.5, 1.5, 1.5, 1.5, 1.5, 1, 0.8, 1, 0.8, 1, 0.8, 1, 0.8,
 #         1, 0.8, 1, 0.55, 1, 0.55, 1, 0.55, 1, 0.55, 1, 0.55, 1, 1, 1, 1, 1, 1.5),  # 设置文本标签的大小
  cat.col = c("dodgerblue", "goldenrod1", "darkorange1", "seagreen3", "orchid3"),  # 设置类别标签的颜色
  cat.cex = 1.5,  # 设置类别标签大小
  cat.fontface = "bold",  # 设置类别标签的字体加粗
  margin = 0.05  # 设置维恩图的边缘宽度
)# 显示图形
grid.draw(venn_plot)

# 保存为PDF（调整画布大小适应5个集合）
ggsave(
  filename = "/Users/wuzhongzi/Desktop/ven_fst04.pdf",
  plot = venn_plot,
  width = 5,
  height = 5,
  device = "pdf"
)

# 保存为PNG（高分辨率）
#ggsave(
 # filename = "/Users/wuzhongzi/Desktop/ven_fst01.png",
 # plot = venn_plot,
#  width = 10,
 # height = 8,
 # dpi = 300,
#  device = "png"
#)