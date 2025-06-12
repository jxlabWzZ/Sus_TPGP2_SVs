# 读取基因列表
a <- read.table("/Users/wuzhongzi/Desktop/gg66.txt", header = FALSE)
genelist <- a$V1

# 加载必要的库
library(clusterProfiler)
library(org.Ss.eg.db)  # 使用猪的基因组数据库

# 将基因符号转换为Entrez ID
s.EntrezID <- bitr(genelist, fromType = "SYMBOL", toType = "ENTREZID", OrgDb = "org.Ss.eg.db")

# 执行GO富集分析
s.ego <- enrichGO(gene = s.EntrezID$ENTREZID, OrgDb = 'org.Ss.eg.db', 
                  pAdjustMethod = 'none', pvalueCutoff = 0.05, qvalueCutoff = 1, 
                  keyType = 'ENTREZID')

# 将GO分析结果写入文件
write.table(as.data.frame(s.ego), '/Users/wuzhongzi/Desktop/go.SS.txt', sep = '\t', row.names = FALSE, quote = FALSE)

# 绘制GO分析结果的柱形图和气泡图
s.barplot <- barplot(s.ego, showCategory = 30, drop = TRUE)
s.barplot
dotplot(s.ego)

# 执行KEGG富集分析
ekk <- clusterProfiler::enrichKEGG(s.EntrezID$ENTREZID, organism = "ssc",  # 使用猪的KEGG数据库
                                    pAdjustMethod = "none", pvalueCutoff = 0.5, qvalueCutoff = 0.5)

# 将KEGG分析结果写入文件
write.table(as.data.frame(ekk), '/Users/wuzhongzi/Desktop/kegg.ALL.txt', sep = '\t', row.names = FALSE, quote = FALSE)

# 绘制KEGG分析结果的柱形图和气泡图
barplot(ekk, showCategory = 10, title = "Enrichment Pathway")  # title可修改
dotplot(ekk, showCategory = 10, title = "Enrichment Pathway")  # title可修改

# 如果需要将GO分析结果按类别分开保存
BP <- subset(s.ego, Ontology == "BP")
CC <- subset(s.ego, Ontology == "CC")
MF <- subset(s.ego, Ontology == "MF")

write.table(as.data.frame(BP), '/Users/wuzhongzi/Desktop/go.BP.txt', sep = '\t', row.names = FALSE, quote = FALSE)
write.table(as.data.frame(CC), '/Users/wuzhongzi/Desktop/go.CC.txt', sep = '\t', row.names = FALSE, quote = FALSE)
write.table(as.data.frame(MF), '/Users/wuzhongzi/Desktop/go.MF.txt', sep = '\t', row.names = FALSE, quote = FALSE)