project_page_ui <- function() {
  
  tagList(
    
    div(
      class = "page-header",
      
      h2(
        class = "page-title",
        "Projeto"
      ),
      
      p(
        class = "page-description",
        "Crie um novo projeto ou abra um projeto existente para iniciar sua análise de RNA-Seq."
      )
    ),
    
    fluidRow(
      
      column(
        width = 6,
        class = "mb-4",
        
        action_card(
          id = "create_project",
          title = "Criar Projeto",
          description = "Crie um novo projeto RNA-Seq.",
          icon_name = "folder-plus"
        )
      ),
      
      column(
        width = 6,
        class = "mb-4",
        
        action_card(
          id = "open_project",
          title = "Abrir Projeto",
          description = "Abra um projeto existente.",
          icon_name = "folder-open"
        )
      )
    ),
    
    hr(),
    
    h4("Projetos recentes"),
    
    empty_state(
      icon_name = "clock",
      title = "Nenhum projeto recente",
      description = "Os projetos abertos recentemente aparecerão aqui."
    )
    
  )
  
}