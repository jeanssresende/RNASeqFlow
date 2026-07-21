open_project <- function(project_path){
  
  readRDS(
    file.path(
      project_path,
      "RNASeqFlow.project"
    )
  )
  
}