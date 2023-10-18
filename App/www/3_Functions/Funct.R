ThermalCal <- function(sdk_dir, emissivity, humidity,distance,in_dir,out_dir){
  
  ### dir where DJI Thermal SDK is located (select appropriate release according to your OS).
  setwd(sdk_dir) # convinient way to set SDK paths across OS systems (path compatibility)
  
  # short version for running commands in terminal
  run<-function(x) shell(x, intern=FALSE, wait=TRUE)
  
  # List of Files
  in_files = list.files(in_dir, full.names = T, pattern = "_T")
  
  
  ### calibration/conversion procedure (...could be paralleled)
  for(i in 1:length(in_files)){
    
    # calibration to celsius
    in_exif = exifr::read_exif(in_files[i])
    in_name = in_files[i]
    out_name = paste0(out_dir, substr(basename(in_files[i]), 0, nchar(basename(in_files[i]))-4), ".raw")
    run(paste0(sdk_dir,"//utility/bin/windows/release_x64/dji_irp.exe -s ", in_name, " -a measure -o ", out_name, " --measurefmt float32", 
               " --emissivity ", emissivity, " --humidity ", humidity, " --distance ", distance))
    
    # from .raw (hex) to .tif (celsius in float)
    raw_data <- readBin(out_name, "double", size = 4, n = in_exif$ImageWidth*in_exif$ImageHeight)
    image_matrix <- matrix(raw_data, nrow = in_exif$ImageHeight, ncol = in_exif$ImageWidth, byrow = T)
    out_name_tif = paste0(substr(out_name, 0, nchar(out_name)-4), ".tif")
    write_tif(image_matrix, path = out_name_tif, overwrite = TRUE)
    
    # transfer metadata (exif)
    exiftool_call(paste0("-Model=", in_exif$Model[1]), out_name_tif)
    exiftool_call(paste0("-Make=", in_exif$Make[1]), out_name_tif)
    exiftool_call(paste0("-Orientation=", in_exif$Orientation[1]), out_name_tif)
    exiftool_call(paste0("-FocalLength=", in_exif$FocalLength[1]), out_name_tif)
    exiftool_call(paste0("-FocalLengthIn35mmFormat=", in_exif$FocalLengthIn35mmFormat[1]), out_name_tif)
    exiftool_call(paste0("-DigitalZoomRatio=", in_exif$DigitalZoomRatio[1]), out_name_tif)
    exiftool_call(paste0("-ApertureValue=", in_exif$ApertureValue[1]), out_name_tif)
    exiftool_call(paste0("-GPSAltitude=", in_exif$GPSAltitude[1]), out_name_tif)
    exiftool_call(paste0("-GPSLatitude=", in_exif$GPSLatitude[1]), out_name_tif)
    exiftool_call(paste0("-GPSLongitude=", in_exif$GPSLongitude[1]), out_name_tif)
  }
  
  ### remove temp files
  file.remove(list.files(out_dir, recursive = TRUE, full.names = T, pattern = "_original"))
  file.remove(list.files(out_dir, recursive = TRUE, full.names = T, pattern = "_T.raw"))
  
}

