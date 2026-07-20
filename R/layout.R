create_layout <- function(header,
                          sidebar,
                          workspace) {
  
  page_fluid(
    
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
    
    header,
    
    div(
      
      class = "app-body",
      
      sidebar,
      
      workspace
      
    )
    
  )
  
}