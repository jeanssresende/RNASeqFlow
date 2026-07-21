# ==========================================================
# RNASeqFlow Project Manager
# ==========================================================

#-----------------------------------------------------------
# Default Project
#-----------------------------------------------------------

default_project <- function() {
  
  results = list(
    
    fastqc = list(
      completed = FALSE,
      date = NULL,
      reports = character()
    ),
    
    multiqc = list(
      completed = FALSE,
      date = NULL,
      reports = character()
    ),
    
    trimming = list(
      completed = FALSE
    ),
    
    quantification = list(
      completed = FALSE
    ),
    
    annotation = list(
      completed = FALSE
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

