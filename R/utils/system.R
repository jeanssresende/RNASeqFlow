# ==========================================================
# RNASeqFlow System Utilities
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
  
  status <- 0
  
  output <- tryCatch({
    
    # Guarda o diretório atual
    old_wd <- getwd()
    
    # Muda temporariamente o diretório
    if (!is.null(working_directory)) {
      
      setwd(working_directory)
      
      on.exit(setwd(old_wd), add = TRUE)
      
    }
    
    system2(
      command = command,
      args = args,
      stdout = stdout,
      stderr = stderr,
      wait = wait
    )
    
  },
  
  error = function(e) {
    
    status <<- 1
    
    conditionMessage(e)
    
  })
  
  list(
    
    success = identical(status, 0),
    
    status = status,
    
    output = output
    
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