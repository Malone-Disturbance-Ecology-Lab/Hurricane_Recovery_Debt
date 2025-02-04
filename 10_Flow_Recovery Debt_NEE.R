rm(list=ls())

library(terra)
library(dplyr)
library(tidyterra)

# Import Daily NEE: 
nee <- terra::rast('/Volumes/MaloneLab/Research/ENP/Everglades_MODIS_LAI_TS/Reed_MODEL_Layers/NEE_2005-2024.tif')
nee.lrc <- terra::rast('/Volumes/MaloneLab/Research/ENP/Everglades_MODIS_LAI_TS/Reed_MODEL_Layers/NEE_2005-2024_LRC.tif')
nee.lrc.trc2 <- terra::rast('/Volumes/MaloneLab/Research/ENP/Everglades_MODIS_LAI_TS/Reed_MODEL_Layers/NEE_2005-2024_LRC_TRC2.tif')

stormDebtStack <- function( rasterStack){
  
  rasterSubDate <- function( rasterStack, startDate, stopDate){
    
    sub1 <- rasterStack %>% subset( time(rasterStack) >= as.Date( startDate) )  
    
    sub2 <- sub1 %>% subset(time(sub1) <= as.Date(stopDate) )
    
    final.sub <- sub2 %>% sum(na.rm=T)   
    
    return(final.sub)
  }
  
  DebtStack <- rast()
  
  DebtStack$Y1.Wilma <- rasterSubDate(rasterStack = rasterStack, startDate= "2005-10-25", stopDate= "2006-10-24" )
  DebtStack$Y2.Wilma <- rasterSubDate(rasterStack = rasterStack, startDate= "2006-10-25", stopDate= "2007-10-24" )
  DebtStack$Y3.Wilma <- rasterSubDate(rasterStack = rasterStack, startDate= "2007-10-25", stopDate= "2008-10-24" )
  DebtStack$Y4.Wilma <- rasterSubDate(rasterStack = rasterStack, startDate= "2008-10-25", stopDate= "2009-10-24" )
  DebtStack$Y5.Wilma <- rasterSubDate(rasterStack = rasterStack, startDate= "2009-10-25", stopDate= "2010-10-24" )
  DebtStack$Y6.Wilma <- rasterSubDate(rasterStack = rasterStack, startDate= "2010-10-25", stopDate= "2011-10-24" )
  
  DebtStack$Y0.Irma <- rasterSubDate(rasterStack = rasterStack, startDate= "2016-09-10", stopDate= "2017-09-09" )
  DebtStack$Y1.Irma <- rasterSubDate(rasterStack = rasterStack, startDate= "2017-09-10", stopDate= "2018-09-09" )
  DebtStack$Y2.Irma <- rasterSubDate(rasterStack = rasterStack, startDate= "2018-09-10", stopDate= "2019-09-09" )
  DebtStack$Y3.Irma <- rasterSubDate(rasterStack = rasterStack, startDate= "2019-09-10", stopDate= "2020-09-09" )
  DebtStack$Y4.Irma <- rasterSubDate(rasterStack = rasterStack, startDate= "2020-09-10", stopDate= "2021-09-09" )
  DebtStack$Y5.Irma <- rasterSubDate(rasterStack = rasterStack, startDate= "2021-09-10", stopDate= "2022-09-09" )
  DebtStack$Y6.Irma <- rasterSubDate(rasterStack = rasterStack, startDate= "2022-09-10", stopDate= "2023-09-09" )
  
  # Convert to monthly total NEE with tapp:
  nee.years <- DebtStack %>% dplyr::mutate( Y0 = Y0.Irma ,
                                     Y1 = (Y1.Wilma +Y1.Irma)/2,
                                     Y2 = ( Y2.Wilma +Y2.Irma)/2,
                                     Y3 = ( Y3.Wilma+ Y3.Irma)/2,
                                     Y4 = ( Y4.Wilma + Y4.Irma)/2,
                                     Y5 = ( Y5.Wilma + Y5.Irma)/2,
                                     Y6 = Y6.Irma,
                                     DEBT.Y1 = Y1 - Y0,
                                     DEBT.Y2 = Y2 - Y0,
                                     DEBT.Y3 = Y3 - Y0,
                                     DEBT.Y4 = Y4 - Y0,
                                     DEBT.Y5 = Y5 - Y0,
                                     DEBT.Y6 = Y6 - Y0,
                                     Total.DEBT =  DEBT.Y1 + DEBT.Y2 + DEBT.Y3 + DEBT.Y4)
                                   
  
  # Add units to the raster stack !!!!
  units(nee.years) <- 'g C m-2'
  
  nee.years$area.m2 <- cellSize(nee.years$Total.DEBT, mask=FALSE, unit="m")
  
  nee.years <- nee.years %>% mutate(  DEBT.Y1.area = (Y1 - Y0) * area.m2/1000000 ,
                        DEBT.Y2.area = ((Y2 - Y0) * area.m2) /1000000,
                        DEBT.Y3.area= ((Y3 - Y0) * area.m2) /1000000,
                        DEBT.Y4.area = ((Y4 - Y0) * area.m2)/1000000 ,
                        DEBT.Y5.area = ((Y5 - Y0) * area.m2)/1000000 ,
                        DEBT.Y6.area = ((Y6 - Y0) * area.m2)/1000000 )
  
  units(nee.years$area.m2 ) <- 'm-2'
  nee.years$DEBT.area <- (nee.years$Total.DEBT*nee.years$area.m2)/1000000
  units(nee.years$DEBT.area) <- 'tonnes'
  
  units( nee.years$DEBT.Y1.area) <- 'tonnes'
  units( nee.years$DEBT.Y2.area) <- 'tonnes'
  units( nee.years$DEBT.Y3.area) <- 'tonnes'
  units( nee.years$DEBT.Y4.area) <- 'tonnes'
  units( nee.years$DEBT.Y5.area) <- 'tonnes'
  units( nee.years$DEBT.Y6.area) <- 'tonnes'
  
  return(nee.years )
}

