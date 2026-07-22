server <- function(input, output, session) {
  
  # ==========================================================
  # Application State
  # ==========================================================
  
  current_page <- reactiveVal("home")
  
  current_project <- reactiveVal(
    list(
      name = NULL,
      path = NULL,
      created = NULL,
      samples = NULL,
      status = list(
        fastqc = FALSE,
        trimming = FALSE,
        fastqc_trimmed = FALSE,
        quantification = FALSE
      )
    )
  )
  
  selected_folder <- reactiveVal(NULL)
  project_samples <- reactiveVal(NULL)
  
  
  # ==========================================================
  # Reactives
  # ==========================================================
  
  fastq_files <- reactive({
    
    req(selected_folder())
    
    list.files(
      selected_folder(),
      pattern = "\\.(fastq|fq)(\\.gz)?$",
      ignore.case = TRUE,
      full.names = TRUE
    )
    
  })
  
  
  project_info <- reactive({
    
    req(project_samples())
    
    project_summary(project_samples())
    
  })
  
  
  # ==========================================================
  # Header
  # ==========================================================
  
  output$current_project <- renderText({
    
    project <- current_project()
    
    if (is.null(project$name)) {
      
      "Project: No project"
      
    } else {
      
      paste("Project:", project$name)
      
    }
    
  })
  
  
  # ==========================================================
  # Create Project Modal
  # ==========================================================
  
  observeEvent(input$create_project, {
    
    showModal(
      
      modalDialog(
        
        title = "Create New Project",
        
        textInput(
          "project_name",
          "Project name",
          value = "MyProject",
          width = "100%"
        ),
        
        footer = tagList(
          
          modalButton("Cancel"),
          
          actionButton(
            "confirm_create_project",
            "Create Project",
            class = "btn-primary"
          )
          
        ),
        
        easyClose = TRUE
        
      )
      
    )
    
  })
  
  # ==========================================================
  # Projects
  # ==========================================================
  
  observeEvent(input$confirm_create_project, {
    
    removeModal()
    
    project_name <- trimws(input$project_name)
    
    if (!nzchar(project_name)) {
      
      showNotification(
        "Please enter a project name.",
        type = "warning"
      )
      
      return()
      
    }
    
    if (!nzchar(project_name)) {
      
      showNotification(
        "Please enter a project name.",
        type = "warning"
      )
      
      return()
      
    }
    
    # Não permitir espaços
    if (grepl("\\s", project_name)) {
      
      showNotification(
        "Project name cannot contain spaces. Use '_' or '-' instead.",
        type = "error",
        duration = 8
      )
      
      return()
      
    }
    
    if (grepl("[^A-Za-z0-9_-]", project_name)) {
      
      showNotification(
        "Project name can only contain letters, numbers, '_' and '-'.",
        type = "error",
        duration = 8
      )
      
      return()
      
    }
    
    parent_directory <- svDialogs::dlg_dir(
      default = normalizePath("~"),
      title = "Select project folder"
    )$res
    
    if (is.null(parent_directory) ||
        length(parent_directory) == 0 ||
        !nzchar(parent_directory)) {
      
      return()
      
    }
    
    tryCatch({
      
      project <- create_project(
        
        project_name = project_name,
        parent_directory = parent_directory
        
      )
      
      current_project(project)
      
      current_page("import")
      
      showNotification(
        
        paste("Project", project$name, "created successfully."),
        
        type = "message"
        
      )
      
    }, error = function(e) {
      
      showNotification(
        
        e$message,
        
        type = "error",
        
        duration = 10
        
      )
      
    })
    
  })
  
  
  observeEvent(input$open_project, {
    
    project_directory <- svDialogs::dlg_dir(
      default = normalizePath("~"),
      title = "Select a RNASeqFlow project"
    )$res
    
    if (is.null(project_directory) ||
        length(project_directory) == 0 ||
        !nzchar(project_directory)) {
      return()
    }
      
    
    project <- open_project(project_directory)
    
    current_project(project)
    
    current_page("import")
    
    showNotification(
      paste("Project", project$name, "opened successfully."),
      type = "message"
    )
    
  })
  
  
  # ==========================================================
  # Folder Selection
  # ==========================================================
  
  observeEvent(input$select_folder, {
    
    folder <- svDialogs::dlg_dir(
      default = normalizePath("~")
    )$res
    
    if (length(folder) == 0 ||
        is.na(folder) ||
        !nzchar(folder)) {
      return()
    }
    
    selected_folder(folder)
    
    files <- list.files(
      folder,
      pattern = "\\.(fastq|fq)(\\.gz)?$",
      ignore.case = TRUE,
      full.names = TRUE
    )
    
    if (length(files) == 0) {
      
      showNotification(
        "No FASTQ files were found in the selected folder.",
        type = "warning"
      )
      
      return()
      
    }
    
    samples <- parse_fastq_files(files)
    
    project_samples(samples)
    
    project <- current_project()
    
    project$fastq_folder <- folder
    project$samples <- samples
    
    if (is.null(project$name)) {
      
      project$name <- basename(folder)
      
    }
    
    current_project(project)
    
  })
  
  
  # ==========================================================
  # Outputs
  # ==========================================================
  
  output$selected_folder <- renderText({
    
    req(selected_folder())
    
    selected_folder()
    
  })
  
  
  output$project_summary <- renderUI({
    
    req(project_info())
    
    info <- project_info()
    
    tagList(
      
      h4("Project Summary"),
      
      tags$table(
        
        class = "table table-sm",
        
        tags$tr(tags$td(strong("Samples")), tags$td(info$samples)),
        tags$tr(tags$td(strong("FASTQ Files")), tags$td(info$fastq)),
        tags$tr(tags$td(strong("Paired-end")), tags$td(info$paired)),
        tags$tr(tags$td(strong("Single-end")), tags$td(info$single)),
        tags$tr(tags$td(strong("Valid Samples")), tags$td(info$valid)),
        tags$tr(tags$td(strong("Missing Files")), tags$td(info$missing))
        
      ),
      
      if (info$ready) {
        
        div(
          class = "alert alert-success",
          "✔ Ready for FastQC"
        )
        
      } else {
        
        div(
          class = "alert alert-danger",
          "✖ Project contains invalid samples."
        )
        
      }
      
    )
    
  })
  
  
  output$fastq_table <- DT::renderDT({
    
    req(project_samples())
    
    DT::datatable(
      
      project_samples(),
      
      rownames = FALSE,
      filter = "top",
      selection = "single",
      
      options = list(
        pageLength = 10,
        autoWidth = TRUE,
        scrollX = TRUE,
        order = list(list(0, "asc"))
      )
      
    ) |>
      
      DT::formatStyle(
        
        "Status",
        
        fontWeight = "bold",
        
        backgroundColor = DT::styleEqual(
          c("Valid", "Missing R1", "Missing R2"),
          c("#d4edda", "#f8d7da", "#f8d7da")
        ),
        
        color = DT::styleEqual(
          c("Valid", "Missing R1", "Missing R2"),
          c("#155724", "#721c24", "#721c24")
        )
        
      )
    
  })
  
  
  # ==========================================================
  # Navigation
  # ==========================================================
  
  observeEvent(input$go_home, current_page("home"))
  observeEvent(input$go_project, current_page("project"))
  observeEvent(input$go_import, current_page("import"))
  observeEvent(input$go_qc, current_page("qc"))
  observeEvent(input$go_trimming, current_page("trimming"))
  observeEvent(input$go_trimmed_qc, current_page("trimmed_qc"))
  observeEvent(input$go_quantification, current_page("quantification"))
  observeEvent(input$go_annotation, current_page("annotation"))
  observeEvent(input$go_export, current_page("export"))
  observeEvent(input$go_logs, current_page("logs"))
  
  
  # ==========================================================
  # Workspace
  # ==========================================================
  
  output$workspace <- renderUI({
    
    switch(
      
      current_page(),
      
      home           = home_page_ui(),
      project        = project_page_ui(),
      import         = import_samples_page_ui(),
      qc             = quality_control_page_ui(),
      trimming       = trimming_page_ui(),
      trimmed_qc     = trimmed_qc_page_ui(),
      quantification = quantification_page_ui(),
      annotation     = annotation_page_ui(),
      export         = export_page_ui(),
      logs           = logs_page_ui()
      
    )
    
  })
  
  quality_control_server(
    input = input,
    output = output,
    session = session,
    current_project = current_project,
    project_samples = project_samples,
    app_settings = app_settings
  )
  
  trimming_server(
    input,
    output,
    session,
    current_project,
    project_samples,
    app_settings
  )
  
  trimmed_qc_server(
    input = input,
    output = output,
    session = session,
    current_project = current_project,
    project_samples = project_samples,
    app_settings = app_settings
  )
  
  quantification_server(
    input,
    output,
    session,
    current_project
  )
  
}



