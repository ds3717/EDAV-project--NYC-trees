library(shiny)
library(ggplot2)
library(dplyr)
# Data pre-processing ----

mydata <- read.csv("./interactive_data.csv",
                   na.strings=c("","NA"), stringsAsFactors = FALSE)
mydata <- mydata %>%
  filter(zipcode != 0)
valid_zip <- distinct(mydata, zipcode)

server <- function(input, output) {
  
  dfInput <- reactive({
    mydata %>% filter (zipcode == strtoi(input$zipcode)) %>%
      filter(Year == strtoi(input$variable))
  })
  
  output$barPlot <- renderPlot({
    df_1 <- dfInput()
    ggplot(df_1, aes(x=spc_common)) + 
      geom_bar(aes(y=(..count..)), fill = "lightblue") + 
      labs(title=paste("Species Count for Zipcode", input$zipcode, "in Year", 
                                   input$variable, sep = " "),
                       x="species", y = "count")+ 
      theme(plot.title = element_text(size=25)) + 
      theme(axis.text=element_text(size=16),axis.title=element_text(size=20)) +
      ylim(0, 750) + coord_flip()
  })
  dfInput2 <- reactive({
    mydata %>% filter (zipcode == strtoi(input$zipcode2)) %>%
      filter(Year == strtoi(input$variable2))
  })
  output$densityPlot <- renderPlot({
    df_1 <- dfInput2()
    ggplot(df_1, aes(x=tree_dbh)) + 
      geom_density(data = mydata, fill="grey", alpha = 0.5) + 
      geom_density(fill="lightblue", alpha = 0.5) + 
      xlim(0, 50)+labs(title=paste("Tree Diameter Density Curve for Zipcode", input$zipcode2, "in Year", 
                                   input$variable2, sep = " "),
                       x="tree breast height diameter (inch)", y = "density")+ 
      theme(plot.title = element_text(size=25)) + 
      theme(axis.text=element_text(size=16),axis.title=element_text(size=20))+
      ylim(0,0.15)
    
  })
  
  output$txtout <- renderText({
    if (strtoi(input$zipcode) %in% valid_zip$zipcode){
      ""
    } else {
      "Invalid Zipcode. Try Again!"
    }
  })
  output$txtout2 <- renderText({
    if (strtoi(input$zipcode2) %in% valid_zip$zipcode){
      ""
    } else {
      "Invalid Zipcode. Try Again!"
    }
  })
  
}
ui = tagList(
  # shinythemes::themeSelector(),
  navbarPage(
    # theme = "cerulean",  # <--- To use a theme, uncomment this
    "Interactive Graph by Zipcode & Year",
    tabPanel("Species Count",
             sidebarLayout(
               
               # Sidebar panel for inputs ----
               sidebarPanel(
                 
                 # Input
                 selectInput("variable", "Year:",
                             c("1995" = "1995",
                               "2005" = "2005",
                               "2015" = "2015")),
                 textInput("zipcode", "Zip Code: (10001 - 10475)", "10025"),
                 # Output
                 verbatimTextOutput("txtout")
               ),
               
               # Main panel for displaying outputs ----
               mainPanel(
                 
                 # Output
                 plotOutput("barPlot")
                 
               )
             )
    ),
    tabPanel("Density Plot", 
             sidebarLayout(
               
               # Sidebar panel for inputs ----
               sidebarPanel(
                 
                 # Input
                 selectInput("variable2", "Year:",
                             c("1995" = "1995",
                               "2005" = "2005",
                               "2015" = "2015")),
                 textInput("zipcode2", "Zip Code: (10001 - 10475)", "10025"),
                 # Output
                 verbatimTextOutput("txtout2")
                 
               ),
               
               # Main panel for displaying outputs ----
               mainPanel(
                 
                 # Output
                 plotOutput("densityPlot"),
                 h5("Grey plot represents density curve of all the data."),
                 h5("Lightblue plot represents density curve of data given zip code and year.")
                 
               )
             ))
  )
)


shinyApp(ui, server)