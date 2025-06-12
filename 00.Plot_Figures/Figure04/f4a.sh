# 读取数据并处理格式
data <- read.table("/Users/wuzhongzi/Desktop/ppsv.txt", header = FALSE, col.names = c("Sample", "Type", "Value"))
data$Group <- gsub("^\\d+", "", data$Sample)  # 提取组织名称
data$Group <- factor(data$Group, 
                    levels = c("liver", "ld", "im", "back"))  # 固定分组顺序
data$Type <- factor(data$Type, 
                   levels = c("gene", "egene", "Svegene"))    # 固定基因类型顺序

# 加载绘图包
library(ggplot2)

# 绘制分组柱状图
ggplot(data, aes(x = Group, y = Value, fill = Type)) +
  geom_col(position = position_dodge(width = 0.7),      # 分组间距
           width = 0.6) +                               # 柱子宽度
  labs(x = "Tissue", y = " Number of genes", 
       title = "") +
  scale_fill_manual(values = c("grey60", "#ff7f0e", "#2ca02c")) + # 自定义颜色"#1f77b4", "#ff7f0e", "#2ca02c"
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5, size = 14, face = "bold"),
        axis.text = element_text(size = 10),
        legend.position = "right")

# 若要保存图片（取消注释使用）
# ggsave("grouped_barchart.png", width = 8, height = 6, dpi = 300)