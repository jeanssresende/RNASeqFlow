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
    
    current_project(
      load_project(current_project()$path)
    )
    
    print("3 - Fastp terminou")
    
  })
  
  #-----------------------------------------------------------
  # Summary
  #-----------------------------------------------------------
  
  output$fastp_summary_card <- renderUI({
    
    req(current_project())
    
    summary <- fastp_summary(current_project())
    
    tagList(
      
      tags$table(
        
        class = "table table-sm",
        
        tags$tr(
          tags$td(strong("Status")),
          tags$td(summary$status)
        ),
        
        tags$tr(
          tags$td(strong("Samples")),
          tags$td(summary$samples)
        ),
        
        tags$tr(
          tags$td(strong("Last execution")),
          tags$td(
            if (is.null(summary$date)) {
              "-"
            } else {
              format(summary$date, "%Y-%m-%d %H:%M")
            }
          )
        )
        
      )
      
    )
    
  })
  
  
  #-----------------------------------------------------------
  # Reports
  #-----------------------------------------------------------
  
  output$fastp_reports <- DT::renderDT({
    
    req(current_project())
    
    reports <- fastp_report_table(current_project())
    
    DT::datatable(
      
      reports,
      
      rownames = FALSE,
      
      selection = "single",
      
      options = list(
        
        pageLength = 10,
        
        autoWidth = TRUE,
        
        scrollX = TRUE,
        
        dom = "tip"
        
      )
      
    ) |>
      
      DT::formatStyle(
        
        "Status",
        
        fontWeight = "bold",
        
        backgroundColor = DT::styleEqual(
          
          "Completed",
          
          "#d4edda"
          
        ),
        
        color = DT::styleEqual(
          
          "Completed",
          
          "#155724"
          
        )
        
      )
    
  })
  
  
  observeEvent(input$open_fastp_report, {
    
    req(current_project())
    
    selected <- input$fastp_reports_rows_selected
    
    if (length(selected) == 0) {
      
      showNotification(
        "Please select a report first.",
        type = "warning"
      )
      
      return()
      
    }
    
    project <- current_project()
    
    report <- project$results$fastp$reports[[selected]]$html
    
    browseURL(report)
    
  })
  
}