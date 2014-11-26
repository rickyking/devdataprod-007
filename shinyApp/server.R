
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(weatherData)
library(ggplot2)
shinyServer(function(input, output, session) {
  
  observe({
    # observe the return of search
    stations <- getStationCode(input$citySearch)[[1]]
    choices <- stations$airportCode
    names(choices) <- stations$Station
    updateSelectInput(session, "cityResult", choices = choices)
  })
  
  output$available <- renderUI({
    if (input$checkDateAvail==0) return(NULL)
    isolate({
      # observe the data availability
      progress <- shiny::Progress$new(session, min=1, max=15)
      progress$set(value = 5, message = "checking availability...")
      check_flag <- checkDataAvailabilityForDateRange(input$cityResult, input$dateRange[1], input$dateRange[2])
      progress$set(value = 14, message = "Done...")
      if (check_flag) {
        progress$close()
        return(HTML('Data Status: <span class="label label-success">Available</span>'))
      } else {
        progress$close()
        return(HTML('Data Status: <span class="label label-warning">Not Available</span>'))
      }
    }) 
  })
  
  weather_dat <- reactive({
    # get data once clicked getData button
    city <- input$cityResult
    dateRange <- input$dateRange
    detailed <- input$detailedData
    if (input$getData == 0) return(NULL)
    isolate({
      progress <- shiny::Progress$new(session, min=1, max=15)
      if (detailed) {
        progress$set(message="getting data...", value = 7)
        dat <- getWeatherForDate(city, dateRange[1], end_date=dateRange[2], opt_detailed=TRUE, opt_all_columns = T)
        progress$set(message="printing data...", value = 14)
        progress$close()
        return(dat)
      } else {
        progress$set(message="getting data...", value = 7)
        dat <- getWeatherForDate(city, dateRange[1], end_date=dateRange[2], opt_detailed=TRUE, opt_all_columns = F)
        progress$set(message="printing data...", value = 14)
        progress$close()
        return(dat)
      }
    })
  })
  
  output$mytable <- renderDataTable({
    if (input$getData == 0) return(NULL)
    isolate({
      dat <- as.data.frame(weather_dat())
      return(dat)
    })
  })
  
  output$tempPlot <- renderPlot({
    if (input$getData == 0) return(NULL)
    qplot(Time, TemperatureF, data = weather_dat(), geom = c("point", "smooth"))
  })
})
