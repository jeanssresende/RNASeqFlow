library(bslib)

ui <- page_fluid(
  
  theme = bs_theme(
    version = 5,
    bootswatch = "flatly"
  ),
  
  tags$head(
    
    tags$link(
      rel = "stylesheet",
      type = "text/css",
      href = "css/style.css"
    )
    
  ),
  
  div(
    
    class = "container-fluid",
    
    h1("🧬 RNASeqFlow"),
    
    hr(),
    
    h3("Bem-vindo"),
    
    p(
      "Interface em desenvolvimento."
    )
    
  )
  
)