# 加载必要的库
library(ggplot2)
library(dplyr)

# 读取数据
data <- read.table("/Users/wuzhongzi/Desktop/tss.txt", header = TRUE)

# 检查数据
head(data)

# 绘制密度图，按照不同的type分页显示
ggplot(data, aes(x = pos, fill = type)) +
  geom_density(alpha = 0.5) +  # 使用透明度
  scale_fill_manual(values = c("Liver" = "orange", 
                               "LD" = "red", 
                               "IMF" = "lightblue", 
                               "Backfat" = "green")) +
  labs(x = "Distance from target gene TSS (kb)", 
       y = "Density", 
       title = "SV-eQTL TSS distance distribution") +
  theme_minimal() +
  theme(legend.title = element_blank()) +
  facet_wrap(~type, scales = "free_y", ncol = 1)  # 竖排分页，每列一个子图