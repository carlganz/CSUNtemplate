context("Does CSUN Thesis Render?")

### Stolen from rticles package

test_that("CSUN Thesis renders", {
  # work in a temp directory
  dir <- tempfile()
  dir.create(dir)
  oldwd <- setwd(dir)
  on.exit(setwd(oldwd), add = TRUE)

  # create a draft of the format
  testdoc <- "testdoc.Rmd"
  rmarkdown::draft(testdoc,
                   system.file("rmarkdown", "templates", "CSUN_Thesis",
                               package = "CSUNtemplate"),
                   create_dir = FALSE,
                   edit = FALSE)

  output_file <- "test.pdf"
  rmarkdown::render(testdoc, output_file = output_file)
  expect_true(file.exists(output_file))
})



