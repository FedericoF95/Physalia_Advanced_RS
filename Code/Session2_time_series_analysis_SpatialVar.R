library(imageRy)
library(terra)
library(viridis)
library(rasterdiv) # Information theory based calculus
library(lattice) # for levelplots

im.list()

#First part ----
par(mfrow=c(1,1))
par(mfrow=c(1,2)) #2 graphs on the same line
par(mfrow=c(1,1)) #plot 1 graph

#Reference systems

im.list()
ndvi2020 <- im.import("Sentinel2_NDVI_2020-02-21.tif")
ndvi2020


#Second part ----
#Variability temporal and spatial

#How to represent change in ecosystem

library(terra)
library(imageRy)

im.list()

EN01 <- im.import("EN_01.png")
EN13 <- im.import("EN_13.png")

par(mfrow = c(1,2))
plot(EN01)
plot(EN13)

diffEN = EN01[[1]] - EN13[[1]]
plot(diffEN)

#import Greenland ice melt
###- Grenland

im.list()
gr <- im.import("greenland")

grt <- c(gr[[1]], gr[[4]])
plot(grt)

#Difference betwenn
diffgr = gr[[1]] - gr[[4]]
dev.off()
plot(diffgr)


# Third part ----
#Biomass change in alipne area

ndvi <- im.import("Sentinel2_NDVI")
ndvi

#ridgeline graph ----

im.ridgeline(ndvi, scale=1, palette= "viridis")

#all the name are NDVI
#change names 

names(ndvi) <- c("02_Feb", "05_May", "08_Aug", "11_Nov")
names(ndvi) <- c("Feb", "May", "Aug", "Nov")
ndvi

#now i can make the correct plot
im.ridgeline(ndvi, scale=1, palette= "viridis")
im.ridgeline(ndvi, scale=2, palette= "viridis")
im.ridgeline(ndvi, scale=2, palette= "mako")

# RGB scheme
#overlapping different species distribution model

im.plotRGB(ndvi, r=ndvi[[1]], g= ndvi[[2]], b = ndvi[[3]])

#variability ----

sent <- im.import("sentinel.png")

# band 1 = NIR
# band 2 = red
# band 3 = green

im.plotRGB(sent, r=1, g=2, b=3)
im.plotRGB(sent, r=2, g=1, b=3)

nir <- sent[[1]]
plot(nir)

# moving window
# focal
sd3 <- focal(nir, matrix(1/9, 3, 3), fun=sd)
plot(sd3)

var3 <-focal(nir, matrix(1/9, 3, 3), fun=var)
plot(var)

#Shannon entropy ----

#crop based on extension
ext <- c(0, 20, 0, 20)
cropnir <- crop(nir, ext)
plot(cropnir)

# blue = 0.8 green = 0.2
# H = -((0.8 * log(0.8)) + (0.2 * log(0.2)))
# 0.5004024
# H = -((0.5 * log(0.5)) + (0.5 * log(0.5)))
# 0.6931472

shan3 <- Shannon(nir, window =3)

shan3 <- Shannon(cropnir, window=3) 
plot(shan3)

#Shannon saturate too much
# Considering abundance AND distances
rao3 <- paRao(nir, window=3, alpha=2) # it is important that the terra package is uploaded first!
# plot(rao3[[1]])
# rasterdiv::Rao() is an alias 
plot(rao3[[1]][[1]]) 

