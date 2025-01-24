

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


            if ERA5_data_30min.ERA5_SW_IN(x)>50
                SRS6_LRC_TRCmodel_NEP_30min(x) = SRS6_LRCmodel_NEP_30min(x);
                TS7_LRC_TRCmodel_NEP_30min(x) = TS7_LRCmodel_NEP_30min(x);
            else
                SRS6_LRC_TRCmodel_NEP_30min(x) = SRS6_TRCmodel_NEP_30min(x);
                TS7_LRC_TRCmodel_NEP_30min(x) = TS7_TRCmodel_NEP_30min(x);
            end

            SRS6_24day_LRC_TRCmodel_NEP(i+15*(num_year-1),j) = SRS6_LRC_TRCmodel_NEP_30min(x);
            TS7_24day_LRC_TRCmodel_NEP(i+15*(num_year-1),j) = TS7_LRC_TRCmodel_NEP_30min(x);
            
            model_day(x) = linear_day(x);

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



%removing data at the end of each year
SRS6_LRCmodel_NEP_30min(model_day==0)=nan;
SRS6_LRC_TRCmodel_NEP_30min(model_day==0)=nan;
SRS6_TRCmodel_NEP_30min(model_day==0)=nan;
TS7_LRCmodel_NEP_30min(model_day==0)=nan;
TS7_TRCmodel_NEP_30min(model_day==0)=nan;
TS7_LRC_TRCmodel_NEP_30min(model_day==0)=nan;
model_day(model_day==0)=nan;




%%%% make daily average for SRS6_LRCmodel_NEP data over 24-day period
%%%% then
%%%% make 24-day average using daily average for SRS6_LRCmodel_NEP
for i=1:300
    for j=1:48  
        
        SRS6_24day_LRCmodel_NEP_dayave(i,j) = mean(SRS6_24day_LRCmodel_NEP(i,j:48:1152),'omitnan');
        TS7_24day_LRCmodel_NEP_dayave(i,j) = mean(TS7_24day_LRCmodel_NEP(i,j:48:1152),'omitnan');

        SRS6_24day_TRCmodel_Reco_dayave(i,j) = mean(SRS6_24day_TRCmodel_Reco(i,j:48:1152),'omitnan');
        TS7_24day_TRCmodel_Reco_dayave(i,j) = mean(TS7_24day_TRCmodel_Reco(i,j:48:1152),'omitnan');

        SRS6_24day_TRCmodel_NEP_dayave(i,j) = mean(SRS6_24day_TRCmodel_NEP(i,j:48:1152),'omitnan');
        TS7_24day_TRCmodel_NEP_dayave(i,j) = mean(TS7_24day_TRCmodel_NEP(i,j:48:1152),'omitnan');

        SRS6_24day_LRC_TRCmodel_NEP_dayave(i,j) = mean(SRS6_24day_LRC_TRCmodel_NEP(i,j:48:1152),'omitnan');
        TS7_24day_LRC_TRCmodel_NEP_dayave(i,j) = mean(TS7_24day_LRC_TRCmodel_NEP(i,j:48:1152),'omitnan');
    end

    SRS6_24day_LRCmodel_NEP_dailyave(i) = mean(SRS6_24day_LRCmodel_NEP_dayave(i,:),'omitnan');
    TS7_24day_LRCmodel_NEP_dailyave(i) = mean(TS7_24day_LRCmodel_NEP_dayave(i,:),'omitnan');

    SRS6_24day_TRCmodel_Reco_dailyave(i) = mean(SRS6_24day_TRCmodel_Reco_dayave(i,:),'omitnan');
    TS7_24day_TRCmodel_Reco_dailyave(i) = mean(TS7_24day_TRCmodel_Reco_dayave(i,:),'omitnan');

    SRS6_24day_TRCmodel_NEP_dailyave(i) = mean(SRS6_24day_TRCmodel_NEP_dayave(i,:),'omitnan');
    TS7_24day_TRCmodel_NEP_dailyave(i) = mean(TS7_24day_TRCmodel_NEP_dayave(i,:),'omitnan');

    SRS6_24day_LRC_TRCmodel_NEP_dailyave(i) = mean(SRS6_24day_LRC_TRCmodel_NEP_dayave(i,:),'omitnan');
    TS7_24day_LRC_TRCmodel_NEP_dailyave(i) = mean(TS7_24day_LRC_TRCmodel_NEP_dayave(i,:),'omitnan');
end


SRS6_24day_LRCmodel_NEE_dailyave = -SRS6_24day_LRCmodel_NEP_dailyave;
TS7_24day_LRCmodel_NEE_dailyave = -TS7_24day_LRCmodel_NEP_dailyave;

SRS6_24day_TRCmodel_NEE_dailyave = -SRS6_24day_TRCmodel_NEP_dailyave;
TS7_24day_TRCmodel_NEE_dailyave = -TS7_24day_TRCmodel_NEP_dailyave;

SRS6_24day_LRC_TRCmodel_NEE_dailyave = -SRS6_24day_LRC_TRCmodel_NEP_dailyave;
TS7_24day_LRC_TRCmodel_NEE_dailyave = -TS7_24day_LRC_TRCmodel_NEP_dailyave;



