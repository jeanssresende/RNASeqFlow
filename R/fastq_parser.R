parse_fastq_files <- function(files) {
  
  data.frame(
    Sample = sub("([._-]R?[12]).*$", "", files),
    Read = ifelse(
      grepl("R1|_1|\\.1", files, ignore.case = TRUE),
      "R1",
      ifelse(
        grepl("R2|_2|\\.2", files, ignore.case = TRUE),
        "R2",
        NA
      )
    ),
    File = files,
    stringsAsFactors = FALSE
  )
  
}