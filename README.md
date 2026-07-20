# RNASeqFlow

![Version](https://img.shields.io/badge/version-v0.1.0-blue)

![Development](https://img.shields.io/badge/status-development-orange)

![License](https://img.shields.io/badge/license-MIT-green)

![R](https://img.shields.io/badge/R-%3E=4.6-blue)

![Shiny](https://img.shields.io/badge/Shiny-Bootstrap%205-red)

![Platform](https://img.shields.io/badge/platform-Windows%20%7C%20Linux-lightgrey)

<p align="center">

<img src="docs/images/logo.png" width="180">

</p>

<h3 align="center">

A Graphical RNA-Seq Preprocessing Platform Built with R and Shiny

</h3>

<p align="center">

A modern, modular and reproducible pipeline for RNA-Seq preprocessing.

</p>

---

## Overview

RNASeqFlow is an open-source graphical application developed in **R/Shiny** to simplify RNA-Seq preprocessing for researchers without requiring command-line experience.

The software provides an intuitive interface to perform the complete preprocessing workflow, from raw FASTQ files to annotated expression matrices.

The application was designed following modern software engineering principles, emphasizing:

- Modular architecture
- Reproducible analyses
- Cross-platform compatibility
- Interactive visualization
- Project management
- Automatic report generation

---

## Features

Current development roadmap includes:

- Project management
- FASTQ organization
- Quality Control (FastQC + MultiQC)
- Read trimming (Trimmomatic)
- Post-trimming quality assessment
- Transcript quantification
  - Salmon
  - Rsubread
- Import into SummarizedExperiment
- Gene annotation
- Expression matrix generation
- TPM calculation
- Interactive plots
- HTML reports
- Execution logs
- Reproducible project configuration

---

## Pipeline

```text
FASTQ
   │
   ▼
Quality Control
   │
   ▼
Read Trimming
   │
   ▼
Post-trimming QC
   │
   ▼
Transcript Quantification
(Salmon or Rsubread)
   │
   ▼
Import
   │
   ▼
Gene Annotation
   │
   ▼
Expression Matrices
```

---

## Technologies

- R
- Shiny
- Bootstrap 5
- bslib
- plotly
- DT
- shinyWidgets
- shinyjs

Supported RNA-Seq tools

- FastQC
- MultiQC
- Trimmomatic
- Salmon
- Rsubread
- tximeta
- SummarizedExperiment

---

## Project Structure

```text
RNASeqFlow/

app.R
global.R
ui.R
server.R

modules/

project/
quality/
trimming/
quantification/
import/
annotation/
export/
logs/

R/

helpers.R
validators.R
pipeline.R
logging.R
config.R
paths.R

www/

css/
js/
images/

reports/
```

---

## Installation

```r
# Clone repository

git clone https://github.com/jeanssresende/RNASeqFlow.git

# Open R

install.packages("renv")

renv::restore()

shiny::runApp()
```

---

## Development Status

Current version:

**v0.1.0 (Development)**

Current sprint

- Architecture
- Project management
- User interface
- Logging system

---

## Roadmap

### Version 0.1

- Project system
- UI redesign
- Logging
- Configuration

### Version 0.2

- Quality Control
- FastQC
- MultiQC

### Version 0.3

- Read trimming
- Trimmomatic

### Version 0.4

- Transcript quantification
- Salmon
- Rsubread

### Version 0.5

- Annotation
- Expression matrices
- Reports

### Version 1.0

First stable public release

---

## Citation

If you use RNASeqFlow in your research, please cite:

> Citation information will be added after the first software release.

---

## Contributing

Contributions are welcome.

Please open an Issue before submitting major changes.

---

## License

This project is licensed under the MIT License.

---

## Contact

Jean Resende

GitHub

https://github.com/jeanssresende
