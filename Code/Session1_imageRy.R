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
