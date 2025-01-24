

%%%%% time series relative nonstationarity


%vickers and Mahrt (1997) Nonstationarity method

clear RN under_y1 under_x1 under_y2 under_x2 under_y3 under_x3
RN = table(SRS6_modis_24day.Date,'VariableNames',"Date");
RN.SRS6Varible = SRS6_24day_beta_TRC(:,2);
RN.TS7Varible = TS7_24day_beta_TRC(:,2);

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
varible_name = SRS6_24day_beta_TRC(:,1);


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





%%% SI Figure showing rb    
subplot(2,1,1)
hold on
plot(RN.Date,RN.SRS6Varible,'Color',[0 0.4470 0.7410])
plot(RN.Date,RN.TS7Varible,'Color',[0.8500 0.3250 0.0980])
box on
plot([wilma_date,wilma_date],[0,8],"--k","LineWidth", 2)
plot([irma_date,irma_date],[0,8],"--k","LineWidth", 2)
ylabel('rb [µmol m^-^2s^-^1]')
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
legend('Forest','Scrub','Hurricane Landfall','15 Percentile','10 Percentile','5 Percentile','location','south')
ylim([-0.5,2.5])
box on
ntitle(' (b) ','location','northwest');






%%% SI Figure showing E0    
subplot(2,1,1)
hold on
plot(RN.Date,RN.SRS6Varible,'Color',[0 0.4470 0.7410])
plot(RN.Date,RN.TS7Varible,'Color',[0.8500 0.3250 0.0980])
box on
plot([wilma_date,wilma_date],[0,500],"--k","LineWidth", 2)
plot([irma_date,irma_date],[0,500],"--k","LineWidth", 2)
ylabel('E0 [µmol m^-^2s^-^1 ^{\circ}C^-^1)')
ylim([50,400])
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


%SRS6 rb 24-day
between(wilma_date,RN.Date(date_wilma_x1),'days')
between(irma_date,RN.Date(date_irma_x1),'days')

between(wilma_date,RN.Date(date_wilma_x2),'days')
between(irma_date,RN.Date(date_irma_x2),'days')

between(wilma_date,RN.Date(date_wilma_x3),'days')
between(irma_date,RN.Date(date_irma_x3),'days')


%SRS6 E0 24-day
%between(wilma_date,RN.Date(date_wilma_x1),'days')
between(irma_date,RN.Date(212),'days')

%between(wilma_date,RN.Date(date_wilma_x2),'days')
between(irma_date,RN.Date(208),'days')

between(wilma_date,RN.Date(31),'days')
between(irma_date,RN.Date(date_irma_x3),'days')

between(irma_date,RN.Date(217),'days')
between(irma_date,RN.Date(216),'days')
between(irma_date,RN.Date(214),'days')



%SRS6 NEE 24-day
between(wilma_date,RN.Date(date_wilma_x1),'days')
between(irma_date,RN.Date(215),'days')

between(wilma_date,RN.Date(date_wilma_x2),'days')
between(irma_date,RN.Date(212),'days')

between(wilma_date,RN.Date(date_wilma_x3),'days')
between(irma_date,RN.Date(date_irma_x3),'days')

