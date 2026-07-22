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