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
    
    actionButton(
      "run_quality_control",
      "Run Quality Control",
      class = "btn-primary btn-lg"
    ),
    
    br(),
    br(),
    
    hr(),
    
    h3("FastQC Reports"),
    
    DT::dataTableOutput("fastqc_reports"),
    
    br(),
    
    uiOutput("qc_status")
    
  )
  
}