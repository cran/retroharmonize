#' @title Read Survey Files
#'
#' Import surveys into a list. Adds filename as a constant to each
#' element of the list.
#'
#' @param import_file_names A vector of file names to import.
#' @param .f A function to import the surveys with.
#' Defaults to \code{'read_rds'}. For SPSS files,
#' \code{read_spss} is recommended, which is a
#' well-parameterized version of \code{\link[haven]{read_spss}} that
#' saves some metadata, too.
#' @param save_to_rds Should it save the imported survey to .rds?
#' Defaults to \code{TRUE}.
#' @return A list of the surveys.  Each element of the list is a data
#' frame-like \code{\link{survey}} type object where some metadata, 
#' such as the original file name, doi identifier if present, and other
#' information is recorded for a reproducible workflow.
#' @importFrom purrr safely
#' @examples
#' file1 <- system.file(
#'     "examples", "ZA7576.rds", package = "retroharmonize")
#' file2 <- system.file(
#'     "examples", "ZA5913.rds", package = "retroharmonize")
#'
#' read_surveys (c(file1,file2), .f = 'read_rds' )
#' @export
#' @family import functions
#' @seealso survey

read_surveys <- function ( import_file_names,
                           .f = 'read_rds',
                           save_to_rds = TRUE ) {

  read_spss_survey <- function( filename ) {

    tried_survey <- purrr::safely(.f = .f)(file = filename, user_na = TRUE)

    if ( is.null(tried_survey$error)) {
      if (save_to_rds) {
        rds_filename <- gsub(".sav|.por", ".rds", filename)
        "Saving the survey to rds in the same location."
      }
      saveRDS(tried_survey$result, rds_filename, version=2)
      tried_survey$result
    } else {
      warning("Survey ", filename, " could not be read: ", tried_survey$error)
    }
  }

  tmp <- lapply ( X = as.list(import_file_names), FUN = eval(.f)   )

  tmp
}

