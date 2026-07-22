# ==========================================================
# Quantification Server
# ==========================================================

quantification_server <- function(input, output, session, current_project) {
  
  # ==========================================================
  # Reference Options
  # ==========================================================
  
  output$reference_options <- renderUI({
    
    req(input$reference_source)
    
    switch(
      
      input$reference_source,
      
      #--------------------------------------------------------
      # Download from Ensembl
      #--------------------------------------------------------
      
      "ensembl" = tagList(
        
        selectInput(
          "reference_species",
          "Species",
          choices = c(
            "Homo sapiens",
            "Mus musculus"
          )
        ),
        
        selectInput(
          "reference_release",
          "Ensembl Release",
          choices = "Latest"
        )
        
      ),
      
      #--------------------------------------------------------
      # Local transcriptome
      #--------------------------------------------------------
      
      "local" = tagList(
        
        actionButton(
          "browse_transcriptome",
          "Browse Transcriptome",
          icon = icon("folder-open")
        ),
        
        br(),
        br(),
        
        strong("Selected transcriptome"),
        
        textOutput("selected_transcriptome"),
        
        br(),
        
        actionButton(
          "browse_annotation",
          "Browse Annotation",
          icon = icon("folder-open")
        ),
        
        br(),
        br(),
        
        strong("Selected annotation"),
        
        textOutput("selected_annotation")
        
      ),
      
      #--------------------------------------------------------
      # Existing Salmon Index
      #--------------------------------------------------------
      
      "index" = tagList(
        
        actionButton(
          "browse_index",
          "Browse Salmon Index",
          icon = icon("folder-open")
        ),
        
        br(),
        br(),
        
        strong("Selected index"),
        
        textOutput("selected_index")
        
      )
      
    )
    
  })
  
  
  output$selected_transcriptome <- renderText({
    
    "No transcriptome selected."
    
  })
  
  output$selected_annotation <- renderText({
    
    "No annotation selected."
    
  })
  
  output$selected_index <- renderText({
    
    "No Salmon index selected."
    
  })
  
  # ==========================================================
  # Reference Information
  # ==========================================================
  
  output$reference_information <- renderUI({
    
    reference_summary(
      source = input$reference_source,
      species = input$reference_species,
      release = input$reference_release,
      transcriptome = NULL,
      annotation = NULL,
      salmon_index = NULL
    )
    
  })
  
  }