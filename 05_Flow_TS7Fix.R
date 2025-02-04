 # 03_TS7Fix : Correct issues in Davids file

ts7.data <- read.csv('/Volumes/MaloneLab/Research/ENP/Everglades_MODIS_LAI_TS/TS7_datatable.csv') %>% mutate(
  TIMESTAMP = as.POSIXct(dates, '%d-%b-%Y %H:%M:%S',tz = "US/Eastern"))



TIMESTAMP <- data.frame(TIMESTAMP = c( seq( as.POSIXct('2004-10-25 00:00:00', '%Y-%m-%d %H:%M:%S',  
                                                       tz = "America/New_York"), 
                                            as.POSIXct('2010-10-25 23:30:00', '%Y-%m-%d %H:%M:%S',  
                                                       tz = "America/New_York"), by=1800) ,
                                       seq( as.POSIXct('2016-09-10 00:00:00', '%Y-%m-%d %H:%M:%S',  
                                                       tz = "America/New_York"), 
                                            as.POSIXct('2023-09-09 23:30:00', '%Y-%m-%d %H:%M:%S',  
                                                       tz = "America/New_York"), by=1800))) %>% 
  mutate( dates = format( TIMESTAMP, '%d-%b-%Y %H:%M:%S') %>% as.character,
          Date = TIMESTAMP %>% as.Date,
          Month = TIMESTAMP %>% format('%m'),
          TSD = case_when( between(Date, as.Date("2004-10-25"), as.Date("2005-10-25"))  ~ 0,
                           between(Date, as.Date("2005-10-25"), as.Date("2006-10-25"))  ~ 1,
                           between(Date, as.Date("2006-10-25"), as.Date("2007-10-25"))  ~ 2,
                           between(Date, as.Date("2007-10-25"), as.Date("2008-10-25"))  ~ 3,
                           between(Date, as.Date("2008-10-25"), as.Date("2009-10-25"))  ~ 4,
                           between(Date, as.Date("2009-10-25"), as.Date("2010-10-25"))  ~ 5,
                           # between(Date, as.Date("2010-10-25"), as.Date("2011-10-24"))  ~ 6,
                           between(Date, as.Date("2016-09-10"), as.Date("2017-09-10")) ~ 0,
                           between(Date, as.Date("2017-09-10"), as.Date("2018-09-10")) ~ 1,
                           between(Date, as.Date("2018-09-10"), as.Date("2019-09-10")) ~ 2,
                           between(Date, as.Date("2019-09-10"), as.Date("2020-09-10")) ~ 3,
                           between(Date, as.Date("2020-09-10"), as.Date("2021-09-10")) ~ 4,
                           between(Date, as.Date("2021-09-10"), as.Date("2022-09-10")) ~ 5,
                           between(Date, as.Date("2022-09-10"), as.Date("2023-09-10")) ~ 6),
          EVENT = case_when( Date < as.Date("2016-09-10") ~ "Wilma",
                             Date >= as.Date("2016-09-10") ~ "Irma"),
          Disturbed = case_when( Date < as.Date("2005-10-23") ~ 0,
                                 Date == as.Date("2005-10-23") ~ 1,
                                 between(Date, as.Date("2005-10-23"), as.Date("2010-12-31")) ~ 1,
                                 Date < as.Date("2017-09-10") ~ 0,
                                 Date == as.Date("2017-09-10") ~ 1,
                                 between(Date, as.Date("2017-09-10"), as.Date("2024-01-01")) ~ 1)) %>% na.omit




ts7 <- TIMESTAMP %>% left_join( srs6.data , by= 'dates') %>% 
  mutate( Hour = format( TIMESTAMP, format='%H') ,
          Date = format( TIMESTAMP, format='%d-%b-%Y'),
          Year = format( TIMESTAMP, format='%Y'),
          YearMon = format( TIMESTAMP, format='%Y-%m') %>% ym)
ts7 %>% names()

rm(TIMESTAMP, ts7.data )


ts7$SW_IN [ ts7$SW_IN < 0] <- 0

# Export a daily file for 03_flow.LAI_Reed_Predictions: ####

# Create a baseline summary:
ts7%>% names
# Files Needed:
ts7.sites <- ts7 %>% mutate(Amax = LRC_Amax, QY = LRC_QY, Reco = LRC_Reco, rb = TRC_R_base) %>% 
  select( "TIMESTAMP", "Date", 'EVENT', 'Disturbed', 'TSD',
          "TA","SW_IN", "Amax", 'QY', "rb", 'Reco','NEE', 'Month') 

ts7.sites %>% summary





