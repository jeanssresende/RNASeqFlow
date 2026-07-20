action_card <- function(id,
                        title,
                        description,
                        icon_name) {
  
  actionLink(
    inputId = id,
    
    label = div(
      class = "action-card",
      
      div(
        class = "action-card-icon",
        icon(icon_name)
      ),
      
      div(
        class = "action-card-body",
        
        h4(
          class = "action-card-title",
          title
        ),
        
        p(
          class = "action-card-description",
          description
        )
      )
    ),
    
    class = "action-card-link"
  )
  
}