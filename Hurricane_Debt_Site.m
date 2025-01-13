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



%read in NSRDB data
NSRDB_data = readtable('C:\Users\der66\Dropbox (YSE)\Yale\FCE projects\Everglades Light Response Curves\NSRDB data at SRS6\1040659_25.37_-81.06_1998_2022.csv','VariableNamingRule','preserve',"TreatAsMissing","NA","NumHeaderLines",2);

%%%% wrangling time
NSRDB_data.TimeStart = datetime(NSRDB_data.Year,NSRDB_data.Month,NSRDB_data.Day,NSRDB_data.Hour,NSRDB_data.Minute,0);
NSRDB_data.TimeStart.Format='yyyyMMddHHmm';





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






%move data into weekly groups (8-day groups to match MODIS data)
%using linear_day as a manual check here
year_len=17520;
year_len_lp=17520+48;




%get NSRDB data into 2004-end format
%NSRDB_data.TimeStart(NSRDB_data.TimeStart>datetime(2004,0,0))
%NSRDB_data.GHI(NSRDB_data.TimeStart>datetime(2004,0,0))
NSRDB_data_2004_end = NSRDB_data.GHI(NSRDB_data.TimeStart>datetime(2004,0,0));
%missing data in 2023
NSRDB_data_2004_end(334416:350256) = nan;





% multiple time series aggregations for flux data


%%%% 8 day aggregation
%%%%%%% SRS6 site, 2004-2023
year_count=0;
year_count_lp=0;
for num_year=1:20   

    x=1+year_len_lp*year_count_lp+year_len*year_count;
    for i=1:45   %45 8-day groups (weeks) in each year
        for j=1:384   %time series along group i (384 30-min data in eight days)
            %SRS6_8day_VPD(i+45*(num_year-1),j) = SRS6_data.VPD_PI(x);
            %SRS6_8day_NetRad(i+45*(num_year-1),j) = SRS6_data.NETRAD(x);
            SRS6_8day_TA(i+45*(num_year-1),j) = SRS6_data.TA(x);
            SRS6_8day_Fc(i+45*(num_year-1),j) = SRS6_data.NEE(x);
            SRS6_8day_NEE_day(i+45*(num_year-1),j) = SRS6_data.NEE_day(x);
            SRS6_8day_NEE_night(i+45*(num_year-1),j) = SRS6_data.NEE_night(x);
            SRS6_8day_Fv(i+45*(num_year-1),j) = SRS6_data.FV(x);
            SRS6_8day_SolarIn(i+45*(num_year-1),j) = SRS6_data.SW_IN(x);
            SRS6_8day_linear_day(i+45*(num_year-1),j) = SRS6_data.linear_day(x);
            SRS6_8day_NSRDB_data(i+45*(num_year-1),j) = NSRDB_data_2004_end(x);
            SRS6_8day_NSRDB_data(i+45*(num_year-1),j) = NSRDB_data_2004_end(x);
            %SRS6_8day_LRCmodel_NEP(i+45*(num_year-1),j) = SRS6_LRCmodel_NEP(x);
            x=x+1;
        end
    end

    %need to decide if each year is a leap year or not, then add to correct
    %counter
    if num_year == 1 | num_year ==5
        year_count_lp=year_count_lp+1;
    else
        year_count=year_count+1;
    end


end
clear x


%%%%%%% TS7 site, 2016-2023
year_count=0;
year_count_lp=0;
for num_year=1:8   

    x=1+year_len_lp*year_count_lp+year_len*year_count;
    for i=1:45   %45 8-day groups (weeks) in each year
        for j=1:384   %time series along group i (384 30-min data in eight days)
            %TS7_8day_VPD(i+45*(num_year-1),j) = TS7_data.VPD_PI(x);
            %TS7_8day_NetRad(i+45*(num_year-1),j) = TS7_data.NETRAD(x);
            TS7_8day_TA(i+45*(num_year-1),j) = TS7_data.TA(x);
            TS7_8day_Fc(i+45*(num_year-1),j) = TS7_data.NEE(x);
            TS7_8day_NEE_day(i+45*(num_year-1),j) = TS7_data.NEE_day(x);
            TS7_8day_NEE_night(i+45*(num_year-1),j) = TS7_data.NEE_night(x);
            TS7_8day_Fv(i+45*(num_year-1),j) = TS7_data.FV(x);
            TS7_8day_SolarIn(i+45*(num_year-1),j) = TS7_data.SW_IN(x);
            TS7_8day_linear_day(i+45*(num_year-1),j) = TS7_data.linear_day(x);
            %TS7_8day_LRCmodel_NEP(i+45*(num_year-1),j) = TS7_LRCmodel_NEP(x);
            x=x+1;
        end
    end

    %need to decide if each year is a leap year or not, then add to correct
    %counter
    if num_year == 1 |num_year == 4 | num_year == 8
        year_count_lp=year_count_lp+1;
    else
        year_count=year_count+1;
    end


end
clear x

%%%% get TS7 back into same timeframe as SRS6
TS7_8day_Fc_filled = nan(900,384);
TS7_8day_NEE_day_filled = nan(900,384);
TS7_8day_NEE_night_filled = nan(900,384);
TS7_8day_TA_filled = nan(900,384);
%TS7_8day_LRCmodel_NEP_filled = nan(900,384);

TS7_8day_Fc_filled(541:900,:) = TS7_8day_Fc;
TS7_8day_NEE_day_filled(541:900,:) = TS7_8day_NEE_day;
TS7_8day_NEE_night_filled(541:900,:) = TS7_8day_NEE_night;
TS7_8day_TA_filled(541:900,:) = TS7_8day_TA;
%TS7_8day_LRCmodel_NEP_filled(541:900,:) = TS7_8day_LRCmodel_NEP;




%%%% 24 day aggregation
%%%%%%% SRS6 site, 2004-2023
year_count=0;
year_count_lp=0;
for num_year=1:20   

    x=1+year_len_lp*year_count_lp+year_len*year_count;
    for i=1:15   %15 24-day groups (weeks) in each year
        for j=1:1152   %time series along group i (1152 30-min data in 24 days)
            %SRS6_24day_VPD(i+15*(num_year-1),j) = SRS6_data.VPD_PI(x);
            %SRS6_24day_NetRad(i+15*(num_year-1),j) = SRS6_data.NETRAD(x);
            SRS6_24day_TA(i+15*(num_year-1),j) = SRS6_data.TA(x);
            SRS6_24day_Fc(i+15*(num_year-1),j) = SRS6_data.NEE(x);
            SRS6_24day_NEE_day(i+15*(num_year-1),j) = SRS6_data.NEE_day(x);
            SRS6_24day_NEE_night(i+15*(num_year-1),j) = SRS6_data.NEE_night(x);
            SRS6_24day_Fv(i+15*(num_year-1),j) = SRS6_data.FV(x);
            SRS6_24day_SolarIn(i+15*(num_year-1),j) = SRS6_data.SW_IN(x);
            SRS6_24day_linear_day(i+15*(num_year-1),j) = SRS6_data.linear_day(x);
            SRS6_24day_NSRDB_data(i+15*(num_year-1),j) = NSRDB_data_2004_end(x);
            SRS6_24day_ERA5_TA(i+15*(num_year-1),j) = ERA5_data_30min.ERA5_2T(x);
            SRS6_24day_ERA5_SW(i+15*(num_year-1),j) = ERA5_data_30min.ERA5_SW_IN(x);
            %SRS6_8day_LRCmodel_NEP(i+15*(num_year-1),j) = SRS6_LRCmodel_NEP(x);
            x=x+1;
        end
    end

    %need to decide if each year is a leap year or not, then add to correct
    %counter
    if num_year == 1 | num_year ==5
        year_count_lp=year_count_lp+1;
    else
        year_count=year_count+1;
    end


end
clear x


%%%%%%% TS7 site, 2016-2023
year_count=0;
year_count_lp=0;
for num_year=1:8   

    x=1+year_len_lp*year_count_lp+year_len*year_count;
    for i=1:15   %15 24-day groups (weeks) in each year
        for j=1:1152   %time series along group i (1152 30-min data in 24 days)
            %TS7_24day_VPD(i+15*(num_year-1),j) = TS7_data.VPD_PI(x);
            %TS7_24day_NetRad(i+41*(num_year-1),j) = TS7_data.NETRAD(x);
            TS7_24day_TA(i+15*(num_year-1),j) = TS7_data.TA(x);
            TS7_24day_Fc(i+15*(num_year-1),j) = TS7_data.NEE(x);
            TS7_24day_NEE_day(i+15*(num_year-1),j) = TS7_data.NEE_day(x);
            TS7_24day_NEE_night(i+15*(num_year-1),j) = TS7_data.NEE_night(x);
            TS7_24day_Fv(i+15*(num_year-1),j) = TS7_data.FV(x);
            TS7_24day_SolarIn(i+15*(num_year-1),j) = TS7_data.SW_IN(x);
            TS7_24day_linear_day(i+15*(num_year-1),j) = TS7_data.linear_day(x);
            %TS7_24day_LRCmodel_NEP(i+15*(num_year-1),j) = TS7_LRCmodel_NEP(x);
            x=x+1;
        end
    end

    %need to decide if each year is a leap year or not, then add to correct
    %counter
    if num_year == 1 |num_year == 4 | num_year == 8
        year_count_lp=year_count_lp+1;
    else
        year_count=year_count+1;
    end


end
clear x

%%%% get TS7 back into same timeframe as SRS6
TS7_24day_Fc_filled = nan(300,1152);
TS7_24day_NEE_day_filled = nan(300,1152);
TS7_24day_NEE_night_filled = nan(300,1152);
TS7_24day_TA_filled = nan(300,1152);
%TS7_24day_LRCmodel_NEP_filled = nan(300,1152);

TS7_24day_Fc_filled(181:300,:) = TS7_24day_Fc; %8/20 years, 300-(.4*300)
TS7_24day_NEE_day_filled(181:300,:) = TS7_24day_NEE_day; %8/20 years, 300-(.4*300)
TS7_24day_NEE_night_filled(181:300,:) = TS7_24day_NEE_night; %8/20 years, 300-(.4*300)
TS7_24day_TA_filled(181:300,:) = TS7_24day_TA; %8/20 years, 300-(.4*300)
%TS7_24day_LRCmodel_NEP_filled(541:900,:) = TS7_8day_LRCmodel_NEP;



%%%% 40 day aggregation
%%%%%%% SRS6 site, 2004-2023
year_count=0;
year_count_lp=0;
for num_year=1:20   

    x=1+year_len_lp*year_count_lp+year_len*year_count;
    for i=1:9   %9 40-day groups (weeks) in each year
        for j=1:1920   %time series along group i (1920 30-min data in 40 days)
            %SRS6_40day_VPD(i+9*(num_year-1),j) = SRS6_data.VPD_PI(x);
            %SRS6_40day_NetRad(i+9*(num_year-1),j) = SRS6_data.NETRAD(x);
            SRS6_40day_TA(i+9*(num_year-1),j) = SRS6_data.TA(x);
            SRS6_40day_Fc(i+9*(num_year-1),j) = SRS6_data.NEE(x);
            SRS6_40day_NEE_day(i+9*(num_year-1),j) = SRS6_data.NEE_day(x);
            SRS6_40day_NEE_night(i+9*(num_year-1),j) = SRS6_data.NEE_night(x);
            SRS6_40day_Fv(i+9*(num_year-1),j) = SRS6_data.FV(x);
            SRS6_40day_SolarIn(i+9*(num_year-1),j) = SRS6_data.SW_IN(x);
            SRS6_40day_linear_day(i+9*(num_year-1),j) = SRS6_data.linear_day(x);
            SRS6_40day_NSRDB_data(i+9*(num_year-1),j) = NSRDB_data_2004_end(x);
            SRS6_40day_NSRDB_data(i+9*(num_year-1),j) = NSRDB_data_2004_end(x);
            %SRS6_40day_LRCmodel_NEP(i+9*(num_year-1),j) = SRS6_LRCmodel_NEP(x);
            x=x+1;
        end
    end

    %need to decide if each year is a leap year or not, then add to correct
    %counter
    if num_year == 1 | num_year ==5
        year_count_lp=year_count_lp+1;
    else
        year_count=year_count+1;
    end


end
clear x


%%%%%%% TS7 site, 2016-2023
year_count=0;
year_count_lp=0;
for num_year=1:8   

    x=1+year_len_lp*year_count_lp+year_len*year_count;
    for i=1:9   %9 40-day groups (weeks) in each year
        for j=1:1920   %time series along group i (1920 30-min data in 40 days)
            %TS7_40day_VPD(i+9*(num_year-1),j) = TS7_data.VPD_PI(x);
            %TS7_40day_NetRad(i+9*(num_year-1),j) = TS7_data.NETRAD(x);
            TS7_40day_TA(i+9*(num_year-1),j) = TS7_data.TA(x);
            TS7_40day_Fc(i+9*(num_year-1),j) = TS7_data.NEE(x);
            TS7_40day_NEE_day(i+9*(num_year-1),j) = TS7_data.NEE_day(x);
            TS7_40day_NEE_night(i+9*(num_year-1),j) = TS7_data.NEE_night(x);
            TS7_40day_Fv(i+9*(num_year-1),j) = TS7_data.FV(x);
            TS7_40day_SolarIn(i+9*(num_year-1),j) = TS7_data.SW_IN(x);
            TS7_40day_linear_day(i+9*(num_year-1),j) = TS7_data.linear_day(x);
            %TS7_40day_LRCmodel_NEP(i+9*(num_year-1),j) = TS7_LRCmodel_NEP(x);
            x=x+1;
        end
    end

    %need to decide if each year is a leap year or not, then add to correct
    %counter
    if num_year == 1 |num_year == 4 | num_year == 8
        year_count_lp=year_count_lp+1;
    else
        year_count=year_count+1;
    end


end
clear x

%%%% get TS7 back into same timeframe as SRS6
TS7_40day_Fc_filled = nan(180,1920);
TS7_40day_NEE_day_filled = nan(180,1920);
TS7_40day_NEE_night_filled = nan(180,1920);
TS7_40day_TA_filled = nan(180,1920);
%TS7_8day_LRCmodel_NEP_filled = nan(900,384);

TS7_40day_Fc_filled(109:180,:) = TS7_40day_Fc; %8/20 years, 180-(.4*180)
TS7_40day_NEE_day_filled(109:180,:) = TS7_40day_NEE_day; %8/20 years, 180-(.4*180)
TS7_40day_NEE_night_filled(109:180,:) = TS7_40day_NEE_night; %8/20 years, 180-(.4*180)
TS7_40day_TA_filled(109:180,:) = TS7_40day_TA; %8/20 years, 180-(.4*180)
%TS7_8day_LRCmodel_NEP_filled(541:900,:) = TS7_8day_LRCmodel_NEP;









%%%% make daily average for SW_In, NSRDB, and NEE data over 8-day period
%%%% then
%%%% make 8-day average using daily average for SW_In, NSRDB, and NEE data
for i=1:900
    for j=1:48  
        SRS6_8day_SolarIn_dayave(i,j) = mean(SRS6_8day_SolarIn(i,j:48:384),'omitnan');
        SRS6_8day_NSRDB_data_dayave(i,j) = mean(SRS6_8day_NSRDB_data(i,j:48:384),'omitnan');
        SRS6_8day_NEE_dayave(i,j) = mean(SRS6_8day_Fc(i,j:48:384),'omitnan');
        SRS6_8day_NEE_day_dayave(i,j) = mean(SRS6_8day_NEE_day(i,j:48:384),'omitnan');
        SRS6_8day_NEE_night_dayave(i,j) = mean(SRS6_8day_NEE_night(i,j:48:384),'omitnan');
        SRS6_8day_TA_dayave(i,j) = mean(SRS6_8day_TA(i,j:48:384),'omitnan');
        %SRS6_8day_LRCmodel_NEP_dayave(i,j) = mean(SRS6_8day_LRCmodel_NEP(i,j:48:384),'omitnan');

        TS7_8day_NEE_dayave(i,j) = mean(TS7_8day_Fc_filled(i,j:48:384),'omitnan');
        TS7_8day_NEE_day_dayave(i,j) = mean(TS7_8day_NEE_day_filled(i,j:48:384),'omitnan');
        TS7_8day_NEE_night_dayave(i,j) = mean(TS7_8day_NEE_night_filled(i,j:48:384),'omitnan');
        %TS7_8day_LRCmodel_NEP_dayave(i,j) = mean(TS7_8day_LRCmodel_NEP_filled(i,j:48:384),'omitnan');
    end
    SRS6_8day_SolarIn_dailyave(i) = mean(SRS6_8day_SolarIn_dayave(i,:),'omitnan');
    SRS6_8day_NSRDB_data_dailyave(i) = mean(SRS6_8day_NSRDB_data_dayave(i,:),'omitnan');
    SRS6_8day_NEE_dailyave(i) = mean(SRS6_8day_NEE_dayave(i,:),'omitnan');
    SRS6_8day_NEE_day_dailyave(i) = mean(SRS6_8day_NEE_day_dayave(i,:),'omitnan');
    SRS6_8day_NEE_night_dailyave(i) = mean(SRS6_8day_NEE_night_dayave(i,:),'omitnan');
    SRS6_8day_TA_dailyave(i) = mean(SRS6_8day_TA_dayave(i,:),'omitnan');
    %SRS6_8day_LRCmodel_NEP_dailyave(i) = mean(SRS6_8day_LRCmodel_NEP_dayave(i,:),'omitnan');

    TS7_8day_NEE_dailyave(i) = mean(TS7_8day_NEE_dayave(i,:),'omitnan');
    TS7_8day_NEE_day_dailyave(i) = mean(TS7_8day_NEE_day_dayave(i,:),'omitnan');
    TS7_8day_NEE_night_dailyave(i) = mean(TS7_8day_NEE_night_dayave(i,:),'omitnan');
    %TS7_8day_LRCmodel_NEP_dailyave(i) = mean(TS7_8day_LRCmodel_NEP_dayave(i,:),'omitnan');
end


clear i j SRS6_8day_SolarIn_dayave SRS6_8day_NSRDB_data_dayav SRS6_8day_NEE_dayave SRS6_8day_NEE_day_dayave SRS6_8day_NEE_night_dayave SRS6_8day_LRCmodel_NEP_dayave TS7_8day_NEE_dayave TS7_8day_NEE_day_dayave TS7_8day_NEE_night_dayave TS7_8day_LRCmodel_NEP_dayave




%%%% make daily average for SW_In, NSRDB, and NEE data over 24-day period
%%%% then
%%%% make 8-day average using daily average for SW_In, NSRDB, and NEE data
for i=1:300
    for j=1:48  
        SRS6_24day_SolarIn_dayave(i,j) = mean(SRS6_24day_SolarIn(i,j:48:1152),'omitnan');
        SRS6_24day_NSRDB_data_dayave(i,j) = mean(SRS6_24day_NSRDB_data(i,j:48:1152),'omitnan');
        SRS6_24day_NEE_dayave(i,j) = mean(SRS6_24day_Fc(i,j:48:1152),'omitnan');
        SRS6_24day_NEE_day_dayave(i,j) = mean(SRS6_24day_NEE_day(i,j:48:1152),'omitnan');
        SRS6_24day_NEE_night_dayave(i,j) = mean(SRS6_24day_NEE_night(i,j:48:1152),'omitnan');
        SRS6_24day_TA_dayave(i,j) = mean(SRS6_24day_TA(i,j:48:1152),'omitnan');
        SRS6_24day_ERA5_TA_dayave(i,j) = mean(SRS6_24day_ERA5_TA(i,j:48:1152),'omitnan');
        SRS6_24day_ERA5_SW_dayave(i,j) = mean(SRS6_24day_ERA5_SW(i,j:48:1152),'omitnan');
        %SRS6_24day_LRCmodel_NEP_dayave(i,j) = mean(SRS6_8day_LRCmodel_NEP(i,j:48:1152),'omitnan');

        TS7_24day_TA_dayave(i,j) = mean(TS7_24day_TA_filled(i,j:48:1152),'omitnan');
        TS7_24day_NEE_dayave(i,j) = mean(TS7_24day_Fc_filled(i,j:48:1152),'omitnan');
        TS7_24day_NEE_day_dayave(i,j) = mean(TS7_24day_NEE_day_filled(i,j:48:1152),'omitnan');
        TS7_24day_NEE_night_dayave(i,j) = mean(TS7_24day_NEE_night_filled(i,j:48:1152),'omitnan');
        %TS7_24day_LRCmodel_NEP_dayave(i,j) = mean(TS7_24day_LRCmodel_NEP_filled(i,j:48:1152),'omitnan');
    end
    SRS6_24day_SolarIn_dailyave(i) = mean(SRS6_24day_SolarIn_dayave(i,:),'omitnan');
    SRS6_24day_NSRDB_data_dailyave(i) = mean(SRS6_24day_NSRDB_data_dayave(i,:),'omitnan');
    SRS6_24day_NEE_dailyave(i) = mean(SRS6_24day_NEE_dayave(i,:),'omitnan');
    SRS6_24day_NEE_day_dailyave(i) = mean(SRS6_24day_NEE_day_dayave(i,:),'omitnan');
    SRS6_24day_NEE_night_dailyave(i) = mean(SRS6_24day_NEE_night_dayave(i,:),'omitnan');
    SRS6_24day_TA_dailyave(i) = mean(SRS6_24day_TA_dayave(i,:),'omitnan');
    SRS6_24day_ERA5_TA_dailyave(i) = mean(SRS6_24day_ERA5_TA_dayave(i,:),'omitnan');
    SRS6_24day_ERA5_TSW_dailyave(i) = mean(SRS6_24day_ERA5_SW_dayave(i,:),'omitnan');
    %SRS6_24day_LRCmodel_NEP_dailyave(i) = mean(SRS6_24day_LRCmodel_NEP_dayave(i,:),'omitnan');

    TS7_24day_TA_dailyave(i) = mean(TS7_24day_TA_dayave(i,:),'omitnan');
    TS7_24day_NEE_dailyave(i) = mean(TS7_24day_NEE_dayave(i,:),'omitnan');
    TS7_24day_NEE_day_dailyave(i) = mean(TS7_24day_NEE_day_dayave(i,:),'omitnan');
    TS7_24day_NEE_day_dailyave(i) = mean(TS7_24day_NEE_night_dayave(i,:),'omitnan');
    %TS7_24day_LRCmodel_NEP_dailyave(i) = mean(TS7_24day_LRCmodel_NEP_dayave(i,:),'omitnan');
