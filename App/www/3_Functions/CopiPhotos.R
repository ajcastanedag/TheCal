library(shiny)
library(shinyjs)
library(shinyFiles)


ui <- fluidPage(
  titlePanel("Photo Copy App"),
  sidebarLayout(
    sidebarPanel(
      textInput("photo_dir", "Enter the directory path of photos", value = "E:\\SebastianData\\Turtmann\\DCIM\\DJI_202308240650_003_Turtmann"),
      textInput("output_dir", "Enter the output directory path", value = "B:\\SebastianThermal\\2023-10-18_ThermalFlights\\0_Flights\\1_Turtmann_DJIM3M\\0_Images"),
      useShinyjs(),
      actionButton("copy_button", "Copy Photos")
    ),
    mainPanel(
      textOutput("status_text")
    )
  )
)

server <- function(input, output) {
  
  observeEvent(input$copy_button, {
    
    photo_dir <- input$photo_dir
    output_dir <- input$output_dir
    
    if (dir.exists(photo_dir) && dir.exists(output_dir)) {
      photo_files <- list.files(path = photo_dir, full.names = T, recursive = T)
      
      # Filter the file names that contain "_T"
      Thermal <- photo_files[grep("_T.JPG", photo_files)]
      
      RGB <- photo_files[grep("_V.JPG", photo_files)]
      
      # Copy each file to the destination directory
      for (file_path in Thermal) {
        # Copy the file to the destination directory
        file.copy(file_path, paste0(output_dir,"\\T\\"), overwrite = TRUE)  # Set overwrite to TRUE to overwrite existing files
      }
      
      # Copy each file to the destination directory
      for (file_path in RGB) {
        # Copy the file to the destination directory
        file.copy(file_path, paste0(output_dir,"\\RGB\\"), overwrite = TRUE)  # Set overwrite to TRUE to overwrite existing files
      }
      
      
      output$status_text <- renderText("Photos copied successfully.")
    } else {
      shinyjs::alert("Please provide valid directory paths.", title = "Error")
    }
  })
}

shinyApp(ui, server)


photo_files <- list.files(path = "E:\\SebastianData\\Turtmann\\DCIM\\DJI_202308240650_003_Turtmann", full.names = T, recursive = T)










