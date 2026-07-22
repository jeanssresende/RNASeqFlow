trimmed_qc_page_ui <- function() {
  
  fluidPage(
    
    h2("Trimmed Quality Control"),
    
    p(
      "Assess the quality of trimmed RNA-Seq reads after adapter removal ",
      "and quality filtering with fastp. FastQC evaluates each trimmed ",
      "FASTQ file individually and MultiQC summarizes all reports into ",
      "a single interactive report."
    ),
    
    br(),
    
    fluidRow(
      
      column(
        width = 6,
        uiOutput("trimmed_qc_project_summary")
      ),
      
      column(
        width = 6,
        uiOutput("trimmed_qc_tools_summary")
      )
      
    ),
    
    br(),
    
    uiOutput("trimmed_qc_output_directory"),
    
    br(),
    
    h3("FastQC"),
    
    actionButton(
      inputId = "run_fastqc_trimmed",
      label = "Run FastQC",
      class = "btn-primary"
    ),
    
    br(),
    br(),
    
    uiOutput("fastqc_trimmed_summary_card"),
    
    br(),
    br(),
    
    h3("Trimmed FastQC Reports"),
    
    DT::dataTableOutput("fastqc_trimmed_reports"),
    
    hr(),
    
    h3("MultiQC"),
    
    actionButton(
      inputId = "run_multiqc_trimmed",
      label = "Run MultiQC",
      class = "btn-primary"
    ),
    
    br(),
    br(),
    
    uiOutput("multiqc_trimmed_summary_card"),
    
    br(),
    
    uiOutput("multiqc_trimmed_status")
    
  )
  
}