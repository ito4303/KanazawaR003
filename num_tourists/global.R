#
# Global settings
#

library(shiny)
library(nanoparquet)
library(ggplot2)

# data
data_dir <- "data"
data_file <- c("city2021-2024.parquet")

# read data
data <- read_parquet(file.path(data_dir, data_file))

# 都道府県名を抽出
pref <- data |>
  dplyr::select(`都道府県名`, `地域コード`) |>
  dplyr::arrange(`地域コード`) |>
  dplyr::pull(`都道府県名`) |>
  unique()

# 各都道府県の市区町村名のベクトルを作成し、リストにする
city <- purrr::map(pref,
                   \(x) data |>
                     dplyr::filter(`都道府県名` == x) |>
                     dplyr::select(`地域名称`, `地域コード`) |>
                     dplyr::arrange(`地域コード`) |>
                     dplyr::pull(`地域名称`) |>
                     unique() |>
                     as.list()
)

# リストの名前を都道府県名にする
names(city) <- pref
