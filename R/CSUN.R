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
                        keep_tex = TRUE) {
  fmt <- rmarkdown::pdf_document(
    ...,
    highlight = NULL,
    template =
      system.file("rmarkdown",
                  "templates",
                  "CSUN_Thesis",
                  "resources",
                  "template.tex",
                  package = "CSUNtemplate"),
    keep_tex = keep_tex,
    pandoc_args = c("--natbib",
                    pandoc_chapters())
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

#' Pandoc Chapter Option
#'
#' Based on Pandoc version selects correct chapters option
#'
#' @author Carl Ganz
#' @importFrom rmarkdown pandoc_version
#'

pandoc_chapters <- function() {
  version <- rmarkdown::pandoc_version()

  if (version >= "1.18") {
    option <- "--top-level-division=chapter"
  } else {
    option <- "--chapters"
  }

  option
}
