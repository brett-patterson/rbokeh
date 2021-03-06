% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/output_html.R
\name{rbokeh2html}
\alias{rbokeh2html}
\title{Get the HTML content required to embed a Bokeh figure}
\usage{
rbokeh2html(fig, file = tempfile(fileext = ".html"), pretty = FALSE,
  secure = TRUE)
}
\arguments{
\item{fig}{figure}

\item{file}{html file name to write the figure to}

\item{pretty}{should the json model be pretty printed to the html file?}

\item{secure}{should https be used for cdn links?}
}
\description{
Get the HTML content required to embed a Bokeh figure
}
\examples{
p <- figure() \%>\% ly_points(1:10)
rbokeh2html(p)
}

