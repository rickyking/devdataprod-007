
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(fluidPage(
  
  # Application title
  titlePanel("weather Data Presenter - Developping Data Project"),
  
  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      p("Due to getting the real time data, each manipulation will take some time, please be patient!"),
      p("This is done for coursera course - data science track - Developping Data Project (7th run)"),
      p("The package used in the application is: `weatherData`"),
      h3("Search Functionality"),
      p("In the following box, you can type a city name in US. The select box will return
        the nearest airport to this city."),
      textInput("citySearch",
                "Search a city:",
                "New York"),
      selectInput("cityResult",
                  "Search Result:",
                  c()),
      p("Please select a date range to get the weather data."),
      dateRangeInput("dateRange", "Select a range of Date", max = Sys.Date(), start = Sys.Date() - 1,end = Sys.Date() - 1),
      actionButton("checkDateAvail", "Check Availability"),
      br(),
      uiOutput("available"),
      hr(),
      h3("Get data and plot"),
      p("If data available, you can get the data by using the button below"),
      checkboxInput("detailedData", "Detailed data (more data beside temperature)", value = FALSE),
      actionButton("getData", "Get Data!"),
      p("Once the data is retrieved, you can navigate the data table and the plot in the right hand side.")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      tabsetPanel(
        tabPanel("Data Table",dataTableOutput("mytable")),
        tabPanel("Temperature Plot", plotOutput("tempPlot"))
      )
    )
  )
))
