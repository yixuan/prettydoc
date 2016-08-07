html_cayman <- function(fig_width = 3,
                        fig_height = 3,
                        dev = 'png',
                        css = NULL,
                        keep_md = FALSE,
                        readme = FALSE,
                        ...) {

    if (is.null(css)) {
        css <- system.file("css", "cayman.css", package = "prettydoc")
    }

    pre_knit <- function(input, ...) {
        if (readme) {
            rmarkdown::render(input,
                              output_format = "github_document",
                              output_options = list(html_preview = FALSE),
                              output_file = "README.md",
                              output_dir = dirname(dirname(input)),
                              quiet = TRUE)
        }
    }

    res <- rmarkdown::output_format(
        knitr = NULL,
        pandoc = NULL,
        pre_knit = pre_knit,
        keep_md = keep_md,
        base_format = rmarkdown::html_document(fig_width = fig_width,
                                               fig_height = fig_height,
                                               dev = dev,
                                               fig_retina = NULL,
                                               css = css,
                                               theme = NULL,
                                               highlight = "pygments",
                                               ...)
    )

    ## We have to do this hack
    pandoc_args <- res$pandoc$args
    pandoc_args[grep("--template", pandoc_args) + 1] =
        system.file("templates", "cayman.html", package = "prettydoc")
    res$pandoc$args <- pandoc_args
    res
}
