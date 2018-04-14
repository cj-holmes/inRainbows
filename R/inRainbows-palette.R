#' Radiohead Album Palette
#'
#' @param option Album name to use for colour scale. See Details.
#'
#' @details
#' \if{html}{Here are the color scales:
#'
#'   \out{<div style="text-align: center">}\figure{inRainbows-scales.png}{options: style="width:750px;max-width:90\%;"}\out{</div>}
#'
#'   }
#' \if{latex}{Here are the colour scales:
#'
#'   \out{\begin{center}}\figure{inRainbows-scales.png}\out{\end{center}}
#'   }
#'
#' @return palette function
#' @export
#'
#' @examples
#' hist(1:8,col =inRainbows_palette("ok_computer")(4), main = "ok_computer")
#' hist(1:14,col =inRainbows_palette("httf")(7), main = "httf")
inRainbows_palette <- function(option){

  rpals <- list(
    pablo_honey = c("#E7CC4A", "#100604", "#E3E7DE", "#1F0155"),
    the_bends = c("#040001", "#E9160E", "#F4D985"),
    ok_computer = c("#F6F7FA", "#BCD5E8", "#A0B1C6", "#2451B0"),
    kid_a = c("#69180E", "#DBD6BF", "#A6A5A2", "#59789A", "#080403"),
    amnesiac = c("#E0292D", "#000000", "#E0AE5B"),
    httf = c("#7E96AF", "#36641A", "#E8330B", "#232868", "#F66603", "#F88C05", "#141A0D"),
    in_rainbows = c("#F3EA56", "#4D84C0", "#E46A38", "#46AE52", "#DFB333", "#D5282F", "#A3D4DF", "#070406"),
    king_of_limbs = c("#E3B92F", "#332928", "#48702C", "#AAAAAD", "#E36551"),
    amsp = c("#BBBABF", "#24201F", "#6C6A6E", "#E7E6EA"))


  return(
    function(n){

      if(length(rpals[[option]]) < n) stop("not enough colours in palette")

      rpals[[option]][1:n]
    }
  )

}
