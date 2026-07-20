header_ui <- function() {
  
  div(
    class = "app-header",
    
    div(
      class = "app-title",
      
      "RNASeqFlow"
    ),
    
    div(
      class = "project-name",
      
      textOutput(
        outputId = "current_project",
        inline = TRUE
      )
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