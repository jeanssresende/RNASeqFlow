menu_item <- function(id, icon_name, label) {
  
  actionLink(
    inputId = id,
    label = tagList(
      icon(icon_name),
      span(label)
    ),
    class = "menu-item"
  )
  
}

sidebar_ui <- function() {
  
  div(
    class = "app-sidebar",
    
    menu_item("go_home", "house", "Home"),
    
    menu_item("go_project", "folder-open", "Projeto"),
    
    menu_item("go_qc", "clipboard-check", "Quality Control"),
    
    menu_item("go_trimming", "scissors", "Trimming"),
    
    menu_item("go_quantification", "chart-bar", "Quantification"),
    
    menu_item("go_annotation", "file-alt", "Annotation"),
    
    menu_item("go_export", "download", "Export"),
    
    menu_item("go_logs", "clipboard-list", "Logs")
    
  )
  
}