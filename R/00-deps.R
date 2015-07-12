# Load Required Libraries -----------------------------------------------

# CONSTANTS -------------------------------------------------------------
# CRAN Libraries
cran.libs <- c("plm")

# GITHUB Libraries
github.libs <- c("hadley/dplyr",
                 "rstudio/packrat")

# FUNCTIONS -------------------------------------------------------------
import <- function(package.namei, src = "cran") {
  if (!(package.name %in% rownames(install.packages))) {
    if (src == "cran") {
        install.packages(package.name)
    } else if (src == "github") {
        devtools::install_github(package.name) 
  }
  require(package.name, character.only = TRUE)
}

# MAIN ------------------------------------------------------------------
install.packages("devtools")
devtools::install_github("rstudio/packrat")

# PACKRAT ---------------------------------------------------------------
# Initialize packrat in current directory and enable packrat mode for the
# project.
packrat::init(paste0("../", getwd()))

# INSTALL ---------------------------------------------------------------
sapply(cran.libs, function(x) import(x))
sapply(github.libs, function(x) import(x, src = "github"))
