

library(shiny)
library(shinythemes)
library(ggplot2)
redwinequality <- read.csv("winequality-red.csv", sep=";")

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
                           p("Select which variable you would like to use for the linear regression."),
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
                           verbatimTextOutput("simplelinear")
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
    # Reactive function to convert the input variable from a string into a useable variable
    inputvar = reactive({
        if(input$variable == "fixed.acidity") return(redwinequality$fixed.acidity)
        if(input$variable == "volatile.acidity") return(redwinequality$volatile.acidity)
        if(input$variable == "citric.acid") return(redwinequality$citric.acid)
        if(input$variable == "residual.sugar") return(redwinequality$residual.sugar)
        if(input$variable == "chlorides") return(redwinequality$chlorides)
        if(input$variable == "free.sulfur.dioxide") return(redwinequality$free.sulfur.dioxide)
        if(input$variable == "total.sulfur.dioxide") return(redwinequality$total.sulfur.dioxide)
        if(input$variable == "density") return(redwinequality$density)
        if(input$variable == "pH") return(redwinequality$pH)
        if(input$variable == "sulphates") return(redwinequality$sulphates)
        if(input$variable == "alcohol") return(redwinequality$alcohol)
    })
    
    # Plotting the data and a linear regression line based on the variable chosen by the user
    output$linearplot = renderPlot(
        ggplot(data = redwinequality, aes_string(x = input$variable, y = "quality")) +
            geom_point() +
            geom_smooth(method = lm, formula = y~x)
    )
    # Showing the actual linear regression formula
    output$simplelinear = renderPrint(
        summary(lm(formula = redwinequality$quality ~ inputvar()))
    )
}

# Run the application 
shinyApp(ui = ui, server = server)
