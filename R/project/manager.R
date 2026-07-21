# ==========================================================
# RNASeqFlow Project Manager
# ==========================================================

#-----------------------------------------------------------
# Default Project
#-----------------------------------------------------------

default_project <- function() {
  
  list(
    
    name = NULL,
    
    path = NULL,
    
    version = "0.1.0",
    
    created = Sys.time(),
    
    samples = NULL,
    
    settings = list(),
    
    results = list(
      
      fastqc = NULL,
      
      multiqc = NULL,
      
      trimming = NULL,
      
      quantification = NULL,
      
      annotation = NULL
      
    )
    
  )
  
}

#-----------------------------------------------------------
# Create Project
#-----------------------------------------------------------

create_project <- function(name,
                           path) {
  
  project <- default_project()
  
  project$name <- name
  
  project$path <- normalizePath(
    path,
    winslash = "/",
    mustWork = FALSE
  )
  
  dir.create(
    project$path,
    recursive = TRUE,
    showWarnings = FALSE
  )
  
  save_project(project)
  
  project
  
}

#-----------------------------------------------------------
# Project File
#-----------------------------------------------------------

project_file <- function(project) {
  
  file.path(
    project$path,
    "project.rds"
  )
  
}

#-----------------------------------------------------------
# Project Exists
#-----------------------------------------------------------

project_exists <- function(project_path) {
  
  file.exists(
    
    file.path(
      project_path,
      "project.rds"
    )
    
  )
  
}

#-----------------------------------------------------------
# Save Project
#-----------------------------------------------------------

save_project <- function(project) {
  
  saveRDS(
    
    project,
    
    project_file(project)
    
  )
  
}

#-----------------------------------------------------------
# Load Project
#-----------------------------------------------------------

load_project <- function(project_path) {
  
  readRDS(
    
    file.path(
      project_path,
      "project.rds"
    )
    
  )
  
}

