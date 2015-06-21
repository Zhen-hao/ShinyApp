# load shiny package
library(shiny)
# begin shiny UI 
shinyUI(navbarPage("Shiny Project",

                
# Create App tab
tabPanel("Predicting Miles per gallon (MPG) by horsepower and weight", 
         # fluid row for space holders                
         fluidRow(  
                 # fluid columns
                 column(6, div(style = "height: 150px")), 
                 column(6, div(style = "height: 150px"))
                 ),
         
         # main content
         fluidRow(
                 column(6, h4("The predicted value of MPG is",
                              span(textOutput("predict", inline = TRUE), 
                                   style = "color: green; font-size: 20px")
                              ),
                        style = "padding-left: 20px"
                 )
         ),
         
         # main content
         fluidRow(
                 column(12,h4("The predicted value of MPG",
                                span(textOutput("population", inline = TRUE), 
                                style = "color: green; font-size: 20px"),
                                "shown in the Histogram of MPG values in mtcars"),
                        tags$hr(),plotOutput("popHist"), 
                        # additional style
                        style = "padding-left: 20px"
                 )
         ),
         
# absolute panel
absolutePanel(
        # position attributes
        top = 50, left = 0, right =0, 
        fixed = TRUE,
        # panel with predefined background 
        wellPanel(
                fluidRow(
                        # sliders
                        column(6, sliderInput("hp", "Gross Horsepower:", min = min(mtcars$hp), max = max(mtcars$hp), value = 200),
                                
                               style = "padding-left: 20px"
                               ),
                        column(6, sliderInput("wt", "Weight (lb):", min = min(1000* mtcars$wt), max = max(1000* mtcars$wt), value = 3000)
                        
                               )
                        ),
                fluidRow(
                        
                        ),
                style = "opacity: 0.80; z-index: 90;"
                )
        )
        ),

# create Documentation Tab
tabPanel("Documentation",
         h3("Predicting Miles per gallon (MPG) by horsepower and weight using the dataset mtcars"),
         # paragraph and bold text
         p("The ", strong("miles per gallon (MPG)")," can be predicted from ", 
           strong("horsepower"), " and ", strong("weight"), " by a linear regression model that uses the hp and wt variables to estimate the mpg variable in the data set mtcars"),
         # break used to space sections
         br(), p("To use this app to make your prediction: "), br(), 
         # ordered list
         tags$ol(
                 tags$li("Use the slider Gross Horsepower to select your value of horsepower(hp)"), 
                 tags$li("Use the slider Weight to select your value of weight(wt)"), 
                 tags$li("The predicted value of MPG will be given as a number"), 
                 tags$li("The predicted value will be shown as aline in the Histogram of MPG values in mtcars if it is in the range")
         ))

))
