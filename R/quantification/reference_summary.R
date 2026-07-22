# ==========================================================
# Reference Summary
# ==========================================================

reference_summary <- function(
    source,
    species = NULL,
    release = NULL,
    transcriptome = NULL,
    annotation = NULL,
    salmon_index = NULL
) {
  
  source_label <- switch(
    
    source,
    
    ensembl = "Download from Ensembl",
    local   = "Local transcriptome",
    index   = "Existing Salmon index",
    "-"
    
  )
  
  tagList(
    
    tags$table(
      
      class = "table table-sm",
      
      tags$tbody(
        
        tags$tr(
          tags$th("Reference Source"),
          tags$td(source_label)
        ),
        
        tags$tr(
          tags$th("Species"),
          tags$td(value_or_default(species))
        ),
        
        tags$tr(
          tags$th("Ensembl Release"),
          tags$td(value_or_default(release))
        ),
        
        tags$tr(
          tags$th("Transcriptome"),
          tags$td(value_or_default(transcriptome, "Not available"))
        ),
        
        tags$tr(
          tags$th("Annotation"),
          tags$td(value_or_default(annotation, "Not available"))
        ),
        
        tags$tr(
          tags$th("Salmon Index"),
          tags$td(value_or_default(salmon_index, "Not available"))
        )
        
      )
      
    )
    
  )
  
}