% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/subset_waves.R
\name{subset_waves}
\alias{subset_waves}
\title{Subset all surveys in a wave}
\usage{
subset_waves(waves, subset_names = NULL)
}
\arguments{
\item{waves}{A list of surveys imported with \code{\link{read_surveys}}.}

\item{subset_names}{The names of the variables that should be kept from all surveys in the list that contains the
wave of surveys. Defaults to \code{NULL} in which case it returns all variables without subsetting.}
}
\value{
The list of surveys with harmonized variable names.
}
\description{
The function harmonizes the variable names of surveys (of class \code{survey}) that 
are imported from an external file as a wave with with \code{\link{read_surveys}}.
}
\details{
It is likely that you want to harmonize the variable names with \code{\link{harmonize_var_names}} first.
}
\examples{
examples_dir <- system.file("examples", package = "retroharmonize")
survey_list <- dir(examples_dir)[grepl("\\\\.rds", dir(examples_dir))]

example_surveys <- read_surveys(
  file.path( examples_dir, survey_list), 
  save_to_rds = FALSE)
metadata <- metadata_waves_create(example_surveys)

metadata$var_name_suggested <- label_normalize(metadata$var_name)

metadata$var_name_suggested[metadata$label_orig == "age education"] <- "age_education"

hnw <- harmonize_var_names(waves = example_surveys, 
                           metadata = metadata )
                           
subset_waves (hnw, subset_names = c("uniqid", "w1", "age_education"))
}
