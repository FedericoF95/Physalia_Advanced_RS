# Code related to the use of the imagery package

# DATA VISUALIZATION

library(terra)
library(imageRy)
library(viridis)
library(ggplot2)
library(patchwork)

# library(devtools)
# devtools::install_github("ducciorocchini/imageRy")

#List the data
im.list()

b2 <- im.import("sentinel.dolomites.b2.tif")
plot(b2, col=inferno(100))
plot(b2, col=inferno(4))
plot(b2, col=inferno(3))

#import 4 bands of sentinel
sent <- im.import("sentinel.dolomites")

# b2 = blue  490 nm, layer 1
# b3 = green 560 nm, layer 2
# b4 = red   665 nm, layer 3
# b8 = NIR   842 nm, layer 4

#Natural color image
im.plotRGB(sent, r=3 , g=2, b=1, title= 'Natural color')
#Infrared color image
im.plotRGB(sent, r=4 , g=3, b=2, title= 'False color')
im.plotRGB(sent, r=3 , g=4, b=2, title= 'False color')
im.plotRGB(sent, r=3 , g=2, b=4, title= 'False color')

im.plotRGB(sent, 3 , 2, 4, title= 'False color')

# 8 bit image
# range 0-255 (2^8=256 values)
# nir -red = 255 - 0 = 255
# MAXndvi = 255/(255+0) = 1

# 4 bit image
# range 0-15 (2^4=16 values)
# nir - nir = 15-0 = 15
# MAXndvi = 15/(15+0) = 1

dvisent <- im.dvi(sent, 4, 3)
ndvisent <- im.ndvi(sent,4,3)

#multitemporal visualization
# nir 1 
# red 2

#landsat data from 1992
m1992 <- im.import("matogrosso_l5_1992219_lrg.jpg")
im.plotRGB(m1992, r=2, g=1, b=3)           

#aster from 2006
m2006 <- im.import("matogrosso_ast_2006209_lrg.jpg")
im.plotRGB(m2006, r=2, g=1, b=3)

ndvi1992 <- im.ndvi(m1992, 1,2)
ndvi2006 <- im.ndvi(m2006, 1,2)
plot(ndvi1992)
plot(ndvi2006)

# Correlation function pairs
# 3 bands - 3*2 /2 correlations
# 4 bands - 4*3 /2 = 6 correlation
# N (N-1)/2 potential correlation

pairs(sent)
pairs(m1992)
pairs(m2006)

#importing data from outside R
setwd("/download/")
sun <- rast("path_to_file.jpg")

#set extension of image
ext <- c(100,1000,100,1000)
sunc <- crop(sun, ext)
plot(sunc)

#create a new raster file
writeRaster(sunc, "output_path.png")

#Classifyng data
m1992c <- im.classify(m1992, num_cluster=2)
names(m1992c) <- c("Forest", "Human")
f1992 <- freq(m1992c)

#percentage of different
p1992 <- f1992 * 100 /ncell(m1992c)

# building a dataframe
class <- c("Forest","Human")
y1992 <- c(83, 17)
y2006 <- c(45, 55)

tabout <- data.frame(class, y1992, y2006)
tabout

p1 <- ggplot(tabout, aes(x= class, y= y1992, color=class)) +
geom_bar(stat="identity", fill= "white" ) +
#same range
ylim(c(0,100))

p2 <- ggplot(tabout, aes(x= class, y= y2006, color=class)) +
geom_bar(stat="identity", fill= "white" ) +
#same range
ylim(c(0,100))
p1 + p2
