# 加载必要的包
library(ggplot2)
library(scales)

# 假设数据格式如下：
# gwas_data <- data.frame(chr = ..., pos = ..., P = ..., r2 = ...)
# 你需要先读取数据： gwas_data <- read.table("your_file.txt", header = TRUE)
gwas_data<-read.table("/Users/wuzhongzi/Desktop/pp08_ld.txt",header=T)
# 添加 -log10P列
gwas_data$logP <- -log10(gwas_data$P)

# 指定R²对应的颜色
r2_colors <- c("grey" = "grey70", "0" = "#B3CDE3", "0.2" = "#6497B1", "0.4" = "#005B96", 
               "0.6" = "#66A61E", "0.8" = "#E6AB02", "1" = "#D53E4F")

# 设置颜色标签（binned）
gwas_data$r2_bin <- cut(gwas_data$r2,
                        breaks = c(-0.01, 0, 0.2, 0.4, 0.6, 0.8, 1),
                        labels = c("0", "0.2", "0.4", "0.6", "0.8", "1"))

# 如果存在NA
gwas_data$r2_bin <- as.character(gwas_data$r2_bin)
gwas_data$r2_bin[is.na(gwas_data$r2)] <- "grey"

# 绘图
ggplot(gwas_data, aes(x = pos/1000000, y = logP)) +
  geom_point(aes(color = r2_bin), size = 1, alpha = 0.8) +
  scale_color_manual(values = r2_colors, name = expression(R^2)) +
  labs(
    x = "Chromosome 8 (Mb)",  # 根据你自己的染色体和区域调整
    y = expression(-log[10](P)),
    title = NULL
  ) +ylim(0,32)+
  theme_bw(base_size = 14) +
  theme(
    legend.position = "right",
    panel.grid.minor = element_blank(),
    plot.title = element_text(hjust = 0.5)
  )