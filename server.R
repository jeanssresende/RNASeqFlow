server <- function(input, output, session) {
  
  current_page <- reactiveVal("home")
  
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