end


clear i j SRS6_24day_SolarIn_dayave SRS6_24day_NSRDB_data_dayav SRS6_24day_NEE_dayave SRS6_24day_NEE_day_dayave SRS6_24day_NEE_night_dayave SRS6_24day_LRCmodel_NEP_dayave TS7_24day_NEE_dayave TS7_24day_NEE_day_dayave TS7_24day_NEE_night_dayave TS7_24day_LRCmodel_NEP_dayave
clear TS7_24day_TA_dayave SRS6_24day_ERA5_TA_dayave SRS6_24day_ERA5_SW_dayave






%%%%%%%%%%%%%%%%%%%%% run MM model

% MM NEP paraments
%beta =
%Rd(1)
%_gl(2)
%Amax(3)


%%%%%%%%%% 8 day aggregation
%%%%%%% SRS6 site

SRS6_8day_beta_MM=NaN(900,3); %number of weeks in dataset

for i=1:900   %loop over all weeks
    
    %using solar_in for light response curve (net rad goofs up Reco)
    
    if sum(isnan(SRS6_8day_SolarIn(i,:))) > 150 || sum(isnan(SRS6_8day_NEE_day(i,:))) > 300   %300 is ~40 % (48*8*.4*2(for day data)) 
        SRS6_8day_beta_MM(i,:)=NaN;
    else
        [SRS6_8day_beta_MM(i,:),a,b] = Light_Response_Function(SRS6_8day_SolarIn(i,:),SRS6_8day_NEE_day(i,:));
    end
        
end



%%%%%%% TS7 site

TS7_8day_beta_MM=NaN(900,3); % 360 number of weeks in dataset

for i=541:900   %for i=1:315   %loop over all weeks  %540 is last 8 yr at ts7 /20 yr total, 900-(.4*900)
    
    %using solar_in for light response curve (net rad goofs up Reco)
    
    if sum(isnan(TS7_8day_SolarIn(i-540,:))) > 150 || sum(isnan(TS7_8day_NEE_day(i-540,:))) > 300  %300 is ~40 % (48*8*.4*2(for day data)) 
        TS7_8day_beta_MM(i,:)=NaN;
    else
        [TS7_8day_beta_MM(i,:),a,b] = Light_Response_Function(TS7_8day_SolarIn(i-540,:),TS7_8day_NEE_day(i-540,:));  %540 is last 8 yr at ts7 /20 yr total, 900-(.4*900)
    end
    
end




%%%%%%%%%% 24 day aggregation
%%%%%%% SRS6 site

SRS6_24day_beta_MM=NaN(300,3); %number of weeks in dataset

for i=1:300   %loop over all weeks
    
    %using solar_in for light response curve (net rad goofs up Reco)
    
    if sum(isnan(SRS6_24day_SolarIn(i,:))) > 960 || sum(isnan(SRS6_24day_NEE_day(i,:))) > 960   %(48*24-4*48)*2 needs at least four days of data
        SRS6_24day_beta_MM(i,:)=NaN;
    else
        [SRS6_24day_beta_MM(i,:),a,b] = Light_Response_Function(SRS6_24day_SolarIn(i,:),SRS6_24day_NEE_day(i,:));
    end
        
end



%%%%%%% TS7 site

TS7_24day_beta_MM=NaN(300,3); % 360 number of weeks in dataset

for i=181:300   %for i=1:315   %loop over all weeks  %180 is last 8 yr at ts7 /20 yr total, 300-(.4*300)
    
    %using solar_in for light response curve (net rad goofs up Reco)
    
    if sum(isnan(TS7_24day_SolarIn(i-180,:))) > 960 || sum(isnan(TS7_24day_NEE_day(i-180,:))) > 960   %(48*24-4*48)*2 needs at least four days of data
        TS7_24day_beta_MM(i,:)=NaN;
    else
        [TS7_24day_beta_MM(i,:),a,b] = Light_Response_Function(TS7_24day_SolarIn(i-180,:),TS7_24day_NEE_day(i-180,:));  %180 is last 8 yr at ts7 /20 yr total, 300-(.4*300)
    end
    
end




%%%%%%%%%% 40 day aggregation
%%%%%%% SRS6 site

SRS6_40day_beta_MM=NaN(180,3); %number of weeks in dataset

for i=1:180   %loop over all weeks
    
    %using solar_in for light response curve (net rad goofs up Reco)
    
    if sum(isnan(SRS6_40day_SolarIn(i,:))) > 1728 || sum(isnan(SRS6_40day_NEE_day(i,:))) > 1728   %(48*40-4*48)*2
        SRS6_40day_beta_MM(i,:)=NaN;
    else
        [SRS6_40day_beta_MM(i,:),a,b] = Light_Response_Function(SRS6_40day_SolarIn(i,:),SRS6_40day_NEE_day(i,:));
    end
        
end



%%%%%%% TS7 site

TS7_40day_beta_MM=NaN(180,3); % 360 number of weeks in dataset

for i=109:180   %for i=1:315   %loop over all weeks  %180 is last 8 yr at ts7 /20 yr total, 180-(.4*180)
    
    %using solar_in for light response curve (net rad goofs up Reco)
    
    if sum(isnan(TS7_40day_SolarIn(i-108,:))) > 1728 || sum(isnan(TS7_40day_NEE_day(i-108,:))) > 1728   %(48*40-4*48)*2
        TS7_40day_beta_MM(i,:)=NaN;
    else
        [TS7_40day_beta_MM(i,:),a,b] = Light_Response_Function(TS7_40day_SolarIn(i-108,:),TS7_40day_NEE_day(i-108,:));  %180 is last 8 yr at ts7 /20 yr total, 180-(.4*180)
    end
    
end




%%%%%%%%%%%%%%%%%%%%% run TRC model
% TRC NEP paraments
%beta =
%rb(1)
%E0(2)



%%%%%%% SRS6 site

SRS6_24day_beta_TRC=NaN(300,2); %number of weeks in dataset

for i=1:300   %loop over all weeks
    
    
    if sum(isnan(SRS6_24day_TA(i,:))) > 960 || sum(isnan(SRS6_24day_NEE_night(i,:))) > 960
        SRS6_24day_beta_TRC(i,:)=NaN;
    else
        [SRS6_24day_beta_TRC(i,:),a,b] = Temp_Response_Function(SRS6_24day_TA(i,:),SRS6_24day_NEE_night(i,:));
    end 
end


%%%%%%% TS7 site

TS7_24day_beta_TRC=NaN(300,2); % 360 number of weeks in dataset

for i=181:300   %for i=1:315   %loop over all weeks
    
    if sum(isnan(TS7_24day_TA(i-180,:))) > 960 || sum(isnan(TS7_24day_NEE_night(i-180,:))) > 960
        TS7_24day_beta_TRC(i,:)=NaN;
    else
        [TS7_24day_beta_TRC(i,:),a,b] = Temp_Response_Function(TS7_24day_TA(i-180,:),TS7_24day_NEE_night(i-180,:));
    end
end












%LAI stats
%mean(SRS6_modis.LAIqc,"omitnan")
%std(SRS6_modis.LAIqc,"omitnan")/sqrt(length(SRS6_modis.LAIqc))
%mean(TS7_modis.LAIqc,"omitnan")
%std(TS7_modis.LAIqc,"omitnan")/sqrt(length(TS7_modis.LAIqc))


mean(SRS6_8day_beta_MM(:,1),"omitnan")
std(SRS6_8day_beta_MM(:,1),"omitnan")/sqrt(length(SRS6_8day_beta_MM(:,1)))

mean(SRS6_8day_beta_MM(:,2),"omitnan")
std(SRS6_8day_beta_MM(:,2),"omitnan")/sqrt(length(SRS6_8day_beta_MM(:,2)))

mean(SRS6_8day_beta_MM(:,3),"omitnan")
std(SRS6_8day_beta_MM(:,3),"omitnan")/sqrt(length(SRS6_8day_beta_MM(:,3)))


mean(TS7_8day_beta_MM(:,1),"omitnan")
std(TS7_8day_beta_MM(:,1),"omitnan")/sqrt(length(TS7_8day_beta_MM(:,1)))

mean(TS7_8day_beta_MM(:,2),"omitnan")
std(TS7_8day_beta_MM(:,2),"omitnan")/sqrt(length(TS7_8day_beta_MM(:,2)))

mean(TS7_8day_beta_MM(:,3),"omitnan")
std(TS7_8day_beta_MM(:,3),"omitnan")/sqrt(length(TS7_8day_beta_MM(:,3)))


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






%%%%%%%%%%%%%%%% LRC parameters models

%core model variables

ecosystem_LAI_8day = cat(1,TS7_modis.LAIqc,SRS6_modis.LAIqc);
ecosystem_MM_1_8day = cat(1,TS7_8day_beta_MM(:,1),SRS6_8day_beta_MM(:,1));
ecosystem_MM_2_8day = cat(1,TS7_8day_beta_MM(:,2),SRS6_8day_beta_MM(:,2));
ecosystem_MM_3_8day = cat(1,TS7_8day_beta_MM(:,3),SRS6_8day_beta_MM(:,3));
ecosystem_TA_8day = cat(1,mean(TS7_8day_TA_filled,2,'omitnan'),mean(SRS6_8day_TA,2,'omitnan'));

ecosystem_LAI_24day = cat(1,TS7_modis_24day.LAIqc,SRS6_modis_24day.LAIqc);
ecosystem_MM_1_24day = cat(1,TS7_24day_beta_MM(:,1),SRS6_24day_beta_MM(:,1));
ecosystem_MM_2_24day = cat(1,TS7_24day_beta_MM(:,2),SRS6_24day_beta_MM(:,2));
ecosystem_MM_3_24day = cat(1,TS7_24day_beta_MM(:,3),SRS6_24day_beta_MM(:,3));
ecosystem_TA_24day = cat(1,mean(TS7_24day_TA_filled,2,'omitnan'),mean(SRS6_24day_TA,2,'omitnan'));

ecosystem_LAI_40day = cat(1,TS7_modis_40day.LAIqc,SRS6_modis_40day.LAIqc);
ecosystem_MM_1_40day = cat(1,TS7_40day_beta_MM(:,1),SRS6_40day_beta_MM(:,1));
ecosystem_MM_2_40day = cat(1,TS7_40day_beta_MM(:,2),SRS6_40day_beta_MM(:,2));
ecosystem_MM_3_40day = cat(1,TS7_40day_beta_MM(:,3),SRS6_40day_beta_MM(:,3));
ecosystem_TA_40day = cat(1,mean(TS7_40day_TA_filled,2,'omitnan'),mean(SRS6_40day_TA,2,'omitnan'));



%making dummy var for year

time_since_dis_facter_8day = zeros(1800,1);   % ds on index 82 and 617
time_since_dis_facter_8day(82:(81+(45*4)))=1:(45*4);
time_since_dis_facter_8day(617:(616+(45*4)))=1:(45*4);
time_since_dis_facter_8day((82+900):((81+900)+(45*4)))=1:(45*4);
time_since_dis_facter_8day((617+900):((616+900)+(45*4)))=1:(45*4);

time_since_dis_facter_24day = zeros(600,1); % ds on index 28 and 206
time_since_dis_facter_24day(28:(27+(15*4)))=1:(15*4);
time_since_dis_facter_24day(206:(205+(15*4)))=1:(15*4);
time_since_dis_facter_24day((28+300):((27+300)+(15*4)))=1:(15*4);
time_since_dis_facter_24day((206+300):((205+300)+(15*4)))=1:(15*4);

time_since_dis_facter_40day = zeros(360,1); % ds on index 28 and 206
time_since_dis_facter_40day(17:(16+(9*4)))=1:(9*4);
time_since_dis_facter_40day(124:(123+(9*4)))=1:(9*4);
time_since_dis_facter_40day((17+180):((16+180)+(9*4)))=1:(9*4);
time_since_dis_facter_40day((124+180):((123+180)+(9*4)))=1:(9*4);




%non_ds_factor= ~(temp1+temp2+temp3+temp4);

TS7_factor_8day=cat(1,zeros(900,1),ones(900,1));
SRS6_factor_8day=cat(1,ones(900,1),zeros(900,1));

TS7_factor_24day=cat(1,zeros(300,1),ones(300,1));
SRS6_factor_24day=cat(1,ones(300,1),zeros(300,1));

TS7_factor_40day=cat(1,zeros(180,1),ones(180,1));
SRS6_factor_40day=cat(1,ones(180,1),zeros(180,1));




X_8day = [ecosystem_LAI_8day,time_since_dis_facter_8day,SRS6_factor_8day,ecosystem_TA_8day];
y1_8day = ecosystem_MM_1_8day;
y2_8day = ecosystem_MM_2_8day;
y3_8day = ecosystem_MM_3_8day;

X_24day = [ecosystem_LAI_24day,time_since_dis_facter_24day,SRS6_factor_24day,ecosystem_TA_24day];
y1_24day = ecosystem_MM_1_24day;
y2_24day = ecosystem_MM_2_24day;
y3_24day = ecosystem_MM_3_24day;

X_40day = [ecosystem_LAI_40day,time_since_dis_facter_40day,SRS6_factor_40day,ecosystem_TA_40day];
y1_40day = ecosystem_MM_1_40day;
y2_40day = ecosystem_MM_2_40day;
y3_40day = ecosystem_MM_3_40day;

%models with four factors
modelfun1 = @(b,x) exp(b(1)*x(:,1)) + b(2)*x(:,2) + b(3)*x(:,3) + b(4)*x(:,4) + b(5);
modelfun2 = @(b,x) b(1)*x(:,3) + b(2)*x(:,4) + b(3);
modelfun3 = @(b,x) exp(b(1)*x(:,1)) + b(2)*x(:,2) + b(3)*x(:,3) + b(4)*x(:,4) + b(5);

beta01 = [1,1,1,1,1];
beta02 = [1,1,1];
beta03 = [1,1,1,1,1];

mdl1_8day = fitnlm(X_8day,y1_8day, modelfun1, beta01,'CoefficientNames',{'Exp(LAI)','Time','Structure','TA','Intercept'})
mdl2_8day = fitnlm(X_8day,y2_8day, modelfun2, beta02,'CoefficientNames',{'Structure','TA','Intercept'})
mdl3_8day = fitnlm(X_8day,y3_8day, modelfun3, beta03,'CoefficientNames',{'Exp(LAI)','Time','Structure','TA','Intercept'})

mdl1_24day = fitnlm(X_24day,y1_24day, modelfun1, beta01,'CoefficientNames',{'Exp(LAI)','Time','Structure','TA','Intercept'})
mdl2_24day = fitnlm(X_24day,y2_24day, modelfun2, beta02,'CoefficientNames',{'Structure','TA','Intercept'})
mdl3_24day = fitnlm(X_24day,y3_24day, modelfun3, beta03,'CoefficientNames',{'Exp(LAI)','Time','Structure','TA','Intercept'})

mdl1_40day = fitnlm(X_40day,y1_40day, modelfun1, beta01,'CoefficientNames',{'Exp(LAI)','Time','Structure','TA','Intercept'})
mdl2_40day = fitnlm(X_40day,y2_40day, modelfun2, beta02,'CoefficientNames',{'Structure','TA','Intercept'})
mdl3_40day = fitnlm(X_40day,y3_40day, modelfun3, beta03,'CoefficientNames',{'Exp(LAI)','Time','Structure','TA','Intercept'})

% %models with countinuous time-since factors
% X = [ecosystem_LAI,time_since_dis_facter,SRS6_factor,Season_factor];
% 
% modelfun1 = @(b,x) exp(b(1)*x(:,1)) + b(2)*x(:,2) + b(3)*x(:,3) + b(4)*x(:,4) + b(5);
% modelfun2 = @(b,x) b(1)*x(:,4) + b(2);
% modelfun3 = @(b,x) exp(b(1)*x(:,1)) + b(2)*x(:,2) + b(3)*x(:,3) + b(4);
% 
% beta01 = [1,1,1,1,1];
% beta02 = [1,1];
% beta03 = [1,1,1,1];
% 
% mdl1 = fitnlm(X,y1, modelfun1, beta01,'CoefficientNames',{'Exp(LAI)','Time-Since Dist','Structure','Season','Intercept'})
% mdl2 = fitnlm(X,y2, modelfun2, beta02,'CoefficientNames',{'Structure','Intercept'})
% mdl3 = fitnlm(X,y3, modelfun3, beta03,'CoefficientNames',{'Exp(LAI)','Time-Since Dist','Structure','Intercept'})
% 

 

%output data
% mdl3_24day.Coefficients.Estimate
% mdl3_24day.Coefficients.SE
% 
% [mdl1_24day.Coefficients.Estimate-(1.96.*mdl1_24day.Coefficients.SE),mdl1_24day.Coefficients.Estimate+(1.96.*mdl1_24day.Coefficients.SE)]
% 
% 
% coefficients = mdl1.Coefficients{:, 'Estimate'}
% %yFitted = coefficients(1) * exp(coefficients(2)*ecosystem_LAI) + coefficients(3);
% yFitted = exp(coefficients(1)*ecosystem_LAI) + coefficients(2);



%correlation plots

% tbl = table(ecosystem_LAI,ecosystem_MM_1,ecosystem_MM_2,ecosystem_MM_3)
% tbl.Properties.VariableNames = ["LAI","Reco","QY","Amax"]
% corrplot(tbl,Type="Pearson",TestR="on")







%%%%%%%%%%%%%%%% TRC parameters models
% TRC NEP paraments
%beta =
%rb(1)
%E0(2)

%core model variables

%ecosystem_LAI_8day = cat(1,TS7_modis.LAIqc,SRS6_modis.LAIqc);
%ecosystem_MM_1_8day = cat(1,TS7_8day_beta_MM(:,1),SRS6_8day_beta_MM(:,1));
%ecosystem_MM_2_8day = cat(1,TS7_8day_beta_MM(:,2),SRS6_8day_beta_MM(:,2));
%ecosystem_MM_3_8day = cat(1,TS7_8day_beta_MM(:,3),SRS6_8day_beta_MM(:,3));
%ecosystem_TA_8day = cat(1,mean(TS7_8day_TA_filled,2,'omitnan'),mean(SRS6_8day_TA,2,'omitnan'));

ecosystem_LAI_24day = cat(1,TS7_modis_24day.LAIqc,SRS6_modis_24day.LAIqc);
ecosystem_TRC_1_24day = cat(1,TS7_24day_beta_TRC(:,1),SRS6_24day_beta_TRC(:,1));
ecosystem_TRC_2_24day = cat(1,TS7_24day_beta_TRC(:,2),SRS6_24day_beta_TRC(:,2));
ecosystem_TA_24day = cat(1,mean(TS7_24day_TA_filled,2,'omitnan'),mean(SRS6_24day_TA,2,'omitnan'));

%ecosystem_LAI_40day = cat(1,TS7_modis_40day.LAIqc,SRS6_modis_40day.LAIqc);
%ecosystem_MM_1_40day = cat(1,TS7_40day_beta_MM(:,1),SRS6_40day_beta_MM(:,1));
%ecosystem_MM_2_40day = cat(1,TS7_40day_beta_MM(:,2),SRS6_40day_beta_MM(:,2));
%ecosystem_MM_3_40day = cat(1,TS7_40day_beta_MM(:,3),SRS6_40day_beta_MM(:,3));
%ecosystem_TA_40day = cat(1,mean(TS7_40day_TA_filled,2,'omitnan'),mean(SRS6_40day_TA,2,'omitnan'));



%making dummy var for year

%time_since_dis_facter_8day = zeros(1800,1);   % ds on index 82 and 617
%time_since_dis_facter_8day(82:(81+(45*4)))=1:(45*4);
%time_since_dis_facter_8day(617:(616+(45*4)))=1:(45*4);
%time_since_dis_facter_8day((82+900):((81+900)+(45*4)))=1:(45*4);
%time_since_dis_facter_8day((617+900):((616+900)+(45*4)))=1:(45*4);

time_since_dis_facter_24day = zeros(600,1); % ds on index 28 and 206
time_since_dis_facter_24day(28:(27+(15*4)))=1:(15*4);
time_since_dis_facter_24day(206:(205+(15*4)))=1:(15*4);
time_since_dis_facter_24day((28+300):((27+300)+(15*4)))=1:(15*4);
time_since_dis_facter_24day((206+300):((205+300)+(15*4)))=1:(15*4);

%time_since_dis_facter_40day = zeros(360,1); % ds on index 28 and 206
%time_since_dis_facter_40day(17:(16+(9*4)))=1:(9*4);
%time_since_dis_facter_40day(124:(123+(9*4)))=1:(9*4);
%time_since_dis_facter_40day((17+180):((16+180)+(9*4)))=1:(9*4);
%time_since_dis_facter_40day((124+180):((123+180)+(9*4)))=1:(9*4);




%non_ds_factor= ~(temp1+temp2+temp3+temp4);

%TS7_factor_8day=cat(1,zeros(900,1),ones(900,1));
%SRS6_factor_8day=cat(1,ones(900,1),zeros(900,1));

