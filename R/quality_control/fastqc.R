# ==========================================================
# FastQC Output Directory
# ==========================================================

fastqc_output_directory <- function(project) {
  
  output_directory <- file.path(
    project$path,
    "results",
    "fastqc"
  )
  
  dir.create(
    output_directory,
    recursive = TRUE,
    showWarnings = FALSE
  )
  
  output_directory
  
}

# ==========================================================
# FastQC Command
# ==========================================================

fastqc_command <- function(files,
                           output_directory,
                           threads) {
  
  c(
    "--threads", as.character(threads),
    "--outdir", output_directory,
    files
  )
  
}

# ==========================================================
# Run FastQC
# ==========================================================

run_fastqc <- function(files,
                       project,
                       threads = 1,
                       progress = NULL) {
  
  output_directory <- fastqc_output_directory(project)
  
  report_progress(
    progress,
    value = 0.10,
    message = "Running FastQC..."
  )
  
  result <- run_command_or_stop(
    
    command = fastqc_binary(),
    
    args = fastqc_command(
      files,
      output_directory,
      threads
    )
    
  )
  
  report_progress(
    progress,
    value = 1,
    message = "FastQC completed."
  )
  
  invisible(result)
  
}

# ==========================================================
# FastQC Reports
# ==========================================================

fastqc_reports <- function(project) {
  
  list.files(
    
    fastqc_output_directory(project),
    
    pattern = "_fastqc\\.html$",
    
    full.names = TRUE
    
  )
  
}