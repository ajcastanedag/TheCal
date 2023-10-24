#########################        ThermalCal      ############################### ----

################################################################################
##### Load libraries                                                            -----
pacman::p_load("shiny","shinyWidgets", "stringr","shinyjs", "shinythemes", "shinyFiles",
               "shinydashboard","leaflet","leaflet.extras", "tidyverse", "rmarkdown", "shinyBS",
               "easycsv","sf","sfheaders","shinyalert","threejs","downloader")

##### Set working directory (temporal for testing)                              ----- 
Root <- paste0(getwd(),"/App")   
#Root <- paste0(getwd())   
##### Add resource path                                                         ----- 
addResourcePath(prefix = 'media', directoryPath = paste0(Root,"/www"))
##### Include Functions file-> IF NOT SPECIFIED LIDAR COMPUTER FILE WILL BE USED----- 
source(paste0(Root,"/www/3_Functions/Funct.R"))
##### Set path to general style                                                 ----- 
Style <- paste0(Root,"/www/2_Style/ThermalStyle.css")
################################################################################
# Define the user interface
ui <-shinydashboard::dashboardPage(
  dashboardHeader(title = "Thermal calibration App"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Instructions", tabName = "instructions"),
      menuItem("Create Folder Structure", tabName = "folder_structure"),
      menuItem("Copy Photos", tabName = "copy_photos"),
      menuItem("Thermal Calibration", tabName = "thermal_calibration"),
      menuItem("View Photos", tabName = "copy_photos")
    )
  ),
  dashboardBody(
    tabItems(
      # In the "Instructions" tab content
      tabItem(tabName = "instructions",

              # Add a radio button group to select the operating system
              radioButtons(inputId = "os_selector", label = "Select Operating System",
                           choices = c("Linux", "Windows"), inline = TRUE),
              
              # Add a button to get the SDK
              actionButton("get_sdk_button", "GET SDK"),
              
      ),
      tabItem(tabName = "folder_structure",
              h2("Create Folder Structure Tab Content"),
              # Add content for this tab here
      ),
      tabItem(tabName = "copy_photos",
              h2("Copy Photos Tab Content"),
              # Add content for this tab here
      ),
      tabItem(tabName = "thermal_calibration",
              h2("Thermal Calibration Tab Content"),
              # Add content for this tab here
      )
    )
  )
)

################################################################################
# Define the server logic
server <- function(input, output, session) {
  # Add server logic for each tab here if needed
  
  # Define the observeEvent to call getSDK when the button is clicked
  observeEvent(input$get_sdk_button, {
    getSDK("Lin", paste0(Root,"/www/1_SDK"))
  })
  
  
}

# Create Shiny app
shinyApp(ui, server)










