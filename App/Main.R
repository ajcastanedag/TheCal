#########################        ThermalCal      ############################### ----

################################################################################
##### Load libraries                                                            -----
pacman::p_load("shiny","shinyWidgets", "stringr","shinyjs", "shinythemes", "shinyFiles",
               "shinydashboard","leaflet","leaflet.extras", "tidyverse", "rmarkdown", "shinyBS",
               "easycsv","sf","sfheaders","shinyalert","threejs","downloader")

##### Set working directory (temporal for testing)                              ----- 
Root <- paste0(getwd(),"/App")   
Root <- paste0(getwd())   
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
    tags$head(
      # Include our custom CSS
      includeCSS(Style)
      #tags$link(rel = "stylesheet", type = "text/css", href = "/www/2_Style/UASstyle.css")
    ),
    tabItems(
      tabItem(tabName = "instructions",
              h2("Instructions Tab Content"),
              p("This is where you can provide instructions or information for users."),
              p("You can use this tab to explain how to use the app, provide guidance, or any other relevant details."),
              # Add content for this tab here
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
}

# Create Shiny app
shinyApp(ui, server)

getSDK("Lin", paste0(Root,"/www/1_SDK"))









