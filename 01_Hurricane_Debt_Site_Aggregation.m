

%move data into weekly groups (8-day groups to match MODIS data)
%using linear_day as a manual check here
year_len=17520;
year_len_lp=17520+48;





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
            %SRS6_8day_NSRDB_data(i+45*(num_year-1),j) = NSRDB_data_2004_end(x);
            %SRS6_8day_NSRDB_data(i+45*(num_year-1),j) = NSRDB_data_2004_end(x);
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
            %SRS6_24day_NSRDB_data(i+15*(num_year-1),j) = NSRDB_data_2004_end(x);
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
            %SRS6_40day_NSRDB_data(i+9*(num_year-1),j) = NSRDB_data_2004_end(x);
            %SRS6_40day_NSRDB_data(i+9*(num_year-1),j) = NSRDB_data_2004_end(x);
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
        %SRS6_8day_NSRDB_data_dayave(i,j) = mean(SRS6_8day_NSRDB_data(i,j:48:384),'omitnan');
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
    %SRS6_8day_NSRDB_data_dailyave(i) = mean(SRS6_8day_NSRDB_data_dayave(i,:),'omitnan');
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
        %SRS6_24day_NSRDB_data_dayave(i,j) = mean(SRS6_24day_NSRDB_data(i,j:48:1152),'omitnan');
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
    %SRS6_24day_NSRDB_data_dailyave(i) = mean(SRS6_24day_NSRDB_data_dayave(i,:),'omitnan');
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




