# 加载必要的库
library(ggplot2)
library(dplyr)

# 读取数据
data <- read.table("/Users/wuzhongzi/Desktop/ldok.txt", header = TRUE)

# 检查数据
head(data)

# 绘制密度直方图，按照不同的type分页显示
ggplot(data, aes(x = ld, fill = type)) +
  geom_histogram(aes(y = ..density..), position = "identity", alpha = 0.5, bins = 50) +  # 使用透明度和指定的箱数
  scale_fill_manual(values = c("SV" = "orange", 
                                "SNP" = "darkgreen")) +
  labs(x = "LD (r2)", 
       y = "Density", 
       title = "SV-SNP LD distribution") +
  theme_minimal() +
  theme(legend.title = element_blank()) +
  geom_vline(xintercept = 0.8, linetype = "dashed", color = "red") +  # 添加红色竖线
  facet_wrap(~type, scales = "free_y", ncol = 1)  # 竖排分页，每列一个子图