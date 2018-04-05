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

pPal <- function(hex, ...) barplot(rep(1, length(hex)), col=hex, names=hex, las=2, border=NA, axes=F, ...)

# All palettes
par(mfrow=c(3,3))
for(i in seq_along(rpals)) pPal(rpals[[i]], main=names(rpals)[i])

# Examples
par(mfrow=c(1,2))
plot(as.factor(mtcars$cyl), mtcars$hp, xlab="cyl", ylab="hp", 
     col=rpals$ok_computer, main="OK COMPUTER palette", sub="mtcars data")

boxplot(Speed~Expt, data=morley, col=rpals$kid_a, 
        main="KID A palette", xlab="Expt.", ylab="Speed", sub="Morley data")
