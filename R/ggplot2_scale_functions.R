#' Radiohead album colour scales for ggplot2
#'
#' Colour and fill scales for ggplot2
#'
#'
#' @param album Album name to use for colour scale. See Details.
#' @param ... Other arguments passed on to ggplot2::discrete_scale() to control name, limits, breaks, labels and so forth.
#' @export
#' @examples
#' ggplot(morley, aes(Expt, Speed, col = factor(Expt))) +
#'   geom_boxplot() +
#'   scale_colour_inrainbows("kid_a")
#'
#' ggplot(mtcars, aes(cyl, hp, col = factor(cyl))) +
#'   geom_boxplot() +
#'   scale_colour_inrainbows("ok_computer")
scale_colour_inrainbows <- function(album, ...){

  ggplot2::discrete_scale(aesthetics = "colour",
                          scale_name = "inRainbows",
                          palette = function(x)inrainbows(album = album, n = x),
                          ...)
}


#' Radiohead album colour scales for ggplot2
#'
#' Colour and fill scales for ggplot2
#'
#'
#' @param album Album name to use for colour scale. See Details.
#' @param ... Other arguments passed on to ggplot2::discrete_scale() to control name, limits, breaks, labels and so forth.
#' @export
#' @examples
#' ggplot(morley, aes(Expt, Speed, fill = factor(Expt))) +
#'   geom_boxplot() +
#'   scale_fill_inrainbows("kid_a")
#'
#' ggplot(mtcars, aes(cyl, hp, fill = factor(cyl))) +
#'   geom_boxplot() +
#'   scale_fill_inrainbows("ok_computer")
scale_fill_inrainbows <- function(album, ...){

  ggplot2::discrete_scale(aesthetics = "fill",
                          scale_name = "inRainbows",
                          palette = function(x)inrainbows(album = album, n = x),
                          ...)
}
