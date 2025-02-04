rm(list=ls())

library(terra)
library(tidyverse)

# Import the new LAI layers: Data was download by two request to the extents are off. Must bring in separately and join: 
lai.files <- list.files( "/Volumes/MaloneLab/Research/ENP/Everglades_MODIS_LAI_TS/data", pattern="Lai_500m")

setwd("/Volumes/MaloneLab/Research/ENP/Everglades_MODIS_LAI_TS/data")

raster.lai <- rast( lai.files[1:245])
raster.lai2 <- rast( lai.files[246:1724])

# Crop by mangroves layer:
library(sf)
enp.msl <- read_sf(dsn="/Volumes/MaloneLab/Research/ENP/VegetationMap/Data", layer="MangroveShrubland" )
enp.ms <- read_sf(dsn="/Volumes/MaloneLab/Research/ENP/VegetationMap/Data", layer="MangroveScrub" )
enp.msc <- rbind(enp.msl, enp.ms)

# Simplify:
enp.msc$msc <- 1

enp.msc.d <- enp.msc[enp.msc$msc == 1, ] %>% # select the central parts
  st_union() %>% # unite to a geometry object
  st_sf()

enp.msc.d <- st_transform( enp.msc.d, crs(raster.lai))

# Crop, mask, and combine layers:
lai.v1.crop.1 <- terra::crop(raster.lai, enp.msc.d) %>% terra::mask( enp.msc.d)
lai.v1.crop.2 <- terra::crop(raster.lai2, enp.msc.d) %>% terra::mask( enp.msc.d)

lai.v2.crop.mask <- c(lai.v1.crop.1, lai.v1.crop.2)
plot(lai.v2.crop.mask[[1]] )

lai.date <-  str_sub (lai.files, 26,32) #Extract the date
lai.date.formatted <- as.POSIXct(lai.date , "%Y%j", tz="EST") %>% as.Date()# Format the date
time(lai.v2.crop.mask) <- lai.date.formatted

#Remove fill value:
lai.v2.crop.mask[ lai.v2.crop.mask > 24] <- NA
lai.v3 <- lai.v2.crop.mask

plot(lai.v3[[1]])
# gap-fill missing values with a neighbor based mean: https://arc2r.github.io/book/Neighborhood.html
lai.v3 <- focal(lai.v3, w=3, fun="mean", na.rm=TRUE, NAonly=TRUE, pad=TRUE)

#Write Files:
writeRaster(lai.v3, '/Volumes/MaloneLab/Research/ENP/Everglades_MODIS_LAI_TS/Reed_MODEL_Layers/ENP_LAI_2000-2023.tif', overwrite=TRUE)