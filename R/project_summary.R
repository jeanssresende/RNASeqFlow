project_summary <- function(samples) {
  
  if (is.null(samples) || nrow(samples) == 0) {
    
    return(list(
      samples = 0,
      fastq = 0,
      paired = 0,
      single = 0,
      valid = 0,
      missing = 0,
      ready = FALSE
    ))
    
  }
  
  valid <- samples$Status == "Valid"
  
  list(
    
    samples = nrow(samples),
    
    fastq =
      sum(!is.na(samples$R1)) +
      sum(!is.na(samples$R2)),
    
    paired = sum(valid),
    
    single = 0,
    
    valid = sum(valid),
    
    missing = sum(!valid),
    
    ready = all(valid)
    
  )
  
}