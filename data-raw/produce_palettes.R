## Code to produce unsupervised (k-means) colour palettes
library(tidyverse)

create_palette <- function(img_path, ncol=5, my.seed=3, ...){

  # Read jpeg image
  i <- jpeg::readJPEG(img_path)

  # Extract dimensions of image
  dim_x <- dim(i)[1]
  dim_y <- dim(i)[2]

  # Wrangle dataframe from image to a tidy format
  df <-
    reshape2::melt(i) %>%
    spread(Var3, value) %>%
    rename(red="1", green="2", blue="3") %>%
    mutate(Var1 = -Var1 + dim_y) %>%
    rename(x=Var2, y=Var1) %>%
    tbl_df()

  # Append hex colour code column to dataframe
  df$original_colour <- df %>% select(red, green, blue) %>% pmap_chr(rgb)

  # Run Kmeans
  set.seed(my.seed)
  kMeans <- kmeans(df[c("red", "green", "blue")], ncol, ...)

  # Compute the hex code colour for each element of the image
  palette_colours <- rgb(kMeans$centers[kMeans$cluster, ])

  # Plot
  # par(mfrow=c(1,3))
  # plot(df$x, df$y, col=rgb(df[,3:5]), asp = 1, pch=".", axes=F, xlab="", ylab="", main="Original")
  # plot(df$x, df$y, col=rgb(approxCol), asp = 1, pch=".", axes=F, xlab="", ylab="", main="Approximate")

  # Define the palette colours and order them from most to least frequent
  palette <- table(palette_colours) %>% sort(decreasing = T)

  list(palette = palette, palette_data = df %>% mutate(palette_colour = palette_colours))
}


visualise_palette <- function(palette, palette_elements=NULL, frac = 1){

  images <-
    palette$palette_data %>%
    rename(Original = original_colour,
           `Palette (full) image` = palette_colour) %>%
    pivot_longer(cols = c(Original, `Palette (full) image`)) %>%
    sample_frac(frac) %>%
    ggplot(aes(x, y, fill=value))+
    geom_tile()+
    facet_wrap(~name)+
    coord_equal()+
    scale_fill_identity()+
    theme_void()

  colours <- tibble(colours = names(palette$palette), n=as.integer(palette$palette))

  palette_bars <-
    colours %>%
    ggplot(aes(reorder(colours, n), fill=colours))+
    geom_bar(col=1, position = "fill")+
    scale_fill_identity()+
    theme_minimal()+
    labs(x="", y="")+
    scale_y_continuous(labels=NULL)+
    coord_flip()+
    labs(title="Full colour palette")

  if(!is.null(palette_elements)){
    colours <- colours[palette_elements,]

    palette_bars_reduced <-
      colours %>%
      ggplot(aes(reorder(colours, n), fill=colours))+
      geom_bar(col=1, position = "fill")+
      scale_fill_identity()+
      theme_minimal()+
      labs(x="", y="")+
      scale_y_continuous(labels=NULL)+
      coord_flip()+
      labs(title="Reduced colour palette")

    return(gridExtra::grid.arrange(images, palette_bars, palette_bars_reduced,
                                   layout_matrix = matrix(c(1,1,2,3), ncol = 2, byrow=TRUE)))


  }

  gridExtra::grid.arrange(images, palette_bars, nrow=2, ncol=1)

}



# Generate unsupervised palettes with 15 colours each
palettes <- map(list.files('data-raw/album_covers/', full.names = TRUE),
                create_palette, ncol=20, my.seed=1)

# Assign album names to list
names(palettes) <- list.files('data-raw/album_covers/') %>% str_remove("\\.[A-z]+")

# Supervised reduction of the palettes to...
# remove similar colours,
# remove very light or white colours (I dont think they are useful for plotting)
# Order remaining colours so the most visually distinct (to my eye) come first in order
# visualise_palette(palette = palettes[["amnesiac"]], palette_elements = c(1, 2, 17), frac = 0.1)
# visualise_palette(palette = palettes[["amsp"]], palette_elements = c(2, 3, 5, 11), frac = 0.1)
# visualise_palette(palette = palettes[["httf"]], palette_elements = c(1, 4, 6, 8, 13, 15), frac = 0.1)
# visualise_palette(palette = palettes[["in_rainbows"]], palette_elements = c(1, 5, 8, 9, 11, 15), frac=0.1)
# visualise_palette(palette = palettes[["kid_a"]], palette_elements = c(1, 5, 7, 17, 19), frac=0.1)
# visualise_palette(palette = palettes[["king_of_limbs"]], palette_elements = c(1, 5, 12, 15, 18, 19), frac=0.1)
# visualise_palette(palette = palettes[["ok_computer"]], palette_elements = c(3, 7, 18, 11))
# visualise_palette(palette = palettes[["pablo_honey"]], palette_elements = c(1, 2, 5, 13))
# visualise_palette(palette = palettes[["the_bends"]], palette_elements = c(1, 2, 6, 15))

# Create dataframe that collates all information
all_data <-
  tibble(album = c("amnesiac",
                   "amsp",
                   "httf",
                   "in_rainbows",
                   "kid_a",
                   "king_of_limbs",
                   "ok_computer",
                   "pablo_honey",
                   "the_bends"),
         full_palette_object = palettes,
         full_palette = lapply(palettes, function(x) names(x[[1]])),
         elements = list(c(1, 2, 17),
                         c(2, 11, 5, 3),
                         c(1, 4, 6, 8, 13, 15),
                         c(1, 5, 8, 9, 11, 15),
                         c(1, 5, 17, 19, 7),
                         c(1, 19, 5, 12, 15, 18),
                         c(3, 7, 18, 11),
                         c(1, 2, 5, 13),
                         c(1, 2, 6, 15))) %>%
  mutate(reduced_palette = map2(full_palette, elements, ~.x[.y]))

# Visaulise each palette
# for(i in 1:nrow(all_data)){
#   visualise_palette(palette = all_data$full_palette_object[[i]],
#                     palette_elements = all_data$elements[[i]],
#                     frac = 0.1)
# }

inrainbows_palettes <- all_data$reduced_palette

# Use inrainbows list
usethis::use_data(inrainbows_palettes, overwrite = TRUE)
