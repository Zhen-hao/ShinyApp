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
                       
                       
        hp<- reactive({sample(1:20, input$hp, replace = TRUE)})
        bootstrapSample<-reactive(input$hp)
        popVar<- reactive({round(var(hp()),2)})
        # print text through reactive funtion
        output$biaVar <- renderText({
                sample<- as.data.frame(matrix(bootstrapSample(), nrow = input$wt,
                                              ncol =input$wt))
                return(round(mean(rowSums((sample-rowMeans(sample))^2)/input$wt), 2))
        })
        # google visualization histogram
        
        output$popHist <-  renderPlot({
                hist(mtcars$mpg, xlab='MPG', col='lightblue',main='Histogram of MPG values in mtcars',breaks=15)
                lines(c(p(), p()), c(0, 200),col="red",lwd=5)
                text(63, 150, paste("Predicted MPG is", p()))
                legend("topright", lwd = 5,col="red","Predicted MPG")

        })
})





