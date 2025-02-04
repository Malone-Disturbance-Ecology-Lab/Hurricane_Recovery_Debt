# Creates Spatial C Parms to support NEE:

rm(list=ls())

library(terra)
library(tidyverse)


# SPATIAL PARMS: ####
# this file was created in flow.LAI

lai.v3 <- rast('/Volumes/MaloneLab/Research/ENP/Everglades_MODIS_LAI_TS/Reed_MODEL_Layers/ENP_LAI_2000-2023.tif')[[2:1724]]

dates <- time(lai.v3)

# Create a dates df for the data:
dates.df <- data.frame(Date = c( seq( as.Date('2005-01-01'), 
                                      as.Date('2010-12-31'), by='days') ,
                                 seq( as.Date('2016-01-01'), 
                                      as.Date('2023-12-31'), by='days')) %>% as.character() )

df.summary <- read.csv('/Volumes/MaloneLab/Research/ENP/Everglades_MODIS_LAI_TS/Air_Temperature_Time_Since_Landfall_Daily_Data.csv') %>% 
  mutate(Date = as.POSIXct(as.character(Date), format="%Y%m%d" , "EST") %>% as.character,
         Date.f = as.POSIXct(as.character(Date), format="%Y-%m-%d" , "EST") %>% as.Date(), 
         Year = format(Date.f, "%Y"), YearMon = format(Date.f, "%Y-%m")) %>% right_join(dates.df, by='Date')


AirTemp.YM.df <- df.summary %>% reframe( .by= c(YearMon),
                                         AirTemp.YM = mean( Air.Temp, na.rm = TRUE)) 

df.summary <- df.summary %>% left_join(AirTemp.YM.df, by='YearMon') %>% mutate( Air.Temp = coalesce( Air.Temp , AirTemp.YM )) 


df.summary %>% summary

# We need blank rasters to add the calculated layers to:
ENP.LAI.RECO <-rast()
ENP.LAI.QY <-rast()
ENP.LAI.AMAX <-rast()
ENP.LAI.rb <-rast()

lai.time <- time(lai.v3 ) 

# Create the forloop to cycle through the dates in the LAI object and do the parameter calculation uing a df with Tair and TSD in 

for( a in 1:length(dates.df$Date)){
  i = dates.df$Date[a]%>% as.Date
  print(i)
  
  # Create the structure from LAI:
  lai.select <- max(lai.time[which( abs( lai.time %>% as.Date - i ) == min(abs(lai.time %>% as.Date - i)) )] )
  lai <- lai.v3 %>% terra::subset( time(lai.v3) == lai.select)
  lai <- lai[[1]]
  names(lai) <- "LAI"
  lai$STRUCTURE <- lai$LAI
  lai$STRUCTURE[lai$LAI <= 4 ] <- 0
  lai$STRUCTURE[lai$LAI >  4 ] <- 1

  
  # Create QY
  #QY <-  0.09 + (df.summary$Air.Temp[df.summary$Date.f == i] * 0.002) + (lai$STRUCTURE * -0.067) 
  #try(ENP.LAI.QY <- c( ENP.LAI.QY, QY), silent=T)
  
  #RECO <- -4.82 + (exp(lai$LAI)*0.25) + (df.summary$Time.Since.Landfall[df.summary$Date.f == i] * 0.03) + (lai$STRUCTURE * -3.91) + (df.summary$Air.Temp[df.summary$Date.f == i] * 0.29)
  #try( ENP.LAI.RECO <- c( ENP.LAI.RECO, RECO),  silent=T)
  RECO[ RECO > 60] <- 60
  
  
  AMAX <- 10.15 + (exp(lai$LAI) * 0.33) + (df.summary$Time.Since.Landfall[df.summary$Date.f == i] * -0.01) + (lai$STRUCTURE * -19.38) + (df.summary$Air.Temp[df.summary$Date.f == i] * 0.63)
  AMAX[ AMAX > 60] <- 60

  try(ENP.LAI.AMAX <- c( ENP.LAI.AMAX, AMAX), silent=T)
  
 # rb <- 3.01 + (df.summary$Time.Since.Landfall[df.summary$Date.f == i] * 0.01) + (lai$STRUCTURE * -2.27)
#  try(ENP.LAI.rb <- c( ENP.LAI.rb,  rb), silent=T)
}

