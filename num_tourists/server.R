#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)

# Define server logic required to draw a histogram
function(input, output, session) {

  # update selectInput "loc" according to the selected pref
  observeEvent(input$pref, {
    updateSelectInput(session = session,
                      inputId = "loc",
                      choices = city[[input$pref]])
  })
  
  # colour
  cols <- palette.colors()[c(2, 3, 4, 6)]
  
  # plot title
  output$result <- renderText({
    paste(input$pref, input$loc)
  })
  
  # line plot
  output$plot <- renderPlot({
    loc_data <- data |>
      dplyr::filter(`都道府県名` == input$pref,
                    `地域名称` == input$loc,
                    `年` %in% input$year) |>
      dplyr::mutate(`年` = as.factor(`年`))
    req(loc_data$`人数`)
    max_n <- loc_data |>
      dplyr::pull(`人数`) |>
      max()
    
    if (max_n > 10000) {
      loc_data <- loc_data |>
        dplyr::mutate(`人数` = `人数` / 10000)
      lab_y <- "人数（万人）"
    } else {
      lab_y <- "人数（人）"
    }
    ggplot(data = loc_data, aes(x = `月`, y = `人数`, color = `年`)) +
      geom_line(linewidth = 1) +
      geom_point(size = 2) +
      scale_x_continuous(breaks = 1:12, minor_breaks = NULL) +
      scale_y_continuous(name = lab_y) +
      scale_color_manual(values = cols[as.numeric(input$year) - 2020]) +
      theme_bw(base_size = 24)
  })
  
  # note
  output$note <- renderText({
    paste("出典: デジタル観光統計オープンデータ",
          "<https://www.nihon-kankou.or.jp/home/jigyou/research/d-toukei/>",
          "（2025年3月11日ダウンロード）")
  })
}
