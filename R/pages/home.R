home_page_ui <- function() {
  
  tagList(
    
    h2("Bem-vindo ao RNASeqFlow"),
    
    p("Pipeline completo para análise de RNA-Seq."),
    
    br(),
    
    actionButton(
      "new_project",
      "Criar Projeto",
      class = "btn-primary"
    ),
    
    actionButton(
      "open_project",
      "Abrir Projeto",
      class = "btn-outline-secondary"
    )
    
  )
  
}