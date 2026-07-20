create_layout <- function(header,
                          sidebar,
                          workspace) {
  
  page_fillable(
    
    theme = bs_theme(
      version = 5,
      bootswatch = "flatly"
    ),
    
    tags$head(
      tags$link(
        rel = "stylesheet",
        href = "css/style.css"
      )
    ),
    
    div(
      class = "app",
      
      header,
      
      div(
        class = "app-body",
        
        sidebar,
        
        workspace
      )
    )
    
  )
  
}