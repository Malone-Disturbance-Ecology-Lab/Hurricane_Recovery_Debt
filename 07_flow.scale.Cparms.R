# flow.scale.Cparms.LAI
library(ggplot2)
library(dplyr)
library(imputeTS)

c.parms <- read.csv('/Volumes/MaloneLab/Research/ENP/Everglades_MODIS_LAI_TS/Carbon_Parms/LRC_parameter_LAI_data.csv' ) %>% mutate_all(~ifelse(is.nan(.), NA, .))

c.parms$Date <- as.Date(c.parms$Date, "%d-%b-%Y")
c.parms$YearMonth <-format(c.parms$Date, "%Y-%m")

# Format SRS6: ####
x <- zoo::zoo(c.parms$SRS6.LAI,c.parms$Date)
x1 <- imputeTS::na.interpolation(x, option = "linear") %>% as.data.frame()
c.parms$SRS6.LAI.f <- x1[,1]

c.parms.tall <- c.parms %>% select(Date, SRS6.LAI.f,
                                   SRS6.LRC_1, SRS6.LRC_2, SRS6.LRC_3) %>%rename(LAI.f= SRS6.LAI.f,LRC_1 = SRS6.LRC_1, LRC_2=SRS6.LRC_2, LRC_3 =SRS6.LRC_3 )

c.parms.tall$Mangroves <- "Tall"
c.parms.tall$DisturbanceY <- 0

# Wilma
c.parms.tall$DisturbanceY[c.parms.tall$Date > as.Date("2005-10-24") & c.parms.tall$Date > as.Date("2006-10-23") ] <- 1
c.parms.tall$DisturbanceY[c.parms.tall$Date > as.Date("2006-10-24") & c.parms.tall$Date > as.Date("2007-10-23") ] <- 2
c.parms.tall$DisturbanceY[c.parms.tall$Date > as.Date("2007-10-24") & c.parms.tall$Date > as.Date("2008-10-23") ] <- 3
c.parms.tall$DisturbanceY[c.parms.tall$Date > as.Date("2008-10-24") & c.parms.tall$Date > as.Date("2009-10-23") ] <- 4

#Irma
c.parms.tall$DisturbanceY[c.parms.tall$Date > as.Date("2017-9-10") & c.parms.tall$Date > as.Date("2018-9-09") ] <- 1
c.parms.tall$DisturbanceY[c.parms.tall$Date > as.Date("2018-9-10") & c.parms.tall$Date > as.Date("2019-9-09") ] <- 2
c.parms.tall$DisturbanceY[c.parms.tall$Date > as.Date("2019-9-10") & c.parms.tall$Date > as.Date("2020-9-09") ] <- 3
c.parms.tall$DisturbanceY[c.parms.tall$Date > as.Date("2020-9-10") & c.parms.tall$Date > as.Date("2021-9-09") ] <- 4

# Format TS7: ####
c.parms %>% ggplot() + geom_point( aes( x=Date, y=TS7.LSI))
c.parms %>% ggplot() + geom_point( aes( x=Date, y=SRS6.LAI))

x <- zoo::zoo(c.parms$TS7.LSI,c.parms$Date)
x1 <- imputeTS::na.interpolation(x, option = "linear") %>% as.data.frame()

c.parms$TS7.LSI.f <- x1[,1]

c.parms.short <- c.parms %>% select(Date, TS7.LSI.f,
                                    LS7.LRC_1, LS7.LRC_2, LS7.LRC_3) %>% rename(LAI.f= TS7.LSI.f,LRC_1 = LS7.LRC_1, LRC_2=LS7.LRC_2, LRC_3 =LS7.LRC_3 ) %>% na.omit

c.parms.short$Mangroves <- "Scrub"

c.parms.short$DisturbanceY[c.parms.short$Date > as.Date("2017-9-10") & c.parms.short$Date > as.Date("2018-9-09") ] <- 1
c.parms.short$DisturbanceY[c.parms.short$Date > as.Date("2018-9-10") & c.parms.short$Date > as.Date("2019-9-09") ] <- 2
c.parms.short$DisturbanceY[c.parms.short$Date > as.Date("2019-9-10") & c.parms.short$Date > as.Date("2020-9-09") ] <- 3
c.parms.short$DisturbanceY[c.parms.short$Date > as.Date("2020-9-10") & c.parms.short$Date > as.Date("2021-9-09") ] <- 4

