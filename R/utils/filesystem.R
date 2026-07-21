# ==========================================================
# RNASeqFlow Filesystem Utilities
# ==========================================================

# Nome do ambiente Conda
RNASEQFLOW_ENV <- "rnaseqflow"

# Diretório de configuração do RNASeqFlow
config_directory <- function() {
  
  if (.Platform$OS.type == "windows") {
    
    file.path(Sys.getenv("APPDATA"), "RNASeqFlow")
    
  } else {
    
    file.path(path.expand("~"), ".RNASeqFlow")
    
  }
  
}

# Diretório de runtime
runtime_directory <- function() {
  
  file.path(
    config_directory(),
    "runtime"
  )
  
}

# Diretório da instalação da Miniconda
miniconda_directory <- function() {
  
  file.path(
    runtime_directory(),
    "miniconda"
  )
  
}

# Diretório dos ambientes Conda
conda_envs_directory <- function() {
  
  file.path(
    miniconda_directory(),
    "envs"
  )
  
}

# Diretório do ambiente do RNASeqFlow
conda_environment_directory <- function() {
  
  file.path(
    conda_envs_directory(),
    RNASEQFLOW_ENV
  )
  
}

# Diretório de logs
logs_directory <- function() {
  
  file.path(
    config_directory(),
    "logs"
  )
  
}

# Diretório de cache
cache_directory <- function() {
  
  file.path(
    config_directory(),
    "cache"
  )
  
}

#-----------------------------------------------------------
# Conda Environment File
#-----------------------------------------------------------

environment_file <- function() {
  
  file.path(
    normalizePath(".", winslash = "/", mustWork = TRUE),
    "install",
    "environment.yml"
  )
  
}