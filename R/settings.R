# ==========================================================
# RNASeqFlow Settings
# ==========================================================

settings_directory <- function() {
  
  if (.Platform$OS.type == "windows") {
    
    file.path(Sys.getenv("APPDATA"), "RNASeqFlow")
    
  } else {
    
    file.path(path.expand("~"), ".RNASeqFlow")
    
  }
  
}


settings_file <- function() {
  
  file.path(
    settings_directory(),
    "settings.rds"
  )
  
}


default_settings <- function() {
  
  list(
    
    version = "0.1.0",
    
    threads = parallel::detectCores(),
    
    tools = list(
      
      fastqc = NULL,
      
      multiqc = NULL
      
    )
    
  )
  
}


load_settings <- function() {
  
  dir.create(
    settings_directory(),
    recursive = TRUE,
    showWarnings = FALSE
  )
  
  file <- settings_file()
  
  if (!file.exists(file)) {
    
    settings <- default_settings()
    
    saveRDS(settings, file)
    
    return(settings)
    
  }
  
  readRDS(file)
  
}


save_settings <- function(settings) {
  
  dir.create(
    settings_directory(),
    recursive = TRUE,
    showWarnings = FALSE
  )
  
  saveRDS(
    settings,
    settings_file()
  )
  
}