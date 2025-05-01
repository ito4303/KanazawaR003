##
## Kanazawa.R #3 初心者向けチュートリアル
## 2025年5月10日
##

# 電卓としてつかう

1 + 2
3 - 4
5 * 6
7 / 8

# べき乗

2^3
2 ** 3

# 関数

sqrt(4) # sqrt()は平方根を返す関数

?sqrt # sqrt()のヘルプを表示
help(sqrt) # これでも同じ

log(100) # log()は自然対数を返す関数
log10(100) # log10()は常用対数を返す関数

# 演算子も実は関数

`+`(1, 2)

# ベクトル

c(1, 2, 3) # c()はベクトルを作る関数

1:10 # コロン(:)で連続する整数のベクトルをつくれる

# 代入

X <- c("AB", "CD", "EF") # 文字列のベクトル
                         # Xというオブジェクトに代入

# オブジェクトの内容を表示

X
print(X) # 明示的に表示

# 代入は"="でもよい

X = c("GH", "IJ", "KL")
X

# 逆向きの代入

c("abc", "def", "ghi") -> X
X

# カッコで囲むと代入と表示を同時にできる

(X <- c(1, 2, 3))

# 因子型
# カテゴリカルデータ（名義尺度変数）を扱うためのデータ型

Y <- factor(c("リンゴ", "ミカン", "ブドウ", "リンゴ")) # 因子型を作る関数
Y

# 順序つきの因子型

answer <- ordered(c("普通", "良い", "悪い", "普通", "良い", "普通"),
                  levels = c("悪い", "普通", "良い"))
answer

# 集計して表にする

table(answer)

# 行列

matrix(1:6, nrow = 2, ncol = 3) # 行列を作る関数

# byrow = TRUE という引数をつけると行優先になる

matrix(1:6, 2, 3, byrow = TRUE) # 行優先
                                # 順番どおりなら引数の名前は省略できる

# ヘルプを確認

?matrix # matrix()のヘルプを表示

# TRUE/FALSEは論理型(logical)

class(TRUE)

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

# リストにはなんでも入れられる

L <- list(a = c(1, 2), b = "abc", c = matrix(1:4, nrow = 2))
L

L[["a"]] # リストの要素を取り出す
L[["b"]]
L[["c"]]

L$a # 簡単な書き方

# リスト構造を解く

unlist(L)

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

install.packages("setariaviridis") # install.packagesはパッケージを
                                   # インストールする関数
# setariaviridis は、エノコログサ(Setaria viridis)の測定データを収めたパッケージ

library(setariaviridis) # library関数でパッケージを読み込む
?setariaviridis # パッケージのヘルプを表示

View(setaria_viridis)    # データを表計算ソフトのように表示

summary(setaria_viridis) # データの要約を表示

# 記述統計

mean(setaria_viridis$culm_length)  # 平均
var(setaria_viridis$culm_length)   # 不偏分散
sd(setaria_viridis$culm_length)    # 標準偏差

# dplyrパッケージを使ったデータの抽出とパイプ演算子

setaria_viridis |>
  dplyr::select(culm_length) |>  # culm_length列を抽出
  mean()                         # 平均

# パッケージ名::関数名 で、パッケージを読み込まなくても関数を使用できる
# ほかのパッケージと関数名がかぶるときに、どのパッケージの関数か明示的に指定できる

# パイプ演算子は結果を次の関数の第1引数として渡す
# magrittrパッケージの %>% も同じ

setaria_viridis |>
  dplyr::filter(culm_length > 60) # culm_lengthが60以上のデータを抽出




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

