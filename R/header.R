header_ui <- function() {
  
  div(
    class = "app-header",
    
    div(
      class = "app-title",
      
      "RNASeqFlow"
    ),
    
    div(
      class = "project-name",
      
      "Projeto: Nenhum projeto"
    ),
    
    div(
      class = "header-actions",
      
      actionButton(
        "settings",
        label = NULL,
        icon = icon("gear"),
        class = "btn-light"
      ),
      
      actionButton(
        "help",
        label = NULL,
        icon = icon("circle-question"),
        class = "btn-light"
      )
      
    )
    
  )
  
}