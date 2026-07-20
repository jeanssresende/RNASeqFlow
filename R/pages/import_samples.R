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
    
    action_card(
      id = "select_folder",
      title = "Select Folder",
      description = "Choose a directory containing FASTQ files.",
      icon_name = "folder-open"
    ),
    
    br(),
    
    h4("FASTQ Files"),
    
    empty_state(
      icon_name = "folder-open",
      title = "No folder selected",
      description = "Select a folder to display FASTQ files."
    ),
    
    br(),
    
    h4("Sample Summary"),
    
    empty_state(
      icon_name = "flask",
      title = "No samples imported",
      description = "Imported samples will appear here."
    )
    
  )
  
}