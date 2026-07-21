find_conda <- function() {
  
  conda <- Sys.which("conda")
  
  if (!nzchar(conda)) {
    return(NULL)
  }
  
  conda
  
}


conda_env_exists <- function(
    env_name = "rnaseqflow"
){
  
  conda <- find_conda()
  
  if (is.null(conda))
    return(FALSE)
  
  result <- system2(
    conda,
    c("env", "list"),
    stdout = TRUE
  )
  
  any(grepl(
    paste0("^", env_name, "\\s"),
    trimws(result)
  ))
  
}

get_conda_env_path <- function(
    env_name = "rnaseqflow"
){
  
  conda <- find_conda()
  
  if (is.null(conda))
    return(NULL)
  
  result <- system2(
    conda,
    c("env", "list"),
    stdout = TRUE
  )
  
  line <- result[
    grepl(
      paste0("^", env_name, "\\s"),
      trimws(result)
    )
  ]
  
  if(length(line)==0)
    return(NULL)
  
  fields <- strsplit(trimws(line),"\\s+")[[1]]
  
  tail(fields,1)
  
}