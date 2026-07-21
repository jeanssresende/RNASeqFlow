quality_control_page_ui <- function() {
  
  fluidPage(
    
    h2("Quality Control"),
    
    br(),
    
    actionButton(
      "run_fastqc",
      "Run Quality Control",
      class = "btn-primary"
    )
    
  )
  
}