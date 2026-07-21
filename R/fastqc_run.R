run_fastqc <- function(
    files,
    output_dir,
    threads = 1,
    fastqc_path
) {
  
  # Verifica se o executável existe
  if (is.null(fastqc_path) || !file.exists(fastqc_path)) {
    stop("FastQC executable not found.")
  }
  
  # Verifica se há arquivos
  if (length(files) == 0) {
    stop("No FASTQ files were provided.")
  }
  
  # Cria pasta de saída
  dir.create(
    output_dir,
    recursive = TRUE,
    showWarnings = FALSE
  )
  
  # Monta comando
  args <- c(
    "--threads", as.character(threads),
    "--outdir", normalizePath(output_dir, mustWork = FALSE),
    normalizePath(files)
  )
  
  # Executa
  result <- system2(
    command = fastqc_path,
    args = args,
    stdout = TRUE,
    stderr = TRUE
  )
  
  return(result)
  
}