# ==========================================================
# RNASeqFlow Settings
# ==========================================================

settings_file <- function() {
  
  file.path(
    config_directory(),
    "settings.rds"
  )
  
}


default_settings <- function() {
  
  list(
    
    version = "0.1.0",
    
    threads = parallel::detectCores(),
    
    conda = list(
      
      installed = FALSE,
      
      version = NULL,
      
      environment = RNASEQFLOW_ENV
      
    ),
    
    tools = list(
      
      fastqc = NULL,
      
      multiqc = NULL,
      
      fastp = NULL,
      
      salmon = NULL
      
    )
    
  )
  
}


load_settings <- function() {
  
  dir.create(
    config_directory(),
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
    config_directory(),
    recursive = TRUE,
    showWarnings = FALSE
  )
  
  saveRDS(
    settings,
    settings_file()
  )
  
}