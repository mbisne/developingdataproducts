#Load the libraries needed
library(forecast)
library(strucchange)

arima_func <- function(val) {
  
  #Set Working Directory
  #setwd('C:/Users/Mandar/Desktop/Adobe/HousingData')
  
  #Read the HPI Data
  HousingData = read.table(file = 'Data.txt', header = TRUE, sep = '\t')
  
  #Read the City Column Data
  CityCol <- read.table(file = 'City_To_Col.txt',header = TRUE, sep = '\t')
  colno<- ifelse(CityCol$City == val, CityCol$ColNo,0)
  
  #Take log of the values and keep the other columns as it is
  HousingData_Log <- cbind(HousingData[,c(1,2,3)],log(HousingData[,-c(1,2,3)]))
  
  #Split the whole data into individual series
  individual_series <-HousingData_Log[,colno]
  
  #Convert it into a time series 
  individual_series <- ts(individual_series, start = c(1991,1),frequency = 12)
  
  #Use the Auto Arima to fit the model
  pred_model <- auto.arima(individual_series,approximation=FALSE)
  
  #Using the model constructed above, predict the values for 2010
  fit <- forecast(pred_model,18)
  
  #Extract the values and create a data frame with respective months
  method <- fit$mean
  Predicted_Values <- exp(method)
  names(Predicted_Values) <- "Predicted Values"
  forecast_months <- as.data.frame(c("July 2009", "August 2009", "September 2009","October 2009", "November 2009", "December 2009", "January 2010", "Febraury 2010", "March 2010", "April 2010", "May 2010", "June 2010", "July 2010", "August 2010", "September 2010", "October 2010", "November 2010", "December 2010"))
  names(forecast_months) = "Month"
  pred_val <- cbind.data.frame(forecast_months,Predicted_Values)
  return(pred_val[7:18,])
}



server <- function(input,output,session) {
  #if(is.na(input$City)) return(NULL)
  output$Results <- renderDataTable({
    progress <- shiny::Progress$new(session = session, min=1, max=25)
    on.exit(progress$close())
    
    progress$set(message = 'Calculation in progress',
                 detail = 'This may take a while...')
    
    for (i in 1:15) {
      progress$set(value = i)
      Sys.sleep(0.5)
    }
    arima_func(input$City)
  })
}