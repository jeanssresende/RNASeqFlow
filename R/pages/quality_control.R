quality_control_page_ui <- function() {
  
  fluidPage(
    
    h2("Quality Control"),
    
    p(
      "Assess the quality of raw RNA-Seq reads before downstream analyses.",
      "FastQC evaluates each FASTQ file individually and MultiQC summarizes",
      "all reports into a single interactive report."
    ),
    
    br(),
    
    fluidRow(
      
      column(
        width = 6,
        uiOutput("qc_project_summary")
      ),
      
      column(
        width = 6,
        uiOutput("qc_tools_summary")
      )
      
    ),
    
    br(),
    
    uiOutput("qc_output_directory"),
    
    br(),
    
    h3("FastQC"),
    
    actionButton(
      "run_fastqc",
      "Run FastQC",
      class = "btn-primary"
    ),
    
    br(),
    br(),
    
    uiOutput("fastqc_summary_card"),
    
    br(),
    
    br(),
    br(),
    
    h3("FastQC Reports"),
    
    DT::dataTableOutput("fastqc_reports"),
    
    hr(),
    
    h3("MultiQC"),
    
    actionButton(
      "run_multiqc",
      "Run MultiQC",
      class = "btn-secondary"
    ),
    
    br(),
    
    uiOutput("multiqc_status")
    
  )
  
}