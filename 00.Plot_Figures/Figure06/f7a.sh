# 加载必要的库
library(ggplot2)
library(maps)

# 创建样本数据框（保持原始顺序）
sample_data <- data.frame(
  Breed = c("YNT", "SCT", "TT", "GST", "GZT", "XSBN", "DNXE", "WA", "WZS", "LUC", "BMX", "YCT", "Goett", "Ossa", "EWE", "CRO"),
  Longitude = c(99.7, 101.71, 91.11, 102.9, 99.99, 100.5, 101.56, 118.32, 109.51, 110.25, 107.25, -89.42, 9.93, -81.48, 13.33, -70.86),
  Latitude = c(27.83, 32.91, 29.97, 34.99, 31.62, 21.75, 24.48, 29.71, 18.77, 22.33, 24.15, 19.82, 51.53, 31.79, 52.52, 18.8)
)

# 将Breed转换为因子，锁定原始顺序
sample_data$Breed <- factor(sample_data$Breed, levels = unique(sample_data$Breed))

# 获取世界地图数据
world_map <- map_data("world")

# 修复后的绘图代码
ggplot() +
  # 先绘制地图（指定地图数据和专属映射）
  geom_polygon(
    data = world_map,
    aes(x = long, y = lat, group = group),  # 仅在地图图层中使用group
    fill = "lightblue", color = "white"
  ) +
  # 再添加采样点（独立数据和映射）
  geom_point(
    data = sample_data,
    aes(x = Longitude, y = Latitude, color = Breed),  # 不需要group参数
    size = 3
  ) +
  coord_fixed(1.1) +
  theme_minimal() +
  theme(
    panel.background = element_rect(fill = "white"),
    panel.grid = element_blank(),
    axis.title = element_blank(),
    axis.text = element_blank(),
    legend.position = "bottom",
    legend.text = element_text(size = 7)
  ) +
  labs(title = "World Map with Sampling Points") +
  guides(color = guide_legend(nrow = 4, byrow = TRUE))