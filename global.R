library(shiny)
library(bslib)
library(shinyWidgets)

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