TS7_factor_24day=cat(1,zeros(300,1),ones(300,1));
SRS6_factor_24day=cat(1,ones(300,1),zeros(300,1));

%TS7_factor_40day=cat(1,zeros(180,1),ones(180,1));
%SRS6_factor_40day=cat(1,ones(180,1),zeros(180,1));




%X_8day = [ecosystem_LAI_8day,time_since_dis_facter_8day,SRS6_factor_8day,ecosystem_TA_8day];
%y1_8day = ecosystem_TRC_1_8day;
%y2_8day = ecosystem_TRC_2_8day;


X_24day = [ecosystem_LAI_24day,time_since_dis_facter_24day,SRS6_factor_24day];
y1_24day = ecosystem_TRC_1_24day;
y2_24day = ecosystem_TRC_2_24day;

%_40day = [ecosystem_LAI_40day,time_since_dis_facter_40day,SRS6_factor_40day,ecosystem_TA_40day];
%y1_40day = ecosystem_TRC_1_40day;
%y2_40day = ecosystem_TRC_2_40day;


%models with four factors
modelfun1 = @(b,x) b(1)*x(:,2) + b(2)*x(:,3) + b(3);
modelfun2 = @(b,x) exp(b(1)*x(:,1)) + b(2)*x(:,3) + b(3);
modelfun3 = @(b,x) b(1)*x(:,3) + b(2)*x(:,4) + b(3);


beta01 = [1,1,1];
beta02 = [1,1,1];


mdl1_TRC_24day = fitnlm(X_24day,y1_24day, modelfun1, beta01,'CoefficientNames',{'Time','Structure','Intercept'})
mdl2_TRC_24day = fitnlm(X_24day,y2_24day, modelfun2, beta02,'CoefficientNames',{'Exp(LAI)','Structure','Intercept'})



%output data
% mdl1_TRC_24day.Coefficients.Estimate
% mdl1_TRC_24day.Coefficients.SE
% 
% [mdl1_TRC_24day.Coefficients.Estimate-(1.96.*mdl1_TRC_24day.Coefficients.SE),mdl1_TRC_24day.Coefficients.Estimate+(1.96.*mdl1_TRC_24day.Coefficients.SE)]











%SI figure to show aggregation results


subplot(3,4,1)
hold on
plot(8,mean(ecosystem_LAI_8day,'omitnan'),'.k','MarkerSize',14)
plot(24,mean(ecosystem_LAI_24day,'omitnan'),'.k','MarkerSize',14)
plot(40,mean(ecosystem_LAI_40day,'omitnan'),'.k','MarkerSize',14)
box on
title('LAI Mean')
xlim([5,45])
xticks([8,24,40])
ntitle(' (a)','location','northwest');

subplot(3,4,5)
hold on
plot(8,var(ecosystem_LAI_8day,'omitnan'),'.k','MarkerSize',14)
plot(24,var(ecosystem_LAI_24day,'omitnan'),'.k','MarkerSize',14)
plot(40,var(ecosystem_LAI_40day,'omitnan'),'.k','MarkerSize',14)
box on
title('LAI Variance')
xlim([5,45])
xticks([8,24,40])
ntitle(' (b)','location','northwest');

subplot(3,4,2)
hold on
plot(8,mean(ecosystem_MM_1_8day,'omitnan'),'.r','MarkerSize',14)
plot(24,mean(ecosystem_MM_1_24day,'omitnan'),'.r','MarkerSize',14)
plot(40,mean(ecosystem_MM_1_40day,'omitnan'),'.r','MarkerSize',14)
box on
title('R_e_c_o Mean')
xlim([5,45])
xticks([8,24,40])
ntitle(' (c)','location','northwest');

subplot(3,4,6)
hold on
plot(8,var(ecosystem_MM_1_8day,'omitnan'),'.r','MarkerSize',14)
plot(24,var(ecosystem_MM_1_24day,'omitnan'),'.r','MarkerSize',14)
plot(40,var(ecosystem_MM_1_40day,'omitnan'),'.r','MarkerSize',14)
box on
title('R_e_c_o Variance')
xlim([5,45])
xticks([8,24,40])
ntitle(' (d)','location','northwest');

subplot(3,4,3)
hold on
plot(8,mean(ecosystem_MM_2_8day,'omitnan'),'.b','MarkerSize',14)
plot(24,mean(ecosystem_MM_2_24day,'omitnan'),'.b','MarkerSize',14)
plot(40,mean(ecosystem_MM_2_40day,'omitnan'),'.b','MarkerSize',14)
box on
title('QY Mean')
xlim([5,45])
xticks([8,24,40])
ntitle(' (e)','location','northwest');

subplot(3,4,7)
hold on
plot(8,var(ecosystem_MM_2_8day,'omitnan'),'.b','MarkerSize',14)
plot(24,var(ecosystem_MM_2_24day,'omitnan'),'.b','MarkerSize',14)
plot(40,var(ecosystem_MM_2_40day,'omitnan'),'.b','MarkerSize',14)
box on
title('QY Variance')
xlim([5,45])
xticks([8,24,40])
ntitle(' (f)','location','northwest');

subplot(3,4,4)
hold on
plot(8,mean(ecosystem_MM_3_8day,'omitnan'),'.g','MarkerSize',14)
plot(24,mean(ecosystem_MM_3_24day,'omitnan'),'.g','MarkerSize',14)
plot(40,mean(ecosystem_MM_3_40day,'omitnan'),'.g','MarkerSize',14)
box on
title('Amax Mean')
xlim([5,45])
xticks([8,24,40])
ntitle(' (g)','location','northwest');

subplot(3,4,8)
hold on
plot(8,var(ecosystem_MM_3_8day,'omitnan'),'.g','MarkerSize',14)
plot(24,var(ecosystem_MM_3_24day,'omitnan'),'.g','MarkerSize',14)
plot(40,var(ecosystem_MM_3_40day,'omitnan'),'.g','MarkerSize',14)
box on
title('Amax Variance')
xlim([5,45])
xticks([8,24,40])
ntitle(' (h)','location','northwest');

subplot(3,4,9:12)
hold on
plot(nan,'.k')
plot(nan,'.r')
plot(nan,'.b')
plot(nan,'.g')

plot(8,mdl1_8day.Rsquared.Ordinary,'.r','MarkerSize',14)
plot(24,mdl1_24day.Rsquared.Ordinary,'.r','MarkerSize',14)
plot(40,mdl1_40day.Rsquared.Ordinary,'.r','MarkerSize',14)

plot(8,mdl2_8day.Rsquared.Ordinary,'.b','MarkerSize',14)
plot(24,mdl2_24day.Rsquared.Ordinary,'.b','MarkerSize',14)
plot(40,mdl2_40day.Rsquared.Ordinary,'.b','MarkerSize',14)

plot(8,mdl3_8day.Rsquared.Ordinary,'.g','MarkerSize',14)
plot(24,mdl3_24day.Rsquared.Ordinary,'.g','MarkerSize',14)
plot(40,mdl3_40day.Rsquared.Ordinary,'.g','MarkerSize',14)
box on
title('Model r^2')
xlim([5,45])
xticks([8,24,40])
ntitle(' (i)','location','northwest');
xlabel('Number of Aggregated Days')
legend('LAI','Reco','QY','Amax','location','southeast')





% NEP calc using mdl results
%NEE   =    (  (QY*Amax*NetRad) / (QY*NetRad + Amax)   ) - reco
%NEP = -NEE

ecosystem_ERA5_TA_24day = cat(1,mean(SRS6_24day_ERA5_TA,2,'omitnan'),mean(SRS6_24day_ERA5_TA,2,'omitnan'));

X = [ecosystem_LAI_24day,time_since_dis_facter_24day,SRS6_factor_24day,ecosystem_ERA5_TA_24day];

SRS6_LRCmodel_Amax = predict(mdl3_24day,X(301:600,:));
SRS6_LRCmodel_QY = mean(ecosystem_MM_2_24day(301:600),'omitnan');
SRS6_LRCmodel_Reco = predict(mdl1_24day,X(301:600,:));

TS7_LRCmodel_Amax = predict(mdl3_24day,X(1:300,:));
TS7_LRCmodel_QY = mean(ecosystem_MM_2_24day(1:300),'omitnan');
TS7_LRCmodel_Reco = predict(mdl1_24day,X(1:300,:));

clear X

%SRS6_LRCmodel_NEP = SRS6_LRCmodel_Amax.*SRS6_LRCmodel_QY.*SRS6_24day_NSRDB_data_dailyave'./(SRS6_LRCmodel_Amax + SRS6_LRCmodel_QY.*SRS6_24day_NSRDB_data_dailyave') - SRS6_LRCmodel_Reco;
%TS7_LRCmodel_NEP = TS7_LRCmodel_Amax.*TS7_LRCmodel_QY.*SRS6_24day_NSRDB_data_dailyave'./(TS7_LRCmodel_Amax + TS7_LRCmodel_QY.*SRS6_24day_NSRDB_data_dailyave') - TS7_LRCmodel_Reco;


X= [ecosystem_LAI_24day,time_since_dis_facter_24day,SRS6_factor_24day];

SRS6_TRCmodel_rb = predict(mdl1_TRC_24day,X(301:600,:));
SRS6_TRCmodel_Eo = mean(ecosystem_TRC_2_24day(301:600),'omitnan');

TS7_TRCmodel_rb = predict(mdl1_TRC_24day,X(1:300,:));
TS7_TRCmodel_Eo = mean(ecosystem_TRC_2_24day(1:300),'omitnan');

clear X