#Write Files:
writeRaster( ENP.LAI.RECO, '/Volumes/MaloneLab/Research/ENP/Everglades_MODIS_LAI_TS/Reed_MODEL_Layers/ENP_RECO_2000-2023_NEW.tif',overwrite=TRUE )
writeRaster( ENP.LAI.QY,  '/Volumes/MaloneLab/Research/ENP/Everglades_MODIS_LAI_TS/Reed_MODEL_Layers/ENP_QuanYield_2000-2023_NEW.tif',overwrite=TRUE)
writeRaster( ENP.LAI.AMAX,  '/Volumes/MaloneLab/Research/ENP/Everglades_MODIS_LAI_TS/Reed_MODEL_Layers/ENP_AMAX_2000-2023_NEW.tif',overwrite=TRUE)
writeRaster( ENP.LAI.rb,  '/Volumes/MaloneLab/Research/ENP/Everglades_MODIS_LAI_TS/Reed_MODEL_Layers/ENP_rb_2000-2023_NEW.tif',overwrite=TRUE)

# Calculate NEE: #####



ENP.LAI.RECO <- rast('/Volumes/MaloneLab/Research/ENP/Everglades_MODIS_LAI_TS/Reed_MODEL_Layers/ENP_RECO_2000-2023_NEW.tif')
ENP.LAI.QY <- rast( '/Volumes/MaloneLab/Research/ENP/Everglades_MODIS_LAI_TS/Reed_MODEL_Layers/ENP_QuanYield_2000-2023_NEW.tif')
ENP.LAI.AMAX <- rast('/Volumes/MaloneLab/Research/ENP/Everglades_MODIS_LAI_TS/Reed_MODEL_Layers/ENP_AMAX_2000-2023_NEW.tif')
ENP.LAI.rb <- rast('/Volumes/MaloneLab/Research/ENP/Everglades_MODIS_LAI_TS/Reed_MODEL_Layers/ENP_rb_2000-2023_NEW.tif')

 lai.v3 <- rast('/Volumes/MaloneLab/Research/ENP/Everglades_MODIS_LAI_TS/Reed_MODEL_Layers/ENP_LAI_2000-2023.tif')

dates <- time(lai.v3)

# Radiation  and Temperature Data:
source('/Volumes/MaloneLab/Research/ENP/Everglades_MODIS_LAI_TS/03_SRS6Fix.R' )

srs6.org$Date <- srs6.org$TIMESTAMP %>% format("%Y-%m-%d") %>% as.Date

data.day <- srs6.org %>% filter( SW_IN > 0 )
data.night <- srs6.org %>% filter( SW_IN <= 0)

lai.time <- time(ENP.LAI.RECO) 

days <- unique(srs6.org$Date) %>% na.omit # makes a list of the unique days to make calculations for

# for loop pulls each unique day, finds to closets LAI layer to use for the date, makes an estimate for all the halfhours, sums them and saves them in a folder called predictions. 


for(i in 1:length(days)){
  
  print(days[i])  
  
  select.lai <- max(lai.time[which(abs(lai.time-days[i]) == min(abs(lai.time - days[i])))] )
  ENP.LAI.RECO.select <- ENP.LAI.RECO %>% subset( time(ENP.LAI.RECO) == select.lai)
  ENP.LAI.QY.select <- ENP.LAI.QY  %>% subset( time(ENP.LAI.QY) == select.lai)
  ENP.LAI.AMAX.select <- ENP.LAI.AMAX %>% subset( time(ENP.LAI.AMAX) == select.lai)
  ENP.LAI.rb.select <- ENP.LAI.rb %>% subset(time(ENP.LAI.rb ) == select.lai)
  ENP.LAI.rb.select[ ENP.LAI.rb.select == 0] <- NA # Makes all 0 NA
  ENP.LAI.rb.select <- focal(ENP.LAI.rb.select, w=3, fun="mean", na.rm=TRUE, NAonly=TRUE, pad=TRUE) # Fills NA with their neighbor
  

  ENP.NEE.day <- ((ENP.LAI.QY.select*data.day$SW_IN[data.day$Date == days[i]] * ENP.LAI.AMAX.select) / ( ENP.LAI.QY.select*data.day$SW_IN[ data.day$Date == days[i]] + ENP.LAI.AMAX.select)) - ENP.LAI.RECO.select
  
  ENP.NEE.night <- ENP.LAI.rb.select * exp( 114 *( (1/(15 --46.02) - (1/(data.day$TA[data.day$Date == days[i]] --46.02)) ) ))*-1
  
  ENP.NEE.day.gC <- 12.0107 * ENP.NEE.day / 1000000 * 1800
  ENP.NEE.night.gC <- 12.0107 * ENP.NEE.night / 1000000 * 1800
  
  ENP.NEE.gC.total  <- sum(ENP.NEE.day.gC ) + sum(ENP.NEE.night.gC)
  
  time( ENP.NEE.gC.total) <-  days[i]
  names( ENP.NEE.gC.total) <- "NEEgC"
  
  writeRaster(ENP.NEE.gC.total,  paste('/Volumes/MaloneLab/Research/ENP/Everglades_MODIS_LAI_TS/predictions/ENP_NEE_DAY',days[i], '.tif', sep=""), overwrite=T)
  
  rm( ENP.LAI.RECO.select, ENP.LAI.QY.select,ENP.LAI.AMAX.select, ENP.NEE.day, ENP.NEE.night,  ENP.NEE.gC.total)
}

