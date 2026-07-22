# ==========================================================
# Utilities
# ==========================================================

value_or_default <- function(x, default = "-") {
  
  if (is.null(x) || length(x) == 0)
    return(default)
  
  if (is.character(x)) {
    
    x <- trimws(x)
    
    if (!nzchar(x))
      return(default)
    
  }
  
  x
  
}