pacman::p_load(shiny, shinyWidgets, shinyjs,  hexView,raster, ijtiff,exifr, shinyFiles)

source("C:/Users/anc65jk/Documents/ThermalCalc/Function.R")

ui <- fluidPage(
  titlePanel("Thermal Calibration M3M App"),
  sidebarLayout(
    sidebarPanel(
      textInput("sdk_dir", "Select SDK Directory", "C:/Users/anc65jk/Documents/ThermalCalc/DJISDK/"),
      sliderInput("emissivity", "Emissivity", 0.1, 1, 1, step = 0.01),
      sliderInput("humidity", "Humidity", 20, 100, 70, step = 5),
      sliderInput("distance", "Distance", 1, 25, 25, step = 1),
      textInput("in_dir", "Select Input Directory","B:/SebastianThermal/2023-10-18_ThermalFlights/0_Flights/1_Turtmann_DJIM3M/0_Images/T/"),
      textInput("out_dir", "Select Output Directory","B:/SebastianThermal/2023-10-18_ThermalFlights/0_Flights/1_Turtmann_DJIM3M/0_Images/T_Cal/"),
      useShinyjs(),
      actionButton("start_button", "Start Processing")
    ),
    mainPanel(
      textOutput("status_text")
    )
  )
)

server <- function(input, output) {
  observeEvent(input$start_button, {
    # Check if all fields are filled
    if (is.null(input$sdk_dir) || is.null(input$in_dir) || is.null(input$out_dir)) {
      shinyjs::alert("Please fill in all required fields.", title = "Error")
    } else {
      # Get the input values
      sdk_dir <- input$sdk_dir
      emissivity <- input$emissivity
      humidity <- input$humidity
      distance <- input$distance
      in_dir <- input$in_dir
      out_dir <- input$out_dir
      
      # Perform data processing by calling the ThermlCal function
      ThermalCal(sdk_dir, emissivity, humidity, distance, in_dir, out_dir)
      
      # Display a message to indicate processing has started
      output$status_text <- renderText("Processing started...")
      
      # Replace this with your actual data processing logic
      Sys.sleep(2) # Simulating a delay, remove this in your actual code
      
      # Update the message to indicate processing is complete
      output$status_text <- renderText("Processing completed.")
    }
  })
}

shinyApp(ui, server)

# B:/SebastianThermal/2023-10-18_ThermalFlights/0_Flights/1_Location1_DJIM3M/0_Images/T/