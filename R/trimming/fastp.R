# ==========================================================
# fastp
# ==========================================================

#-----------------------------------------------------------
# Output directory
#-----------------------------------------------------------

fastp_output_directory <- function(project) {
  
  file.path(
    project$path,
    "results",
    "trimming"
  )
  
}

#-----------------------------------------------------------
# Trimmed FASTQ directory
#-----------------------------------------------------------

fastp_fastq_directory <- function(project) {
  
  file.path(
    fastp_output_directory(project),
    "fastq"
  )
  
}

#-----------------------------------------------------------
# Reports directory
#-----------------------------------------------------------

fastp_reports_directory <- function(project) {
  
  file.path(
    fastp_output_directory(project),
    "reports"
  )
  
}



#-----------------------------------------------------------
# fastp files
#-----------------------------------------------------------

fastp_files <- function(sample, project){
  
  print(sample)
  print(sample$Sample)
  
  sample_name <- sample$Sample
  
  list(
    
    ## Input
    r1 = sample$R1,
    r2 = sample$R2,
    
    ## Output
    r1_out = file.path(
      fastp_fastq_directory(project),
      paste0(sample_name, "_R1.trimmed.fastq.gz")
    ),
    
    r2_out = file.path(
      fastp_fastq_directory(project),
      paste0(sample_name, "_R2.trimmed.fastq.gz")
    ),
    
    ## Reports
    html = file.path(
      fastp_reports_directory(project),
      paste0(sample_name, "_fastp.html")
    ),
    
    json = file.path(
      fastp_reports_directory(project),
      paste0(sample_name, "_fastp.json")
    )
    
  )
  
}

#-----------------------------------------------------------
# fastp command
#-----------------------------------------------------------

fastp_command <- function(
    sample,
    project,
    threads = 1
){
  
  files <- fastp_files(sample, project)
  
  c(
    
    "-i", files$r1,
    
    "-I", files$r2,
    
    "-o", files$r1_out,
    
    "-O", files$r2_out,
    
    "-h", files$html,
    
    "-j", files$json,
    
    "--thread", as.character(threads)
    
  )
  
}

#-----------------------------------------------------------
# Run fastp
#-----------------------------------------------------------

run_fastp <- function(
    samples,
    project,
    threads = 1,
    progress = NULL
){
  
  dir.create(
    fastp_fastq_directory(project),
    recursive = TRUE,
    showWarnings = FALSE
  )
  
  dir.create(
    fastp_reports_directory(project),
    recursive = TRUE,
    showWarnings = FALSE
  )
  
  n <- nrow(samples)
  
  reports <- vector("list", n)
  
  for(i in seq_len(n)){
    
    sample <- samples[i, ]
    
    args <- fastp_command(
      sample = sample,
      project = project,
      threads = threads
    )
    
    run_command_or_stop(
      command = fastp_binary(),
      args = args
    )
    
    reports[[i]] <- fastp_files(
      sample,
      project
    )
    
    if(!is.null(progress)){
      progress$set(
        value = i / n,
        message = sprintf(
          "Processing %s (%d/%d)",
          sample$Sample,
          i,
          n
        )
      )
    }
    
  }
  
  project$results$fastp <- list(
    completed = TRUE,
    date = Sys.time(),
    reports = reports
  )
  
  save_project(project)
  
  invisible(project)
  
}