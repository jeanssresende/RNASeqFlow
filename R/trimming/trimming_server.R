trimming_server <- function(
    input,
    output,
    session,
    current_project,
    project_samples,
    app_settings
){
  
  #==========================================================
  # Trimming
  #==========================================================
  
  fastp_reports_state <- reactiveVal(data.frame())
  
  #-----------------------------------------------------------
  # Run fastp
  #-----------------------------------------------------------
  
  observeEvent(input$run_fastp, {
    
    req(current_project())
    req(project_samples())
    
    print("1 - Clique")
    
    fastp_ok <- tryCatch({
      
      print(fastp_binary())
      
      TRUE
      
    }, error = function(e){
      
      print(e$message)
      
      FALSE
      
    })
    
    if (!fastp_ok)
      return()
    
    print("2 - Executando fastp")
    
    withProgress(
      
      message = "Running fastp...",
      
      value = 0,
      
      {
        
        run_fastp(
          
          samples = project_samples(),
          
          project = current_project(),
          
          threads = app_settings$threads,
          
          progress = NULL
          
        )
        
      }
      
    )
    
    print("3 - Fastp terminou")
    
  })
  
  #-----------------------------------------------------------
  # Aqui depois virão:
  # output$fastp_summary_card <- ...
  # output$fastp_reports <- ...
  # observeEvent(input$open_fastp_report, ...)
  #-----------------------------------------------------------
  
}