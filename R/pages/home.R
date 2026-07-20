home_page_ui <- function() {
  
  tagList(
    
    div(
      class = "page-header",
      
      h2(
        class = "page-title",
        "Welcome to RNASeqFlow"
      ),
      
      p(
        class = "page-description",
        "A graphical workflow for RNA-Seq preprocessing, quantification and downstream analysis."
      )
      
    ),
    
    fluidRow(
      
      column(
        width = 6,
        class = "mb-4",
        
        action_card(
          id = "new_project",
          title = "Create Project",
          description = "Create a new RNA-Seq project.",
          icon_name = "folder-plus"
        )
        
      ),
      
      column(
        width = 6,
        class = "mb-4",
        
        action_card(
          id = "open_project",
          title = "Open Project",
          description = "Open an existing project.",
          icon_name = "folder-open"
        )
        
      )
      
    )
    
  )
  
}