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

# pref and city
pref <- data |>
  dplyr::select(`都道府県名`, `地域コード`) |>
  dplyr::arrange(`地域コード`) |>
  dplyr::pull(`都道府県名`) |>
  unique()

city <- purrr::map(pref,
                   \(x) data |>
                     dplyr::filter(`都道府県名` == x) |>
                     dplyr::select(`地域名称`, `地域コード`) |>
                     dplyr::arrange(`地域コード`) |>
                     dplyr::pull(`地域名称`) |>
                     unique() |>
                     as.list()
)
names(city) <- pref