Debt.LRC.TRC2 <- stormDebtStack(rasterStack = nee.lrc.trc2)
Debt.LRC.TRC <- stormDebtStack(rasterStack = nee)
Debt.LRC <- stormDebtStack(rasterStack = nee.lrc)

writeRaster(Debt.LRC.TRC2 ,'/Volumes/MaloneLab/Research/ENP/Everglades_MODIS_LAI_TS/Reed_MODEL_Layers/Debt_LRC_TRC2.tif', overwrite=TRUE)
writeRaster(Debt.LRC.TRC ,'/Volumes/MaloneLab/Research/ENP/Everglades_MODIS_LAI_TS/Reed_MODEL_Layers/Debt_LRC_TRC.tif', overwrite=TRUE)
writeRaster(Debt.LRC ,'/Volumes/MaloneLab/Research/ENP/Everglades_MODIS_LAI_TS/Reed_MODEL_Layers/Debt_LRC.tif', overwrite=TRUE)

Debt.df <- function( stormDebtStack ){
  
  d.0 <- 0
  d.1 <- global(stormDebtStack$DEBT.Y1.area , 'sum', na.rm=T)
  d.2 <- global(stormDebtStack$DEBT.Y2.area , 'sum', na.rm=T)
  d.3 <- global(stormDebtStack$DEBT.Y3.area , 'sum', na.rm=T)
  d.4 <- global(stormDebtStack$DEBT.Y4.area , 'sum', na.rm=T)
  #d.5 <- global(stormDebtStack$DEBT.Y5.area , 'sum', na.rm=T)
  #d.6 <- global(stormDebtStack$DEBT.Y6.area , 'sum', na.rm=T)
  # Show cum sum of recovery debt them map of final NEE or delta nee. 
  
  # Create a dataframe:
  debt <- c(d.0,d.1[1,1], d.2[1,1], d.3[1,1], 
            d.4[1,1])#, d.5[1,1], d.6[1,1]) 
  summary.df <- data.frame( TSH=c(-1, 1, 2, 3, 4) , debt=debt)
  
  summary.df$debt.mT <- summary.df$debt/1000000 
return( summary.df)
}

debt.lrc.df <- Debt.df( stormDebtStack = Debt.LRC)
debt.lrc.trc.df <- Debt.df( stormDebtStack = Debt.LRC.TRC)
debt.lrc.trc2.df <- Debt.df( stormDebtStack = Debt.LRC.TRC2)

debt.df <- rbind(debt.lrc.df %>% mutate( approach = "LRC"),
                 debt.lrc.trc.df %>% mutate( approach = "LRC+TRC"),
                 debt.lrc.trc2.df %>% mutate( approach = "LRC+TRC2"))

write.csv(debt.df, file='/Volumes/MaloneLab/Research/ENP/Everglades_MODIS_LAI_TS/Reed_MODEL_Layers/Debt.csv' )

