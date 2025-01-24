clear all
close all

%code modified Nov 2023, running light reposnse curves on everglades data
%first drafted in spring 2018 for Wyoming bark beetle work, DOI 10.1088/1748-9326/9/10/105004



%Lat, Lon
%US-Skr:    25.3629, -81.0776
%US-TaS:    25.1908, -80.6391



% 
% %linear day calculation
% %leap years: 2004, 2008, 2012, 2016, 2020
% 
% %DOY
 DOY = 1:1/48:(366-(1/48));
 DOY_leap = 1:1/48:(367-(1/48));
% %DOY decimal day
 dec_DOY=DOY./366;
 dec_DOY_leap=DOY_leap./367;
% %continuous linear day variable
  linear_day=[(2004.+dec_DOY_leap),(2005+dec_DOY),(2006+dec_DOY),(2007+dec_DOY),(2008+dec_DOY_leap),(2009+dec_DOY),(2010+dec_DOY),(2011+dec_DOY),(2012+dec_DOY_leap),(2013+dec_DOY),(2014+dec_DOY),(2015+dec_DOY),(2016+dec_DOY_leap),(2017+dec_DOY),(2018+dec_DOY),(2019+dec_DOY),(2020+dec_DOY_leap),(2021+dec_DOY),(2022+dec_DOY),(2023+dec_DOY)]';
% %WOY
% WOY = 1:45;
% dec_WOY=WOY./45;
% %continuous linear day variable
% linear_week=[(2004.+dec_WOY),(2005+dec_WOY),(2006+dec_WOY),(2007+dec_WOY),(2008+dec_WOY),(2009+dec_WOY),(2010+dec_WOY),(2011+dec_WOY),(2012+dec_WOY),(2013+dec_WOY),(2014+dec_WOY),(2015+dec_WOY),(2016+dec_WOY),(2017+dec_WOY),(2018+dec_WOY),(2019+dec_WOY),(2020+dec_WOY),(2021+dec_WOY),(2022+dec_WOY),(2023+dec_WOY)]';
% 






%%%%%%%% creating indexs for disturbance/non-disturbance years %%wet/dry years

wilma_date=datetime(2005,10,15);
irma_date=datetime(2017,08,30);

wilma_linear_day=2005+(288/365);
irma_linear_day=2017+(242/365);



%%% disturbance years 2006, 2007 (years 3 and 4), 2018, 2019 (years 15 and 16)
%Wilma on  Oct 15 2005, index position 82
%year 3 91:135
%year 4 136:180
%Irma on Aug 30 2017, index position 617
%year 15 631:675
%year 16 676:720
index_ds=cat(2,[82:171],[617:706]);

index_ds_minusyr1=cat(2,[37:81],[572:616]);
index_ds_yr1=cat(2,[82:126],[617:661]);
index_ds_yr2=cat(2,[127:171],[662:706]);
index_ds_yr3=cat(2,[172:216],[707:751]);
index_ds_yr4=cat(2,[217:261],[752:796]);

index_ds_yr1_yr4=cat(2,[82:261],[617:796]);

%%%w non disturbance years
%year 1 1:45 
%year 2 46:90 
%year 5 181:225
%year 6 226:270 
%year 7 271:315
%year 8 316:360 ...
%year 17  721:end
index_not_ds=cat(2,[1:81],[172:616],[707:900]);


%%%%% 30 min index
%pre wilma 1:31392
%    wilma 31393:52608
%post wilma, pre irma 52609:239616
%    irma 239617:280512
%post irma 280513:350640
index_ds_30min=cat(2,[31393:52608],[239617:280512]);
index_not_ds_30min=cat(2,[1:31392],[52609:239616],[280513:350640]);


%%% 24 day index  
index_24day_ds=cat(2,[28:57],[206:235]);

index_24day_ds_minusyr1=cat(2,[13:27],[191:205]);
index_24day_ds_yr1=cat(2,[28:42],[206:220]);
index_24day_ds_yr2=cat(2,[43:57],[221:235]); 
index_24day_ds_yr3=cat(2,[58:72],[236:250]); 
index_24day_ds_yr4=cat(2,[73:87],[251:265]); 

index_24day_ds_yr1_yr4=cat(2,[28:87],[206:265]);

index_24day_not_ds=cat(2,[1:27],[88:205],[266:300]);



%creating index for disturbance - 1 year to disturbance + 4 years
wilma_fiveyear_ind = and(SRS6_modis_24day.Date>wilma_date-calendarDuration(1,0,0),SRS6_modis_24day.Date<wilma_date+calendarDuration(4,0,0));
irma_fiveyear_ind = and(SRS6_modis_24day.Date>irma_date-calendarDuration(1,0,0),SRS6_modis_24day.Date<irma_date+calendarDuration(4,0,0));


