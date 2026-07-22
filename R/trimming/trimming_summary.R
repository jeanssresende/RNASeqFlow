# ==========================================================
# Trimming Summary
# ==========================================================

#-----------------------------------------------------------
# fastp summary
#-----------------------------------------------------------

fastp_summary <- function(project){
  
  result <- project$results$fastp
  
  if (is.null(result)) {
    
    return(
      
      list(
        
        completed = FALSE,
        
        reports = 0,
        
        date = NULL,
        
        status = "Not executed"
        
      )
      
    )
    
  }
  
  list(
    
    completed = TRUE,
    
    samples = length(result$reports),
    
    date = result$date,
    
    status = "Completed"
    
  )
  
}
