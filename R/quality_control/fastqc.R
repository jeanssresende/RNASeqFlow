# ==========================================================
# FastQC Output Directory
# ==========================================================

fastqc_output_directory <- function(project) {
  
  file.path(
    project$path,
    "results",
    "fastqc"
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
                       progress = NULL) {
  
  output_directory <- fastqc_output_directory(project)
  
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
  
  project$results$fastqc <- list(
    
    completed = TRUE,
    
    date = Sys.time(),
    
    reports = fastqc_reports(project)
    
  )
  
  save_project(project)
  
  if (!is.null(progress)) {
    progress$set(
      value = 1,
      message = "FastQC completed."
    )
  }
  
  return(result)
  
}
# ==========================================================
# FastQC Reports
# ==========================================================

fastqc_reports <- function(project) {
  
  if (is.null(project))
    return(character())
  
  if (is.null(project$path))
    return(character())
  
  output_directory <- fastqc_output_directory(project)
  
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

#-----------------------------------------------------------
# FastQC Report Table
#-----------------------------------------------------------

fastqc_report_table <- function(project) {
  
  reports <- fastqc_reports(project)
  
  if (length(reports) == 0) {
    return(data.frame())
  }
  
  data.frame(
    
    Sample = sub("_fastqc\\.html$", "", basename(reports)),
    
    File = basename(reports),
    
    Status = "✅",
    
    Path = normalizePath(
      reports,
      winslash = "/",
      mustWork = FALSE
    ),
    
    stringsAsFactors = FALSE
    
  )
  
}