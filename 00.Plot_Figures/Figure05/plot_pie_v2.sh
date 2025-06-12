# 设置图形布局为 2x2
par(mfrow = c(2, 1))
# 第一行左图：主要为灰色，5% 为绿色
pie(c(1, 33), labels = c("Ref", "Alt"), col = c("grey", "orange"), main = "AF in EWB")
# 第一行右图：主要为绿色，5% 为白色
pie(c(1690, 32), labels = c("Ref", "Alt"), col = c("grey", "orange"), main = "AF in EDP")

# 设置图形布局为 2x2
par(mfrow = c(2, 1))
# 第一行左图：主要为灰色，5% 为绿色
pie(c(139, 5), labels = c("Ref", "Alt"), col = c("grey", "orange"), main = "AF in AWB")
# 第一行右图：主要为绿色，5% 为白色
pie(c(73, 129), labels = c("Ref", "Alt"), col = c("grey", "orange"), main = "AF in ADP")

# 设置图形布局为 2x2
par(mfrow = c(2, 1))
# 第一行左图：主要为灰色，5% 为绿色
pie(c(7, 45), labels = c("Ref", "Alt"), col = c("grey", "orange"), main = "AF in TT")
# 第一行右图：主要为绿色，5% 为白色
pie(c(567, 113), labels = c("Ref", "Alt"), col = c("grey", "orange"), main = "AF in ADP")

# 设置图形布局为 2x2
par(mfrow = c(2, 1))
# 第一行左图：主要为灰色，5% 为绿色
pie(c(118, 74), labels = c("Ref", "Alt"), col = c("grey", "orange"), main = "AF in NCB")
# 第一行右图：主要为绿色，5% 为白色
pie(c(29, 795), labels = c("Ref", "Alt"), col = c("grey", "orange"), main = "AF in SCB")