%creating index for disturbance year to disturbance + 4 years
wilma_fouryear_ind = and(SRS6_modis_24day.Date>wilma_date,SRS6_modis_24day.Date<wilma_date+calendarDuration(4,0,0));
irma_fouryear_ind = and(SRS6_modis_24day.Date>irma_date,SRS6_modis_24day.Date<irma_date+calendarDuration(4,0,0));






%%%%%%%%%%%%%%%%%read in flux data


%SRS6 site
%from site BADM:
%The Florida Everglades Shark River Slough Mangrove Forest site is located along the Shark River in the western region of Everglades National Park. Also referred to as site SRS6 of the Florida Coastal Everglades LTER program, freshwater in the mangrove riverine floods the forest floor under a meter of water twice per day. Transgressive discharge of freshwater from the Shark river follows annual rainfall distributions between the wet and dry seasons. Hurricane Wilma struck the site in October of 2005 causing significant damage. The tower was offline until the following October in order to continue temporally consistent measurements. In post-hurricane conditions, ecosystem respiration rates and solar irradiance transfer increased. 2007- 2008 measurements indicate that these factors led to an decline in both annual -NEE and daily NEE from pre-hurricane conditions in 2004-2005.

%data from 2004-2011
%2004-2005 pre hurricane Wilma
%oct 2005 hurricane Wilma
%2006 offline
%2007-2008 recovery
%2009-2011 stable


%read in data from 2004-2011
one_SRS6_data = readtable('C:\Users\der66\Dropbox (YSE)\Yale\FCE projects\ameriflux data upload\US-Skr_HH_200401010000_201119130000.csv','VariableNamingRule','preserve');

%missing values set to nan
one_SRS6_data = standardizeMissing(one_SRS6_data, -9999);


%read in 2017-2023 data

two_SRS6_data = readtable('C:\Users\der66\Dropbox (YSE)\Yale\FCE projects\ameriflux data upload\US-Skr_HH_201612312230_202312312230.csv','VariableNamingRule','preserve',"TreatAsMissing","NA");
two_SRS6_data = standardizeMissing(two_SRS6_data, -9999);
%plot(new_SRS6_data.TIMESTAMP,new_SRS6_data.ch4_flux,'.k')


%make SRS6 table
SRS6_data = table(linear_day);


%date used
%SRS6_data.Date
SRS6_data.Date=NaN(350640,1);
SRS6_data.Date(1:134976)=one_SRS6_data.TIMESTAMP_START;
SRS6_data.Date(227953:350640)=two_SRS6_data.TIMESTAMP_START;

%SRS6_data.TA
SRS6_data.TA=NaN(350640,1);
SRS6_data.TA(1:134976)=one_SRS6_data.TA_1_1_1;
SRS6_data.TA(227953:350640)=two_SRS6_data.TA_1_1_1;


%SRS6_data.FC
SRS6_data.FC=NaN(350640,1);
SRS6_data.FC(1:134976)=one_SRS6_data.FC;
temp=two_SRS6_data.FC;
%temp(two_SRS6_data.FC_SSITC_TEST==1)=nan;
temp(two_SRS6_data.FC_SSITC_TEST==2)=nan;
SRS6_data.FC(227953:350640)=temp;


%SRS6_data.SC
SRS6_data.SC=NaN(350640,1);
SRS6_data.SC(1:134976)=one_SRS6_data.SC;
temp=two_SRS6_data.SC;
%temp(two_SRS6_data.FC_SSITC_TEST==1)=nan;
temp(two_SRS6_data.FC_SSITC_TEST==2)=nan;
SRS6_data.SC(227953:350640)=temp;

%SRS6_data.NEE
SRS6_data.NEE=SRS6_data.FC+SRS6_data.SC;


%SRS6_data.LE
SRS6_data.LE=NaN(350640,1);
SRS6_data.LE(1:134976)=one_SRS6_data.LE;
SRS6_data.LE(227953:350640)=two_SRS6_data.LE;


%SRS6_data.SW_IN
SRS6_data.SW_IN=NaN(350640,1);
SRS6_data.SW_IN(1:134976)=one_SRS6_data.SW_IN;
SRS6_data.SW_IN(227953:350640)=two_SRS6_data.SW_IN;
SRS6_data.SW_IN(SRS6_data.SW_IN<0)=0;



%%%nan count
%sum(isnan(one_SRS6_data.FC))/(length(one_SRS6_data.FC)-sum(isnan(one_SRS6_data.WS)))
%sum(isnan(two_SRS6_data.FC))/(length(two_SRS6_data.FC))
%compare with WS data to get missing FC data as a percetnage of time that
%the site was running
%(sum(isnan(one_SRS6_data.FC))+sum(isnan(two_SRS6_data.FC)))/(length(one_SRS6_data.FC)+length(two_SRS6_data.FC)-sum(isnan(one_SRS6_data.WS))-sum(isnan(two_SRS6_data.WS)))

