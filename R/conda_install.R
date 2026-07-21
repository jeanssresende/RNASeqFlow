# ==========================================================
# RNASeqFlow Conda Manager
# ==========================================================

# ==========================================================
# Platform Information
# ==========================================================

platform_info <- function() {
  
  os <- Sys.info()[["sysname"]]
  arch <- Sys.info()[["machine"]]
  
  list(
    os = os,
    arch = arch
  )
  
}

# ==========================================================
# Miniconda Download URL
# ==========================================================

miniconda_download_url <- function() {
  
  info <- platform_info()
  
  if (info$os == "Linux") {
    
    return(
      "https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh"
    )
    
  }
  
  if (info$os == "Windows") {
    
    return(
      "https://repo.anaconda.com/miniconda/Miniconda3-latest-Windows-x86_64.exe"
    )
    
  }
  
  stop("Unsupported operating system.")
  
}

