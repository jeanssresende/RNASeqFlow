library(shiny)
library(bslib)
library(shinyWidgets)
library(svDialogs)
library(DT)
library(curl)

# Components
source("R/components/action_card.R")
source("R/components/empty_state.R")

# Layout
source("R/header.R")
source("R/sidebar.R")
source("R/workspace.R")
source("R/layout.R")

# Pages
source("R/pages/home.R")
source("R/pages/project.R")
source("R/pages/quality_control.R")
source("R/pages/trimming.R")
source("R/pages/quantification.R")
source("R/pages/annotation.R")
source("R/pages/export.R")
source("R/pages/logs.R")
source("R/pages/import_samples.R")
source("R/fastq_parser.R")
source("R/project_summary.R")
source("R/project_create.R")
source("R/project_open.R")


# Primeiro carrega todos os arquivos
source_files <- list.files(
  "R",
  pattern = "\\.R$",
  recursive = TRUE,
  full.names = TRUE
)

invisible(lapply(source_files, source))

# Só depois usa as funções
app_settings <- load_settings()
app_settings <- detect_tools(app_settings)