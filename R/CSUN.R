#' CSUN Thesis Template
#'
#' Write your thesis for CSUN in R Markdown
#'
#' @export
#' @author Carl Ganz
#' @importFrom rmarkdown pdf_document
#' @inheritParams rmarkdown::pdf_document
#' @param ... Additional arguments to \code{rmarkdown::pdf_document}
#' @references href{https://www.sharelatex.com/templates/thesis/csun-thesis}
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
  fmt$knitr$knit_hooks$source <- function(x, options) {
    if (options$prompt && length(x)) {
      x <- gsub("\\n", paste0("\n", getOption("continue")), x)
      x <- paste0(getOption("prompt"), x)
    }
    paste0(
      c(
        '\n\\begin{lstlisting}[language=',
        options$engine,
        "]",
        x,
        '\\end{lstlisting}',
        ''
      ),
      collapse = '\n'
    )
  }
  fmt
}