# Integrate Sites: ####
c.parm.calc <- gtools::smartbind(c.parms.tall,c.parms.short)

c.parm.calc$Month <- as.Date(c.parm.calc$Date) %>% format("%m") %>% as.factor
c.parm.calc$DisturbanceY <- c.parm.calc$DisturbanceY %>% as.factor
c.parm.calc.nona<- c.parm.calc %>% na.omit

# Data Exploration: ####

# Explore a linear relationship

summary(lm(data=c.parm.calc, LRC_1 ~ LAI.f))
summary(lm(data=c.parm.calc, LRC_2 ~ LAI.f))
summary(lm(data=c.parm.calc, LRC_3 ~ LAI.f ))

c.parm.calc %>% ggplot()+ geom_point(aes(x=LAI.f , y=LRC_1) )
c.parm.calc %>% ggplot()+ geom_point(aes(x=LAI.f , y=LRC_2) )
c.parm.calc %>% ggplot()+ geom_point(aes(x=LAI.f , y=LRC_3) )

# Explore an exponential relationship

summary(lm(data=c.parm.calc, LRC_1 ~ exp(LAI.f)))
summary(lm(data=c.parm.calc, LRC_2 ~ exp(LAI.f)))
summary(lm(data=c.parm.calc, LRC_3 ~ exp(LAI.f )))

c.parm.calc %>% ggplot(aes(x=LAI.f , y=LRC_1))+ geom_point( ) + 
  geom_smooth(method="lm", formula= (y ~ exp(x)), se=FALSE)

c.parm.calc %>% ggplot(aes(x=LAI.f , y=LRC_2))+ geom_point( ) + 
  geom_smooth(method="lm", formula= (y ~ exp(x)), se=FALSE)

c.parm.calc %>% ggplot(aes(x=LAI.f , y=LRC_2))+ geom_point( ) + 
  geom_smooth(method="lm", formula= (y ~ exp(x)), se=FALSE)

# Import temporal elements:

summary(lm(data=c.parm.calc, LRC_1 ~ exp(LAI.f) + Month))
summary(lm(data=c.parm.calc, LRC_2 ~ exp(LAI.f) + Month))
summary(lm(data=c.parm.calc, LRC_3 ~ exp(LAI.f) + Month))

c.parm.calc %>% ggplot(aes(x=LAI.f , y=LRC_1))+ geom_point( ) + 
  geom_smooth(method="lm", formula= (y ~ exp(x)), se=FALSE, aes(col=Month))

c.parm.calc %>% ggplot(aes(x=LAI.f , y=LRC_2))+ geom_point( ) + 
  geom_smooth(method="lm", formula= (y ~ exp(x)), se=FALSE, aes(col=Month))

c.parm.calc %>% ggplot(aes(x=LAI.f , y=LRC_3))+ geom_point( ) + 
  geom_smooth(method="lm", formula= (y ~ exp(x)), se=FALSE, aes(col=Month))

# Import study design elements:

summary(lm(data=c.parm.calc, LRC_1 ~ exp(LAI.f) + DisturbanceY + Mangroves + Month))
summary(lm(data=c.parm.calc, LRC_2 ~ exp(LAI.f) + DisturbanceY + Mangroves + Month))
summary(lm(data=c.parm.calc, LRC_3 ~ exp(LAI.f) + DisturbanceY + Mangroves + Month))

# Other approaches:

rf.lrc1 <- randomForest(LRC_1 ~ LAI.f + Mangroves  + Month + DisturbanceY, data=c.parm.calc.nona)
varImpPlot(rf.lrc1)

rf.lrc2 <- randomForest(LRC_2 ~ LAI.f + Mangroves  + Month, data=c.parm.calc.nona )
varImpPlot(rf.lrc2)

rf.lrc3 <- randomForest(LRC_3 ~ LAI.f + Mangroves  + Month , data=c.parm.calc.nona)
varImpPlot(rf.lrc3)

gam.lrc1 <- mgcv::gam(LRC_1 ~ s(LAI.f) + Mangroves  + Month + DisturbanceY, data=c.parm.calc)

summary(gam.lrc1 )

