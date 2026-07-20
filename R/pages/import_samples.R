import_samples_page_ui <- function() {
  
  tagList(
    
    div(
      class = "page-header",
      
      h2(
        class = "page-title",
        "Import Samples"
      ),
      
      p(
        class = "page-description",
        "Import paired-end FASTQ files into the current project."
      )
      
    ),
    
    div(
      class = "mb-4",
      
      actionButton(
        inputId = "select_folder",
        label = "📂 Select Folder",
        class = "btn btn-primary"
      )
    ),
    
    verbatimTextOutput("selected_folder"),
    
    br(),
    
    h4("FASTQ Files"),
    
    tableOutput("fastq_table"),
    
    br(),
    
    h4("Sample Summary"),
    
    empty_state(
      icon_name = "flask",
      title = "No samples imported",
      description = "Imported samples will appear here."
    )
    
  )
  
}