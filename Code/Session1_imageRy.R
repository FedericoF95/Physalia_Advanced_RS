# Code related to the use of the imagery package

# DATA VISUALIZATION

library(terra)
library(imageRy)
library(viridis)

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
#nir -red = 255 - 0 = 255

dvisent <- im.dvi(sent, 4, 3)
plot(dvisent)

# range 0-255 (2^8=256 values)
# nir -red = 255 - 0 = 255

# 4 bit image
# range 0-15 (2^4=16 values)
dvisent <- im.dvi(sent, 4, 3)
plot(dvisent)


