##
## Kanazawa.R #3 初心者向けチュートリアル
## 2025年5月10日
##

# 四則演算

1 + 2

3 - 4

5 * 6

7 / 8

# べき乗

2^3

2 ** 3

# 平方根

sqrt(4) # sqrt()は平方根を返す関数

?sqrt # sqrt()のヘルプを表示
help(sqrt) # これでも同じ

# 演算子も実は関数

`+`(1, 2)

# ベクトル

c(1, 2, 3) # c()はベクトルを作る関数

1:10 # 連続する整数のベクトル

# 代入

X <- c("AB", "CD", "EF") # 文字列のベクトル
                         # Xというオブジェクトに代入
# "="でもよい

X = c("AB", "CD", "EF")

# 表示

X
print(X) # 明示的に表示

# 因子型
# カテゴリカルデータを扱うためのデータ型

(Y <- factor(c("AB", "CD", "EF"))) # 因子型を作る関数
# カッコで囲むと結果を表示できる

# 行列

matrix(c(1, 2, 3, 4), nrow = 2, ncol = 2) # 行列を作る関数

# byrow = TRUE という引数をつけると行優先になる

matrix(c(1, 2, 3, 4), 2, 2, byrow = TRUE) # 行優先

# ヘルプを確認

?matrix # matrix()のヘルプを表示

# 行列演算

A <- matrix(c(1, 2, 3, 4), nrow = 2, ncol = 2) # 行列をAというオブジェクトに代入
B <- matrix(c(2, 0, 0, 2), nrow = 2, ncol = 2) # 行列をBというオブジェクトに代入

A
B

A + B # 行列の足し算

A - B # 行列の引き算

A %*% B # 行列の掛け算

A * B # "*"だと要素ごとの掛け算になる

?`%*%` # 行列の掛け算のヘルプを表示

# リスト型

list(a = 1, b = 2, b = 3) # リストを作る関数

L <- list(a = c(1, 2), b = "abc", c = matrix(1:4, nrow = 2)) # リストにはなんでも入れられる

L

L[["a"]] # リストの要素を取り出す
L[["b"]]
L[["c"]]

L$a # 簡単な書き方

# データフレーム型
# リスト型で、要素の数がそろっていて、行列のようにあつかえる

member <- data.frame(name = c("鈴木", "佐藤", "田中"),
                     age = c(20, 30, 40),
                     height = c(170, 160, 180))
member

member$name # name列を取り出す

member[, 1] # これでも同じ（Rの添え字は1から始まります）

member[, "name"] # これでも同じ

member[2, ] # 2行目を取り出す

member[2, "name"] # 2行目のname列を取り出す
member[2, 1]      # これでも同じ
member$name[2]    # これでも同じ

# パッケージの利用

install.packages("setariaviridis") # パッケージをインストールする関数
# setariaviridis は、エノコログサ(Setaria viridis)の測定データを収めたパッケージ
library(setariaviridis) # パッケージを読み込む
?setariaviridis # パッケージのヘルプを表示

View(setaria_viridis)    # データを表計算ソフトのように表示

summary(setaria_viridis) # データの要約を表示

# 記述統計

mean(setaria_viridis$culm_length)  # 平均
var(setaria_viridis$culm_length)   # 不偏分散
sd(setaria_viridis$culm_length)    # 標準偏差

# ggplot2パッケージを使ったグラフの描画

install.packages("ggplot2") # ggplot2パッケージをインストール
library(ggplot2) # ggplot2パッケージを読み込む
?ggplot2 # ggplot2のヘルプを表示

# culm_lengthを横軸に、panicle_lengthを縦軸にした散布図を描く

ggplot(data = setaria_viridis,
       mapping = aes(x = culm_length, y = panicle_length)) +
  geom_point() + # 散布図
  labs(title = "Setaria viridis", # タイトル
       x = "Culm length (cm)", y = "Panicle length (cm)") # 軸ラベル

# 参考までにデフォルトのbaseグラフィックスなら

plot(x = setaria_viridis$culm_length,
     y = setaria_viridis$panicle_length,
     type = "p",
     main = "Setaria viridis",
     xlab = "Culm length (cm)", ylab = "Panicle length (cm)")

# あるいは

plot(panicle_length ~ culm_length, data = setaria_viridis,
     type = "p",
     main = "Setaria viridis",
     xlab = "Culm length (cm)", ylab = "Panicle length (cm)")

# ggplot2に戻ります
# 根株ごとに色を変える

ggplot(data = setaria_viridis,
       mapping = aes(x = culm_length, y = panicle_length,
                     colour = factor(root_number))) +
  geom_point(size = 3) +  # 点のサイズを変える
  labs(title = "Setaria viridis",
       x = "Culm length (cm)", y = "Panicle length (cm)") +
  scale_colour_discrete(name = "Root number")

