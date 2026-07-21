# ==========================================================
# RNASeqFlow Tool Manager
# ==========================================================

#-----------------------------------------------------------
# Tool Binary
#-----------------------------------------------------------

tool_binary <- function(tool) {
  
  info <- platform_info()
  
  binary <- if (info$os == "Windows") {
    
    paste0(tool, ".exe")
    
  } else {
    
    tool
    
  }
  
  file.path(
    
    conda_environment_directory(),
    
    if (info$os == "Windows") "Scripts" else "bin",
    
    binary
    
  )
  
}


#-----------------------------------------------------------
# FastQC Binary
#-----------------------------------------------------------

fastqc_binary <- function() {
  
  tool_binary("fastqc")
  
}

fastqc_version <- function() {
  
  result <- run_command(
    
    command = fastqc_binary(),
    
    args = "--version"
    
  )
  
  if (!result$success) {
    
    return(NULL)
    
  }
  
  trimws(result$output)
  
}

