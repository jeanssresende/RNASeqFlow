# ==========================================================
# RNASeqFlow Conda Manager
# ==========================================================

# ==========================================================
# Progress Helper
# ==========================================================

report_progress <- function(progress = NULL,
                            value = NULL,
                            message = NULL,
                            detail = NULL) {
  
  # Shiny
  if (!is.null(progress)) {
    
    progress$set(
      value = value,
      message = message,
      detail = detail
    )
    
  }
  
  # Console
  if (!is.null(message)) {
    
    message(message)
    
  }
  
}

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

# ==========================================================
# Miniconda Installer Path
# ==========================================================

miniconda_installer_path <- function() {
  
  downloads_dir <- file.path(
    cache_directory(),
    "downloads"
  )
  
  dir.create(
    downloads_dir,
    recursive = TRUE,
    showWarnings = FALSE
  )
  
  info <- platform_info()
  
  if (info$os == "Linux") {
    
    return(
      file.path(downloads_dir, "Miniconda3.sh")
    )
    
  }
  
  if (info$os == "Windows") {
    
    return(
      file.path(downloads_dir, "Miniconda3.exe")
    )
    
  }
  
  stop("Unsupported operating system.")
  
}

# ==========================================================
# Download Miniconda Installer
# ==========================================================

download_miniconda <- function(force = FALSE,
                               progress = NULL) {
  
  installer <- miniconda_installer_path()
  
  if (file.exists(installer) && !force) {
    
    report_progress(
      progress,
      value = 1,
      message = "Miniconda installer already available."
    )
    
    return(installer)
    
  }
  
  report_progress(
    progress,
    value = 0.1,
    message = "Downloading Miniconda..."
  )
  
  curl::curl_download(
    url = miniconda_download_url(),
    destfile = installer,
    quiet = FALSE
  )
  
  if (!file.exists(installer)) {
    
    stop("Failed to download the Miniconda installer.")
    
  }
  
  report_progress(
    progress,
    value = 1,
    message = "Download completed."
  )
  
  installer
  
}

# ==========================================================
# Conda Binary
# ==========================================================

conda_binary <- function() {
  
  info <- platform_info()
  
  if (info$os == "Linux") {
    
    return(
      file.path(
        miniconda_directory(),
        "bin",
        "conda"
      )
    )
    
  }
  
  if (info$os == "Windows") {
    
    return(
      file.path(
        miniconda_directory(),
        "Scripts",
        "conda.exe"
      )
    )
    
  }
  
  stop("Unsupported operating system.")
  
}

# ==========================================================
# Check Miniconda Installation
# ==========================================================

miniconda_installed <- function() {
  
  file.exists(
    conda_binary()
  )
  
}