# ==========================================================
# Quality Control Summary
# ==========================================================

#-----------------------------------------------------------
# FastQC summary
#-----------------------------------------------------------

# ==========================================================
# FastQC summary
# ==========================================================

fastqc_summary <- function(project,
                           stage = "raw") {
  
  if (is.null(project)) {
    return(NULL)
  }
  
  result <- project$results[[paste0("fastqc_", stage)]]
  
  if (is.null(result) || !isTRUE(result$completed)) {
    
    return(list(
      completed = FALSE,
      reports = 0,
      date = NULL,
      status = "Not executed"
    ))
    
  }
  
  list(
    completed = TRUE,
    reports = length(result$reports),
    date = result$date,
    status = "Completed"
  )
  
}


#-----------------------------------------------------------
# MultiQC summary
#-----------------------------------------------------------

multiqc_summary <- function(project,
                            stage = "raw") {
  
  if (is.null(project)) {
    return(NULL)
  }
  
  result <- project$results[[paste0("multiqc_", stage)]]
  
  if (is.null(result) || !isTRUE(result$completed)) {
    
    return(list(
      completed = FALSE,
      report = NULL,
      date = NULL,
      status = "Not executed"
    ))
    
  }
  
  list(
    completed = TRUE,
    report = result$report,
    date = result$date,
    status = "Completed"
  )
  
}