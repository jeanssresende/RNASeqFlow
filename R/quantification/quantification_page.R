# ==========================================================
# Quantification Page
# ==========================================================

quantification_page_ui <- function() {
  
  page_fill(
    
    gap = "1rem",
    
    #=======================================================
    # Project Summary + Reference
    #=======================================================
    
    layout_columns(
      
      col_widths = c(4, 8),
      
      #-----------------------------------------------------
      # Project Summary
      #-----------------------------------------------------
      
      card(
        
        full_screen = FALSE,
        
        card_header("Project Summary"),
        
        uiOutput("quantification_project_summary")
        
      ),
      
      #-----------------------------------------------------
      # Reference
      #-----------------------------------------------------
      
      card(
        
        full_screen = FALSE,
        
        card_header("Reference"),
        
        radioButtons(
          "reference_source",
          "Reference Source",
          choices = c(
            "Download from Ensembl" = "ensembl",
            "Local transcriptome" = "local",
            "Existing Salmon index" = "index"
          ),
          selected = "ensembl"
        ),
        
        uiOutput("reference_options"),
        
        br(),
        
        actionButton(
          "download_reference",
          "Download Reference",
          icon = icon("download"),
          class = "btn-primary"
        )
        
      )
      
    ),
    
    #=======================================================
    # Reference Information
    #=======================================================
    
    card(
      
      full_screen = FALSE,
      
      card_header("Reference Information"),
      
      uiOutput("reference_information")
      
    ),
    
    #=======================================================
    # Salmon Index
    #=======================================================
    
    card(
      
      full_screen = FALSE,
      
      card_header("Salmon Index"),
      
      actionButton(
        "build_salmon_index",
        "Build Index",
        icon = icon("hammer"),
        class = "btn-primary"
      ),
      
      br(),
      br(),
      
      uiOutput("salmon_index_summary")
      
    ),
    
    #=======================================================
    # Salmon
    #=======================================================
    
    card(
      
      full_screen = FALSE,
      
      card_header("Salmon Quantification"),
      
      actionButton(
        "run_salmon",
        "Run Salmon",
        icon = icon("play"),
        class = "btn-primary"
      ),
      
      br(),
      br(),
      
      uiOutput("salmon_summary")
      
    ),
    
    #=======================================================
    # Results
    #=======================================================
    
    card(
      
      full_screen = TRUE,
      
      card_header("Quantification Results"),
      
      DT::dataTableOutput("quantification_results")
      
    )
    
  )
  
}