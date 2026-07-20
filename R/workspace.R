workspace_ui <- function() {
  
  div(
    class = "app-workspace",
    
    h2("Bem-vindo ao RNASeqFlow"),
    
    p(
      "Pipeline completo para análise de RNA-Seq."
    ),
    
    br(),
    
    div(
      
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
    
  )
  
}