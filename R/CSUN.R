#' CSUN Thesis Template
#'
#' @export
#' @author Carl Ganz
#' @importFrom rmarkdown pdf_document
#'

csun_thesis <- function(...,
                        keep_tex = TRUE,
                        pandoc_args = c("--chapters")) {
  fmt <- rmarkdown::pdf_document(
    ...,
    template =
      system.file("templates", "resources",
                  "template.tex",
                  package = "CSUNtemplate"),
    keep_tex = keep_tex,
    pandoc_args = pandoc_args
  )
  fmt$inherits <- "pdf_document"
  fmt
}
