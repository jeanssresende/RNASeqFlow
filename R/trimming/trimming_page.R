# ==========================================================
# Trimming Page
# ==========================================================

trimming_page_ui <- function() {
  
  page_fill(
    
    gap = "1rem",
    
    layout_columns(
      
      col_widths = c(4, 8),
      
      #=======================================================
      # Project Summary
      #=======================================================
      
      card(
        
        full_screen = FALSE,
        
        card_header("Project Summary"),
        
        uiOutput("trimming_project_summary")
        
      ),
      
      #=======================================================
      # fastp
      #=======================================================
      
      card(
        
        full_screen = FALSE,
        
        card_header("fastp"),
        
        actionButton(
          "run_fastp",
          "Run fastp",
          icon = icon("play"),
          class = "btn-primary"
        ),
        
        actionButton(
          "open_fastp_report",
          "Open Report",
          icon = icon("file-lines"),
          class = "btn-secondary"
          
        ),
        
        br(),
        br(),
        
        uiOutput("fastp_summary_card")
        
      )
      
    ),
    
    #=========================================================
    # Reports
    #=========================================================
    
    card(
      
      full_screen = TRUE,
      
      card_header("Reports"),
      
      DT::dataTableOutput("fastp_reports")
      
    )
    
  )
  
}