clear one_SRS6_data two_SRS6_data temp





% TS7 site
% data from 2016-2023

TS7_data = readtable('C:\Users\der66\Dropbox (YSE)\Yale\FCE projects\ameriflux data upload\US-TaS_HH_201601010000_202401010000.csv','VariableNamingRule','preserve',"TreatAsMissing","NA");
%missing values set to nan
TS7_data = standardizeMissing(TS7_data, -9999);

% cloning data columns to sync names between sites
TS7_data.Date=TS7_data.TIMESTAMP_START;
TS7_data.FC = TS7_data.FC;
TS7_data.SC = TS7_data.SC;
TS7_data.NEE = TS7_data.FC+TS7_data.SC;
TS7_data.SW_IN = TS7_data.SW_IN;
TS7_data.TA = TS7_data.TA_1_1_1;

%continuous linear day variable
TS7_data.linear_day=[(2016+dec_DOY_leap),(2017.+dec_DOY),(2018+dec_DOY),(2019+dec_DOY),(2020+dec_DOY_leap),(2021+dec_DOY),(2022+dec_DOY),(2023+dec_DOY)]';



%%%nan count
%sum(isnan(TS7_data.FC))/(length(TS7_data.FC)-sum(isnan(TS7_data.WS)))

%sum(isnan(TS7_data.FC))/(length(TS7_data.FC)-sum(isnan(TS7_data.WS)))


%sum(isnan(TS7_data.FC(TS7_data.SW_IN>50)))/(length(TS7_data.FC(TS7_data.SW_IN>50))-sum(isnan(TS7_data.WS(TS7_data.SW_IN>50))))
%sum(isnan(TS7_data.FC(TS7_data.SW_IN<50)))/(length(TS7_data.FC(TS7_data.SW_IN<50))-sum(isnan(TS7_data.WS(TS7_data.SW_IN<50))))


%sum(isnan(SRS6_data.FC(SRS6_data.SW_IN>50)))/(length(SRS6_data.FC(SRS6_data.SW_IN>50))-sum(isnan(SRS6_data.LE(SRS6_data.SW_IN>50))))
%sum(isnan(SRS6_data.FC(SRS6_data.SW_IN<50)))/(length(SRS6_data.FC(SRS6_data.SW_IN<50))-sum(isnan(SRS6_data.LE(SRS6_data.SW_IN<50))))



%%%%%%%%%%%%%%%%%read in ERA5 temperature and radiation data
ERA5_data = readtable('C:\Users\der66\Dropbox (YSE)\Yale\FCE projects\Everglades Light Response Curves\ERA5 data\ERA5_data_SRS6_LRC.csv','VariableNamingRule','preserve',"TreatAsMissing","NA");
%%% make datetime variable
%ERA5_data.Time = datetime(compose("%d",ERA5_data.dates),'InputFormat','yyyyMMddHHmm');

ERA5_data = table2timetable(ERA5_data);

%%% start/end dates
start_day = ERA5_data.dates(1);
end_day = ERA5_data.dates(end)+duration(0,30,0);
time_step = duration(0,30,0);
time_array = (start_day:time_step:end_day)';


%%% interplote ERA5 and FLUX data to hourly
ERA5_data_30min = retime(ERA5_data, time_array,'linear');






%%%%%%%%%%%%%%%%%read in MODIS data

%%%SRS6
SRS6_modis = readtable('C:\Users\der66\Dropbox (YSE)\Yale\FCE projects\Everglades Light Response Curves\modis-SRS6\SRS6-LAI-clean.csv','VariableNamingRule','preserve');

%LAI QC screening

temp=SRS6_modis.MCD15A2H_061_Lai_500m;

temp=temp.*not(SRS6_modis.MCD15A2H_061_FparLai_QC_MODLAND);
temp=temp.*not(SRS6_modis.MCD15A2H_061_FparLai_QC_CloudState);
temp=temp.*not(SRS6_modis.MCD15A2H_061_FparExtra_QC_Aerosol);
temp=temp.*not(SRS6_modis.MCD15A2H_061_FparExtra_QC_Cirrus);
temp=temp.*not(SRS6_modis.MCD15A2H_061_FparExtra_QC_Internal_CloudMask);
temp=temp.*not(SRS6_modis.MCD15A2H_061_FparExtra_QC_Cloud_Shadow);
temp = standardizeMissing(temp, 0);

SRS6_modis.LAIqc=temp;
clear temp


%%%TS7
TS7_modis = readtable('C:\Users\der66\Dropbox (YSE)\Yale\FCE projects\Everglades Light Response Curves\modis-TS7\TS7-LAI-clean.csv','VariableNamingRule','preserve');