%%%% 24 day aggregation
%%%%%%% SRS6 site, 2004-2023
year_count=0;
year_count_lp=0;
for num_year=1:20   

    x=1+year_len_lp*year_count_lp+year_len*year_count;
    for i=1:15   %15 24-day groups (weeks) in each year
        for j=1:1152   %time series along group i (1152 30-min data in 24 days)

            SRS6_LRCmodel_NEP_30min(x) = SRS6_LRCmodel_Amax(i+15*(num_year-1)).*SRS6_LRCmodel_QY.*ERA5_data_30min.ERA5_SW_IN(x)'./(SRS6_LRCmodel_Amax(i+15*(num_year-1)) + SRS6_LRCmodel_QY.*ERA5_data_30min.ERA5_SW_IN(x)') - SRS6_LRCmodel_Reco(i+15*(num_year-1));
            TS7_LRCmodel_NEP_30min(x) = TS7_LRCmodel_Amax(i+15*(num_year-1)).*TS7_LRCmodel_QY.*ERA5_data_30min.ERA5_SW_IN(x)'./(TS7_LRCmodel_Amax(i+15*(num_year-1)) + TS7_LRCmodel_QY.*ERA5_data_30min.ERA5_SW_IN(x)') - TS7_LRCmodel_Reco(i+15*(num_year-1));
            
            SRS6_24day_LRCmodel_NEP(i+15*(num_year-1),j) = SRS6_LRCmodel_NEP_30min(x);
            TS7_24day_LRCmodel_NEP(i+15*(num_year-1),j) = TS7_LRCmodel_NEP_30min(x);


            SRS6_TRCmodel_Reco_30min(x) = SRS6_TRCmodel_rb(i+15*(num_year-1),1).*exp(SRS6_TRCmodel_Eo.*((1./(15--46.02)-(1./(ERA5_data_30min.ERA5_2T(x)'--46.02)))));
            TS7_TRCmodel_Reco_30min(x) = TS7_TRCmodel_rb(i+15*(num_year-1),1).*exp(TS7_TRCmodel_Eo.*((1./(15--46.02)-(1./(ERA5_data_30min.ERA5_2T(x)'--46.02)))));

            SRS6_24day_TRCmodel_Reco(i+15*(num_year-1),j) = SRS6_TRCmodel_Reco_30min(x);
            TS7_24day_TRCmodel_Reco(i+15*(num_year-1),j) = TS7_TRCmodel_Reco_30min(x);


            SRS6_TRCmodel_NEP_30min(x) = SRS6_LRCmodel_Amax(i+15*(num_year-1)).*SRS6_LRCmodel_QY.*ERA5_data_30min.ERA5_SW_IN(x)'./(SRS6_LRCmodel_Amax(i+15*(num_year-1)) + SRS6_LRCmodel_QY.*ERA5_data_30min.ERA5_SW_IN(x)') - SRS6_TRCmodel_Reco_30min(x);
            TS7_TRCmodel_NEP_30min(x) = TS7_LRCmodel_Amax(i+15*(num_year-1)).*TS7_LRCmodel_QY.*ERA5_data_30min.ERA5_SW_IN(x)'./(TS7_LRCmodel_Amax(i+15*(num_year-1)) + TS7_LRCmodel_QY.*ERA5_data_30min.ERA5_SW_IN(x)') - TS7_TRCmodel_Reco_30min(x);
            
            SRS6_24day_TRCmodel_NEP(i+15*(num_year-1),j) = SRS6_TRCmodel_NEP_30min(x);
            TS7_24day_TRCmodel_NEP(i+15*(num_year-1),j) = TS7_TRCmodel_NEP_30min(x);



            x=x+1;
            
        end

    end
    
    %need to decide if each year is a leap year or not, then add to correct
    %counter
    if num_year == 1 | num_year ==5
        year_count_lp=year_count_lp+1;
    else
        year_count=year_count+1;
    end



end
clear x

%%%% make daily average for SRS6_LRCmodel_NEP data over 24-day period
%%%% then
%%%% make 8-day average using daily average for SRS6_LRCmodel_NEP
for i=1:300
    for j=1:48  
        
        SRS6_24day_LRCmodel_NEP_dayave(i,j) = mean(SRS6_24day_LRCmodel_NEP(i,j:48:1152),'omitnan');
        TS7_24day_LRCmodel_NEP_dayave(i,j) = mean(TS7_24day_LRCmodel_NEP(i,j:48:1152),'omitnan');

        SRS6_24day_TRCmodel_Reco_dayave(i,j) = mean(SRS6_24day_TRCmodel_Reco(i,j:48:1152),'omitnan');
        TS7_24day_TRCmodel_Reco_dayave(i,j) = mean(TS7_24day_TRCmodel_Reco(i,j:48:1152),'omitnan');

        SRS6_24day_TRCmodel_NEP_dayave(i,j) = mean(SRS6_24day_TRCmodel_NEP(i,j:48:1152),'omitnan');
        TS7_24day_TRCmodel_NEP_dayave(i,j) = mean(TS7_24day_TRCmodel_NEP(i,j:48:1152),'omitnan');
    end

    SRS6_24day_LRCmodel_NEP_dailyave(i) = mean(SRS6_24day_LRCmodel_NEP_dayave(i,:),'omitnan');
    TS7_24day_LRCmodel_NEP_dailyave(i) = mean(TS7_24day_LRCmodel_NEP_dayave(i,:),'omitnan');

    SRS6_24day_TRCmodel_Reco_dailyave(i) = mean(SRS6_24day_TRCmodel_Reco_dayave(i,:),'omitnan');
    TS7_24day_TRCmodel_Reco_dailyave(i) = mean(TS7_24day_TRCmodel_Reco_dayave(i,:),'omitnan');

    SRS6_24day_TRCmodel_NEP_dailyave(i) = mean(SRS6_24day_TRCmodel_NEP_dayave(i,:),'omitnan');
    TS7_24day_TRCmodel_NEP_dailyave(i) = mean(TS7_24day_TRCmodel_NEP_dayave(i,:),'omitnan');
end


SRS6_24day_LRCmodel_NEE_dailyave = -SRS6_24day_LRCmodel_NEP_dailyave;
TS7_24day_LRCmodel_NEE_dailyave = -TS7_24day_LRCmodel_NEP_dailyave;

SRS6_24day_TRCmodel_NEE_dailyave = -SRS6_24day_TRCmodel_NEP_dailyave;
TS7_24day_TRCmodel_NEE_dailyave = -TS7_24day_TRCmodel_NEP_dailyave;



%%%% SI Figure EC NEP vs LRC NEP
SRS6_24day_NEE_dailyave_outlier = SRS6_24day_NEE_dailyave;
SRS6_24day_NEE_dailyave_outlier(isoutlier(SRS6_24day_NEE_dailyave_outlier)) = nan;

TS7_24day_NEE_dailyave_outlier = TS7_24day_NEE_dailyave;
TS7_24day_NEE_dailyave_outlier(isoutlier(TS7_24day_NEE_dailyave_outlier)) = nan;


hold on
plot(SRS6_24day_NEE_dailyave_outlier,SRS6_24day_LRCmodel_NEE_dailyave,'.','Color',[0 0.4470 0.7410],'markersize',12)
plot(TS7_24day_NEE_dailyave_outlier,TS7_24day_LRCmodel_NEE_dailyave,'.','Color',[0.8500 0.3250 0.0980],'markersize',12)

plot([-6,2],[-6,2],'k:')

xlim([-5,2])
ylim([-5,2])
box on
xlabel('Eddy Covariance NEE (µmol m^-^2s^-^1)')
ylabel('Light Based Modeled NEE (µmol m^-^2s^-^1)')
legend('Mangrove Forest','Mangrove Scrub','location','northwest')






%%%% SI Figure LRC Reco vs TRC Reco PARAMETERS, at 24-day timescales


%nanmean(SRS6_24day_beta_MM(:,1)) %7.4877
%nanmean(SRS6_24day_beta_TRC(:,1)) %3.2184

%nanmean(TS7_24day_beta_MM(:,1)) %1.7636
%nanmean(TS7_24day_beta_TRC(:,1)) %0.9585

%fitlm(SRS6_24day_beta_MM(:,1),SRS6_24day_beta_TRC(:,1)) %R-squared: 0.083
%fitlm(TS7_24day_beta_MM(:,1),TS7_24day_beta_TRC(:,1)) %R-squared: 0.00171



hold on
plot(SRS6_24day_beta_MM(:,1),SRS6_24day_beta_TRC(:,1),'.','Color',[0 0.4470 0.7410],'markersize',12)
plot(TS7_24day_beta_MM(:,1),TS7_24day_beta_TRC(:,1),'.','Color',[0.8500 0.3250 0.0980],'markersize',12)
plot([-1,25],[-1,25],'k:')
xlabel('Light Based R_e_c_o (µmol m^-^2s^-^1)')
ylabel('Temperature Based rb (µmol m^-^2s^-^1)')
legend('Mangrove Forest','Mangrove Scrub','location','northwest')
box on
xlim([-1,25])
ylim([-1,25])


% hold on
% plot(SRS6_24day_beta_MM(:,1))
% plot(SRS6_24day_beta_TRC(:,1))
% 
% hold on
% plot(TS7_24day_beta_MM(:,1))
% plot(TS7_24day_beta_TRC(:,1))






%%%% SI Figure LRC Reco vs TRC Reco MODELED VALUES, at 24-day timescales


%nanmean(SRS6_LRCmodel_Reco) %7.1359
%nanmean(SRS6_24day_TRCmodel_Reco_dailyave) %4.0037

%nanmean(TS7_LRCmodel_Reco) %1.0878
%nanmean(TS7_24day_TRCmodel_Reco_dailyave) %1.1249

%fitlm(SRS6_LRCmodel_Reco,SRS6_24day_TRCmodel_Reco_dailyave) %R-squared: 0.562
%fitlm(TS7_LRCmodel_Reco,TS7_24day_TRCmodel_Reco_dailyave) %R-squared: 0.473



hold on
plot(SRS6_LRCmodel_Reco,SRS6_24day_TRCmodel_Reco_dailyave,'.','Color',[0 0.4470 0.7410],'markersize',12)
plot(TS7_LRCmodel_Reco,TS7_24day_TRCmodel_Reco_dailyave,'.','Color',[0.8500 0.3250 0.0980],'markersize',12)
plot([-3,11],[-3,11],'k:')
xlabel('Light Based Respiration (µmol m^-^2s^-^1)')
ylabel('Temperature Based Respiration (µmol m^-^2s^-^1)')
legend('Mangrove Forest','Mangrove Scrub','location','northwest')
box on
xlim([-3,11])
ylim([-3,11])




%hold on
%plot(SRS6_LRCmodel_Reco)
%plot(SRS6_24day_TRCmodel_Reco_dailyave)

%hold on
%plot(TS7_LRCmodel_Reco)
%plot(TS7_24day_TRCmodel_Reco_dailyave)



%%%%%%%% SI Figure 1 LAI Aggregation

subplot(3,1,1)
hold on
plot(SRS6_modis.Date,SRS6_modis.LAIqc)  %mean 5.55
plot(TS7_modis.Date,TS7_modis.LAIqc)    %mean 2.8747

plot([wilma_date,wilma_date],[0,8],"--k","LineWidth", 2)
plot([irma_date,irma_date],[0,8],"--k","LineWidth", 2)
xlim([datetime(2004,01,01) datetime(2024,01,01)])
ylim([0 8])
box on
ylabel('8-day LAI (m^2 m^-^2)')
ntitle('(a) ','location','northeast');


subplot(3,1,2)
hold on
plot(SRS6_modis_24day.Date,SRS6_modis_24day.LAIqc)  %mean 5.55
plot(TS7_modis_24day.Date,TS7_modis_24day.LAIqc)    %mean 2.8747

plot([wilma_date,wilma_date],[0,8],"--k","LineWidth", 2)
plot([irma_date,irma_date],[0,8],"--k","LineWidth", 2)
xlim([datetime(2004,01,01) datetime(2024,01,01)])
ylim([0 8])
box on
ylabel('24-day LAI (m^2 m^-^2)')
ntitle('(b) ','location','northeast');


subplot(3,1,3)
hold on
plot(SRS6_modis_40day.Date,SRS6_modis_40day.LAIqc)  %mean 5.55
plot(TS7_modis_40day.Date,TS7_modis_40day.LAIqc)    %mean 2.8747

plot([wilma_date,wilma_date],[0,8],"--k","LineWidth", 2)
plot([irma_date,irma_date],[0,8],"--k","LineWidth", 2)
xlim([datetime(2004,01,01) datetime(2024,01,01)])
ylim([0 8])
box on
ylabel('40-day LAI (m^2 m^-^2)')
ntitle('(c) ','location','northeast');











%%%%%%%%%% data availability figure 1B
subplot(2,1,1)
hold on
plot(SRS6_modis.Date,SRS6_modis.LAIqc)  %mean 5.55
plot(TS7_modis.Date,TS7_modis.LAIqc)    %mean 2.8747

plot([wilma_date,wilma_date],[0,8],"--k","LineWidth", 2)
plot([irma_date,irma_date],[0,8],"--k","LineWidth", 2)
xlim([datetime(2004,01,01) datetime(2024,01,01)])
ylim([0 8])
box on
ylabel('LAI (m^2 m^-^2)')
ntitle('(b) ','location','northeast');


subplot(2,1,2)
hold on
plot(SRS6_data.linear_day,SRS6_data.NEE)
plot(TS7_data.linear_day,TS7_data.NEE)

plot([wilma_linear_day,wilma_linear_day],[-200,200],"--k","LineWidth", 2)
plot([irma_linear_day,irma_linear_day],[-200,200],"--k","LineWidth", 2)

box on
legend('Tall Forest','Scrub Forest','Wilma/Irma','Location','north')
ylabel('NEE (µmol m^-^2s^-^1)')
ntitle('(c) ','location','northeast');
%ylabel('F CH_4 (µmol m^-^2s^-^1)')
%xlim([2004,2024])
%ylim([-0.5,0.5])
%ntitle('(c) ','location','northeast');







%%%%%%%%%% mean (SE) LRC parameter values

mean(SRS6_24day_beta_MM(:,1),'omitnan')
std(SRS6_24day_beta_MM(:,1),'omitnan')/sqrt(length(SRS6_24day_beta_MM(:,1)))

mean(SRS6_24day_beta_MM(:,2),'omitnan')
std(SRS6_24day_beta_MM(:,2),'omitnan')/sqrt(length(SRS6_24day_beta_MM(:,1)))

mean(SRS6_24day_beta_MM(:,3),'omitnan')
std(SRS6_24day_beta_MM(:,3),'omitnan')/sqrt(length(SRS6_24day_beta_MM(:,1)))




mean(TS7_24day_beta_MM(:,1),'omitnan')
std(TS7_24day_beta_MM(:,1),'omitnan')/sqrt(length(TS7_24day_beta_MM(:,1)))

mean(TS7_24day_beta_MM(:,2),'omitnan')
std(TS7_24day_beta_MM(:,2),'omitnan')/sqrt(length(TS7_24day_beta_MM(:,1)))

mean(TS7_24day_beta_MM(:,3),'omitnan')
std(TS7_24day_beta_MM(:,3),'omitnan')/sqrt(length(TS7_24day_beta_MM(:,1)))




%%%%%% ploting average LRC figure 2 %and disurbance LRC


reco_mean_srs6 = mean(SRS6_24day_beta_MM(:,1),'omitnan');
qy_mean_srs6 = mean(SRS6_24day_beta_MM(:,2),'omitnan');
amax_mean_srs6 = mean(SRS6_24day_beta_MM(:,3),'omitnan');

%reco_std_srs6 = std(SRS6_24day_beta_MM(:,1),'omitnan');
%qy_std_srs6 = std(SRS6_24day_beta_MM(:,2),'omitnan');
%amax_std_srs6 = std(SRS6_24day_beta_MM(:,3),'omitnan');

reco_mean_srs6_ds = mean(SRS6_24day_beta_MM(index_24day_ds,1),'omitnan');
qy_mean_srs6_ds = mean(SRS6_24day_beta_MM(index_24day_ds,2),'omitnan');
amax_mean_srs6_ds = mean(SRS6_24day_beta_MM(index_24day_ds,3),'omitnan');
%std(SRS6_24day_beta_MM(index_ds,3),'omitnan');

reco_mean_srs6_not_ds = mean(SRS6_24day_beta_MM(index_24day_not_ds,1),'omitnan');
qy_mean_srs6_not_ds = mean(SRS6_24day_beta_MM(index_24day_not_ds,2),'omitnan');
amax_mean_srs6_not_ds = mean(SRS6_24day_beta_MM(index_24day_not_ds,3),'omitnan');
%std(SRS6_24day_beta_MM(index_not_ds,3),'omitnan');

reco_mean_ts7 = mean(TS7_24day_beta_MM(:,1),'omitnan');
qy_mean_ts7 = mean(TS7_24day_beta_MM(:,2),'omitnan');
amax_mean_ts7 = mean(TS7_24day_beta_MM(:,3),'omitnan');

%reco_std_ts7 = std(TS7_24day_beta_MM(:,1),'omitnan');
%qy_std_ts7 = std(TS7_24day_beta_MM(:,2),'omitnan');
%amax_std_ts7 = std(TS7_24day_beta_MM(:,3),'omitnan');



x_ppdf_values = 0:10:1300;

y_lrc_srs6 = amax_mean_srs6.*qy_mean_srs6.*x_ppdf_values./(amax_mean_srs6 + qy_mean_srs6.*x_ppdf_values) - reco_mean_srs6;
y_lrc_srs6_ds = amax_mean_srs6_ds.*qy_mean_srs6_ds.*x_ppdf_values./(amax_mean_srs6_ds + qy_mean_srs6_ds.*x_ppdf_values) - reco_mean_srs6_ds;
y_lrc_srs6_not_ds = amax_mean_srs6_not_ds.*qy_mean_srs6_not_ds.*x_ppdf_values./(amax_mean_srs6_not_ds + qy_mean_srs6_not_ds.*x_ppdf_values) - reco_mean_srs6_not_ds;
y_lrc_ts7 = amax_mean_ts7.*qy_mean_ts7.*x_ppdf_values./(amax_mean_ts7 + qy_mean_ts7.*x_ppdf_values) - reco_mean_ts7;


subplot(2,2,1)
hold on
plot(x_ppdf_values,-y_lrc_srs6)
%plot(x_ppdf_values,y_lrc_srs6_ds,':','Color',[0 0.4470 0.7410])
%plot(x_ppdf_values,y_lrc_srs6_not_ds,'--','Color',[0 0.4470 0.7410])
plot(x_ppdf_values,-y_lrc_ts7,'Color',[0.8500 0.3250 0.0980])
plot([0,1300],[0,0],'--k')

box on
ntitle('(a) ','location','northeast');
ylabel('NEE (µmol m^-^2s^-^1)')
xlabel('Solar Incoming Radiation (W m^-^2)')
%legend('SRS6','SRS6 disturbance','SRS6 non-disturbance','TS7','Location','northwest')
legend('Tall Forest','Scrub Forest','Location','north')

subplot(2,2,2)
hold on
h1 = histogram(SRS6_24day_beta_MM(:,1),'EdgeColor','none',Normalization="percentage")
h1.BinWidth = 0.5;
h2 = histogram(TS7_24day_beta_MM(:,1),'EdgeColor','none',Normalization="percentage")
h2.BinWidth = 0.5;
xlabel('R_e_c_o (µmol m^-^2s^-^1)')
ylabel('Relative Percentage')
ytickformat("percentage")
ntitle('(b) ','location','northeast');
box on


subplot(2,2,3)
hold on
h1 = histogram(SRS6_24day_beta_MM(:,2),'EdgeColor','none',Normalization="percentage")
h1.BinWidth = 0.01;
h2 = histogram(TS7_24day_beta_MM(:,2),'EdgeColor','none',Normalization="percentage")
h2.BinWidth = 0.01;
xlabel('Quantum Yield (µmol J^-^1)')
ylabel('Relative Percentage')
ytickformat("percentage")
ntitle('(c) ','location','northeast');
box on

subplot(2,2,4)
hold on
h1 = histogram(SRS6_24day_beta_MM(:,3),'EdgeColor','none',Normalization="percentage")
h1.BinWidth = 2;
h2 = histogram(TS7_24day_beta_MM(:,3),'EdgeColor','none',Normalization="percentage")
h2.BinWidth = 2;
xlabel('Amax (µmol m^-^2s^-^1)')
ylabel('Relative Percentage')
ytickformat("percentage")
ntitle('(d) ','location','northeast');
box on





% %%%%%%% stats works for Table 1
% %SRS6 LAI
% mean(SRS6_modis.LAIqc(:),'omitnan')
% [h,p] = ttest2(SRS6_modis_24day.LAIqc(:),SRS6_modis_24day.LAIqc(index_24day_not_ds))
% mean(SRS6_modis_24day.LAIqc(index_24day_ds),'omitnan')
% [h,p] = ttest2(SRS6_modis_24day.LAIqc(index_24day_ds),SRS6_modis_24day.LAIqc(index_24day_not_ds))
% mean(SRS6_modis_24day.LAIqc(index_24day_ds_yr1),'omitnan')
% [h,p] = ttest2(SRS6_modis_24day.LAIqc(index_24day_ds_yr1),SRS6_modis_24day.LAIqc(index_24day_not_ds))
% mean(SRS6_modis_24day.LAIqc(index_24day_ds_yr2),'omitnan')
% [h,p] = ttest2(SRS6_modis_24day.LAIqc(index_24day_ds_yr2),SRS6_modis_24day.LAIqc(index_24day_not_ds))
% mean(SRS6_modis_24day.LAIqc(index_24day_ds_yr3),'omitnan')
% [h,p] = ttest2(SRS6_modis_24day.LAIqc(index_24day_ds_yr3),SRS6_modis_24day.LAIqc(index_24day_not_ds))
% mean(SRS6_modis_24day.LAIqc(index_24day_ds_yr4),'omitnan')
% [h,p] = ttest2(SRS6_modis_24day.LAIqc(index_24day_ds_yr4),SRS6_modis_24day.LAIqc(index_24day_not_ds))
% mean(SRS6_modis_24day.LAIqc(index_24day_not_ds),'omitnan')
% 
% %(1-(mean(SRS6_modis_24day.LAIqc(index_24day_ds_yr2),'omitnan')./mean(SRS6_modis_24day.LAIqc(index_24day_not_ds),'omitnan')))*100
% 
% 
% %TS7 LAI
% mean(TS7_modis_24day.LAIqc,'omitnan')
% [h,p] = ttest2(TS7_modis_24day.LAIqc(:),TS7_modis_24day.LAIqc(index_24day_not_ds))
% mean(TS7_modis_24day.LAIqc(index_24day_ds),'omitnan')
% [h,p] = ttest2(TS7_modis_24day.LAIqc(index_24day_ds),TS7_modis_24day.LAIqc(index_24day_not_ds))
% mean(TS7_modis_24day.LAIqc(index_24day_ds_yr1),'omitnan')
% [h,p] = ttest2(TS7_modis_24day.LAIqc(index_24day_ds_yr1),TS7_modis_24day.LAIqc(index_24day_not_ds))
% mean(TS7_modis_24day.LAIqc(index_24day_ds_yr2),'omitnan')
% [h,p] = ttest2(TS7_modis_24day.LAIqc(index_24day_ds_yr2),TS7_modis_24day.LAIqc(index_24day_not_ds))
% mean(TS7_modis_24day.LAIqc(index_24day_ds_yr3),'omitnan')
% [h,p] = ttest2(TS7_modis_24day.LAIqc(index_24day_ds_yr3),TS7_modis_24day.LAIqc(index_24day_not_ds))
% mean(TS7_modis_24day.LAIqc(index_24day_ds_yr4),'omitnan')
% [h,p] = ttest2(TS7_modis_24day.LAIqc(index_24day_ds_yr4),TS7_modis_24day.LAIqc(index_24day_not_ds))
% mean(TS7_modis_24day.LAIqc(index_24day_not_ds),'omitnan')
% 
% 
% 
% %SRS6 Reco
% mean(SRS6_24day_beta_MM(:,1),'omitnan')
% [h,p] = ttest2(SRS6_24day_beta_MM(:,1),SRS6_24day_beta_MM(index_24day_not_ds,1))
% mean(SRS6_24day_beta_MM(index_24day_ds,1),'omitnan')
% [h,p] = ttest2(SRS6_24day_beta_MM(index_24day_ds,1),SRS6_24day_beta_MM(index_24day_not_ds,1))
% mean(SRS6_24day_beta_MM(index_24day_ds_yr1,1),'omitnan')
% [h,p] = ttest2(SRS6_24day_beta_MM(index_24day_ds_yr1,1),SRS6_24day_beta_MM(index_24day_not_ds,1))
% mean(SRS6_24day_beta_MM(index_24day_ds_yr2,1),'omitnan')
% [h,p] = ttest2(SRS6_24day_beta_MM(index_24day_ds_yr2,1),SRS6_24day_beta_MM(index_24day_not_ds,1))
% mean(SRS6_24day_beta_MM(index_24day_ds_yr3,1),'omitnan')
% [h,p] = ttest2(SRS6_24day_beta_MM(index_24day_ds_yr3,1),SRS6_24day_beta_MM(index_24day_not_ds,1))
% mean(SRS6_24day_beta_MM(index_24day_ds_yr4,1),'omitnan')
% [h,p] = ttest2(SRS6_24day_beta_MM(index_24day_ds_yr4,1),SRS6_24day_beta_MM(index_24day_not_ds,1))
% mean(SRS6_24day_beta_MM(index_24day_not_ds,1),'omitnan')
% 
% %(1-(mean(SRS6_24day_beta_MM(index_24day_ds_yr2,1),'omitnan')./mean(SRS6_24day_beta_MM(index_24day_not_ds,1),'omitnan')))*100
% 
% %TS7 Reco
% mean(TS7_24day_beta_MM(:,1),'omitnan')
% [h,p] = ttest2(TS7_24day_beta_MM(:,1),TS7_24day_beta_MM(index_24day_not_ds,1))
% mean(TS7_24day_beta_MM(index_24day_ds,1),'omitnan')
% [h,p] = ttest2(TS7_24day_beta_MM(index_24day_ds,1),TS7_24day_beta_MM(index_24day_not_ds,1))
% mean(TS7_24day_beta_MM(index_24day_ds_yr1,1),'omitnan')
% [h,p] = ttest2(TS7_24day_beta_MM(index_24day_ds_yr1,1),TS7_24day_beta_MM(index_24day_not_ds,1))
% mean(TS7_24day_beta_MM(index_24day_ds_yr2,1),'omitnan')
% [h,p] = ttest2(TS7_24day_beta_MM(index_24day_ds_yr2,1),TS7_24day_beta_MM(index_24day_not_ds,1))
% mean(TS7_24day_beta_MM(index_24day_ds_yr3,1),'omitnan')
% [h,p] = ttest2(TS7_24day_beta_MM(index_24day_ds_yr3,1),TS7_24day_beta_MM(index_24day_not_ds,1))
% mean(TS7_24day_beta_MM(index_24day_ds_yr4,1),'omitnan')
% [h,p] = ttest2(TS7_24day_beta_MM(index_24day_ds_yr4,1),TS7_24day_beta_MM(index_24day_not_ds,1))
% mean(TS7_24day_beta_MM(index_24day_not_ds,1),'omitnan')
% 
% %(1-(mean(TS7_24day_beta_MM(index_24day_ds_yr3,1),'omitnan')./mean(TS7_24day_beta_MM(index_24day_not_ds,1),'omitnan')))*100
% 
% 
% 
% %SRS6 QY
% mean(SRS6_24day_beta_MM(:,2),'omitnan')
% [h,p] = ttest2(SRS6_24day_beta_MM(:,2),SRS6_24day_beta_MM(index_24day_not_ds,2))
% mean(SRS6_24day_beta_MM(index_24day_ds,2),'omitnan')
% [h,p] = ttest2(SRS6_24day_beta_MM(index_24day_ds,2),SRS6_24day_beta_MM(index_24day_not_ds,2))
% mean(SRS6_24day_beta_MM(index_24day_ds_yr1,2),'omitnan')
% [h,p] = ttest2(SRS6_24day_beta_MM(index_24day_ds_yr1,2),SRS6_24day_beta_MM(index_24day_not_ds,2))
% mean(SRS6_24day_beta_MM(index_24day_ds_yr2,2),'omitnan')
% [h,p] = ttest2(SRS6_24day_beta_MM(index_24day_ds_yr2,2),SRS6_24day_beta_MM(index_24day_not_ds,2))
% mean(SRS6_24day_beta_MM(index_24day_ds_yr3,2),'omitnan')
% [h,p] = ttest2(SRS6_24day_beta_MM(index_24day_ds_yr3,2),SRS6_24day_beta_MM(index_24day_not_ds,2))
% mean(SRS6_24day_beta_MM(index_24day_ds_yr4,2),'omitnan')
% [h,p] = ttest2(SRS6_24day_beta_MM(index_24day_ds_yr4,2),SRS6_24day_beta_MM(index_24day_not_ds,2))
% mean(SRS6_24day_beta_MM(index_24day_not_ds,2),'omitnan')
% 
% %(1-(mean(SRS6_24day_beta_MM(index_24day_ds_yr1,2),'omitnan')./mean(SRS6_24day_beta_MM(index_24day_not_ds,2),'omitnan')))*100
% 
% 
% %TS7 QY
% mean(TS7_24day_beta_MM(:,2),'omitnan')
% [h,p] = ttest2(TS7_24day_beta_MM(:,2),TS7_24day_beta_MM(index_24day_not_ds,2))
% mean(TS7_24day_beta_MM(index_24day_ds,2),'omitnan')
% [h,p] = ttest2(TS7_24day_beta_MM(index_24day_ds,2),TS7_24day_beta_MM(index_24day_not_ds,2))
% mean(TS7_24day_beta_MM(index_24day_ds_yr1,2),'omitnan')
% [h,p] = ttest2(TS7_24day_beta_MM(index_24day_ds_yr1,2),TS7_24day_beta_MM(index_24day_not_ds,2))
% mean(TS7_24day_beta_MM(index_24day_ds_yr2,2),'omitnan')
% [h,p] = ttest2(TS7_24day_beta_MM(index_24day_ds_yr2,2),TS7_24day_beta_MM(index_24day_not_ds,2))
% mean(TS7_24day_beta_MM(index_24day_ds_yr3,2),'omitnan')
% [h,p] = ttest2(TS7_24day_beta_MM(index_24day_ds_yr3,2),TS7_24day_beta_MM(index_24day_not_ds,2))
% mean(TS7_24day_beta_MM(index_24day_ds_yr4,2),'omitnan')
% [h,p] = ttest2(TS7_24day_beta_MM(index_24day_ds_yr4,2),TS7_24day_beta_MM(index_24day_not_ds,2))
% mean(TS7_24day_beta_MM(index_24day_not_ds,2),'omitnan')
% 
% %(1-(mean(TS7_24day_beta_MM(index_24day_ds,2),'omitnan')./mean(TS7_24day_beta_MM(index_24day_not_ds,2),'omitnan')))*100
% 
% 
% 
% %SRS6 Amax
% mean(SRS6_24day_beta_MM(:,3),'omitnan')
% [h,p] = ttest2(SRS6_24day_beta_MM(:,3),SRS6_24day_beta_MM(index_24day_not_ds,3))
% mean(SRS6_24day_beta_MM(index_24day_ds,3),'omitnan')
% [h,p] = ttest2(SRS6_24day_beta_MM(index_24day_ds,3),SRS6_24day_beta_MM(index_24day_not_ds,3))
% mean(SRS6_24day_beta_MM(index_24day_ds_yr1,3),'omitnan')
% [h,p] = ttest2(SRS6_24day_beta_MM(index_24day_ds_yr1,3),SRS6_24day_beta_MM(index_24day_not_ds,3))
% mean(SRS6_24day_beta_MM(index_24day_ds_yr2,3),'omitnan')
% [h,p] = ttest2(SRS6_24day_beta_MM(index_24day_ds_yr2,3),SRS6_24day_beta_MM(index_24day_not_ds,3))
% mean(SRS6_24day_beta_MM(index_24day_ds_yr3,3),'omitnan')
% [h,p] = ttest2(SRS6_24day_beta_MM(index_24day_ds_yr3,3),SRS6_24day_beta_MM(index_24day_not_ds,3))
% mean(SRS6_24day_beta_MM(index_24day_ds_yr4,3),'omitnan')
% [h,p] = ttest2(SRS6_24day_beta_MM(index_24day_ds_yr4,3),SRS6_24day_beta_MM(index_24day_not_ds,3))
% mean(SRS6_24day_beta_MM(index_24day_not_ds,3),'omitnan')
% 
% %(1-(mean(SRS6_24day_beta_MM(index_24day_ds_yr2,3),'omitnan')./mean(SRS6_24day_beta_MM(index_24day_not_ds,3),'omitnan')))*100
% 
% %TS7 Amax
% mean(TS7_24day_beta_MM(:,3),'omitnan')
% [h,p] = ttest2(TS7_24day_beta_MM(:,3),TS7_24day_beta_MM(index_24day_not_ds,3))
% mean(TS7_24day_beta_MM(index_24day_ds,3),'omitnan')
% [h,p] = ttest2(TS7_24day_beta_MM(index_24day_ds,3),TS7_24day_beta_MM(index_24day_not_ds,3))
% mean(TS7_24day_beta_MM(index_24day_ds_yr1,3),'omitnan')
% [h,p] = ttest2(TS7_24day_beta_MM(index_24day_ds_yr1,3),TS7_24day_beta_MM(index_24day_not_ds,3))
% mean(TS7_24day_beta_MM(index_24day_ds_yr2,3),'omitnan')
% [h,p] = ttest2(TS7_24day_beta_MM(index_24day_ds_yr2,3),TS7_24day_beta_MM(index_24day_not_ds,3))
% mean(TS7_24day_beta_MM(index_24day_ds_yr3,3),'omitnan')
% [h,p] = ttest2(TS7_24day_beta_MM(index_24day_ds_yr3,3),TS7_24day_beta_MM(index_24day_not_ds,3))
% mean(TS7_24day_beta_MM(index_24day_ds_yr4,3),'omitnan')
% [h,p] = ttest2(TS7_24day_beta_MM(index_24day_ds_yr4,3),TS7_24day_beta_MM(index_24day_not_ds,3))
% mean(TS7_24day_beta_MM(index_24day_not_ds,3),'omitnan')
% 
% %(1-(mean(TS7_24day_beta_MM(index_24day_ds_yr1,3),'omitnan')./mean(TS7_24day_beta_MM(index_24day_not_ds,3),'omitnan')))*100

sum(~isnan(SRS6_24day_beta_MM(index_24day_ds_yr4,3)))
sum(~isnan(SRS6_modis.LAIqc(index_24day_ds_yr3)))


mean(SRS6_24day_beta_MM(index_24day_ds,3),'omitnan')
mean(SRS6_24day_beta_MM(index_24day_ds_yr1,3),'omitnan')
mean(SRS6_24day_beta_MM(index_24day_ds_yr2,3),'omitnan')
mean(SRS6_24day_beta_MM(index_24day_ds_yr3,1),'omitnan')
mean(SRS6_24day_beta_MM(index_24day_ds_yr4,1),'omitnan')
mean(SRS6_24day_beta_MM(index_24day_not_ds,3),'omitnan')







%%%% test model paramenters for normal disturbution
kstest(TS7_24day_beta_MM(:,1))







% %%%%%%%%%% carbon cycling parameters timeseries figure 3
% subplot(3,1,1)
% hold on
% plot(SRS6_8day_linear_day(:,1),SRS6_8day_beta_MM(:,1))
% plot(TS7_8day_linear_day(:,1),TS7_8day_beta_MM(:,1))
% 
% box on
% ylabel('R_e_c_o')
% 
% 
% subplot(3,1,2)
% hold on
% plot(SRS6_8day_linear_day(:,1),SRS6_8day_beta_MM(:,2))
% plot(TS7_8day_linear_day(:,1),TS7_8day_beta_MM(:,2))
% 
% box on
% ylabel('QY')
% ylim([0,0.5])
% 
% 
% subplot(3,1,3)
% hold on
% plot(SRS6_8day_linear_day(:,1),SRS6_8day_beta_MM(:,3))
% plot(TS7_8day_linear_day(:,1),TS7_8day_beta_MM(:,3))
% 
% box on
% ylabel('Amax')
% 


%%% plot all MM parameters with histograms

date_plot=TS7_modis_24day.Date;


subplot(3,1,1)
hold on
plot(date_plot,SRS6_24day_beta_MM(:,1))
plot(date_plot,TS7_24day_beta_MM(:,1))
plot([wilma_date,wilma_date],[0,10],"--k","LineWidth", 2)
plot([irma_date,irma_date],[0,10],"--k","LineWidth", 2)
ylabel('R_e_c_o (µmol m^-^2s^-^1)')
%xlim([2004,2024])
ntitle('(a) ','location','northeast');
legend('Tall Forest','Scrub Forest','Wilma/Irma','Location','northwest')
box on



subplot(3,1,2)
hold on
plot(date_plot,SRS6_24day_beta_MM(:,2))
plot(date_plot,TS7_24day_beta_MM(:,2))
plot([wilma_date,wilma_date],[0,.4],"--k","LineWidth", 2)
plot([irma_date,irma_date],[0,.4],"--k","LineWidth", 2)
ylabel('Quantum Yield (µmol J^-^1)')
%xlim([2004,2024])
ntitle('(b) ','location','northeast');
box on


subplot(3,1,3)
hold on
plot(date_plot,SRS6_24day_beta_MM(:,3))
plot(date_plot,TS7_24day_beta_MM(:,3))
plot([wilma_date,wilma_date],[0,60],"--k","LineWidth", 2)
plot([irma_date,irma_date],[0,60],"--k","LineWidth", 2)
ylabel('Amax (µmol m^-^2s^-^1)')
%xlim([2004,2024])
%xlabel('Weeks (Since Jan 1, 2004)')
ntitle('(c) ','location','northeast');
box on











%%%%%% figure 5 LAI histogram and LAI regressions


subplot (2,2,1)
hold on
%bar(ENP_LAI.Label,ENP_LAI.("Leaf Area Index (m2/m2)"),0.8,"EdgeColor","none")
bar(ENP_LAI.Label,ENP_LAI.("Leaf Area Index (m2/m2)"),0.8,'k')
bar(ENP_LAI.Label(26),ENP_LAI.("Leaf Area Index (m2/m2)")(26),0.8,"FaceColor",[0 0.4470 0.7410],"EdgeColor",[0 0.4470 0.7410])
bar(ENP_LAI.Label(13),ENP_LAI.("Leaf Area Index (m2/m2)")(13),0.8,"FaceColor",[0.8500 0.3250 0.0980],"EdgeColor",[0.8500 0.3250 0.0980])
xticklabels(ENP_LAI.("Max of_Pixel Count"))
xlabel('LAI (m^2 m^-^2)')
ylabel('Mangrove Ecosytem Pixel Count')
ntitle('(a) ','location','northeast');
box on


subplot(2,2,2)
hold on

time_since_dis_24day = zeros(300,1); % ds on index 28 and 206
time_since_dis_24day(28:(27+(15*4)))=1:(15*4);
time_since_dis_24day(206:(205+(15*4)))=1:(15*4);


X_predict_SRS6_nonds = [SRS6_modis_24day.LAIqc,zeros(300,1),zeros(300,1),mean(SRS6_24day_TA,2,'omitnan')];
X_predict_SRS6_ds    = [SRS6_modis_24day.LAIqc,time_since_dis_24day,zeros(300,1),mean(SRS6_24day_TA,2,'omitnan')];

Y_predict_SRS6_nonds = predict(mdl1_24day,X_predict_SRS6_nonds);
Y_predict_SRS6_ds    = predict(mdl1_24day,X_predict_SRS6_ds);

xy_plot_SRS6_nonds = sort([SRS6_modis_24day.LAIqc,Y_predict_SRS6_nonds],1);
xy_plot_SRS6_ds  = sort([SRS6_modis_24day.LAIqc,Y_predict_SRS6_ds],1);


X_predict_TS7_nonds = [TS7_modis_24day.LAIqc,zeros(300,1),ones(300,1),mean(TS7_24day_TA_filled,2,'omitnan')];
X_predict_TS7_ds    = [TS7_modis_24day.LAIqc,time_since_dis_24day,ones(300,1),mean(TS7_24day_TA_filled,2,'omitnan')];

Y_predict_TS7_nonds = predict(mdl1_24day,X_predict_TS7_nonds);
Y_predict_TS7_ds = predict(mdl1_24day,X_predict_TS7_ds);

xy_plot_TS7_nonds = sort([TS7_modis_24day.LAIqc,Y_predict_TS7_nonds],1);
xy_plot_TS7_ds = sort([TS7_modis_24day.LAIqc,Y_predict_TS7_ds],1);


%plot(ecosystem_LAI,ecosystem_MM_1,'.k')
plot(TS7_modis_24day.LAIqc,TS7_24day_beta_MM(:,1),'.','Color',[0.8500 0.3250 0.0980],'MarkerSize',12)
plot(SRS6_modis_24day.LAIqc,SRS6_24day_beta_MM(:,1),'.','Color',[0 0.4470 0.7410],'MarkerSize',12)

plot(xy_plot_SRS6_nonds(:,1),xy_plot_SRS6_nonds(:,2),'-','Color',[0 0.4470 0.7410])
plot(xy_plot_SRS6_ds(:,1),xy_plot_SRS6_ds(:,2),':','Color',[0 0.4470 0.7410])


plot(xy_plot_TS7_nonds(:,1),xy_plot_TS7_nonds(:,2),'-','Color',[0.8500 0.3250 0.0980])
plot(xy_plot_TS7_ds(:,1),xy_plot_TS7_ds(:,2),':','Color',[0.8500 0.3250 0.0980])


ylabel('R_e_c_o (µmol m^-^2s^-^1)')
xlabel('LAI (m^2 m^-^2)')
ntitle('(b) ','location','northeast');
xlim([1 7.5])
box on



subplot(2,2,3)
hold on

%fake data for legend
plot(nan,nan,'.','Color',[0 0.4470 0.7410],'MarkerSize',12)
plot(nan,nan,'-','Color',[0 0.4470 0.7410])
plot(nan,nan,':','Color',[0 0.4470 0.7410])
plot(nan,nan,'.','Color',[0.8500 0.3250 0.0980],'MarkerSize',12)
plot(nan,nan,'-','Color',[0.8500 0.3250 0.0980])
plot(nan,nan,':','Color',[0.8500 0.3250 0.0980])


%plot(ecosystem_LAI,ecosystem_MM_2,'.k')
plot(SRS6_modis_24day.LAIqc,SRS6_24day_beta_MM(:,2),'.','Color',[0 0.4470 0.7410],'MarkerSize',12)
plot(TS7_modis_24day.LAIqc,TS7_24day_beta_MM(:,2),'.','Color',[0.8500 0.3250 0.0980],'MarkerSize',12)

% plot(lm_plot_x,lm_plot_y_MM_2,'k')
% [ypred,yci]=predict(lm_ecosystem_MM_2,lm_plot_x');
% plot(lm_plot_x,yci,"k:","DisplayName","±95% CI")

ylabel('Quantum Yield (µmol J^-^1)')
xlabel('LAI (m^2 m^-^2)')
ntitle('(c) ','location','northeast');
xlim([1 7.5])
ylim([0 0.42])
box on
legend('Tall Forest','Tall Model','Tall Disturbance Model','Scrub Forest','Scrub Model','Scrub Disturbance Model','Location','northwest')



subplot(2,2,4)
hold on


X_predict_SRS6_nonds = [SRS6_modis_24day.LAIqc,zeros(300,1),zeros(300,1),mean(SRS6_24day_TA,2,'omitnan')];
X_predict_SRS6_ds    = [SRS6_modis_24day.LAIqc,time_since_dis_24day,zeros(300,1),mean(SRS6_24day_TA,2,'omitnan')];

Y_predict_SRS6_nonds = predict(mdl3_24day,X_predict_SRS6_nonds);
Y_predict_SRS6_ds    = predict(mdl3_24day,X_predict_SRS6_ds);

xy_plot_SRS6_nonds = sort([SRS6_modis_24day.LAIqc,Y_predict_SRS6_nonds],1);
xy_plot_SRS6_ds  = sort([SRS6_modis_24day.LAIqc,Y_predict_SRS6_ds],1);


X_predict_TS7_nonds = [TS7_modis_24day.LAIqc,zeros(300,1),ones(300,1),mean(TS7_24day_TA_filled,2,'omitnan')];
X_predict_TS7_ds    = [TS7_modis_24day.LAIqc,time_since_dis_24day,ones(300,1),mean(TS7_24day_TA_filled,2,'omitnan')];

Y_predict_TS7_nonds = predict(mdl3_24day,X_predict_TS7_nonds);
Y_predict_TS7_ds = predict(mdl3_24day,X_predict_TS7_ds);

xy_plot_TS7_nonds = sort([TS7_modis_24day.LAIqc,Y_predict_TS7_nonds],1);
xy_plot_TS7_ds = sort([TS7_modis_24day.LAIqc,Y_predict_TS7_ds],1);


plot(TS7_modis_24day.LAIqc,TS7_24day_beta_MM(:,3),'.','Color',[0.8500 0.3250 0.0980],'MarkerSize',12)
plot(SRS6_modis_24day.LAIqc,SRS6_24day_beta_MM(:,3),'.','Color',[0 0.4470 0.7410],'MarkerSize',12)
%plot(SRS6_modis.LAIqc(index_ds),SRS6_8day_beta_MM(index_ds,3),'.r','MarkerSize',10)

plot(xy_plot_SRS6_nonds(:,1),xy_plot_SRS6_nonds(:,2),'-','Color',[0 0.4470 0.7410])
plot(xy_plot_SRS6_ds(:,1),xy_plot_SRS6_ds(:,2),':','Color',[0 0.4470 0.7410])


plot(xy_plot_TS7_nonds(:,1),xy_plot_TS7_nonds(:,2),'-','Color',[0.8500 0.3250 0.0980])
plot(xy_plot_TS7_ds(:,1),xy_plot_TS7_ds(:,2),':','Color',[0.8500 0.3250 0.0980])

ylabel('Amax (µmol m^-^2s^-^1)')
xlabel('LAI (m^2 m^-^2)')
ntitle('(d) ','location','northeast');
xlim([1 7.5])
ylim([0 62])
box on






%%% modeling LRC for fig 6 and 7



%%%%%% SI Figure, justify using mean for debt recovery


for i=1:15
    SRS6_24day_annual_reco(i) = mean(SRS6_24day_beta_MM((0+i):15:300,1),'omitnan');
    SRS6_24day_annual_qy(i) = mean(SRS6_24day_beta_MM((0+i):15:300,2),'omitnan');
    SRS6_24day_annual_amax(i) = mean(SRS6_24day_beta_MM((0+i):15:300,3),'omitnan');

    TS7_24day_annual_reco(i) = mean(TS7_24day_beta_MM((0+i):15:300,1),'omitnan');
    TS7_24day_annual_qy(i) = mean(TS7_24day_beta_MM((0+i):15:300,2),'omitnan');
    TS7_24day_annual_amax(i) = mean(TS7_24day_beta_MM((0+i):15:300,3),'omitnan');
end

subplot(3,1,1)
hold on
plot(SRS6_24day_annual_reco,'Color',[0 0.4470 0.7410])

plot(SRS6_24day_beta_MM(1:15,1),'.','Color',[0 0.4470 0.7410])
plot(SRS6_24day_beta_MM(16:27,1),'.','Color',[0 0.4470 0.7410]) % hurricane on index 28
plot(SRS6_24day_beta_MM(28:30,1),'.','Color',[0 0.4470 0.7410])
plot(SRS6_24day_beta_MM(31:45,1),'.','Color',[0 0.4470 0.7410])
plot(SRS6_24day_beta_MM(46:60,1),'.','Color',[0 0.4470 0.7410])
plot(SRS6_24day_beta_MM(61:75,1),'.','Color',[0 0.4470 0.7410])
plot(SRS6_24day_beta_MM(76:87,1),'.','Color',[0 0.4470 0.7410])
plot(SRS6_24day_beta_MM(88:90,1),'.','Color',[0 0.4470 0.7410])
plot(SRS6_24day_beta_MM(88:90,1),'.','Color',[0 0.4470 0.7410])
plot(SRS6_24day_beta_MM(91:105,1),'.','Color',[0 0.4470 0.7410])
plot(SRS6_24day_beta_MM(106:120,1),'.','Color',[0 0.4470 0.7410])

plot(SRS6_24day_beta_MM(196:210,1),'.','Color',[0 0.4470 0.7410])
plot(SRS6_24day_beta_MM(211:225,1),'.','Color',[0 0.4470 0.7410])
plot(SRS6_24day_beta_MM(226:240,1),'.','Color',[0 0.4470 0.7410])
plot(SRS6_24day_beta_MM(241:255,1),'.','Color',[0 0.4470 0.7410])
plot(SRS6_24day_beta_MM(256:270,1),'.','Color',[0 0.4470 0.7410])
plot(SRS6_24day_beta_MM(271:285,1),'.','Color',[0 0.4470 0.7410])
plot(SRS6_24day_beta_MM(286:300,1),'.','Color',[0 0.4470 0.7410])

plot(TS7_24day_annual_reco,'Color',[0.8500 0.3250 0.0980])

plot(TS7_24day_beta_MM(196:210,1),'.','Color',[0.8500 0.3250 0.0980])
plot(TS7_24day_beta_MM(211:225,1),'.','Color',[0.8500 0.3250 0.0980])
plot(TS7_24day_beta_MM(226:240,1),'.','Color',[0.8500 0.3250 0.0980])
plot(TS7_24day_beta_MM(241:255,1),'.','Color',[0.8500 0.3250 0.0980])
plot(TS7_24day_beta_MM(256:270,1),'.','Color',[0.8500 0.3250 0.0980])
plot(TS7_24day_beta_MM(271:285,1),'.','Color',[0.8500 0.3250 0.0980])
plot(TS7_24day_beta_MM(286:300,1),'.','Color',[0.8500 0.3250 0.0980])

box on
xticks([1,6,11,15])
xticklabels({'','','',''})
ylabel('R_e_c_o (µmol m^-^2s^-^1)')
ntitle('(a) ','location','northeast');
xlim([0.5,15.5])

subplot(3,1,2)
hold on
plot(SRS6_24day_annual_qy,'Color',[0 0.4470 0.7410])
plot(TS7_24day_annual_qy,'Color',[0.8500 0.3250 0.0980])

plot(SRS6_24day_beta_MM(1:15,2),'.','Color',[0 0.4470 0.7410])
plot(SRS6_24day_beta_MM(16:27,2),'.','Color',[0 0.4470 0.7410]) % hurricane on index 28
plot(SRS6_24day_beta_MM(28:30,2),'.','Color',[0 0.4470 0.7410])
plot(SRS6_24day_beta_MM(31:45,2),'.','Color',[0 0.4470 0.7410])
plot(SRS6_24day_beta_MM(46:60,2),'.','Color',[0 0.4470 0.7410])
plot(SRS6_24day_beta_MM(61:75,2),'.','Color',[0 0.4470 0.7410])
plot(SRS6_24day_beta_MM(76:87,2),'.','Color',[0 0.4470 0.7410])
plot(SRS6_24day_beta_MM(88:90,2),'.','Color',[0 0.4470 0.7410])
plot(SRS6_24day_beta_MM(88:90,2),'.','Color',[0 0.4470 0.7410])
plot(SRS6_24day_beta_MM(91:105,2),'.','Color',[0 0.4470 0.7410])
plot(SRS6_24day_beta_MM(106:120,2),'.','Color',[0 0.4470 0.7410])

plot(SRS6_24day_beta_MM(196:210,2),'.','Color',[0 0.4470 0.7410])
plot(SRS6_24day_beta_MM(211:225,2),'.','Color',[0 0.4470 0.7410])
plot(SRS6_24day_beta_MM(226:240,2),'.','Color',[0 0.4470 0.7410])
plot(SRS6_24day_beta_MM(241:255,2),'.','Color',[0 0.4470 0.7410])
plot(SRS6_24day_beta_MM(256:270,2),'.','Color',[0 0.4470 0.7410])
plot(SRS6_24day_beta_MM(271:285,2),'.','Color',[0 0.4470 0.7410])
plot(SRS6_24day_beta_MM(286:300,2),'.','Color',[0 0.4470 0.7410])



plot(TS7_24day_beta_MM(196:210,2),'.','Color',[0.8500 0.3250 0.0980])
plot(TS7_24day_beta_MM(211:225,2),'.','Color',[0.8500 0.3250 0.0980])
plot(TS7_24day_beta_MM(226:240,2),'.','Color',[0.8500 0.3250 0.0980])
plot(TS7_24day_beta_MM(241:255,2),'.','Color',[0.8500 0.3250 0.0980])
plot(TS7_24day_beta_MM(256:270,2),'.','Color',[0.8500 0.3250 0.0980])
plot(TS7_24day_beta_MM(271:285,2),'.','Color',[0.8500 0.3250 0.0980])
plot(TS7_24day_beta_MM(286:300,2),'.','Color',[0.8500 0.3250 0.0980])

box on
xticks([1,6,11,15])
xticklabels({'','','',''})
ylabel('Quantum Yield (µmol J^-^1)')
ntitle('(b) ','location','northeast');
xlim([0.5,15.5])
legend('Mangrove Forest','Mangrove Scrub','Location','northwest')

subplot(3,1,3)
hold on
plot(SRS6_24day_annual_amax,'Color',[0 0.4470 0.7410])

plot(SRS6_24day_beta_MM(1:15,3),'.','Color',[0 0.4470 0.7410])
plot(SRS6_24day_beta_MM(16:27,3),'.','Color',[0 0.4470 0.7410]) % hurricane on index 28
plot(SRS6_24day_beta_MM(28:30,3),'.','Color',[0 0.4470 0.7410])
plot(SRS6_24day_beta_MM(31:45,3),'.','Color',[0 0.4470 0.7410])
plot(SRS6_24day_beta_MM(46:60,3),'.','Color',[0 0.4470 0.7410])
plot(SRS6_24day_beta_MM(61:75,3),'.','Color',[0 0.4470 0.7410])
plot(SRS6_24day_beta_MM(76:87,3),'.','Color',[0 0.4470 0.7410])
plot(SRS6_24day_beta_MM(88:90,3),'.','Color',[0 0.4470 0.7410])
plot(SRS6_24day_beta_MM(88:90,3),'.','Color',[0 0.4470 0.7410])
plot(SRS6_24day_beta_MM(91:105,3),'.','Color',[0 0.4470 0.7410])
plot(SRS6_24day_beta_MM(106:120,3),'.','Color',[0 0.4470 0.7410])

plot(SRS6_24day_beta_MM(196:210,3),'.','Color',[0 0.4470 0.7410])
plot(SRS6_24day_beta_MM(211:225,3),'.','Color',[0 0.4470 0.7410])
plot(SRS6_24day_beta_MM(226:240,3),'.','Color',[0 0.4470 0.7410])
plot(SRS6_24day_beta_MM(241:255,3),'.','Color',[0 0.4470 0.7410])
plot(SRS6_24day_beta_MM(256:270,3),'.','Color',[0 0.4470 0.7410])
plot(SRS6_24day_beta_MM(271:285,3),'.','Color',[0 0.4470 0.7410])
plot(SRS6_24day_beta_MM(286:300,3),'.','Color',[0 0.4470 0.7410])

plot(TS7_24day_annual_amax,'Color',[0.8500 0.3250 0.0980])

plot(TS7_24day_beta_MM(196:210,3),'.','Color',[0.8500 0.3250 0.0980])
plot(TS7_24day_beta_MM(211:225,3),'.','Color',[0.8500 0.3250 0.0980])
plot(TS7_24day_beta_MM(226:240,3),'.','Color',[0.8500 0.3250 0.0980])
plot(TS7_24day_beta_MM(241:255,3),'.','Color',[0.8500 0.3250 0.0980])
plot(TS7_24day_beta_MM(256:270,3),'.','Color',[0.8500 0.3250 0.0980])
plot(TS7_24day_beta_MM(271:285,3),'.','Color',[0.8500 0.3250 0.0980])
plot(TS7_24day_beta_MM(286:300,3),'.','Color',[0.8500 0.3250 0.0980])

box on
xticks([1,6,11,15])
xticklabels({'Jan','May','Sept','Dec'})
ylabel('Amax (µmol m^-^2s^-^1)')
ntitle('(c) ','location','northeast');
xlim([0.5,15.5])




%%%%% figure 6   LAI, Reco, QY, and Amax recovery debt


%smoothing post-distrubance data
SRS6_LAI_fouryear_smooth = smooth(mean([SRS6_modis_24day.LAIqc(wilma_fouryear_ind),SRS6_modis_24day.LAIqc(irma_fouryear_ind)],2,"omitnan"),0.5,'rloess');
TS7_LAI_fouryear_smooth = smooth(TS7_modis_24day.LAIqc(irma_fouryear_ind),0.5,'rloess');


SRS6_Reco_fouryear_smooth = smooth(mean([SRS6_24day_beta_MM(index_24day_ds_yr1_yr4(1:60),1),SRS6_24day_beta_MM(index_24day_ds_yr1_yr4(61:120),1)],2,"omitnan"),0.5,'rloess');
TS7_Reco_fouryear_smooth = smooth(TS7_24day_beta_MM(index_24day_ds_yr1_yr4(61:120),1),0.5,'rloess');
SRS6_Reco_fouryear_smooth(1:9)=nan;
SRS6_LRCmodel_Reco_fouryear_smooth = smooth(mean([SRS6_LRCmodel_Reco(index_24day_ds_yr1_yr4(1:60)),SRS6_LRCmodel_Reco(index_24day_ds_yr1_yr4(61:120))],2,"omitnan"),0.5,'rloess');
TS7_LRCmodel_Reco_fouryear_smooth = smooth(TS7_LRCmodel_Reco(index_24day_ds_yr1_yr4(61:120)),0.5,'rloess');
%SRS6_LRCmodel_Reco_fouryear_smooth(1:7)=nan;

SRS6_Reco_TRC_fouryear_smooth = smooth(mean([SRS6_24day_beta_TRC(index_24day_ds_yr1_yr4(1:60),1),SRS6_24day_beta_TRC(index_24day_ds_yr1_yr4(61:120),1)],2,"omitnan"),0.5,'rloess');
TS7_Reco_TRC_fouryear_smooth = smooth(TS7_24day_beta_TRC(index_24day_ds_yr1_yr4(61:120),1),0.5,'rloess');
SRS6_Reco_TRC_fouryear_smooth(1:9)=nan;
SRS6_24day_TRCmodel_Reco_dailyave=SRS6_24day_TRCmodel_Reco_dailyave';
SRS6_TRCmodel_Reco_fouryear_smooth = smooth(mean([SRS6_24day_TRCmodel_Reco_dailyave(index_24day_ds_yr1_yr4(1:60)),SRS6_24day_TRCmodel_Reco_dailyave(index_24day_ds_yr1_yr4(61:120))],2,"omitnan"),0.5,'rloess');
TS7_TRCmodel_Reco_fouryear_smooth = smooth(TS7_24day_TRCmodel_Reco(index_24day_ds_yr1_yr4(61:120)),0.5,'rloess');


SRS6_Amax_fouryear_smooth = smooth(mean([SRS6_24day_beta_MM(index_24day_ds_yr1_yr4(1:60),3),SRS6_24day_beta_MM(index_24day_ds_yr1_yr4(61:120),3)],2,"omitnan"),0.5,'rloess');
TS7_Amax_fouryear_smooth = smooth(TS7_24day_beta_MM(index_24day_ds_yr1_yr4(61:120),3),0.5,'rloess');
SRS6_Amax_fouryear_smooth(1:9)=nan;
SRS6_LRCmodel_Amax_fouryear_smooth = smooth(mean([SRS6_LRCmodel_Amax(index_24day_ds_yr1_yr4(1:60)),SRS6_LRCmodel_Amax(index_24day_ds_yr1_yr4(61:120))],2,"omitnan"),0.5,'rloess');
TS7_LRCmodel_Amax_fouryear_smooth = smooth(TS7_LRCmodel_Amax(index_24day_ds_yr1_yr4(61:120)),0.5,'rloess');
%SRS6_LRCmodel_Amax_fouryear_smooth(1:7)=nan;



subplot(2,2,1)
hold on
plot(SRS6_modis_24day.LAIqc(wilma_fiveyear_ind),'.','Color',[0 0.4470 0.7410],'MarkerSize',12)
plot(SRS6_modis_24day.LAIqc(irma_fiveyear_ind),'.','Color',[0 0.4470 0.7410],'MarkerSize',12)
plot(TS7_modis_24day.LAIqc(irma_fiveyear_ind),'.','Color',[0.8500 0.3250 0.0980],'MarkerSize',12)
%add fancy lines
plot([15,15],[0,8],"--k","LineWidth", 2)   %15 is the number of 24-day periods in one year
plot([0,15],[6.15,6.15],"LineWidth", 2,'Color',[0 0.4470 0.7410]) %nondisutrbance mean LAI 6.15
plot([0,15],[2.97,2.97],"LineWidth", 2,'Color',[0.8500 0.3250 0.0980]) %nondisutrbance mean LAI 2.97
%add fancy smoothin
plot(16:75,SRS6_LAI_fouryear_smooth,"LineWidth", 2,'Color',[0 0.4470 0.7410],'MarkerSize',12)
plot(16:75,TS7_LAI_fouryear_smooth,"LineWidth", 2,'Color',[0.8500 0.3250 0.0980],'MarkerSize',12)
box on
ylabel('LAI (m^2 m^-^2)')
ntitle(' (a)','location','northwest');
xticks([0 15 30 45 60 75])
xticklabels({'','','','','',''})
xlim([0 75])


subplot(2,2,2)
hold on
plot(1:15,SRS6_24day_beta_MM(index_24day_ds_minusyr1(1:15),1),'.','Color',[0 0.4470 0.7410],'MarkerSize',12)
plot(nan,nan,'o','Color',[0 0.4470 0.7410],'MarkerSize',4) %for the legend
plot(nan,nan,'.','Color',[0.8500 0.3250 0.0980],'MarkerSize',12) %for the legend
plot(nan,nan,'o','Color',[0.8500 0.3250 0.0980],'MarkerSize',4) %for the legend
plot(1:15,SRS6_24day_beta_MM(index_24day_ds_minusyr1(16:30),1),'.','Color',[0 0.4470 0.7410],'MarkerSize',12)
plot(16:30,SRS6_24day_beta_MM(index_24day_ds_yr1(1:15),1),'.','Color',[0 0.4470 0.7410],'MarkerSize',12)
plot(16:30,SRS6_24day_beta_MM(index_24day_ds_yr1(16:30),1),'.','Color',[0 0.4470 0.7410],'MarkerSize',12)
plot(31:45,SRS6_24day_beta_MM(index_24day_ds_yr2(1:15),1),'.','Color',[0 0.4470 0.7410],'MarkerSize',12)
plot(31:45,SRS6_24day_beta_MM(index_24day_ds_yr2(16:30),1),'.','Color',[0 0.4470 0.7410],'MarkerSize',12)
plot(46:60,SRS6_24day_beta_MM(index_24day_ds_yr3(1:15),1),'.','Color',[0 0.4470 0.7410],'MarkerSize',12)
plot(46:60,SRS6_24day_beta_MM(index_24day_ds_yr3(16:30),1),'.','Color',[0 0.4470 0.7410],'MarkerSize',12)
plot(61:75,SRS6_24day_beta_MM(index_24day_ds_yr4(1:15),1),'.','Color',[0 0.4470 0.7410],'MarkerSize',12)
plot(61:75,SRS6_24day_beta_MM(index_24day_ds_yr4(16:30),1),'.','Color',[0 0.4470 0.7410],'MarkerSize',12)

plot(1:15,TS7_24day_beta_MM(index_24day_ds_minusyr1(16:30),1),'.','Color',[0.8500 0.3250 0.0980],'MarkerSize',12)
plot(16:30,TS7_24day_beta_MM(index_24day_ds_yr1(16:30),1),'.','Color',[0.8500 0.3250 0.0980],'MarkerSize',12)
plot(31:45,TS7_24day_beta_MM(index_24day_ds_yr2(16:30),1),'.','Color',[0.8500 0.3250 0.0980],'MarkerSize',12)
plot(46:60,TS7_24day_beta_MM(index_24day_ds_yr3(16:30),1),'.','Color',[0.8500 0.3250 0.0980],'MarkerSize',12)
plot(61:75,TS7_24day_beta_MM(index_24day_ds_yr4(16:30),1),'.','Color',[0.8500 0.3250 0.0980],'MarkerSize',12)

%LRC modeled data
plot(1:15,SRS6_LRCmodel_Reco(index_24day_ds_minusyr1(16:30)),'o','Color',[0 0.4470 0.7410],'MarkerSize',4)
plot(16:30,SRS6_LRCmodel_Reco(index_24day_ds_yr1(16:30)),'o','Color',[0 0.4470 0.7410],'MarkerSize',4)
plot(31:45,SRS6_LRCmodel_Reco(index_24day_ds_yr2(16:30)),'o','Color',[0 0.4470 0.7410],'MarkerSize',4)
plot(46:60,SRS6_LRCmodel_Reco(index_24day_ds_yr3(16:30)),'o','Color',[0 0.4470 0.7410],'MarkerSize',4)
plot(61:75,SRS6_LRCmodel_Reco(index_24day_ds_yr4(16:30)),'o','Color',[0 0.4470 0.7410],'MarkerSize',4)

plot(1:15,TS7_LRCmodel_Reco(index_24day_ds_minusyr1(16:30)),'o','Color',[0.8500 0.3250 0.0980],'MarkerSize',4)
plot(16:30,TS7_LRCmodel_Reco(index_24day_ds_yr1(16:30)),'o','Color',[0.8500 0.3250 0.0980],'MarkerSize',4)
plot(31:45,TS7_LRCmodel_Reco(index_24day_ds_yr2(16:30)),'o','Color',[0.8500 0.3250 0.0980],'MarkerSize',4)
plot(46:60,TS7_LRCmodel_Reco(index_24day_ds_yr3(16:30)),'o','Color',[0.8500 0.3250 0.0980],'MarkerSize',4)
plot(61:75,TS7_LRCmodel_Reco(index_24day_ds_yr4(16:30)),'o','Color',[0.8500 0.3250 0.0980],'MarkerSize',4)


%add fancy lines
plot([15,15],[-3,25],"--k","LineWidth", 2)   %45 is the number of 8-day periods in one year
%nanmean(SRS6_24day_beta_MM(index_24day_ds_minusyr1,1))
plot([0,15],[5.53,5.53],"LineWidth", 2,'Color',[0 0.4470 0.7410]) %nondisutrbance mean Reco 5.53
plot([0,15],[1.38,1.38],"LineWidth", 2,'Color',[0.8500 0.3250 0.0980]) %nondisutrbance mean Reco 1.38
%nanmean(TS7_LRCmodel_Reco(index_24day_ds_minusyr1))
plot([0,15],[7.01,7.01],":","LineWidth", 2,'Color',[0 0.4470 0.7410]) %nondisutrbance mean Reco 7.01
plot([0,15],[0.54,0.54],":","LineWidth", 2,'Color',[0.8500 0.3250 0.0980]) %nondisutrbance mean Reco 0.54
%add fancy smoothin
plot(16:75,SRS6_Reco_fouryear_smooth,"LineWidth", 2,'Color',[0 0.4470 0.7410])
plot(16:75,TS7_Reco_fouryear_smooth,"LineWidth", 2,'Color',[0.8500 0.3250 0.0980])
plot(16:75,SRS6_LRCmodel_Reco_fouryear_smooth,":","LineWidth", 2,'Color',[0 0.4470 0.7410])
plot(16:75,TS7_LRCmodel_Reco_fouryear_smooth,":","LineWidth", 2,'Color',[0.8500 0.3250 0.0980])


xticks([0 15 30 45 60 75])
xticklabels({'','','','','',''})
xlim([0 75])
ylim([-3 25])
box on
legend('EC Tall Forest','Modeled Tall Forest','EC Scrub Forest','Modeled Scrub Forest','Location','northeast')
ylabel('Light Based R_e_c_o (µmol m^-^2s^-^1)')
ntitle(' (b)','location','northwest');


subplot(2,2,4)
hold on
plot(1:15,SRS6_24day_beta_TRC(index_24day_ds_minusyr1(1:15),1),'.','Color',[0 0.4470 0.7410],'MarkerSize',12)
plot(nan,nan,'o','Color',[0 0.4470 0.7410],'MarkerSize',4) %for the legend
plot(nan,nan,'.','Color',[0.8500 0.3250 0.0980],'MarkerSize',12) %for the legend
plot(nan,nan,'o','Color',[0.8500 0.3250 0.0980],'MarkerSize',4) %for the legend
plot(1:15,SRS6_24day_beta_TRC(index_24day_ds_minusyr1(16:30),1),'.','Color',[0 0.4470 0.7410],'MarkerSize',12)
plot(16:30,SRS6_24day_beta_TRC(index_24day_ds_yr1(1:15),1),'.','Color',[0 0.4470 0.7410],'MarkerSize',12)
plot(16:30,SRS6_24day_beta_TRC(index_24day_ds_yr1(16:30),1),'.','Color',[0 0.4470 0.7410],'MarkerSize',12)
plot(31:45,SRS6_24day_beta_TRC(index_24day_ds_yr2(1:15),1),'.','Color',[0 0.4470 0.7410],'MarkerSize',12)
plot(31:45,SRS6_24day_beta_TRC(index_24day_ds_yr2(16:30),1),'.','Color',[0 0.4470 0.7410],'MarkerSize',12)
plot(46:60,SRS6_24day_beta_TRC(index_24day_ds_yr3(1:15),1),'.','Color',[0 0.4470 0.7410],'MarkerSize',12)
plot(46:60,SRS6_24day_beta_TRC(index_24day_ds_yr3(16:30),1),'.','Color',[0 0.4470 0.7410],'MarkerSize',12)
plot(61:75,SRS6_24day_beta_TRC(index_24day_ds_yr4(1:15),1),'.','Color',[0 0.4470 0.7410],'MarkerSize',12)
plot(61:75,SRS6_24day_beta_TRC(index_24day_ds_yr4(16:30),1),'.','Color',[0 0.4470 0.7410],'MarkerSize',12)

plot(1:15,TS7_24day_beta_TRC(index_24day_ds_minusyr1(16:30),1),'.','Color',[0.8500 0.3250 0.0980],'MarkerSize',12)
plot(16:30,TS7_24day_beta_TRC(index_24day_ds_yr1(16:30),1),'.','Color',[0.8500 0.3250 0.0980],'MarkerSize',12)
plot(31:45,TS7_24day_beta_TRC(index_24day_ds_yr2(16:30),1),'.','Color',[0.8500 0.3250 0.0980],'MarkerSize',12)
plot(46:60,TS7_24day_beta_TRC(index_24day_ds_yr3(16:30),1),'.','Color',[0.8500 0.3250 0.0980],'MarkerSize',12)
plot(61:75,TS7_24day_beta_TRC(index_24day_ds_yr4(16:30),1),'.','Color',[0.8500 0.3250 0.0980],'MarkerSize',12)

%LRC modeled data
plot(1:15,SRS6_24day_TRCmodel_Reco_dailyave(index_24day_ds_minusyr1(16:30)),'o','Color',[0 0.4470 0.7410],'MarkerSize',4)
plot(16:30,SRS6_24day_TRCmodel_Reco_dailyave(index_24day_ds_yr1(16:30)),'o','Color',[0 0.4470 0.7410],'MarkerSize',4)
plot(31:45,SRS6_24day_TRCmodel_Reco_dailyave(index_24day_ds_yr2(16:30)),'o','Color',[0 0.4470 0.7410],'MarkerSize',4)
plot(46:60,SRS6_24day_TRCmodel_Reco_dailyave(index_24day_ds_yr3(16:30)),'o','Color',[0 0.4470 0.7410],'MarkerSize',4)
plot(61:75,SRS6_24day_TRCmodel_Reco_dailyave(index_24day_ds_yr4(16:30)),'o','Color',[0 0.4470 0.7410],'MarkerSize',4)

plot(1:15,TS7_24day_TRCmodel_Reco_dailyave(index_24day_ds_minusyr1(16:30)),'o','Color',[0.8500 0.3250 0.0980],'MarkerSize',4)
plot(16:30,TS7_24day_TRCmodel_Reco_dailyave(index_24day_ds_yr1(16:30)),'o','Color',[0.8500 0.3250 0.0980],'MarkerSize',4)
plot(31:45,TS7_24day_TRCmodel_Reco_dailyave(index_24day_ds_yr2(16:30)),'o','Color',[0.8500 0.3250 0.0980],'MarkerSize',4)
plot(46:60,TS7_24day_TRCmodel_Reco_dailyave(index_24day_ds_yr3(16:30)),'o','Color',[0.8500 0.3250 0.0980],'MarkerSize',4)
plot(61:75,TS7_24day_TRCmodel_Reco_dailyave(index_24day_ds_yr4(16:30)),'o','Color',[0.8500 0.3250 0.0980],'MarkerSize',4)


%add fancy lines
plot([15,15],[-2,10],"--k","LineWidth", 2)   %45 is the number of 8-day periods in one year
%nanmean(TS7_24day_beta_TRC(index_24day_ds_minusyr1,1))
plot([0,15],[2.1492,2.1492],"LineWidth", 2,'Color',[0 0.4470 0.7410]) %nondisutrbance mean Reco 2.1492
plot([0,15],[0.5349,0.5349],"LineWidth", 2,'Color',[0.8500 0.3250 0.0980]) %nondisutrbance mean Reco 0.5349
%nanmean(SRS6_24day_TRCmodel_Reco_dailyave(index_24day_ds_minusyr1))
plot([0,15],[3.8019,3.8019],":","LineWidth", 2,'Color',[0 0.4470 0.7410]) %nondisutrbance mean Reco 3.8019
plot([0,15],[0.9261,0.9261],":","LineWidth", 2,'Color',[0.8500 0.3250 0.0980]) %nondisutrbance mean Reco 0.9261
%add fancy smoothin
plot(16:75,SRS6_Reco_TRC_fouryear_smooth,"LineWidth", 2,'Color',[0 0.4470 0.7410])
plot(16:75,TS7_Reco_TRC_fouryear_smooth,"LineWidth", 2,'Color',[0.8500 0.3250 0.0980])
plot(16:75,SRS6_TRCmodel_Reco_fouryear_smooth,":","LineWidth", 2,'Color',[0 0.4470 0.7410])
plot(16:75,TS7_TRCmodel_Reco_fouryear_smooth,":","LineWidth", 2,'Color',[0.8500 0.3250 0.0980])


xticks([0 15 30 45 60 75])
xticklabels({'','','','','',''})
xticklabels({'Year = -1','Hurricane','Year = 1','Year = 2','Year = 3','Year = 4'})
xlim([0 75])
ylim([-0.5 8])
box on
ylabel('Temperature Based R_e_c_o (µmol m^-^2s^-^1)')
ntitle(' (d)','location','northwest');


subplot(2,2,3)
hold on
plot(1:15,SRS6_24day_beta_MM(index_24day_ds_minusyr1(1:15),3),'.','Color',[0 0.4470 0.7410],'MarkerSize',12)
plot(1:15,SRS6_24day_beta_MM(index_24day_ds_minusyr1(16:30),3),'.','Color',[0 0.4470 0.7410],'MarkerSize',12)
plot(16:30,SRS6_24day_beta_MM(index_24day_ds_yr1(1:15),3),'.','Color',[0 0.4470 0.7410],'MarkerSize',12)
plot(16:30,SRS6_24day_beta_MM(index_24day_ds_yr1(16:30),3),'.','Color',[0 0.4470 0.7410],'MarkerSize',12)
plot(31:45,SRS6_24day_beta_MM(index_24day_ds_yr2(1:15),3),'.','Color',[0 0.4470 0.7410],'MarkerSize',12)
plot(31:45,SRS6_24day_beta_MM(index_24day_ds_yr2(16:30),3),'.','Color',[0 0.4470 0.7410],'MarkerSize',12)
plot(46:60,SRS6_24day_beta_MM(index_24day_ds_yr3(1:15),3),'.','Color',[0 0.4470 0.7410],'MarkerSize',12)
plot(46:60,SRS6_24day_beta_MM(index_24day_ds_yr3(16:30),3),'.','Color',[0 0.4470 0.7410],'MarkerSize',12)
plot(61:75,SRS6_24day_beta_MM(index_24day_ds_yr4(1:15),3),'.','Color',[0 0.4470 0.7410],'MarkerSize',12)
plot(61:75,SRS6_24day_beta_MM(index_24day_ds_yr4(16:30),3),'.','Color',[0 0.4470 0.7410],'MarkerSize',12)

plot(1:15,TS7_24day_beta_MM(index_24day_ds_minusyr1(16:30),3),'.','Color',[0.8500 0.3250 0.0980],'MarkerSize',12)
plot(16:30,TS7_24day_beta_MM(index_24day_ds_yr1(16:30),3),'.','Color',[0.8500 0.3250 0.0980],'MarkerSize',12)
plot(31:45,TS7_24day_beta_MM(index_24day_ds_yr2(16:30),3),'.','Color',[0.8500 0.3250 0.0980],'MarkerSize',12)
plot(46:60,TS7_24day_beta_MM(index_24day_ds_yr3(16:30),3),'.','Color',[0.8500 0.3250 0.0980],'MarkerSize',12)
plot(61:75,TS7_24day_beta_MM(index_24day_ds_yr4(16:30),3),'.','Color',[0.8500 0.3250 0.0980],'MarkerSize',12)

%LRC modeled data
plot(1:15,SRS6_LRCmodel_Amax(index_24day_ds_minusyr1(16:30)),'o','Color',[0 0.4470 0.7410],'MarkerSize',4)
plot(16:30,SRS6_LRCmodel_Amax(index_24day_ds_yr1(16:30)),'o','Color',[0 0.4470 0.7410],'MarkerSize',4)
plot(31:45,SRS6_LRCmodel_Amax(index_24day_ds_yr2(16:30)),'o','Color',[0 0.4470 0.7410],'MarkerSize',4)
plot(46:60,SRS6_LRCmodel_Amax(index_24day_ds_yr3(16:30)),'o','Color',[0 0.4470 0.7410],'MarkerSize',4)
plot(61:75,SRS6_LRCmodel_Amax(index_24day_ds_yr4(16:30)),'o','Color',[0 0.4470 0.7410],'MarkerSize',4)

plot(1:15,TS7_LRCmodel_Amax(index_24day_ds_minusyr1(16:30)),'o','Color',[0.8500 0.3250 0.0980],'MarkerSize',4)
plot(16:30,TS7_LRCmodel_Amax(index_24day_ds_yr1(16:30)),'o','Color',[0.8500 0.3250 0.0980],'MarkerSize',4)
plot(31:45,TS7_LRCmodel_Amax(index_24day_ds_yr2(16:30)),'o','Color',[0.8500 0.3250 0.0980],'MarkerSize',4)
plot(46:60,TS7_LRCmodel_Amax(index_24day_ds_yr3(16:30)),'o','Color',[0.8500 0.3250 0.0980],'MarkerSize',4)
plot(61:75,TS7_LRCmodel_Amax(index_24day_ds_yr4(16:30)),'o','Color',[0.8500 0.3250 0.0980],'MarkerSize',4)

%add fancy lines
plot([15,15],[0,60],"--k","LineWidth", 2)   %15 is the number of 24-day periods in one year
%nanmean(SRS6_24day_beta_MM(index_24day_ds_minusyr1,3))
plot([0,15],[28.77,28.77],"LineWidth", 2,'Color',[0 0.4470 0.7410]) %nondisutrbance mean Amax 28.77
plot([0,15],[6.65,6.65],"LineWidth", 2,'Color',[0.8500 0.3250 0.0980]) %nondisutrbance mean Amax 6.65
%nanmean(TS7_LRCmodel_Amax(index_24day_ds_minusyr1))
plot([0,15],[32.97,32.97],":","LineWidth", 2,'Color',[0 0.4470 0.7410]) %nondisutrbance mean Reco  32.97
plot([0,15],[9.06,9.06],":","LineWidth", 2,'Color',[0.8500 0.3250 0.0980]) %nondisutrbance mean Reco 9.06
%add fancy smoothin
plot(16:75,SRS6_Amax_fouryear_smooth,"LineWidth", 2,'Color',[0 0.4470 0.7410],'MarkerSize',12)
plot(16:75,TS7_Amax_fouryear_smooth,"LineWidth", 2,'Color',[0.8500 0.3250 0.0980],'MarkerSize',12)
plot(16:75,SRS6_LRCmodel_Amax_fouryear_smooth,":","LineWidth", 2,'Color',[0 0.4470 0.7410])
plot(16:75,TS7_LRCmodel_Amax_fouryear_smooth,":","LineWidth", 2,'Color',[0.8500 0.3250 0.0980])

xticks([0 15 30 45 60 75])
xticklabels({'Year = -1','Hurricane','Year = 1','Year = 2','Year = 3','Year = 4'})
xlim([0 75])
ylim([0 40])
box on
ylabel('Amax (µmol m^-^2s^-^1)')
ntitle(' (c)','location','northwest');








%%%%%%%%%%%%% Figure 7 NEP recovery debt


%smoothing post-distrubance data
SRS6_NEE_fouryear_smooth = smooth(mean([SRS6_24day_NEE_dailyave(wilma_fouryear_ind)',SRS6_24day_NEE_dailyave(irma_fouryear_ind)'],2,"omitnan"),0.5,'rloess');
TS7_NEE_fouryear_smooth = smooth(TS7_24day_NEE_dailyave(irma_fouryear_ind),0.5,'rloess');
SRS6_NEE_fouryear_smooth(1:8)=nan;


SRS6_LRCmodel_NEE_fouryear_smooth = smooth(mean([SRS6_24day_LRCmodel_NEE_dailyave(wilma_fouryear_ind)',SRS6_24day_LRCmodel_NEE_dailyave(irma_fouryear_ind)'],2,"omitnan"),0.5,'rloess');
TS7_LRCmodel_NEE_fouryear_smooth = smooth(TS7_24day_LRCmodel_NEE_dailyave(irma_fouryear_ind),0.5,'rloess');
%SRS6_LRCmodel_NEE_fouryear_smooth(1:6)=nan;


SRS6_TRCmodel_NEE_fouryear_smooth = smooth(mean([SRS6_24day_TRCmodel_NEE_dailyave(wilma_fouryear_ind)',SRS6_24day_TRCmodel_NEE_dailyave(irma_fouryear_ind)'],2,"omitnan"),0.5,'rloess');
TS7_TRCmodel_NEE_fouryear_smooth = smooth(TS7_24day_TRCmodel_NEE_dailyave(irma_fouryear_ind),0.5,'rloess');

%non-disturbance means
%mean(SRS6_24day_NEE_dailyave(~or(wilma_fouryear_ind,irma_fouryear_ind)),"omitnan") -2.9956
%mean(TS7_24day_NEE_dailyave(~irma_fouryear_ind),"omitnan") -1.1308

%mean(SRS6_24day_LRCmodel_NEP_dailyave(~or(wilma_fouryear_ind,irma_fouryear_ind)),"omitnan") 1.6616
%mean(TS7_24day_LRCmodel_NEP_dailyave(~irma_fouryear_ind),"omitnan") 1.6563


%nanmean(SRS6_24day_NEE_dailyave(index_24day_ds_minusyr1)) -3.4097
%nanmean(TS7_24day_NEE_dailyave(index_24day_ds_minusyr1)) -1.1780

%nanmean(SRS6_24day_LRCmodel_NEP_dailyave(index_24day_ds_minusyr1)) 2.4004
%nanmean(TS7_24day_LRCmodel_NEP_dailyave(index_24day_ds_minusyr1)) 2.5586

%nanmean(SRS6_24day_TRCmodel_NEP_dailyave(index_24day_ds_minusyr1)) 5.6126
%nanmean(TS7_24day_TRCmodel_NEP_dailyave(index_24day_ds_minusyr1)) 2.1753

subplot(3,1,1)
hold on
plot(SRS6_24day_NEE_dailyave(wilma_fiveyear_ind),'.','Color',[0 0.4470 0.7410],'MarkerSize',12)
plot(nan,'.','Color',[0.8500 0.3250 0.0980],'MarkerSize',12) %faking it for the legend
plot(SRS6_24day_NEE_dailyave(irma_fiveyear_ind),'.','Color',[0 0.4470 0.7410],'MarkerSize',12)

plot(TS7_24day_NEE_dailyave(irma_fiveyear_ind),'.','Color',[0.8500 0.3250 0.0980],'MarkerSize',12)
%add fancy lines
plot([15,15],[-14,16],"--k","LineWidth", 2)   %15 is the number of 24-day periods in one year
plot([0,15],[-3.4097,-3.4097],"LineWidth", 2,'Color',[0 0.4470 0.7410]) %nondisutrbance mean NEE -3.4097
plot([0,15],[-1.1780,-1.1780],"LineWidth", 2,'Color',[0.8500 0.3250 0.0980]) %nondisutrbance mean NEE -1.1780
%add fancy smoothin
plot(16:75,SRS6_NEE_fouryear_smooth,"LineWidth", 2,'Color',[0 0.4470 0.7410],'MarkerSize',12)
plot(16:75,TS7_NEE_fouryear_smooth,"LineWidth", 2,'Color',[0.8500 0.3250 0.0980],'MarkerSize',12)

xticks([0 15 30 45 60 75])
xticklabels({'','','','','',''})
ylim([-6 2])
xlim([0 75])
box on
ylabel({'Eddy Covariance  NEE';'(µmol m^-^2s^-^1)'})
ntitle(' (a)','location','northwest');
legend('Tall Forest','Scrub Forest','Location','northeast')


subplot(3,1,2)
hold on
plot(SRS6_24day_LRCmodel_NEE_dailyave(wilma_fiveyear_ind),'o','Color',[0 0.4470 0.7410],'MarkerSize',4)
plot(SRS6_24day_LRCmodel_NEE_dailyave(irma_fiveyear_ind),'o','Color',[0 0.4470 0.7410],'MarkerSize',4)

plot(TS7_24day_LRCmodel_NEE_dailyave(irma_fiveyear_ind),'o','Color',[0.8500 0.3250 0.0980],'MarkerSize',4)
%add fancy lines
plot([15,15],[-4,10],"--k","LineWidth", 2)   %15 is the number of 24-day periods in one year
plot([0,15],[-2.4004,-2.4004],":","LineWidth", 2,'Color',[0 0.4470 0.7410]) %nondisutrbance mean NEP 2.4004
plot([0,15],[-2.5586,-2.5586],":","LineWidth", 2,'Color',[0.8500 0.3250 0.0980]) %nondisutrbance mean NEP 2.5586
%add fancy smoothin
plot(16:75,SRS6_LRCmodel_NEE_fouryear_smooth,":","LineWidth", 2,'Color',[0 0.4470 0.7410],'MarkerSize',12)
plot(16:75,TS7_LRCmodel_NEE_fouryear_smooth,":","LineWidth", 2,'Color',[0.8500 0.3250 0.0980],'MarkerSize',12)

xticks([0 15 30 45 60 75])
xticklabels({'','','','','',''})
ylim([-4 1])
xlim([0 75])
box on
ylabel({'Light Based Modeled NEE';'(µmol m^-^2s^-^1)'})
ntitle(' (b)','location','northwest');



subplot(3,1,3)
hold on
plot(SRS6_24day_TRCmodel_NEE_dailyave(wilma_fiveyear_ind),'o','Color',[0 0.4470 0.7410],'MarkerSize',4)
plot(SRS6_24day_TRCmodel_NEE_dailyave(irma_fiveyear_ind),'o','Color',[0 0.4470 0.7410],'MarkerSize',4)

plot(TS7_24day_TRCmodel_NEE_dailyave(irma_fiveyear_ind),'o','Color',[0.8500 0.3250 0.0980],'MarkerSize',4)
%add fancy lines
plot([15,15],[-8,4],"--k","LineWidth", 2)   %15 is the number of 24-day periods in one year
plot([0,15],[-5.6126,-5.6126],":","LineWidth", 2,'Color',[0 0.4470 0.7410]) %nondisutrbance mean NEP 5.6126
plot([0,15],[-2.1753,-2.1753],":","LineWidth", 2,'Color',[0.8500 0.3250 0.0980]) %nondisutrbance mean NEP 2.1753
%add fancy smoothin
plot(16:75,SRS6_TRCmodel_NEE_fouryear_smooth,":","LineWidth", 2,'Color',[0 0.4470 0.7410],'MarkerSize',12)
plot(16:75,TS7_TRCmodel_NEE_fouryear_smooth,":","LineWidth", 2,'Color',[0.8500 0.3250 0.0980],'MarkerSize',12)

xticks([0 15 30 45 60 75])
xticklabels({'Year = -1','Hurricane','Year = 1','Year = 2','Year = 3','Year = 4'})
ylim([-8 2])
xlim([0 75])
box on
ylabel({'Temperature Based Modeled NEE';'(µmol m^-^2s^-^1)'})
ntitle(' (c)','location','northwest');









%%%%%% code for table three


%Amax
sum(mean(SRS6_LRCmodel_Amax(index_24day_ds_minusyr1),'omitnan')-SRS6_LRCmodel_Amax(wilma_fouryear_ind),'omitnan')*3600*48*24*(1/1000000)*12
sum(mean(SRS6_LRCmodel_Amax(index_24day_ds_minusyr1),'omitnan')-SRS6_LRCmodel_Amax(irma_fouryear_ind),'omitnan')*3600*48*24*(1/1000000)*12
sum(mean(TS7_LRCmodel_Amax(index_24day_ds_minusyr1),'omitnan')-TS7_LRCmodel_Amax(wilma_fouryear_ind),'omitnan')*3600*48*24*(1/1000000)*12
sum(mean(TS7_LRCmodel_Amax(index_24day_ds_minusyr1),'omitnan')-TS7_LRCmodel_Amax(irma_fouryear_ind),'omitnan')*3600*48*24*(1/1000000)*12

%QY
%sum(mean(SRS6_LRCmodel_QY(index_not_ds),'omitnan')-SRS6_LRCmodel_QY(index_ds),'omitnan')
%sum(mean(TS7_LRCmodel_QY(index_not_ds),'omitnan')-TS7_LRCmodel_QY(index_ds),'omitnan')

%Reco
sum(mean(SRS6_LRCmodel_Reco(index_24day_ds_minusyr1),'omitnan')-SRS6_LRCmodel_Reco(wilma_fouryear_ind),'omitnan')*3600*48*24*(1/1000000)*12
sum(mean(SRS6_LRCmodel_Reco(index_24day_ds_minusyr1),'omitnan')-SRS6_LRCmodel_Reco(irma_fouryear_ind),'omitnan')*3600*48*24*(1/1000000)*12
sum(mean(TS7_LRCmodel_Reco(index_24day_ds_minusyr1),'omitnan')-TS7_LRCmodel_Reco(wilma_fouryear_ind),'omitnan')*3600*48*24*(1/1000000)*12
sum(mean(TS7_LRCmodel_Reco(index_24day_ds_minusyr1),'omitnan')-TS7_LRCmodel_Reco(irma_fouryear_ind),'omitnan')*3600*48*24*(1/1000000)*12

%LRC NEP
sum(mean(SRS6_24day_LRCmodel_NEP_dailyave(index_24day_ds_minusyr1),'omitnan')-SRS6_24day_LRCmodel_NEP_dailyave(wilma_fouryear_ind),'omitnan')*3600*48*24*(1/1000000)*12
sum(mean(SRS6_24day_LRCmodel_NEP_dailyave(index_24day_ds_minusyr1),'omitnan')-SRS6_24day_LRCmodel_NEP_dailyave(irma_fouryear_ind),'omitnan')*3600*48*24*(1/1000000)*12
sum(mean(TS7_24day_LRCmodel_NEP_dailyave(index_24day_ds_minusyr1),'omitnan')-TS7_24day_LRCmodel_NEP_dailyave(wilma_fouryear_ind),'omitnan')*3600*48*24*(1/1000000)*12
sum(mean(TS7_24day_LRCmodel_NEP_dailyave(index_24day_ds_minusyr1),'omitnan')-TS7_24day_LRCmodel_NEP_dailyave(irma_fouryear_ind),'omitnan')*3600*48*24*(1/1000000)*12



















%%%%% time series relative nonstationarity


%vickers and Mahrt (1997) Nonstationarity method

clear RN under_y1 under_x1 under_y2 under_x2 under_y3 under_x3
RN = table(TS7_modis_24day.Date,'VariableNames',"Date");
RN.SRS6Varible = SRS6_24day_NEE_dailyave';
RN.TS7Varible = TS7_24day_NEE_dailyave';

% 8-day varibles
% varible_name = SRS6_modis.LAIqc;
% varible_name = TS7_modis.LAIqc;
% varible_name = SRS6_8day_TA_dailyave';
% 
% varible_name = SRS6_8day_beta_MM(:,2);
% varible_name = TS7_8day_beta_MM(:,1);
% 
% varible_name = SRS6_8day_NEE_dailyave;
% varible_name = TS7_8day_NEE_dailyave;

%24-day variables
varible_name = SRS6_24day_TA_dailyave';
varible_name = SRS6_modis_24day.LAIqc;
varible_name = SRS6_24day_beta_MM(:,2);
varible_name = SRS6_24day_NEE_dailyave';


RN_num_years=3;
RN_stop=length(RN.SRS6Varible)-(RN_num_years*15); %%% 45 for 8-day, 15 for 24-day

for RN_start=1:RN_stop; %180 = 2008

    RN_end=RN_start+(RN_num_years*15); %45 for 8-day aggregation, 15 for 24-day
    
    
    RN_ysrs6 = RN.SRS6Varible(RN_start:RN_end); % four years starting in 2008
    RN_yts7 = RN.TS7Varible(RN_start:RN_end); % four years starting in 2008
    RN_x = 1:length(RN_ysrs6);
    
    %[b,bint,r,rint,stats] = regress(RN_y,RN_x');
    SRS6_mdl = fitlm(RN_x,RN_ysrs6);
    TS7_mdl = fitlm(RN_x,RN_yts7);

    SRS6slope=SRS6_mdl.Coefficients.Estimate(2);
    TS7slope=TS7_mdl.Coefficients.Estimate(2);

    RN.SRS6output(RN_start) = (mean(RN_ysrs6,'omitnan')-(SRS6slope.*length(RN_ysrs6)))./mean(RN_ysrs6,'omitnan'); %mean(SRS6_modis.LAIqc,'omitnan');%;
    RN.TS7output(RN_start) = (mean(RN_yts7,'omitnan')-(TS7slope.*length(RN_yts7)))./mean(RN_yts7,'omitnan'); %mean(SRS6_modis.LAIqc,'omitnan');%;

    if sum(isnan(RN_ysrs6)) > length(RN_ysrs6)*.66
        RN.SRS6output(RN_start) = nan;
    end
    if sum(isnan(RN_yts7)) > length(RN_yts7)*.66
        RN.TS7output(RN_start) = nan;
    end

    if RN_start>20
        if sum(isnan(RN.SRS6Varible(RN_start-20:RN_start)))>20
            RN.SRS6output(RN_start) = nan;
        end
        if sum(isnan(RN.TS7Varible(RN_start-20:RN_start)))>20
            RN.TS7output(RN_start) = nan;
        end
    end
end
RN.SRS6output(RN_start:RN_end)=nan;
RN.TS7output(RN_start:RN_end)=nan;



prctile(RN.SRS6output,[15])
prctile(RN.SRS6output,[10]) 
prctile(RN.SRS6output,[5])

prctile(RN.TS7output,[15])
prctile(RN.TS7output,[10]) 
prctile(RN.TS7output,[5])






%%%% SI Figures for RN results

%%%%SI figure for TA
subplot(2,1,1)
hold on
plot(RN.Date,RN.Varible)
box on
plot([wilma_date,wilma_date],[10,30],"--k","LineWidth", 2)
plot([irma_date,irma_date],[10,30],"--k","LineWidth", 2)
ylabel('Air Temperature [{\circ}C]')
ntitle(' (a)','location','southeast');

subplot(2,1,2)
hold on
plot(RN.Date,RN.output)
box on

% re-run code with various summery lengths
plot(RN.Date,RN.output)
ylabel('Air Temperature Relative Nonstationarity')
plot([wilma_date,wilma_date],[-1,2],"--k","LineWidth", 2)
plot([irma_date,irma_date],[-1,2],"--k","LineWidth", 2)
legend(['1 Year';'2 Year';'3 Year'],'location','south')
ntitle(' (b)','location','southeast');



%%% SI Figure showing LAI   
subplot(2,1,1)
hold on
plot(RN.Date,RN.SRS6Varible,'Color',[0 0.4470 0.7410])
plot(RN.Date,RN.TS7Varible,'Color',[0.8500 0.3250 0.0980])
box on
plot([wilma_date,wilma_date],[0,8],"--k","LineWidth", 2)
plot([irma_date,irma_date],[0,8],"--k","LineWidth", 2)
ylabel('LAI [m^2/m^-^2]')
ylim([0,8])
ntitle(' (a)','location','northwest');

subplot(2,1,2)  
hold on
plot(RN.Date,RN.SRS6output)
plot(RN.Date,RN.TS7output)

plot([wilma_date,wilma_date],[-.5,2.5],"--k","LineWidth", 2)

RN.under_y1SRS6 = RN.SRS6output;
RN.under_y1SRS6(RN.SRS6output>=prctile(RN.SRS6output,[15])) = nan;
plot(RN.Date,RN.under_y1SRS6,'o','markersize',4,'MarkerEdgeColor','k','MarkerFaceColor','k')
RN.under_y2SRS6 = RN.SRS6output;
RN.under_y2SRS6(RN.SRS6output>=prctile(RN.SRS6output,[10])) = nan;
plot(RN.Date,RN.under_y2SRS6,'o','markersize',6,'MarkerEdgeColor','k','MarkerFaceColor','k')
RN.under_y3SRS6 = RN.SRS6output;
RN.under_y3SRS6(RN.SRS6output>=prctile(RN.SRS6output,[5])) = nan;
plot(RN.Date,RN.under_y3SRS6,'o','markersize',8,'MarkerEdgeColor','k','MarkerFaceColor','k')
RN.under_y1TS7 = RN.TS7output;
RN.under_y1TS7(RN.TS7output>=prctile(RN.TS7output,[15])) = nan;
plot(RN.Date,RN.under_y1TS7,'o','markersize',4,'MarkerEdgeColor','k','MarkerFaceColor','k')
RN.under_y2TS7 = RN.TS7output;
RN.under_y2TS7(RN.TS7output>=prctile(RN.TS7output,[10])) = nan;
plot(RN.Date,RN.under_y2TS7,'o','markersize',6,'MarkerEdgeColor','k','MarkerFaceColor','k')
RN.under_y3TS7 = RN.TS7output;
RN.under_y3TS7(RN.TS7output>=prctile(RN.TS7output,[5])) = nan;
plot(RN.Date,RN.under_y3TS7,'o','markersize',8,'MarkerEdgeColor','k','MarkerFaceColor','k')

ylabel('Relative Nonstationarity [unitless]')

plot([irma_date,irma_date],[-.5,2.5],"--k","LineWidth", 2)
legend('Forest','Scrub','Hurricane Landfall','15 Percentile','10 Percentile','5 Percentile','location','north')
ylim([-0.5,2.5])
box on
ntitle(' (b) ','location','northwest');







%%% SI Figure showing Reco    
subplot(2,1,1)
hold on
plot(RN.Date,RN.SRS6Varible,'Color',[0 0.4470 0.7410])
plot(RN.Date,RN.TS7Varible,'Color',[0.8500 0.3250 0.0980])
box on
plot([wilma_date,wilma_date],[0,8],"--k","LineWidth", 2)
plot([irma_date,irma_date],[0,8],"--k","LineWidth", 2)
ylabel('R_e_c_o [µmol m^-^2s^-^1]')
ylim([0,25])
ntitle(' (a)','location','northwest');

subplot(2,1,2)  
hold on
plot(RN.Date,RN.SRS6output)
plot(RN.Date,RN.TS7output)

plot([wilma_date,wilma_date],[-.5,2.5],"--k","LineWidth", 2)

RN.under_y1SRS6 = RN.SRS6output;
RN.under_y1SRS6(RN.SRS6output>=prctile(RN.SRS6output,[15])) = nan;
plot(RN.Date,RN.under_y1SRS6,'o','markersize',4,'MarkerEdgeColor','k','MarkerFaceColor','k')
RN.under_y2SRS6 = RN.SRS6output;
RN.under_y2SRS6(RN.SRS6output>=prctile(RN.SRS6output,[10])) = nan;
plot(RN.Date,RN.under_y2SRS6,'o','markersize',6,'MarkerEdgeColor','k','MarkerFaceColor','k')
RN.under_y3SRS6 = RN.SRS6output;
RN.under_y3SRS6(RN.SRS6output>=prctile(RN.SRS6output,[5])) = nan;
plot(RN.Date,RN.under_y3SRS6,'o','markersize',8,'MarkerEdgeColor','k','MarkerFaceColor','k')
RN.under_y1TS7 = RN.TS7output;
RN.under_y1TS7(RN.TS7output>=prctile(RN.TS7output,[15])) = nan;
plot(RN.Date,RN.under_y1TS7,'o','markersize',4,'MarkerEdgeColor','k','MarkerFaceColor','k')
RN.under_y2TS7 = RN.TS7output;
RN.under_y2TS7(RN.TS7output>=prctile(RN.TS7output,[10])) = nan;
plot(RN.Date,RN.under_y2TS7,'o','markersize',6,'MarkerEdgeColor','k','MarkerFaceColor','k')
RN.under_y3TS7 = RN.TS7output;
RN.under_y3TS7(RN.TS7output>=prctile(RN.TS7output,[5])) = nan;
plot(RN.Date,RN.under_y3TS7,'o','markersize',8,'MarkerEdgeColor','k','MarkerFaceColor','k')

ylabel('Relative Nonstationarity [unitless]')

plot([irma_date,irma_date],[-.5,2.5],"--k","LineWidth", 2)
legend('Forest','Scrub','Hurricane Landfall','15 Percentile','10 Percentile','5 Percentile','location','south')
ylim([-0.5,2.5])
box on
ntitle(' (b) ','location','northwest');






%%% SI Figure showing QY
subplot(2,1,1)
hold on
plot(RN.Date,RN.SRS6Varible,'Color',[0 0.4470 0.7410])
plot(RN.Date,RN.TS7Varible,'Color',[0.8500 0.3250 0.0980])
box on
plot([wilma_date,wilma_date],[0,.18],"--k","LineWidth", 2)
plot([irma_date,irma_date],[0,.18],"--k","LineWidth", 2)
ylabel('Quantum Yield [µmol J^-^1]')
ylim([0,.18])
ntitle(' (a)','location','northwest');


subplot(2,1,2)  
hold on
plot(RN.Date,RN.SRS6output)
plot(RN.Date,RN.TS7output)

plot([wilma_date,wilma_date],[-.5,2.5],"--k","LineWidth", 2)

RN.under_y1SRS6 = RN.SRS6output;
RN.under_y1SRS6(RN.SRS6output>=prctile(RN.SRS6output,[15])) = nan;
plot(RN.Date,RN.under_y1SRS6,'o','markersize',4,'MarkerEdgeColor','k','MarkerFaceColor','k')
RN.under_y2SRS6 = RN.SRS6output;
RN.under_y2SRS6(RN.SRS6output>=prctile(RN.SRS6output,[10])) = nan;
plot(RN.Date,RN.under_y2SRS6,'o','markersize',6,'MarkerEdgeColor','k','MarkerFaceColor','k')
RN.under_y3SRS6 = RN.SRS6output;
RN.under_y3SRS6(RN.SRS6output>=prctile(RN.SRS6output,[5])) = nan;
plot(RN.Date,RN.under_y3SRS6,'o','markersize',8,'MarkerEdgeColor','k','MarkerFaceColor','k')
RN.under_y1TS7 = RN.TS7output;
RN.under_y1TS7(RN.TS7output>=prctile(RN.TS7output,[15])) = nan;
plot(RN.Date,RN.under_y1TS7,'o','markersize',4,'MarkerEdgeColor','k','MarkerFaceColor','k')
RN.under_y2TS7 = RN.TS7output;
RN.under_y2TS7(RN.TS7output>=prctile(RN.TS7output,[10])) = nan;
plot(RN.Date,RN.under_y2TS7,'o','markersize',6,'MarkerEdgeColor','k','MarkerFaceColor','k')
RN.under_y3TS7 = RN.TS7output;
RN.under_y3TS7(RN.TS7output>=prctile(RN.TS7output,[5])) = nan;
plot(RN.Date,RN.under_y3TS7,'o','markersize',8,'MarkerEdgeColor','k','MarkerFaceColor','k')

ylabel('Relative Nonstationarity [unitless]')

plot([irma_date,irma_date],[-.5,2.5],"--k","LineWidth", 2)
legend('Forest','Scrub','Hurricane Landfall','15 Percentile','10 Percentile','5 Percentile','location','south')
ylim([-0.5,2.5])
box on
ntitle(' (b) ','location','northwest');




%%% SI Figure showing Amax
subplot(2,1,1)
hold on
plot(RN.Date,RN.SRS6Varible,'Color',[0 0.4470 0.7410])
plot(RN.Date,RN.TS7Varible,'Color',[0.8500 0.3250 0.0980])
box on
plot([wilma_date,wilma_date],[0,60],"--k","LineWidth", 2)
plot([irma_date,irma_date],[0,60],"--k","LineWidth", 2)
ylabel('Amax [µmol m^-^2s^-^1]')
ylim([0,60])
ntitle(' (a)','location','northwest');


subplot(2,1,2)  
hold on
plot(RN.Date,RN.SRS6output)
plot(RN.Date,RN.TS7output)

plot([wilma_date,wilma_date],[-1.5,2.5],"--k","LineWidth", 2)

RN.under_y1SRS6 = RN.SRS6output;
RN.under_y1SRS6(RN.SRS6output>=prctile(RN.SRS6output,[15])) = nan;
plot(RN.Date,RN.under_y1SRS6,'o','markersize',4,'MarkerEdgeColor','k','MarkerFaceColor','k')
RN.under_y2SRS6 = RN.SRS6output;
RN.under_y2SRS6(RN.SRS6output>=prctile(RN.SRS6output,[10])) = nan;
plot(RN.Date,RN.under_y2SRS6,'o','markersize',6,'MarkerEdgeColor','k','MarkerFaceColor','k')
RN.under_y3SRS6 = RN.SRS6output;
RN.under_y3SRS6(RN.SRS6output>=prctile(RN.SRS6output,[5])) = nan;
plot(RN.Date,RN.under_y3SRS6,'o','markersize',8,'MarkerEdgeColor','k','MarkerFaceColor','k')
RN.under_y1TS7 = RN.TS7output;
RN.under_y1TS7(RN.TS7output>=prctile(RN.TS7output,[15])) = nan;
plot(RN.Date,RN.under_y1TS7,'o','markersize',4,'MarkerEdgeColor','k','MarkerFaceColor','k')
RN.under_y2TS7 = RN.TS7output;
RN.under_y2TS7(RN.TS7output>=prctile(RN.TS7output,[10])) = nan;
plot(RN.Date,RN.under_y2TS7,'o','markersize',6,'MarkerEdgeColor','k','MarkerFaceColor','k')
RN.under_y3TS7 = RN.TS7output;
RN.under_y3TS7(RN.TS7output>=prctile(RN.TS7output,[5])) = nan;
plot(RN.Date,RN.under_y3TS7,'o','markersize',8,'MarkerEdgeColor','k','MarkerFaceColor','k')

ylabel('Relative Nonstationarity [unitless]')

plot([irma_date,irma_date],[-1.5,2.5],"--k","LineWidth", 2)
legend('Forest','Scrub','Hurricane Landfall','15 Percentile','10 Percentile','5 Percentile','location','south')
ylim([-1.5,2.5])
box on
ntitle(' (b) ','location','northwest');





%%% SI Figure showing NEE
subplot(2,1,1)
hold on
plot(RN.Date,RN.SRS6Varible,'Color',[0 0.4470 0.7410])
plot(RN.Date,RN.TS7Varible,'Color',[0.8500 0.3250 0.0980])
box on
plot([wilma_date,wilma_date],[-10,5],"--k","LineWidth", 2)
plot([irma_date,irma_date],[-10,5],"--k","LineWidth", 2)
ylabel('NEE [µmol m^-^2s^-^1]')
ylim([-10,5])
ntitle(' (a)','location','northwest');

subplot(2,1,2)
hold on
plot(RN.Date,RN.SRS6output)
plot(RN.Date,RN.TS7output)

plot([wilma_date,wilma_date],[-1.5,2.5],"--k","LineWidth", 2)

RN.under_y1SRS6 = RN.SRS6output;
RN.under_y1SRS6(RN.SRS6output>=prctile(RN.SRS6output,[15])) = nan;
plot(RN.Date,RN.under_y1SRS6,'o','markersize',4,'MarkerEdgeColor','k','MarkerFaceColor','k')
RN.under_y2SRS6 = RN.SRS6output;
RN.under_y2SRS6(RN.SRS6output>=prctile(RN.SRS6output,[10])) = nan;
plot(RN.Date,RN.under_y2SRS6,'o','markersize',6,'MarkerEdgeColor','k','MarkerFaceColor','k')
RN.under_y3SRS6 = RN.SRS6output;
RN.under_y3SRS6(RN.SRS6output>=prctile(RN.SRS6output,[5])) = nan;
plot(RN.Date,RN.under_y3SRS6,'o','markersize',8,'MarkerEdgeColor','k','MarkerFaceColor','k')
RN.under_y1TS7 = RN.TS7output;
RN.under_y1TS7(RN.TS7output>=prctile(RN.TS7output,[15])) = nan;
plot(RN.Date,RN.under_y1TS7,'o','markersize',4,'MarkerEdgeColor','k','MarkerFaceColor','k')
RN.under_y2TS7 = RN.TS7output;
RN.under_y2TS7(RN.TS7output>=prctile(RN.TS7output,[10])) = nan;
plot(RN.Date,RN.under_y2TS7,'o','markersize',6,'MarkerEdgeColor','k','MarkerFaceColor','k')
RN.under_y3TS7 = RN.TS7output;
RN.under_y3TS7(RN.TS7output>=prctile(RN.TS7output,[5])) = nan;
plot(RN.Date,RN.under_y3TS7,'o','markersize',8,'MarkerEdgeColor','k','MarkerFaceColor','k')

ylabel('Relative Nonstationarity [unitless]')

plot([irma_date,irma_date],[-1.5,2.5],"--k","LineWidth", 2)
legend('Forest','Scrub','Hurricane Landfall','15 Percentile','10 Percentile','5 Percentile','location','south')
ylim([-1.4,2.4])
box on
ntitle(' (b)','location','northwest');







%%%make table for timescale recvoery dates

clear under_x1 under_x2 under_x3 under_x1_half under_x2_half under_x3_half

y=1:length(RN.SRS6output);
RN_half=RN.SRS6output(1:(length(RN.SRS6output)/2));

under_x1 = y(RN.SRS6output<prctile(RN.SRS6output,[15]));
under_x2 = y(RN.SRS6output<prctile(RN.SRS6output,[10]));
under_x3 = y(RN.SRS6output<prctile(RN.SRS6output,[5]));

under_x1_half = y(RN_half<prctile(RN.SRS6output,[15]));
under_x2_half = y(RN_half<prctile(RN.SRS6output,[10]));
under_x3_half = y(RN_half<prctile(RN.SRS6output,[5]));

date_wilma_x1 = under_x1_half(find(under_x1_half,1,'last'));
date_irma_x1 = under_x1(find(under_x1,1,'last'));

date_wilma_x2 = under_x2_half(find(under_x2_half,1,'last'));
date_irma_x2 = under_x2(find(under_x2,1,'last'));

date_wilma_x3 = under_x3_half(find(under_x3_half,1,'last'));
date_irma_x3 = under_x3(find(under_x3,1,'last'));




clear under_x1 under_x2 under_x3 under_x1_half under_x2_half under_x3_half

y=1:length(RN.TS7output);
RN_half=RN.TS7output(1:(length(RN.TS7output)/2));


under_x1 = y(RN.TS7output<prctile(RN.TS7output,[15]));
under_x2 = y(RN.TS7output<prctile(RN.TS7output,[10]));
under_x3 = y(RN.TS7output<prctile(RN.TS7output,[5]));

under_x1_half = y(RN_half<prctile(RN.TS7output,[15]));
under_x2_half = y(RN_half<prctile(RN.TS7output,[10]));
under_x3_half = y(RN_half<prctile(RN.TS7output,[5]));

date_wilma_x1 = under_x1_half(find(under_x1_half,1,'last'));
date_irma_x1 = under_x1(find(under_x1,1,'last'));

date_wilma_x2 = under_x2_half(find(under_x2_half,1,'last'));
date_irma_x2 = under_x2(find(under_x2,1,'last'));

date_wilma_x3 = under_x3_half(find(under_x3_half,1,'last'));
date_irma_x3 = under_x3(find(under_x3,1,'last'));




%SRS6 LAI 24-day
between(wilma_date,RN.Date(36),'days')%between(wilma_date,SRS6_modis_24day.Date(date_wilma_x1),'days')
between(irma_date,RN.Date(211),'days') %between(irma_date,SRS6_modis.Date(date_irma_x1),'days')

between(wilma_date,RN.Date(date_wilma_x2),'days')
between(irma_date,RN.Date(date_irma_x2),'days')

between(wilma_date,RN.Date(date_wilma_x3),'days')
between(irma_date,RN.Date(date_irma_x3),'days')



%SRS6 Reco 24-day
between(wilma_date,RN.Date(date_wilma_x1),'days')
between(irma_date,RN.Date(date_irma_x1),'days')

between(wilma_date,RN.Date(date_wilma_x2),'days')
between(irma_date,RN.Date(date_irma_x2),'days')

between(wilma_date,RN.Date(date_wilma_x3),'days')
between(irma_date,RN.Date(date_irma_x3),'days')


%SRS6 QY 24-day
between(wilma_date,RN.Date(date_wilma_x1),'days')
between(irma_date,RN.Date(date_irma_x1),'days')

between(wilma_date,RN.Date(date_wilma_x2),'days')
between(irma_date,RN.Date(date_irma_x2),'days')

between(wilma_date,RN.Date(date_wilma_x3),'days')
between(irma_date,RN.Date(date_irma_x3),'days')


%SRS6 Amax 24-day
between(wilma_date,RN.Date(date_wilma_x1),'days')
between(irma_date,RN.Date(date_irma_x1),'days')

between(wilma_date,RN.Date(date_wilma_x2),'days')
between(irma_date,RN.Date(date_irma_x2),'days')

between(wilma_date,RN.Date(date_wilma_x3),'days')
between(irma_date,RN.Date(date_irma_x3),'days')



%SRS6 NEE 24-day
between(wilma_date,RN.Date(date_wilma_x1),'days')
between(irma_date,RN.Date(215),'days')

between(wilma_date,RN.Date(date_wilma_x2),'days')
between(irma_date,RN.Date(212),'days')

between(wilma_date,RN.Date(date_wilma_x3),'days')
between(irma_date,RN.Date(date_irma_x3),'days')


% 
% %SRS6 LAI 8-day
% between(wilma_date,SRS6_modis.Date(date_wilma_x1),'days')
% between(irma_date,SRS6_modis.Date(638),'days') %between(irma_date,SRS6_modis.Date(date_irma_x1),'days')
% 
% between(wilma_date,SRS6_modis.Date(date_wilma_x2),'days')
% between(irma_date,SRS6_modis.Date(date_irma_x2),'days')
% 
% between(wilma_date,SRS6_modis.Date(date_wilma_x3),'days')
% between(irma_date,SRS6_modis.Date(date_irma_x3),'days')
% 
% 
% %TS7 LAI 8-day
% between(irma_date,TS7_modis.Date(date_irma_x1),'days')
% between(irma_date,TS7_modis.Date(date_irma_x2),'days')
% between(irma_date,TS7_modis.Date(date_irma_x3),'days')
% 
% 
% %SRS6 Reco days  8-day
% between(wilma_date,SRS6_modis.Date(83),'days')%between(wilma_date,SRS6_modis.Date(date_wilma_x1),'days')
% between(irma_date,SRS6_modis.Date(date_irma_x1),'days')
% 
% between(wilma_date,SRS6_modis.Date(82),'days')%between(wilma_date,SRS6_modis.Date(date_wilma_x2),'days')
% between(irma_date,SRS6_modis.Date(date_irma_x2),'days')
% 
% between(wilma_date,SRS6_modis.Date(81),'days')%between(wilma_date,SRS6_modis.Date(date_wilma_x3),'days')
% between(irma_date,SRS6_modis.Date(date_irma_x3),'days')
% 
% 
% %SRS6 Amax days  8-day
% between(wilma_date,SRS6_modis.Date(date_wilma_x1),'days')
% between(irma_date,SRS6_modis.Date(date_irma_x1),'days')
% 
% between(wilma_date,SRS6_modis.Date(date_wilma_x2),'days')
% between(irma_date,SRS6_modis.Date(date_irma_x2),'days')
% 
% between(wilma_date,SRS6_modis.Date(date_wilma_x3),'days')
% between(irma_date,SRS6_modis.Date(date_irma_x3),'days')






%Temperature betweeen SRS5 and TS7
%regress(SRS6_24day_TA_dailyave',TS7_24day_TA_dailyave')
%regression slope of 0.9798
    

%%%% write output tables

Time = datetime(compose("%d",SRS6_data.Date),'InputFormat','yyyyMMddHHmm');
SRS6_datatable_flux=timetable(Time,SRS6_data.NEE,'VariableNames',{'NEE'});
SRS6_datatable_LAI=timetable(SRS6_modis_8day.Date,SRS6_modis_8day.LAIqc,'VariableNames',{'LAI'});
SRS6_datatable_flux_parms=timetable(SRS6_modis_24day.Date,SRS6_24day_beta_MM(:,1),SRS6_24day_beta_MM(:,2),SRS6_24day_beta_MM(:,3),SRS6_24day_beta_TRC(:,1),SRS6_24day_beta_TRC(:,2),'VariableNames',{'LRC_Reco','LRC_QY','LRC_Amax','TRC_R_base','TRC_temp_sensitivity'});


Time = datetime(compose("%d",TS7_data.Date),'InputFormat','yyyyMMddHHmm');
TS7_datatable_flux=timetable(Time,TS7_data.NEE,'VariableNames',{'NEE'});
TS7_datatable_LAI=timetable(TS7_modis_8day.Date,TS7_modis_8day.LAIqc,'VariableNames',{'LAI'});
TS7_datatable_flux_parms=timetable(TS7_modis_24day.Date,TS7_24day_beta_MM(:,1),TS7_24day_beta_MM(:,2),TS7_24day_beta_MM(:,3),TS7_24day_beta_TRC(:,1),TS7_24day_beta_TRC(:,2),'VariableNames',{'LRC_Reco','LRC_QY','LRC_Amax','TRC_R_base','TRC_temp_sensitivity'});


SRS6_output = synchronize(rmmissing(SRS6_datatable_flux),ERA5_data_30min,SRS6_datatable_LAI,SRS6_datatable_flux_parms);
SRS6_output = renamevars(SRS6_output,["ERA5_2T","ERA5_SW_IN"],["TA","SW_IN"]);

TS7_output = synchronize(rmmissing(TS7_datatable_flux),ERA5_data_30min,TS7_datatable_LAI,TS7_datatable_flux_parms);
TS7_output = renamevars(TS7_output,["ERA5_2T","ERA5_SW_IN"],["TA","SW_IN"]);



writetimetable(SRS6_output,'SRS6_datatable.csv')
writetimetable(TS7_output,'TS7_datatable.csv')


