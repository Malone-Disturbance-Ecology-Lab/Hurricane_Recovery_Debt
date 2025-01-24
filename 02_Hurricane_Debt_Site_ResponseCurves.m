


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





