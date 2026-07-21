# ==========================================================
# RNASeqFlow System Utilities
# ==========================================================

# ==========================================================
# Execute External Command
# ==========================================================

# ==========================================================
# Execute External Command
# ==========================================================

run_command <- function(command,
                        args = character(),
                        working_directory = NULL,
                        stdout = TRUE,
                        stderr = TRUE,
                        wait = TRUE) {
  
  old_wd <- getwd()
  
  on.exit(
    setwd(old_wd),
    add = TRUE
  )
  
  if (!is.null(working_directory)) {
    
    dir.create(
      working_directory,
      recursive = TRUE,
      showWarnings = FALSE
    )
    
    setwd(working_directory)
    
  }
  
  output <- tryCatch(
    
    system2(
      command = command,
      args = args,
      stdout = stdout,
      stderr = stderr,
      wait = wait
    ),
    
    error = function(e) {
      
      structure(
        conditionMessage(e),
        status = 1
      )
      
    }
    
  )
  
  status <- attr(output, "status")
  
  if (is.null(status)) {
    
    status <- 0
    
  }
  
  list(
    
    success = identical(status, 0),
    
    status = status,
    
    output = output,
    
    command = command,
    
    args = args
    
  )
  
}


run_command_or_stop <- function(...) {
  
  result <- run_command(...)
  
  if (!result$success) {
    
    stop(
      paste(result$output, collapse = "\n"),
      call. = FALSE
    )
    
  }
  
  result
  
}