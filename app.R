library(shiny)
library(ggplot2)
# Data pre-processing ----
# Tweak the "am" variable to have nicer factor labels -- since this
# doesn't rely on any user inputs, we can do this once at startup
# and then use the value throughout the lifetime of the app
mydata <- read.csv("/Users/dazunsun/Documents/EDA/Proj/NYCTree.csv",
                   na.strings=c("","NA"), stringsAsFactors = FALSE)


# Define server logic to plot various variables against mpg ----
server <- function(input, output) {
  
  # Compute the formula text ----
  # This is in a reactive expression since it is shared by the
  # output$caption and output$mpgPlot functions
  dfInput <- reactive({
    mydata %>% filter (postcode == strtoi(input$zipcode))
  })
  
  # formulaText <- reactive({
  #   paste("density ~", d[input$variable])
  # })
  # 
  # Return the formula text for printing as a caption ----
  # output$caption <- renderText({
  #   formulaText()
  # })
  
  # Generate a plot of the requested variable against mpg ----
  # and only exclude outliers if requested
  output$densityPlot <- renderPlot({
    df_1 <- dfInput()
    ggplot(df_1, aes(x=tree_dbh)) + 
      geom_density(data = mydata, fill="grey", alpha = 0.5) + 
      geom_density(fill="lightblue", alpha = 0.5) + 
      xlim(0, 50)+labs(title=paste("density curve for", input$zipcode, sep = " "),
                        x="tree breast height diameter (cm)", y = "density")+ 
      theme(plot.title = element_text(size=22)) + 
      theme(axis.text=element_text(size=12),axis.title=element_text(size=16))
  })
  
}

# Define UI for miles per gallon app ----
ui <- fluidPage(
  
  # App title ----
  titlePanel("Plot by Zipcode"),
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      
      # Input: Selector for variable to plot against mpg ----
      # selectInput("variable", "Borough:",
      #             c("Bronx" = "Bronx",
      #               "Brooklyn" = "Brooklyn",
      #               "Queens" = "Queens",
      #               "Staten Island" = "Staten Island",
      #               "Manhattan" = "Manhattan")),
      textInput("zipcode", "Zip Code:", "10025")
      
    ),
    
    # Main panel for displaying outputs ----
    mainPanel(
      
      # Output: Formatted text for caption ----
      # h3(textOutput("caption")),
      
      # Output: Plot of the requested variable against mpg ----
      plotOutput("densityPlot")
      
    )
  )
)

shinyApp(ui, server)