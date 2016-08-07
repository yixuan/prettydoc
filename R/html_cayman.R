html_pretty <- function(theme = "cayman",
                        highlight = NULL,
                        css = NULL,
                        fig_retina = NULL,
                        keep_md = FALSE,
                        readme = FALSE,
                        ...) {

    ## Directories for resources
    css_dir  <- system.file("resources", "css",              package = "prettydoc")
    hl_dir   <- system.file("resources", "css", "highlight", package = "prettydoc")
    font_dir <- system.file("resources", "fonts",            package = "prettydoc")
    img_dir  <- system.file("resources", "images",           package = "prettydoc")
    tmpl_dir <- system.file("resources", "templates",        package = "prettydoc")

    ## Obtain theme CSS
    avail_themes <- gsub("\\.css$", "", list.files(css_dir, "\\.css$"))
    theme <- as.character(theme)
    if (!isTRUE(theme %in% avail_themes)) {
        warning("theme not found, use default (cayman) instead")
        theme <- "cayman"
    }
    theme_css <- file.path(css_dir, sprintf("%s.css", theme))

    ## Also theme template
    avail_tmpl <- gsub("\\.html$", "", list.files(tmpl_dir, "\\.html$"))
    if (!isTRUE(theme %in% avail_tmpl)) {
        theme <- "cayman"
    }
    theme_tmpl <- file.path(tmpl_dir, sprintf("%s.html", theme))

    ## Final CSS file
    final_css <- tempfile(fileext = ".css")
    file.copy(theme_css, final_css)
    file.copy(font_dir, tempdir(), recursive = TRUE)
    file.copy(img_dir,  tempdir(), recursive = TRUE)

    ## Merge syntax highlight CSS
    if (!is.null(highlight)) {
        avail_hl <- gsub("\\.css$", "", list.files(hl_dir, "\\.css$"))
        if (!isTRUE(highlight %in% avail_hl)) {
            warning("highlight style not found, use default instead")
        } else {
            hl_css <- file.path(hl_dir, sprintf("%s.css", highlight))
            file.append(final_css, hl_css)
        }
    }

    ## Merge user-supplied CSS file
    if (!is.null(css)) {
        file.append(final_css, css)
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
        ## Note that here `theme` and `highlight` are just parameters to make
        ## the HTML document tiny
        ## The real `theme` and `highlight` passed to html_pretty() are
        ## reflected in the final CSS file
        base_format = rmarkdown::html_document(fig_retina = fig_retina,
                                               css = final_css,
                                               theme = NULL,
                                               highlight = "pygments",
                                               ...)
    )

    ## We have to do this hack, sadly. :-|
    ## html_document() disables certain features (including MathJax) when
    ## we are using a template file other than default. I guess this is to
    ## avoid the incompatibility between templates and options. However,
    ## our templates only add a few <section> wrappers around existing
    ## elements, so it should be safe to override this restriction.
    pandoc_args <- res$pandoc$args
    pandoc_args[grep("^--template$", pandoc_args) + 1] <- theme_tmpl
    res$pandoc$args <- pandoc_args
    res
}
