sidebar_ui <- function() {
  
  div(
    class = "app-sidebar",
    
    div(class = "menu-item", "🏠 Home"),
    div(class = "menu-item", "📁 Projeto"),
    div(class = "menu-item", "🧬 Quality Control"),
    div(class = "menu-item", "✂ Trimming"),
    div(class = "menu-item", "📊 Quantification"),
    div(class = "menu-item", "📝 Annotation"),
    div(class = "menu-item", "📦 Export"),
    div(class = "menu-item", "📜 Logs")
    
  )
  
}