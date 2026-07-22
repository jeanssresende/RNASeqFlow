# ==========================================================
# MultiQC
# ==========================================================

# ==========================================================
# MultiQC Output Directory
# ==========================================================

multiqc_output_directory <- function(project,
                                     stage = "raw") {
  
  folder <- switch(
    
    stage,
    
    raw = file.path("qc", "multiqc"),
    
    trimmed = file.path("qc_trimmed", "multiqc"),
    
    stop("Invalid MultiQC stage.")
    
  )
  
  file.path(
    project$path,
    "results",
    folder
  )
  
}

# ==========================================================
# MultiQC Input Directory
# ==========================================================

multiqc_input_directory <- function(project,
                                    stage = "raw") {
  
  fastqc_output_directory(
    project,
    stage = stage
  )
  
}

# ==========================================================
# MultiQC Command
# ==========================================================

multiqc_command <- function(project,
                            stage = "raw") {
  
  c(
    
    multiqc_input_directory(
      project,
      stage = stage
    ),
    
    "--outdir",
    
    multiqc_output_directory(
      project,
      stage = stage
    ),
    
    "--force"
    
  )
  
}

# ==========================================================
# MultiQC Report
# ==========================================================

multiqc_report <- function(project,
                           stage = "raw") {
  
  report <- file.path(
    
    multiqc_output_directory(
      project,
      stage = stage
    ),
    
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
                        progress = NULL,
                        stage = "raw") {
  
  output_directory <- multiqc_output_directory(
    project,
    stage = stage
  )
  
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
    
    args = multiqc_command(
      project,
      stage = stage
    )
    
  )
  
  project$results[[paste0("multiqc_", stage)]] <- list(
    
    completed = TRUE,
    
    date = Sys.time(),
    
    report = multiqc_report(
      project,
      stage = stage
    )
    
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