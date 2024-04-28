setwd('C:\\Users\\raaki\\OneDrive\\Documents\\RShiny')
library(tidyverse)
library(shiny)
library(shinythemes)
data <- read.csv('realnbadata.csv')
rownames(data) <- data$X
data <- data[, -which(names(data) == "X")]

ui <- fluidPage(theme = shinytheme("lumen"),
                
titlePanel("Ebb and Flow: The Cyclical Nature of NBA Team Performance"),
                
sidebarLayout(
                  
sidebarPanel(
  selectInput("team", "Team:",
  choices = colnames(data)),
  helpText("This Shiny app demonstrates NBA team performance over the years, starting from the 1999-2000 season. You can select a team from the dropdown menu to view their performance graph."),
  helpText("Team performances for the shortened 2011-2012, 2019-2020, and 2020-2021 NBA seasons was normalized to an 82-game standard using win rate percentages."),
  helpText("The Pelicans franchise did not exist before the 2002-2003 NBA season, so there are no records for them prior to that time."),
  helpText("Data from BasketballReference")
),
                  
mainPanel(
plotOutput("winPlot")
   )
  )
)

server <- function(input, output) {
  
  output$winPlot <- renderPlot({
    
    # Create the bar plot
    bp <- barplot(data[, input$team], 
            main = input$team,
            ylab = "Number of Wins",
            names.arg = NULL) 
    axis(side = 1, at = bp, labels = rownames(data), las = 2, cex.axis = 0.9)
  })
}
shinyApp(ui = ui, server = server)