# LRC only:

srs6.org$SW_IN[ srs6.org$Date == days[i]]
data.day$SW_IN[ data.day$Date == days[i]]

# 1827 There is still on issue with 11/01

data.day <- srs6.org %>% filter( Date != "2011-01-01")

for(i in 1:length(days)){
  
  print(days[i])  
  
  select.lai <- max(lai.time[which(abs(lai.time-days[i]) == min(abs(lai.time - days[i])))] )
  ENP.LAI.RECO.select <- ENP.LAI.RECO %>% subset( time(ENP.LAI.RECO) == select.lai)
  ENP.LAI.QY.select <- ENP.LAI.QY  %>% subset( time(ENP.LAI.QY) == select.lai)
  ENP.LAI.AMAX.select <- ENP.LAI.AMAX %>% subset( time(ENP.LAI.AMAX) == select.lai)
  
  ENP.NEE.day <- ((ENP.LAI.QY.select*data.day$SW_IN[data.day$Date == days[i]] * ENP.LAI.AMAX.select)/ ( ENP.LAI.QY.select*data.day$SW_IN[ data.day$Date == days[i]] + ENP.LAI.AMAX.select) - ENP.LAI.RECO.select)
  
  ENP.NEE.day.gC <- 12.0107 * ENP.NEE.day / 1000000 * 1800
  
  
  ENP.NEE.gC.total  <- sum(ENP.NEE.day.gC )
  
  time( ENP.NEE.gC.total) <-  days[i]
  names( ENP.NEE.gC.total) <- "NEEgC"
  
  writeRaster(ENP.NEE.gC.total,  paste('/Volumes/MaloneLab/Research/ENP/Everglades_MODIS_LAI_TS/predictions/LRC_only/ENP_NEE_DAY',days[i], '.tif', sep=""), overwrite=T)
  
  rm( ENP.LAI.RECO.select, ENP.LAI.QY.select,ENP.LAI.AMAX.select, ENP.NEE.day, ENP.NEE.gC,  ENP.NEE.gC.total)
}


# REC_TRC V2
for(i in 1:length(days)){
  
  print(days[i])  
  
  select.lai <- max(lai.time[which(abs(lai.time-days[i]) == min(abs(lai.time - days[i])))] )
  ENP.LAI.RECO.select <- ENP.LAI.RECO %>% subset( time(ENP.LAI.RECO) == select.lai)
  ENP.LAI.QY.select <- ENP.LAI.QY  %>% subset( time(ENP.LAI.QY) == select.lai)
  ENP.LAI.AMAX.select <- ENP.LAI.AMAX %>% subset( time(ENP.LAI.AMAX) == select.lai)
  ENP.LAI.rb.select <- ENP.LAI.rb %>% subset(time(ENP.LAI.rb ) == select.lai)
  ENP.LAI.rb.select[ ENP.LAI.rb.select == 0] <- NA # Makes all 0 NA
  ENP.LAI.rb.select <- focal(ENP.LAI.rb.select, w=3, fun="mean", na.rm=TRUE, NAonly=TRUE, pad=TRUE) # Fills NA with their neighbor
  
  
  ENP.NEE.day <- ((ENP.LAI.QY.select*data.day$SW_IN[data.day$Date == days[i]] * ENP.LAI.AMAX.select) / ( ENP.LAI.QY.select*data.day$SW_IN[ data.day$Date == days[i]] + ENP.LAI.AMAX.select)) - (ENP.LAI.rb.select * exp( 114 *( (1/(15 --46.02) - (1/(data.day$TA[data.day$Date == days[i]] --46.02)) ) )))
  
  ENP.NEE.day.gC <- 12.0107 * ENP.NEE.day / 1000000 * 1800
 
  ENP.NEE.gC.total  <- sum(ENP.NEE.day.gC )
  
  time( ENP.NEE.gC.total) <-  days[i]
  names( ENP.NEE.gC.total) <- "NEEgC"
  
  writeRaster(ENP.NEE.gC.total,  paste('/Volumes/MaloneLab/Research/ENP/Everglades_MODIS_LAI_TS/predictions/LRC_TRC_DAVID/ENP_NEE_LRC_TRC',days[i], '.tif', sep=""), overwrite=T)
  
  rm( ENP.LAI.RECO.select, ENP.LAI.QY.select,ENP.LAI.AMAX.select, ENP.NEE.day, ENP.NEE.night,  ENP.NEE.gC.total)
}

