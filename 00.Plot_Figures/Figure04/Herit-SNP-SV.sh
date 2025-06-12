# 加载必要的库
library(ggplot2)
library(dplyr)

# 读取数据
data <- read.table("/Users/wuzhongzi/Desktop/herit_04.back.txt", header = F)

# 检查数据
head(data)

# 计算每组的平均值
mean_values <- data %>%
  group_by(V1) %>%
  summarise(mean_heritability = mean(V2))

# 绘制密度图，按照不同的type分页显示
ggplot(data, aes(x = V2, fill = V1)) +
  geom_density(alpha = 0.5) +  # 使用透明度
  scale_fill_manual(values = c("all" = "orange", 
                               "sv" = "red", 
                               "snp" = "darkgreen")) +
  labs(x = "Heritability", 
       y = "Density", 
       title = "") +
  theme_minimal() +
  theme(legend.title = element_blank()) +
  facet_wrap(~V1, scales = "free_y", ncol = 1) +  # 竖排分页，每列一个子图
  geom_vline(data = mean_values, aes(xintercept = mean_heritability), 
             color = "blue", linetype = "dashed", size = 1) + # 添加平均值竖线
  geom_text(data = mean_values, aes(x = mean_heritability, y = 0, 
                                     label = paste("Mean =", round(mean_heritability, 3))),
            color = "blue", hjust = -0.1, vjust = 0) # 添加平均值标签