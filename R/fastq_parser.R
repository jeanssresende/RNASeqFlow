parse_fastq_files <- function(files) {
  
  if (length(files) == 0) {
    return(data.frame())
  }
  
  samples <- sub("([._-]R?[12]).*$", "", files)
  
  reads <- ifelse(
    grepl("R1|_1|\\.1", files, ignore.case = TRUE),
    "R1",
    ifelse(
      grepl("R2|_2|\\.2", files, ignore.case = TRUE),
      "R2",
      NA
    )
  )
  
  df <- data.frame(
    Sample = samples,
    Read = reads,
    File = files,
    stringsAsFactors = FALSE
  )
  
  unique_samples <- unique(df$Sample)
  
  result <- lapply(unique_samples, function(sample) {
    
    tmp <- df[df$Sample == sample, ]
    
    r1 <- tmp$File[tmp$Read == "R1"]
    r2 <- tmp$File[tmp$Read == "R2"]
    
    data.frame(
      Sample = sample,
      R1 = ifelse(length(r1) == 0, NA, r1[1]),
      R2 = ifelse(length(r2) == 0, NA, r2[1]),
      Status = ifelse(
        length(r1) > 0 && length(r2) > 0,
        "Valid",
        ifelse(length(r1) == 0, "Missing R1", "Missing R2")
      ),
      stringsAsFactors = FALSE
    )
    
  })
  
  do.call(rbind, result)
  
}