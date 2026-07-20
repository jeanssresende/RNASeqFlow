empty_state <- function(icon_name,
                        title,
                        description) {
  
  div(
    class = "empty-state",
    
    icon(icon_name, class = "empty-state-icon"),
    
    h4(
      class = "empty-state-title",
      title
    ),
    
    p(
      class = "empty-state-description",
      description
    )
    
  )
  
}