% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ggplot2_scale_functions.R
\name{scale_colour_inrainbows}
\alias{scale_colour_inrainbows}
\title{Radiohead album colour scales for ggplot2}
\usage{
scale_colour_inrainbows(album, ...)
}
\arguments{
\item{album}{Album name to use for colour scale. See Details.}

\item{...}{Other arguments passed on to ggplot2::discrete_scale() to control name, limits, breaks, labels and so forth.}
}
\description{
Colour and fill scales for ggplot2
}
\examples{
ggplot(morley, aes(Expt, Speed, col = factor(Expt))) +
  geom_boxplot() +
  scale_colour_inrainbows("kid_a")

ggplot(mtcars, aes(cyl, hp, col = factor(cyl))) +
  geom_boxplot() +
  scale_colour_inrainbows("ok_computer")
}
