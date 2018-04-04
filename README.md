# inRainbows
Radiohead album colour palettes.

I thought i'd like to have a go at producing some R colour palettes based on Radiohead album art. I got the idea from the briliant wesanderson library (https://github.com/karthik/wesanderson).

I'm using this project as both an opportuity to learn how to use GitHub whilst simultaneously learning about colour spaces and their implementation in R.

![Example kmeans derived palette](kmeans_palette_creation_files/figure-html/unnamed-chunk-6-1.png)

This project is massively an active work in progress. Two main approaches so far...

* using Kmeans to make colour palettes unsupervised
* make manual selections in imageJ and then calculate average colours in R