rm(list=ls())

library(terra)
library(tidyverse)

# this file was created in flow.LAI

lai.v3 <- rast('/Volumes/MaloneLab/Research/ENP/Everglades_MODIS_LAI_TS/Reed_MODEL_Layers/ENP_LAI_2000-2023.tif')[[2:1724]]


dates <- time(lai.v3)


df.summary <- read.csv('/Volumes/MaloneLab/Research/ENP/Everglades_MODIS_LAI_TS/Air_Temperature_Time_Since_Landfall_Daily_Data.csv')

df.summary$Date.f <-  as.POSIXct(as.character(df.summary $Date), format="%Y%m%d" , "EST") %>% as.Date 

# We need blank rasters to add the calculated layers to:
ENP.LAI.RECO <-rast()
ENP.LAI.QY <-rast()
ENP.LAI.AMAX <-rast()

# Create the forloop to cycle through the dates in the LAI object and do the parameter calculation uing a df with Tair and TSD in it:
dates[1618]
for( a in 1618: length(dates)){
  i = dates[a]
  print(i)
  # Create the structure from LAI:
  
  # Create QT
  QY <-  structure <- subset( lai.v3, time(lai.v3) == i)[[1]]
  names(QY) <- "LAI"
  QY$QY =QY$LAI
  QY$QY[QY$LAI <= 0.4 ] <- 0.0440
  QY$QY[QY$LAI >  0.4 ] <- 0.0663
  try(ENP.LAI.QY <- c( ENP.LAI.QY, QY$QY), silent=T)
  
  lai = subset( lai.v3, time(lai.v3) == i)[[1]]
  names(lai) <- "LAI"
  lai$STRUCTURE <- lai$LAI
  lai$STRUCTURE[lai$LAI <= 0.4 ] <- 0
  lai$STRUCTURE[lai$LAI >  0.4 ] <- 1
  
  RECO <- -3.61 + (exp(lai$LAI)*0.11) + (df.summary$Time.Since.Landfall[df.summary$Date.f == i] * 0.01) + (lai$STRUCTURE * -2.60) + (df.summary$Air.Temp[df.summary$Date.f == i] * 0.23)
  try( ENP.LAI.RECO <- c( ENP.LAI.RECO, RECO),  silent=T)
  
  AMAX <- 0.28 + exp(lai$LAI)*0.11 + df.summary$Time.Since.Landfall[df.summary$Date.f == i] * -0.05 + lai$STRUCTURE * -12.29 + df.summary$Air.Temp[df.summary$Date.f == i] * 0.53
  try(ENP.LAI.AMAX <- c( ENP.LAI.AMAX, AMAX), silent=T)
  
}

#Write Files:

writeRaster(lai.v3, '/Volumes/MaloneLab/Research/ENP/Everglades_MODIS_LAI_TS/Reed_MODEL_Layers/ENP_LAI_2000-2023.tif', overwrite=TRUE)
writeRaster(ENP.LAI.RECO, '/Volumes/MaloneLab/Research/ENP/Everglades_MODIS_LAI_TS/Reed_MODEL_Layers/ENP_RECO_2000-2023_NEW.tif',overwrite=TRUE )
writeRaster(ENP.LAI.QY,  '/Volumes/MaloneLab/Research/ENP/Everglades_MODIS_LAI_TS/Reed_MODEL_Layers/ENP_QuanYield_2000-2023_NEW.tif',overwrite=TRUE)
writeRaster(ENP.LAI.AMAX,  '/Volumes/MaloneLab/Research/ENP/Everglades_MODIS_LAI_TS/Reed_MODEL_Layers/ENP_AMAX_2000-2023_NEW.tif',overwrite=TRUE)

#Use the New Layers to calculate NEE: #####
  
# Radiation Data
sw.data <- read.csv( '/Volumes/MaloneLab/Research/ENP/Everglades_MODIS_LAI_TS/NSRDB_SW_IN.csv')
sw.data$TimeStart
sw.data$TimeStamp <- as.POSIXct(as.character(sw.data$TimeStart), format="%Y%m%d%H%M" , "EST")
sw.data$Date <- as.Date( sw.data$TimeStamp)

sw.data.day <- sw.data %>% filter( SW_IN >0 & Date > "2005-01-01"& Date < "2024-01-01")

lai.time <- time(ENP.LAI.RECO) 

days <- unique(sw.data.day$Date) # makes a list of the unique days to make calculations for

summary(days)
length(days)

days[6410]

# for loop pulls each unique day, finds to closets LAI layer to use for the date, makes an estimate for all the halfhours, sums them and saves them in a folder called predictions. 
for(i in 6410:length(days)){
  
  print(days[i])  
  
  select.lai <- max(lai.time[which(abs(lai.time-days[i]) == min(abs(lai.time - days[i])))] )
  
  ENP.LAI.RECO.select <- ENP.LAI.RECO %>% subset( time(ENP.LAI.RECO) == select.lai)
  ENP.LAI.QY.select <- ENP.LAI.QY %>% subset( time(ENP.LAI.QY) == select.lai)
  ENP.LAI.AMAX.select <- ENP.LAI.AMAX %>% subset( time(ENP.LAI.AMAX) == select.lai)
  
  ENP.NEE <- ENP.LAI.QY.select*sw.data.day$SW_IN[sw.data.day$Date == days[i]] * ENP.LAI.AMAX.select/ ( ENP.LAI.QY.select* sw.data.day$SW_IN[sw.data.day$Date == days[i]] + ENP.LAI.AMAX.select) - ENP.LAI.RECO.select
  ENP.NEE.gC <- 12.0107 * ENP.NEE / 1000000 * 1800
  ENP.NEE.gC.total <- sum(  ENP.NEE.gC)
  time( ENP.NEE.gC.total) <-  days[i]
  names( ENP.NEE.gC.total) <- "NEEgC"
  
  writeRaster(ENP.NEE.gC.total,  paste('/Volumes/MaloneLab/Research/ENP/Everglades_MODIS_LAI_TS/predictions/ENP_NEE_',days[i], '.tif', sep=""), overwrite=T)
  
  rm( ENP.LAI.RECO.select, ENP.LAI.QY.select,ENP.LAI.AMAX.select, ENP.NEE, ENP.NEE.gC,  ENP.NEE.gC.total)
}

