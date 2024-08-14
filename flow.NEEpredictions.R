# Explor the predictions:
rm(list=ls())

library(terra)
library(dplyr)

# Import NEE:

NEE.files <- list.files('/Volumes/MaloneLab/Research/ENP/Everglades_MODIS_LAI_TS/predictions', pattern="tif$")

setwd('/Volumes/MaloneLab/Research/ENP/Everglades_MODIS_LAI_TS/predictions')
nee <- terra::rast(NEE.files )
writeRaster(nee ,'/Volumes/MaloneLab/Research/ENP/Everglades_MODIS_LAI_TS/Reed_MODEL_Layers/NEE_2005-2024.tif')

# Get AOI:
lai <- terra::rast('/Volumes/MaloneLab/Research/ENP/Everglades_MODIS_LAI_TS/Reed_MODEL_Layers/ENP_LAI_2007-2024.tif')

nee <- terra:rast('/Volumes/MaloneLab/Research/ENP/Everglades_MODIS_LAI_TS/Reed_MODEL_Layers/NEE_2005-2024.tif')


# Convert to monthly total NEE with tapp:
nee.years <- nee %>% tapp(index="years", fun=sum, na.rm=T ) 

writeRaster(nee.years ,'/Volumes/MaloneLab/Research/ENP/Everglades_MODIS_LAI_TS/Reed_MODEL_Layers/NEE_2005-2024_annual.tif')

# START HERE
nee.years <- terra::rast('/Volumes/MaloneLab/Research/ENP/Everglades_MODIS_LAI_TS/Reed_MODEL_Layers/NEE_2005-2024_annual.tif')


nee.years.sub.pre <- (nee.years[[time(nee.years) < 2004 |
                                    time(nee.years) > 2010 & time(nee.years) < 2017]] %>% mean)  

area.m2 <- cellSize(nee.years.sub.pre, mask=FALSE, unit="m")

nee.pre <- nee.years.sub.pre * area.m2

nee.post.y1 <- (nee.years[[time(nee.years) == 2006 |
                                  time(nee.years) == 2018]] %>% mean ) * area.m2

nee.post.y2 <- (nee.years[[time(nee.years) ==2007 |
                            time(nee.years) ==2019]] %>% mean)  * area.m2

nee.post.y3 <- (nee.years[[time(nee.years) ==2008 |
                            time(nee.years) ==2020]] %>% mean) * area.m2

nee.post.y4 <- (nee.years[[time(nee.years) ==2009 |
                            time(nee.years) ==2021]] %>% mean)  * area.m2

nee.post.y5 <- (nee.years[[time(nee.years) ==2022]] %>% mean)  * area.m2

nee.post.y6 <- (nee.years[[time(nee.years) ==2023]] %>% mean)  * area.m2

Debt.y1 <- nee.post.y1 - nee.pre

Debt.y2 <- nee.post.y2 - nee.pre

Debt.y3 <- nee.post.y3 - nee.pre

Debt.y4 <- nee.post.y4 - nee.pre

Debt.y5 <- nee.post.y5 - nee.pre

Debt.y6 <- nee.post.y6 - nee.pre

total.Debt <- Debt.y1 + Debt.y2 + Debt.y3 + Debt.y4 

writeRaster(total.Debt ,'/Volumes/MaloneLab/Research/ENP/Everglades_MODIS_LAI_TS/Reed_MODEL_Layers/Irma_Debt.tif', overwrite=TRUE)


d.0 <- 0
d.1 <- global(Debt.y1 , 'sum', na.rm=T)
d.2 <- global(Debt.y2 , 'sum', na.rm=T)
d.3 <- global(Debt.y3 , 'sum', na.rm=T)
d.4 <- global(Debt.y4 , 'sum', na.rm=T)
d.5 <- global(Debt.y5 , 'sum', na.rm=T)
d.6 <- global(Debt.y6 , 'sum', na.rm=T)
# Show cum sum of recovery debt them map of final NEE or delta nee. 


debt <- c(d.0,d.1[1,1], d.2[1,1], d.3[1,1], 
                           d.4[1,1], d.5[1,1]) 
summary.df <- data.frame( TSH=c(-1, 1, 2, 3, 4, 5) , debt=debt)
save(summary.df , file='/Volumes/MaloneLab/Research/ENP/Everglades_MODIS_LAI_TS/Reed_MODEL_Layers/Irma_Debt.csv' )

summary.df$debt.mT <- summary.df$debt/1000000000000 
total.Debt.tonnes = total.Debt/1000000

# Plot 

library(ggplot2)
library(tidyterra)
library(ggpubr)

global(total.Debt, 'sum', na.rm=T)

p.1 <- ggplot(summary.df, aes(x=TSH, y=cumsum(debt.mT))) + geom_line() + geom_point() + theme_bw() +
  xlab('Years Following Disturbance') + ylab( 'Landscape C Debt (Mt)') +
  geom_vline(xintercept=0, linetype="dashed", color = "red") + theme(text = element_text(size = 20))

# Import enp shape ans change the CRS
library(sf)
enp <- st_read("/Volumes/MaloneLab/Research/ENP/shapefiles/enp.shp") %>% st_transform(crs(total.Debt.tonnes))

p.2 <- ggplot() + geom_sf(data= enp, fill=NA, col="black", linewidth = 1) +
  geom_spatraster(data = total.Debt.tonnes) +   
  scale_fill_grass_c(palette = "inferno", 
                     na.value = "transparent",
                     name="tonnes")+ theme_bw() + theme(text = element_text(size = 20), legend.position="top",
                                                        legend.text = element_text(colour="black", size=10, 
                                                                                   face="bold", angle=-45))

setwd('/Volumes/MaloneLab/Research/ENP/Everglades_MODIS_LAI_TS/')
png("Debt_4Years.png", width = 650, height = 350)
ggarrange( p.1, p.2, ncol=2, nrow=1, labels= c('(a)', "(b)"))
dev.off()


length(total.Debt.tonnes[ total.Debt.tonnes <0])/ length(total.Debt.tonnes[!is.na(total.Debt.tonnes)])
sum( summary.df$debt.mT)
