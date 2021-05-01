

library(shiny)
library(shinythemes)
library(ggplot2)
redwinequality <- read.csv("https://raw.githubusercontent.com/gdr10/wine-quality/master/winequality-red.csv", sep=";")

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
               ),
               tabPanel("Multiple Linear",
                        sidebarLayout(
                            sidebarPanel(
                                "Multi-Variable Selection",
                                p("Select two different variables to test for correlation. Once you think you have 
                                  two correlated variables, check the box to perform a linear regression."),
                                selectInput("variable1",
                                            "Variable 1: ",
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
                                            selected = NULL),
                                selectInput("variable2",
                                            "Variable 2: ",
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
                                            selected = "Volatile Acidity"),
                                checkboxInput("performreg", "Perform Regression?", FALSE)
                            ),
                            mainPanel(
                                plotOutput("corplot"),
                                verbatimTextOutput("cortest"),
                                verbatimTextOutput("twovarreg")
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
    
    # Same as above, but for the first variable in the two-variable regression
    firstvar = reactive({
        if(input$variable1 == "fixed.acidity") return(redwinequality$fixed.acidity)
        if(input$variable1 == "volatile.acidity") return(redwinequality$volatile.acidity)
        if(input$variable1 == "citric.acid") return(redwinequality$citric.acid)
        if(input$variable1 == "residual.sugar") return(redwinequality$residual.sugar)
        if(input$variable1 == "chlorides") return(redwinequality$chlorides)
        if(input$variable1 == "free.sulfur.dioxide") return(redwinequality$free.sulfur.dioxide)
        if(input$variable1 == "total.sulfur.dioxide") return(redwinequality$total.sulfur.dioxide)
        if(input$variable1 == "density") return(redwinequality$density)
        if(input$variable1 == "pH") return(redwinequality$pH)
        if(input$variable1 == "sulphates") return(redwinequality$sulphates)
        if(input$variable1 == "alcohol") return(redwinequality$alcohol)
    })
    
    # Same as above, but for the second variable in the two-variable regression
    secondvar = reactive({
        if(input$variable2 == "fixed.acidity") return(redwinequality$fixed.acidity)
        if(input$variable2 == "volatile.acidity") return(redwinequality$volatile.acidity)
        if(input$variable2 == "citric.acid") return(redwinequality$citric.acid)
        if(input$variable2 == "residual.sugar") return(redwinequality$residual.sugar)
        if(input$variable2 == "chlorides") return(redwinequality$chlorides)
        if(input$variable2 == "free.sulfur.dioxide") return(redwinequality$free.sulfur.dioxide)
        if(input$variable2 == "total.sulfur.dioxide") return(redwinequality$total.sulfur.dioxide)
        if(input$variable2 == "density") return(redwinequality$density)
        if(input$variable2 == "pH") return(redwinequality$pH)
        if(input$variable2 == "sulphates") return(redwinequality$sulphates)
        if(input$variable2 == "alcohol") return(redwinequality$alcohol)
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
    # Plotting the variables the user chooses in two-variable regression
    output$corplot = renderPlot(
        ggplot(data = redwinequality, aes_string(x = input$variable1, y = input$variable2)) +
            geom_point() +
            geom_smooth(method = lm, formula = y~x)
    )
    # Printing the result of the correlation test between the two variables
    output$cortest = renderPrint(
        cor.test(firstvar(), secondvar())
    )
    output$twovarreg = renderPrint(
        if(input$performreg == TRUE) summary(lm(formula = quality ~ secondvar() + firstvar(), data = redwinequality))
    )
}

# Run the application 
shinyApp(ui = ui, server = server)
