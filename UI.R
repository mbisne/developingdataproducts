# ui.R
ui <-
  shinyUI(
    
    fluidPage(
      titlePanel("Time Series Forecast - Home Price Index "),
      sidebarLayout(
        sidebarPanel(radioButtons(inputId = "City","Select the City",choices = list("Phoenix, Arizona" , "Los Angeles, California", "San Deigo, California", "San Francisco, California", "Denver, Colorado", "Washington DC, Maryland", "Miami, Florida", "Tampa, Florida", "Atlanta, Georgia", "Chicago, Illinois", "Boston, Massachusetts", "Detroit, Michigan", "Minneapolis, Minnesota", "Charlotte, North Carolina", "Las Vegas, Nevada", "New York, New York", "Cleveland, Ohio", "Portland, Oregon", "Seattle, Washington", "Composite 10 Index")),
                     submitButton(text = "Submit")
        ),
        mainPanel(
          dataTableOutput("Results")
        )
      )
    )
  )
