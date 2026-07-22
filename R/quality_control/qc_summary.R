# ==========================================================
# Quality Control Summary
# ==========================================================

#-----------------------------------------------------------
# FastQC summary
#-----------------------------------------------------------

fastqc_summary <- function(project) {
  
  if (is.null(project)) {
    return(NULL)
  }
  
  result <- project$results$fastqc
  
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

multiqc_summary <- function(project) {
  
  if (is.null(project)) {
    return(NULL)
  }
  
  result <- project$results$multiqc
  
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