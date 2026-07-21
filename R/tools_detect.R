# ==========================================================
# Tool Detection
# ==========================================================

detect_tool <- function(tool) {
  
  path <- Sys.which(tool)
  
  if (nzchar(path)) {
    
    normalizePath(path)
    
  } else {
    
    NULL
    
  }
  
}


detect_tools <- function(settings) {
  
  settings$tools$fastqc  <- detect_tool("fastqc")
  
  settings$tools$multiqc <- detect_tool("multiqc")
  
  save_settings(settings)
  
  settings
  
}