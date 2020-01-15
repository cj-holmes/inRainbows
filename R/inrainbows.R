#' Radiohead Album Palette
#'
#' @param option Album name to use for colour scale.
#' @param n Number of colours required
#'
#' @return Character vector of colour strings
#' @export
#'
#' @examples
#' inrainbows("kid_a", 6)
#' inrainbows("httf", 6)
inrainbows <- function(album, n){

  if(!album %in% names(inrainbows_palettes)){stop(paste0("Invalid album name"))}

  if(length(inrainbows_palettes[[album]]) < n){
        stop(paste0("Palette ", album, " only contains ",
                    length(inrainbows_palettes[[album]]), " colours but ", n, " were requested"))}

      inrainbows_palettes[[album]][1:n]

}

#' inrainbows summary
#'
#' Plot all palettes and their colours
#'
#' @return A ggplot2
#' @export
inrainbows_summary <- function(){

  tibble::tibble(album = rep(names(inrainbows_palettes), sapply(inrainbows_palettes, length)),
                 colour = unlist(inrainbows_palettes)) %>%
    # Create factor so palettes are plotted in the correct order
    dplyr::mutate(colour = factor(colour, levels=colour)) %>%
    ggplot2::ggplot(ggplot2::aes(colour, fill=colour, group=colour))+
    ggplot2::geom_bar(col=1)+
    ggplot2::facet_wrap(~album, scales="free_x")+
    ggplot2::scale_fill_identity() +
    ggplot2::theme_minimal()+
    ggplot2::labs(x = "Colour", y="")+
    ggplot2::theme(axis.text.x = ggplot2::element_text(angle=90, hjust=1, vjust=0.5),
                   axis.text.y = ggplot2::element_blank(),
                   axis.title.y = ggplot2::element_blank())
}
