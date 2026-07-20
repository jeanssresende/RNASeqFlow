project_page_ui <- function() {
  
  tagList(
    
    div(
      class = "page-header",
      
      h2(
        class = "page-title",
        "Projects"
      ),
      
      p(
        class = "page-description",
        "Create a new RNA-Seq project or open an existing project to start your analysis."
      )
    ),
    
    fluidRow(
      
      column(
        width = 6,
        class = "mb-4",
        
        action_card(
          id = "create_project",
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
      
    ),
    
    hr(),
    
    h4("Recent Projects"),
    
    empty_state(
      icon_name = "clock",
      title = "No Recent Projects",
      description = "Recently opened projects will appear here."
    )
    
  )
  
}