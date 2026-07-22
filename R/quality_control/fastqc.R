# ==========================================================
# FastQC Output Directory
# ==========================================================

fastqc_output_directory <- function(project,
                                    stage = "raw") {
  
  folder <- switch(
    
    stage,
    
    raw = file.path("qc", "fastqc"),
    
    trimmed = file.path("qc_trimmed", "fastqc"),
    
    stop("Invalid FastQC stage.")
    
  )
  
  file.path(
    project$path,
    "results",
    folder
  )
  
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
                       progress = NULL,
                       stage = "raw") {
  
  output_directory <- fastqc_output_directory(
    project,
    stage = stage
  )
  
  # Cria o diretório apenas quando necessário
  dir.create(
    output_directory,
    recursive = TRUE,
    showWarnings = FALSE
  )
  
  if (!is.null(progress)) {
    progress$set(
      value = 0.10,
      message = "Running FastQC..."
    )
  }
  
  result <- run_command_or_stop(
    
    command = fastqc_binary(),
    
    args = fastqc_command(
      files,
      output_directory,
      threads
    )
    
  )
  
  project$results[[paste0("fastqc_", stage)]] <- list(
    
    completed = TRUE,
    
    date = Sys.time(),
    
    reports = fastqc_reports(
      project,
      stage = stage
    )
    
  )
  
  save_project(project)
  
  if (!is.null(progress)) {
    progress$set(
      value = 1,
      message = "FastQC completed."
    )
  }
  
  project$results[[paste0("fastqc_", stage)]] <- list(
    
    completed = TRUE,
    
    date = Sys.time(),
    
    reports = fastqc_reports(
      project,
      stage = stage
    )
    
  )
  
  return(result)
  
}
# ==========================================================
# FastQC Reports
# ==========================================================

fastqc_reports <- function(project,
                           stage = "raw") {
  
  if (is.null(project))
    return(character())
  
  if (is.null(project$path))
    return(character())
  
  output_directory <- fastqc_output_directory(
    project,
    stage = stage
  )
  
  if (!dir.exists(output_directory))
    return(character())
  
  list.files(
    output_directory,
    pattern = "_fastqc\\.html$",
    full.names = TRUE
  )
  
}

#-----------------------------------------------------------
# FastQC Report Table
#-----------------------------------------------------------

fastqc_report_table <- function(project,
                                stage = "raw") {
  
  reports <- fastqc_reports(
    project,
    stage = stage
  )
  
  if (length(reports) == 0)
    return(data.frame())
  
  data.frame(
    
    Sample = sub(
      "_fastqc\\.html$",
      "",
      basename(reports)
    ),
    
    Report = "HTML Report",
    
    Status = "🟢 Completed",
    
    Path = normalizePath(
      reports,
      winslash = "/",
      mustWork = FALSE
    ),
    
    stringsAsFactors = FALSE
    
  )
  
}