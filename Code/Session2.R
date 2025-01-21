library(terra)
library(imageRy)
library(viridis)
library(ggplot2)
library(patchwork)

par(mfrow=c(1,1))
par(mfrow=c(1,2))
par(mfrow=c(1,1))

#Reference systems

im.list()
ndvi2020 <- im.import("Sentinel2_NDVI_2020-02-21.tif")
ndvi2020
