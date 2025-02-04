# Summarize NEE Predictions: 
rm(list=ls())

library(terra)
library(dplyr)

# Import NEE:

junk <- dir(path='/Volumes/MaloneLab/Research/ENP/Everglades_MODIS_LAI_TS/predictions',  pattern=".json")
setwd('/Volumes/MaloneLab/Research/ENP/Everglades_MODIS_LAI_TS/predictions')
file.remove(junk)

NEE.files <- list.files('/Volumes/MaloneLab/Research/ENP/Everglades_MODIS_LAI_TS/predictions', pattern=".tif$")

setwd('/Volumes/MaloneLab/Research/ENP/Everglades_MODIS_LAI_TS/predictions')
nee <- terra::rast(NEE.files)

# Extract the date out of the file name and add it into the time:
library(stringr)

time(nee) <-substr(NEE.files, 12, 21) %>% as.Date
writeRaster(nee ,'/Volumes/MaloneLab/Research/ENP/Everglades_MODIS_LAI_TS/Reed_MODEL_Layers/NEE_2005-2024.tif',overwrite=TRUE)

# Get AOI:
lai <- terra::rast('/Volumes/MaloneLab/Research/ENP/Everglades_MODIS_LAI_TS/Reed_MODEL_Layers/ENP_LAI_2007-2024.tif')
nee <- terra:rast('/Volumes/MaloneLab/Research/ENP/Everglades_MODIS_LAI_TS/Reed_MODEL_Layers/NEE_2005-2024.tif')


# Convert to monthly total NEE with tapp:
nee.years <- nee %>% tapp(index="years", fun=sum, na.rm=T ) 

writeRaster(nee.years ,'/Volumes/MaloneLab/Research/ENP/Everglades_MODIS_LAI_TS/Reed_MODEL_Layers/NEE_2005-2024_annual.tif', overwrite=TRUE)
