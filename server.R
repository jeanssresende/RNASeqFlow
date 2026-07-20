server <- function(input, output, session) {
  
  current_page <- reactiveVal("home")
  
  current_project <- reactiveVal(NULL)
  
  output$current_project <- renderText({
    
    if (is.null(current_project())) {
      "Project: No project"
    } else {
      paste("Project:", current_project())
    }
    
  })
  
  observeEvent(input$go_home,{
    current_page("home")
  })
  
  observeEvent(input$go_project,{
    current_page("project")
  })
  
  output$workspace <- renderUI({
    
    switch(
      
      current_page(),
      
      home = home_page_ui(),
      
      project = project_page_ui()
      
    )
    
  })
  
}