%LAI QC screening

temp=TS7_modis.MCD15A2H_061_Lai_500m;

temp=temp.*not(TS7_modis.MCD15A2H_061_FparLai_QC_MODLAND);
temp=temp.*not(TS7_modis.MCD15A2H_061_FparLai_QC_CloudState);
temp=temp.*not(TS7_modis.MCD15A2H_061_FparExtra_QC_Aerosol);
temp=temp.*not(TS7_modis.MCD15A2H_061_FparExtra_QC_Cirrus);
temp=temp.*not(TS7_modis.MCD15A2H_061_FparExtra_QC_Internal_CloudMask);
temp=temp.*not(TS7_modis.MCD15A2H_061_FparExtra_QC_Cloud_Shadow);
temp = standardizeMissing(temp, 0);

TS7_modis.LAIqc=temp;
clear temp







%%%%% LAI time aggregation work





%%% aggregate to 24 day period (aggregate 3 8-day points)
TT_SRS6 = table2timetable(table(SRS6_modis.Date,SRS6_modis.LAIqc,'VariableNames',["Date","LAIqc"]));
TT_TS7 = table2timetable(table(TS7_modis.Date,TS7_modis.LAIqc,'VariableNames',["Date","LAIqc"]));

%%%%%% Interpolate 8-day LAI
SRS6_modis_8day = synchronize(TT_SRS6,SRS6_modis.Date,'linear');
TS7_modis_8day = synchronize(TT_TS7,TS7_modis.Date,'linear');


clear newTimes i

num_years = 20;%2004-2023
for i = 1:num_years
    newTimes(i,:) = datetime((2004+i-1),1,1) + days((0:14)*24);
end

newTimes = reshape(newTimes',[(15*num_years),1]);

%TT4 = synchronize(TT,newTimes,@nanmean);
SRS6_modis_24day = synchronize(TT_SRS6,newTimes,@nanmax); %using max LAI over agregating time period
TS7_modis_24day = synchronize(TT_TS7,newTimes,@nanmax); %using max LAI over agregating time period

%%%%%% Interpolate 24-day LAI
SRS6_modis_24day = synchronize(SRS6_modis_24day,newTimes,'linear'); %fill missing values with linear interpolation 
TS7_modis_24day = synchronize(TT_TS7,newTimes,'linear'); %fill missing values with linear interpolation 


clear newTimes i


%%% aggregate to 40 day period (aggregate 5 8-day points)

num_years = 20;%2004-2023
for i = 1:num_years
    newTimes(i,:) = datetime((2004+i-1),1,1) + days((0:8)*40);
end

newTimes = reshape(newTimes',[(9*num_years),1]);

%TT4 = synchronize(TT,newTimes,@nanmean);
SRS6_modis_40day = synchronize(TT_SRS6,newTimes,@nanmax); %using max LAI over agregating time period
TS7_modis_40day = synchronize(TT_TS7,newTimes,@nanmax); %using max LAI over agregating time period

clear newTimes i TT_SRS6 TT_TS7





%%%%%%%%%%%%%%%%%read in ENP LAI data, make histogram plot from spatial LAI data


ENP_LAI = readtable('C:\Users\der66\Dropbox (YSE)\Yale\FCE projects\Everglades Light Response Curves\LAI_Table_SCv2.csv','VariableNamingRule','preserve');
%scale factor of 0.1 for LAI data
%values 246-255 are fill values

%min and max valuesa are min-max of histogram bins





%%%%%% unit converstions
%convert LE from energy units (W/m-2) to water units (mmole m-2 s-1)
%latent heat of vapouraztion 40.8 KJ/mol
SRS6_data.FV=SRS6_data.LE./40.8;
TS7_data.FV=TS7_data.LE./40.8;




%filter NEE to a range of -100 to 100
SRS6_data.NEE(SRS6_data.NEE>100) = NaN;
SRS6_data.NEE(SRS6_data.NEE<-100) = NaN;

TS7_data.NEE(TS7_data.NEE>100) = NaN;
TS7_data.NEE(TS7_data.NEE<-100) = NaN;



%%%%%% select nighttime NEE data
SRS6_data.NEE_night = SRS6_data.NEE;
SRS6_data.NEE_night(SRS6_data.SW_IN>50) = NaN;

TS7_data.NEE_night = TS7_data.NEE;
TS7_data.NEE_night(TS7_data.SW_IN>50) = NaN;



%%%%%% select daytime NEE data
SRS6_data.NEE_day = SRS6_data.NEE;
SRS6_data.NEE_day(SRS6_data.SW_IN<50) = NaN;

TS7_data.NEE_day = TS7_data.NEE;
TS7_data.NEE_day(TS7_data.SW_IN<50) = NaN;



