# load libraries
library(shiny)
require(googleVis)
# begin shiny server
shinyServer(function(input, output) {
        # define reactive parameters
        
        fit <- lm(mpg ~  hp  + wt, data = mtcars)
        newData <- reactive( data.frame(hp=input$hp, wt=input$wt/1000))
        p <- reactive( predict(fit, newData() ))
        output$predict <- renderText({p()})
                       
                       
        
        output$hist <-  renderPlot({
                hist(mtcars$mpg, xlab='MPG', col='lightblue',main='Histogram of MPG values in mtcars',breaks=15)
                lines(c(p(), p()), c(0, 200),col="red",lwd=5)
                text(63, 150, paste("Predicted MPG is", p()))
                legend("topright", lwd = 5,col="red","Predicted MPG")

        })
})





