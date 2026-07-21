save_project <- function(project){
  
  saveRDS(
    
    project,
    
    file.path(
      project$path,
      "RNASeqFlow.project"
    )
    
  )
  
}