server <- function(input, output, session) {
  
  # ==========================================================
  # Application State
  # ==========================================================
  
  current_page <- reactiveVal("home")
  current_project <- reactiveVal(NULL)
  selected_folder <- reactiveVal(NULL)
  project_samples <- reactiveVal(NULL)
  
  
  # ==========================================================
  # Reactives
  # ==========================================================
  
  fastq_files <- reactive({
    
    req(selected_folder())
    
    list.files(
      path = selected_folder(),
      pattern = "\\.(fastq|fq)(\\.gz)?$",
      ignore.case = TRUE,
      full.names = FALSE
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
    
    if (is.null(current_project())) {
      "Project: No project"
    } else {
      paste("Project:", current_project())
    }
    
  })
  
  
  # ==========================================================
  # Folder Selection
  # ==========================================================
  
  observeEvent(input$select_folder, {
    
    folder <- svDialogs::dlg_dir(
      default = normalizePath("~")
    )$res
    
    if (!is.null(folder) && nzchar(folder)) {
      
      selected_folder(folder)
      
      files <- list.files(
        path = folder,
        pattern = "\\.(fastq|fq)(\\.gz)?$",
        ignore.case = TRUE,
        full.names = FALSE
      )
      
      project_samples(
        parse_fastq_files(files)
      )
      
    }
    
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
        
        tags$tr(
          tags$td(strong("Samples")),
          tags$td(info$samples)
        ),
        
        tags$tr(
          tags$td(strong("FASTQ Files")),
          tags$td(info$fastq)
        ),
        
        tags$tr(
          tags$td(strong("Paired-end")),
          tags$td(info$paired)
        ),
        
        tags$tr(
          tags$td(strong("Single-end")),
          tags$td(info$single)
        ),
        
        tags$tr(
          tags$td(strong("Valid Samples")),
          tags$td(info$valid)
        ),
        
        tags$tr(
          tags$td(strong("Missing Files")),
          tags$td(info$missing)
        )
        
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
      quantification = quantification_page_ui(),
      annotation     = annotation_page_ui(),
      export         = export_page_ui(),
      logs           = logs_page_ui()
      
    )
    
  })
  
}