# Load the data:
debt.df <- read.csv('/Volumes/MaloneLab/Research/ENP/Everglades_MODIS_LAI_TS/Reed_MODEL_Layers/Debt.csv' )
debt.df$TSH[ debt.df$TSH == -1] <- 0
debt.df
library(ggplot2)
library(ggpubr)

debt.df <- debt.df %>% filter( approach != 'LRC+TRC2')

debt.df$debt.mT[ debt.df$TSH == 1 ] %>% mean
debt.df$debt.mT[ debt.df$TSH == 1 ] %>% sd/sqrt(2)
debt.df$debt.mT[ debt.df$TSH == 4] %>% mean
debt.df$debt.mT[ debt.df$TSH == 4 ] %>% sd/sqrt(2)

p.1a <- ggplot(data = debt.df)  + 
  geom_point(aes(x=TSH, y=debt.mT, shape = approach), size=3) + xlab('Years Since Landfall') + ylab( 'Recovery Debt (Mt)') + 
  geom_smooth(aes(x=TSH, y=debt.mT),col="black", method='loess', fullrange=TRUE) +
  geom_vline(xintercept=0, linetype="dashed", color = "black", linewidth=1) + theme_bw() + 
  theme(text = element_text(size = 25,), 
        legend.title = element_blank(),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        axis.ticks.length=unit(-0.25, "cm")) + xlim(0, 4) + 
  geom_hline(yintercept=0, linetype="dotted", color = "black", linewidth=1) + scale_shape_manual(values =c(1,2))

p.1b <- ggplot(data = debt.df %>% filter( approach != 'LRC+TRC2') )  + 
  geom_point(aes(x=TSH, y= cumsum(debt.mT), shape = approach), size=3) + xlab('Years Since Landfall') + 
  ylab( 'Cumulative Recovery Debt (Mt)') + geom_smooth(aes(x=TSH, y=cumsum(debt.mT)), col="black", method='loess', fullrange=TRUE) + theme_bw() + 
  geom_vline(xintercept=0, linetype="dashed", color = "black", linewidth=1) + theme(text = element_text(size = 25), 
                                                                       legend.title = element_blank(),
                                                                       panel.grid.major = element_blank(),
                                                                       panel.grid.minor = element_blank(),
                                                                       axis.ticks.length=unit(-0.25, "cm")) + 
  xlim(0, 4)  + geom_hline(yintercept=0, linetype="dotted", color = "black", linewidth=1) + scale_shape_manual(values =c(1,2))

# Import enp shape ans change the CRS
library(sf)
library(tidyterra)

total.Debt.tonnes.all <- ((Debt.LRC$DEBT.area + Debt.LRC.TRC$DEBT.area + Debt.LRC.TRC2$DEBT.area)/3)

total.Debt.tonnes.LRC.TRC <- ((Debt.LRC$DEBT.area + Debt.LRC.TRC$DEBT.area )/2)

enp <- st_read("/Volumes/MaloneLab/Research/ENP/shapefiles/enp.shp") %>% st_transform(crs(total.Debt.tonnes.LRC.TRC))

p.2 <- ggplot() +
  geom_spatraster(data = total.Debt.tonnes.LRC.TRC) +   geom_sf(data= enp, fill=NA, col="black", linewidth = 1) +
  coord_sf(crs = st_crs(4087), expand = FALSE) + theme_bw() + 
  theme(text = element_text(size = 20), legend.position="top",
        legend.text = element_text(colour="black", size=18, 
                                   face="bold", angle=-45),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        axis.ticks.length=unit(-0.25, "cm")) + 
  scale_fill_whitebox_c(palette = "muted", 
                        na.value = "transparent",
                        name="Recovery Debt (tonnes)   ")


plots.arrange.1 <- ggarrange( p.1a, p.1b, ncol=2, nrow=1, labels= c('(a)', "(b)"), common.legend = TRUE, font.label=list(color="black",size=20))
plots.arrange.2 <- ggarrange( p.2, ncol=1, nrow=1, labels= c('(c)'), font.label=list(color="black",size=20))

setwd('/Volumes/MaloneLab/Research/ENP/Everglades_MODIS_LAI_TS/')
png("Debt_4Years.png", width = 1000, height = 1000)
ggarrange( plots.arrange.1, plots.arrange.2, ncol=1, nrow=2)
dev.off()

length(total.Debt.tonnes.LRC.TRC[ total.Debt.tonnes.LRC.TRC <0])/ length(total.Debt.tonnes.LRC.TRC[!is.na(total.Debt.tonnes.LRC.TRC)])


