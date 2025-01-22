#Colorblind friendly graph ----
#Code related to colorblindness simulation

library(imageRy)
library(terra)

# install.packages("colorblindcheck")
library(devtools)
# devtools::install_github("clauswilke/colorblindr")
# devtools::install_github("ducciorocchini/cblindplot")
library(colorblindcheck)
library(colorblindr)
library(cblindplot)
library(ggplot2)
library(patchwork)
library(imageRy)
library(terra)

im.list()

sentdol <- im.import("sentinel.dolomites")
sentdol
sources(sentdol) #images
names(sentdol) # names of bands

# Nir in band 4 - B8A sentinel
# red in band 3 - B4 Sentinel
ndvi <- im.ndvi(sentdol, 4, 3)
plot(ndvi)

# change color palette
# grey scale, blue-red, brown-green etc etc.
clgr <- colorRampPalette(c("black","dark grey","light grey"))(100) #dark to grey
clbr <- colorRampPalette(c("blue","white","red"))(100) #blue to red
clbg <- colorRampPalette(c("brown","yellow","green"))(100) 

plot(ndvi, col=clgr)
plot(ndvi, col=clbr)
plot(ndvi, col=clbg)

par(mfrow= c(2,2))
plot(ndvi)
plot(ndvi, col=clgr)
plot(ndvi, col=clbr)
plot(ndvi, col=clbg)

# Simulation of color vision deficiency (CVD) ----

# Palettes 
# Colors in R: http://www.stat.columbia.edu/~tzheng/files/Rcolor.pdf
#
palraw <- colorRampPalette(c("red", "orange", "red", "chartreuse", "cyan",
                             "blue"))(100)
#
palraw_grey <- colorRampPalette(c("dark orange", "orange", "grey", "dark grey",
                                  "light grey", "blue"))(100)

par(mfrow = c(1,2))
plot(ndvi, col=palraw )
plot(ndvi, col=palraw_grey )

#Mountains image

dev.off()
setwd("C:\\Users\\ASUS\\OneDrive - Università Politecnica delle Marche (1)\\Courses\\Physalia\\Advanced Ecological Remote Sensing in R\\data")

setwd("~/Downloads")
vinicunca <- rast("vinicunca.jpg")
plot(vinicunca)

par(mfrow = c(1,2))
im.plotRGB(vinicunca, 1,2,3, title ='standard vision')
im.plotRGB(vinicunca, 2,2,3, title = 'protanopia') #protanopia, skip green or double it

#if the image is flipped
plot(flip(vinicunca)) #plot flipped

# Check colorblind ----
dev.off()
rainbow_pal <- rainbow(7)
palette_check(rainbow_pal, plot=TRUE)

rainbow_pal <- rainbow(20)
palette_check(rainbow_pal, plot=TRUE)

## colorblindr

# install_github("colorblindr")
head(iris)

explot <- ggplot(iris, aes(Sepal.Length, fill=Species)) +
  geom_density(alpha=0.7)
explot 

colorblindr::cvd_grid(explot)

explot2 <- ggplot(iris, aes(Sepal.Length, fill = Species)) + 
  geom_density(alpha=0.7) + scale_fill_OkabeIto()
explot2

# with patchwork package
explot + explot2

#Raimbow image temperature ----

rb <- rast("rainbow.jpg")
plot(rb)

cblind.plot(rb, cvd = "protanopia")
cblind.plot(rb, cvd = "deuteranopia")
cblind.plot(rb, cvd = "tritanopia")
dev.off()
