

library(shiny)
library(shinythemes)
library(ggplot2)
redwinequality <- read.csv("~/Comp Stats/winequality-red.csv", sep=";")

# Define UI
ui <- fluidPage(
    theme = shinytheme("united"),
    # Application title and holding page
    navbarPage("Quality of Various Red Wines",
               # Show the raw data used
               tabPanel("The Data",
                   mainPanel(
                       p("This is the raw data we are using. It measures the amounts of various chemicals
                        in a number of red wines, and the eventual quality rating on a scale of 1-10. In
                         the following tabs you can attempt some regression tests to find out the most 
                         important factors in determining the final quality."),
                       tableOutput("rawdata"))
               ),
               tabPanel("Simple Linear",
                   sidebarLayout(
                       sidebarPanel(
                           "Variable Selection",
                           p("Select a variable from the list to compare with quality."),
                           selectInput("variable",
                                       "Variable: ",
                                       c("Fixed Acidity" = "fixed.acidity",
                                         "Volatile Acidity" = "volatile.acidity",
                                         "Citric Acid" = "citric.acid",
                                         "Residual Sugar" = "residual.sugar",
                                         "Chlorides" = "chlorides",
                                         "Free Sulfur Dioxide" = "free.sulfur.dioxide",
                                         "Total Sulfur Dioxide" = "total.sulfur.dioxide",
                                         "Density" = "density",
                                         "pH",
                                         "Sulphates" = "sulphates",
                                         "% ABV" = "alcohol"),
                                       selected = NULL)
                       ),
                       mainPanel(
                           plotOutput("linearplot"),
                           
                       )
                   )
               )
    ),
)

# Define server logic 
server <- function(input, output) {

    # Display the raw data as a table
    output$rawdata = renderTable(
        redwinequality, 
        width = "500px"
    )
    # Reactive function to convert the input of 
    # Plotting the data and a linear regression line based on the variable chosen by the user
    output$linearplot = renderPlot(
        ggplot(data = redwinequality, aes_string(x = input$variable, y = "quality")) +
            geom_point() +
            geom_smooth(method = lm, formula = y~x)
    )
    # Showing the actual linear regression formula
    linearfit = lm(formula = quality ~ input$variable, data = redwinequality)
    output$simplelinear = renderPrint(
        summary(linearfit)
    )
}

# Run the application 
shinyApp(ui = ui, server = server)
