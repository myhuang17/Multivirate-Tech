#讀取資料
data = read.csv("C:\\Users\\user\\Desktop\\多變量報告\\data\\winequality-red.csv")
data = data[,-12]
#names(data) = c("x1","x2","x3","x4","x5","x6","x7","x8","x9","x10","x11")

#主成份分析
pca = prcomp(formula = ~ fixed.acidity+volatile.acidity+citric.acid
             +residual.sugar+chlorides+free.sulfur.dioxide
             +total.sulfur.dioxide+density
             +pH+sulphates+alcohol, data = data, scale = TRUE)
write.csv(pca$x,"C:\\Users\\user\\Desktop\\多變量報告\\data\\wq_pca.csv")
vars = (pca$sdev)^2 # 從pca中取出標準差(pca$sdev)後再平方，計算variance(特徵值)
props = vars / sum(vars)#每個主成分的解釋比例 = 各個主成分的特徵值/總特徵值
# 使用plot()函式 畫陡坡圖
plot(pca, # 放pca
     type="line", # 用直線連結每個點
     pch = 16,
     main="陡坡圖", col = "darkred") # 主標題
abline(h=1, col="orange")#BY 
cumulative.props = cumsum(props) # 累加前n個主成分的解釋比例
#取前4個主成份，可以解釋 70.8% 的變異
cumulative.props[4]

# 累積解釋比例圖
plot(cumulative.props, pch = 16, col = "darkred")

top2 = pca$x[, 1:4]
top2.ev = pca$rotation[,1:4]
fpca = top2.ev[,1]
spca = top2.ev[,2]
tpca = top2.ev[,3]
fopca = top2.ev[,4]
dotchart(fpca[order(fpca, decreasing = FALSE)], col="red", main = "第一主成份")
dotchart(spca[order(spca, decreasing = FALSE)], col="red", main = "第二主成份")
dotchart(tpca[order(tpca, decreasing = FALSE)], col="red", main = "第三主成份")
dotchart(fopca[order(fopca, decreasing = FALSE)], col="red", main = "第四主成份")
