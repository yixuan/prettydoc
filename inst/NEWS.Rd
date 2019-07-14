\name{NEWS}
\title{News for Package "prettydoc"}

\section{Changes in "prettydoc" version 0.3.0}{
  \subsection{NEW FEATURES}{
    \itemize{
      \item New option \code{math} to choose math expression rendering engines. Possible
            values are \code{mathjax} and \code{katex}. The \code{katex} engine supports
            offline rendering of math expressions when there is no internet connection.
    }
  }
}

\section{Changes in "prettydoc" version 0.2.1}{
  \subsection{BUG FIXES}{
    \itemize{
      \item Fixed errors in building the vignette.
    }
  }
}

\section{Changes in "prettydoc" version 0.2.0}{
  \subsection{NEW FEATURES}{
    \itemize{
      \item New themes \code{leonids} and \code{hpstr}.
      \item New option \code{compressed_css} to allow users selecting between
            the original CSS and the compressed one processed by
            \url{http://csscompressor.com/}.
    }
  }
  \subsection{BUG FIXES}{
    \itemize{
      \item Fixed the alignment of Table of Contents (#3).
      \item Fixed the incorrect link to CSS file when \code{self_contained} is
            \code{false} (#4).
    }
  }
}

\section{Changes in "prettydoc" version 0.1.0}{
  \subsection{NEW FEATURES}{
    \itemize{
      \item Initial release.
      \item Includes themes \code{cayman}, \code{tactile} and \code{architect}.
      \item Includes syntax highlight styles \code{github} and \code{vignette}.
    }
  }
}
