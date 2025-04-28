#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)

# Define UI for application that draws a histogram
fluidPage(
  
  # Application title
  titlePanel("観光来訪者数"),
  
  # Sidebar with select lists
  sidebarLayout(
    sidebarPanel(
      selectInput(inputId = "pref",
                  label = "都道府県を選択してください:", choices = pref),
      selectInput(inputId = "loc",
                  label = "地域を選択してください:", choices = NULL),
      checkboxGroupInput(inputId = "year",
                         label = "年を選択してください:",
                         choices = as.character(2021:2024),
                         selected = as.character(2021:2024))
    ),
    
    mainPanel(
      textOutput("result"),
      plotOutput("plot"),
      textOutput("note")
    )
  )
)
