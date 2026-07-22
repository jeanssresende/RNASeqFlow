# ==========================================================
# MultiQC
# ==========================================================

#-----------------------------------------------------------
# Output directory
#-----------------------------------------------------------

multiqc_output_directory <- function(project) {
  
  file.path(
    project$path,
    "results",
    "multiqc"
  )
  
}

#-----------------------------------------------------------
# Input directory
#-----------------------------------------------------------

multiqc_input_directory <- function(project) {
  
  fastqc_output_directory(project)
  
}

#-----------------------------------------------------------
# Command
#-----------------------------------------------------------

multiqc_command <- function(project) {
  
  c(
    
    multiqc_input_directory(project),
    
    "--outdir",
    multiqc_output_directory(project),
    
    "--force"
    
  )
  
}

#-----------------------------------------------------------
# Report
#-----------------------------------------------------------

multiqc_report <- function(project) {
  
  report <- file.path(
    
    multiqc_output_directory(project),
    
    "multiqc_report.html"
    
  )
  
  if (!file.exists(report)) {
    
    return(NULL)
    
  }
  
  normalizePath(
    report,
    winslash = "/",
    mustWork = FALSE
  )
  
}

run_multiqc <- function(project,
                        progress = NULL) {
  
  output_directory <- multiqc_output_directory(project)
  
  dir.create(
    output_directory,
    recursive = TRUE,
    showWarnings = FALSE
  )
  
  if (!is.null(progress)) {
    
    progress$set(
      value = 0.10,
      message = "Running MultiQC..."
    )
    
  }
  
  result <- run_command_or_stop(
    
    command = multiqc_binary(),
    
    args = multiqc_command(project)
    
  )
  
  project$results$multiqc <- list(
    
    completed = TRUE,
    
    date = Sys.time(),
    
    report = multiqc_report(project)
    
  )
  
  save_project(project)
  
  if (!is.null(progress)) {
    
    progress$set(
      value = 1,
      message = "MultiQC completed."
    )
    
  }
  
  result
  
}