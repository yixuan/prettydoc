## Creating Pretty Documents From R Markdown

> Have you ever tried to find a lightweight yet nice theme for the R Markdown
documents, like [this page](https://prettydoc.statr.me/cayman.html)?

### Themes for R Markdown

With the powerful [rmarkdown](https://rmarkdown.rstudio.com/index.html)
package, we could easily create nice HTML document
by adding some meta information in the header, for example

```yaml
---
title: Nineteen Years Later
author: Harry Potter
date: July 31, 2016
output:
  rmarkdown::html_document:
    theme: lumen
---
```

The [html_document](https://bookdown.org/yihui/rmarkdown/html-document.html)
engine uses the [Bootswatch](https://bootswatch.com/)
theme library to support different styles of the document.
This is a quick and easy way to tune the appearance of your document, yet with
the price of a large file size (> 700KB) since the whole
[Bootstrap](https://getbootstrap.com/) library needs to be packed in.

For package vignettes, we can use the
[html_vignette](https://bookdown.org/yihui/rmarkdown/r-package-vignette.html)
engine to generate a more lightweight HTML file that is meant to minimize the
package size, but the output HTML is less stylish than the `html_document` ones.

So can we do **BOTH**, a lightweight yet nice-looking theme for R Markdown?

### The prettydoc Engine

The answer is YES! (At least towards that direction)

The **prettydoc** package provides an alternative engine, `html_pretty`,
to knit your R Markdown document into pretty HTML pages.
Its usage is extremely easy: simply replace the
`rmarkdown::html_document` or `rmarkdown::html_vignette` output engine by
`prettydoc::html_pretty` in your R Markdown header, and use one of the built-in
themes and syntax highlighters. For example

```yaml
---
title: Nineteen Years Later
author: Harry Potter
date: July 31, 2016
output:
  prettydoc::html_pretty:
    theme: cayman
    highlight: github
---
```

You can also create documents from **prettydoc** templates in RStudio.

**Step 1:** Click the "New File" button and choose "R Markdown".

<div align="center">
  <img src="https://prettydoc.statr.me/images/step1.png" alt="Step 1" />
</div>

**Step 2:** In the "From Template" tab, choose one of the built-in templates.

<div align="center">
  <img src="https://prettydoc.statr.me/images/step2.png" alt="Step 2" />
</div>

### Options and Themes

The options for the `html_pretty` engine are mostly compatible with the default
`html_document`
(see the [documentation](https://bookdown.org/yihui/rmarkdown/html-document.html))
with a few exceptions:

1. Currently the `theme` option can take the following values. More themes will
be added in the future.
    - `cayman`: Modified from the [Cayman](https://github.com/jasonlong/cayman-theme) theme.
    - `tactile`: Modified from the [Tactile](https://github.com/jasonlong/tactile-theme) theme.
    - `architect`: Modified from the [Architect](https://github.com/jasonlong/architect-theme) theme.
    - `leonids`: Modified from the [Leonids](https://github.com/renyuanz/leonids) theme.
    - `hpstr`: Modified from the [HPSTR](https://github.com/mmistakes/jekyll-theme-hpstr) theme.
2. The `highlight` option takes value from `github` and `vignette`.
3. A new `math` parameter to choose between `mathjax` and `katex` for rendering math expressions.
   The `katex` option supports offline display when there is no internet connection.
4. Options `code_folding`, `code_download` and `toc_float` are not applicable.

### Offline Math Expressions

By default, `html_pretty` uses MathJax to render math expressions. However, using MathJax
requires an internet connection. If you need to create documents that can
show math expressions offline, simply add one line `math: katex` to the document metadata:

```yaml
---
title: Nineteen Years Later
author: Harry Potter
date: July 31, 2016
output:
  prettydoc::html_pretty:
    theme: cayman
    highlight: github
    math: katex
---
```

This option will enable [KaTeX](https://katex.org/) for rendering the math expressions, and all
resource files will be included in for offline viewing. The offline document will be ~800k larger.

### Related Projects

- [tufte](https://github.com/rstudio/tufte) provides the Tufte style for
R Markdown documents.
- [BiocStyle](https://bioconductor.org/packages/release/bioc/html/BiocStyle.html)
provides standard formatting styles for Bioconductor PDF and HTML documents.
- [rmdformats](https://github.com/juba/rmdformats) by Julien Barnier contains
HTML formats and templates for R Markdown documents, with some extra features
such as automatic table of contents, lightboxed figures, and dynamic crosstab
helper.
- [markdowntemplates](https://github.com/hrbrmstr/markdowntemplates) by Bob Rudis
is a collection of alternative R Markdown templates.
- [prettyjekyll](https://github.com/privefl/prettyjekyll) by Florian Privé
uses **prettydoc** to convert R Markdown documents to Jekyll Markdown for blog posting.


### Gallery

Here are some screenshots of the HTML pages generated by **prettydoc** with
different themes and syntax highlighters.

#### Cayman [(demo page)](https://prettydoc.statr.me/cayman.html)

<div align="center">
  <img width="600px" src="https://prettydoc.statr.me/images/cayman.png" alt="Cayman Theme" />
</div>

#### Tactile [(demo page)](https://prettydoc.statr.me/tactile.html)

<div align="center">
  <img width="600px" src="https://prettydoc.statr.me/images/tactile.png" alt="Tactile Theme" />
</div>

#### Architect [(demo page)](https://prettydoc.statr.me/architect.html)

<div align="center">
  <img width="600px" src="https://prettydoc.statr.me/images/architect.png" alt="Architect Theme" />
</div>

#### Leonids [(demo page)](https://prettydoc.statr.me/leonids.html)

<div align="center">
  <img width="800px" src="https://prettydoc.statr.me/images/leonids.png" alt="Leonids Theme" />
</div>

#### HPSTR [(demo page)](https://prettydoc.statr.me/hpstr.html)

<div align="center">
  <img width="600px" src="https://prettydoc.statr.me/images/hpstr.png" alt="HPSTR Theme" />
</div>
