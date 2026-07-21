quality_control_server <- function(
    input,
    output,
    session,
    current_project,
    project_samples,
    app_settings
){
  
  # ==========================================================
  # Quality control
  # ==========================================================
  
  observeEvent(input$run_quality_control, {
    
    req(current_project()$path)
    
    if (is.null(current_project()$path)) {
      
      showNotification(
        "Please create or open a project before running FastQC.",
        type = "error"
      )
      
      return()
      
    }
    
    req(current_project())
    req(project_samples())
    
    if (is.null(app_settings$tools$fastqc)) {
      
      showNotification(
        "FastQC was not found on this computer.",
        type = "error"
      )
      
      return()
      
    }
    
    print(current_project())
    
    print(current_project()$path)
    
    print(project_samples())
    
    output_dir <- file.path(
      current_project()$path,
      "results",
      "fastqc"
    )
    
    print(output_dir)
    
    samples <- project_samples()
    
    ## Ajuste os nomes das colunas conforme sua tabela
    files <- unique(c(samples$R1, samples$R2))
    
    files <- files[!is.na(files)]
    
    withProgress(
      
      message = "Running FastQC...",
      value = 0,
      
      {
        
        run_fastqc(
          
          files = files,
          
          output_dir = output_dir,
          
          threads = app_settings$threads,
          
          fastqc_path = app_settings$tools$fastqc
          
        )
        
        incProgress(1)
        
      }
      
    )
    
    showNotification(
      "FastQC completed successfully!",
      type = "message"
    )
    
  })  


  output$qc_project_summary <- renderUI({
    
    req(current_project())
    
    samples <- project_samples()
    
    n_samples <- nrow(samples)
    n_fastq <- sum(!is.na(c(samples$R1, samples$R2)))
    
    div(
      style = "
      border:1px solid #ddd;
      border-radius:8px;
      padding:15px;
      background:white;
      min-height:220px;
    ",
      
      h4("Project Summary"),
      
      hr(),
      
      p(strong("Project:"), current_project()$name),
      
      p(strong("Samples:"), n_samples),
      
      p(strong("FASTQ Files:"), n_fastq),
      
      p(strong("Output:"), "results/")
    )
    
  })

  output$qc_tools_summary <- renderUI({
    
    settings <- app_settings
    
    fastqc_path <- settings$tools$fastqc
    multiqc_path <- settings$tools$multiqc
    
    fastqc_ok <- !is.null(fastqc_path) &&
      nzchar(fastqc_path) &&
      file.exists(fastqc_path)
    
    multiqc_ok <- !is.null(multiqc_path) &&
      nzchar(multiqc_path) &&
      file.exists(multiqc_path)
    
    div(
      style = "
      border:1px solid #ddd;
      border-radius:8px;
      padding:15px;
      background:white;
      min-height:220px;
    ",
      
      h4("Installed Tools"),
      
      hr(),
      
      p(if (fastqc_ok) "🟢 FastQC" else "🔴 FastQC"),
      
      p(if (multiqc_ok) "🟢 MultiQC" else "🔴 MultiQC"),
      
      p(strong("Threads:"), settings$threads)
    )
    
  })

}