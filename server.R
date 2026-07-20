server <- function(input, output, session) {
  
  # ==========================
  # Application State
  # ==========================
  
  current_page <- reactiveVal("home")
  current_project <- reactiveVal(NULL)
  selected_folder <- reactiveVal(NULL)
  
  
  # ==========================
  # Header
  # ==========================
  
  output$current_project <- renderText({
    
    if (is.null(current_project())) {
      "Project: No project"
    } else {
      paste("Project:", current_project())
    }
    
  })
  
  
  observeEvent(input$select_folder, {
    
    folder <- svDialogs::dlg_dir(
      default = normalizePath("~")
    )$res
    
    if (nzchar(folder)) {
      selected_folder(folder)
    }
    
  })
  
  output$selected_folder <- renderText({
    
    req(selected_folder())
    
    selected_folder()
    
  })
  
  # ==========================
  # Navigation
  # ==========================
  
  observeEvent(input$go_home, {
    current_page("home")
  })
  
  observeEvent(input$go_project, {
    current_page("project")
  })
  
  observeEvent(input$go_import, {
    current_page("import")
  })
  
  observeEvent(input$go_qc, {
    current_page("qc")
  })
  
  observeEvent(input$go_trimming, {
    current_page("trimming")
  })
  
  observeEvent(input$go_quantification, {
    current_page("quantification")
  })
  
  observeEvent(input$go_annotation, {
    current_page("annotation")
  })
  
  observeEvent(input$go_export, {
    current_page("export")
  })
  
  observeEvent(input$go_logs, {
    current_page("logs")
  })
  
  observeEvent(input$select_folder, {
    
    folder <- parseDirPath(volumes, input$select_folder)
    
    if (length(folder) > 0) {
      selected_folder(folder)
    }
    
  })
  
  
  output$selected_folder <- renderText({
    
    req(selected_folder())
    
    selected_folder()
    
  })
  # ==========================
  # Workspace
  # ==========================
  
  output$workspace <- renderUI({
    
    switch(
      
      current_page(),
      
      home            = home_page_ui(),
      project         = project_page_ui(),
      import          = import_samples_page_ui(),
      qc              = quality_control_page_ui(),
      trimming        = trimming_page_ui(),
      quantification  = quantification_page_ui(),
      annotation      = annotation_page_ui(),
      export          = export_page_ui(),
      logs            = logs_page_ui()
      
    )
    
  })
  
}