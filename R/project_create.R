create_project <- function(project_name, parent_directory) {
  
  project_path <- file.path(parent_directory, project_name)
  
  if (dir.exists(project_path)) {
    stop("Project already exists.")
  }
  
  dir.create(project_path, recursive = TRUE)
  
  folders <- c(
    "samples",
    "metadata",
    "results",
    "results/fastqc",
    "results/trimmed",
    "results/quantification",
    "results/differential_expression",
    "results/figures",
    "logs",
    "cache"
  )
  
  for (folder in folders) {
    dir.create(
      file.path(project_path, folder),
      recursive = TRUE,
      showWarnings = FALSE
    )
  }
  
  project <- list(
    name = project_name,
    path = project_path,
    created = Sys.time(),
    version = "1.0.0",
    samples = NULL,
    status = list(
      fastqc = FALSE,
      trimming = FALSE,
      quantification = FALSE
    )
  )
  
  saveRDS(
    project,
    file.path(project_path, "RNASeqFlow.project")
  )
  
  project
}