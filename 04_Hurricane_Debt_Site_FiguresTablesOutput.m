

%%%%%%%%% stats results

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







%SI figure 2 to show aggregation results


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
plot(8,-mean(ecosystem_MM_2_8day,'omitnan'),'.b','MarkerSize',14)
plot(24,-mean(ecosystem_MM_2_24day,'omitnan'),'.b','MarkerSize',14)
plot(40,-mean(ecosystem_MM_2_40day,'omitnan'),'.b','MarkerSize',14)
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
plot(8,-mean(ecosystem_MM_3_8day,'omitnan'),'.g','MarkerSize',14)
plot(24,-mean(ecosystem_MM_3_24day,'omitnan'),'.g','MarkerSize',14)
plot(40,-mean(ecosystem_MM_3_40day,'omitnan'),'.g','MarkerSize',14)
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










%%%% SI Figure 3 EC NEP vs LRC NEP
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






%%%% SI Figure 4 LRC Reco vs TRC Reco PARAMETERS, at 24-day timescales


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






%%%% SI Figure 5 LRC Reco vs TRC Reco MODELED VALUES, at 24-day timescales


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

mean(SRS6_24day_beta_TRC(:,1),'omitnan')
std(SRS6_24day_beta_TRC(:,1),'omitnan')/sqrt(length(SRS6_24day_beta_TRC(:,1)))

mean(SRS6_24day_beta_TRC(:,2),'omitnan')
std(SRS6_24day_beta_TRC(:,2),'omitnan')/sqrt(length(SRS6_24day_beta_TRC(:,1)))


mean(TS7_24day_beta_MM(:,1),'omitnan')
std(TS7_24day_beta_MM(:,1),'omitnan')/sqrt(length(TS7_24day_beta_MM(:,1)))

mean(TS7_24day_beta_MM(:,2),'omitnan')
std(TS7_24day_beta_MM(:,2),'omitnan')/sqrt(length(TS7_24day_beta_MM(:,1)))

mean(TS7_24day_beta_MM(:,3),'omitnan')
std(TS7_24day_beta_MM(:,3),'omitnan')/sqrt(length(TS7_24day_beta_MM(:,1)))

mean(TS7_24day_beta_TRC(:,1),'omitnan')
std(TS7_24day_beta_TRC(:,1),'omitnan')/sqrt(length(TS7_24day_beta_TRC(:,1)))

mean(TS7_24day_beta_TRC(:,2),'omitnan')
std(TS7_24day_beta_TRC(:,2),'omitnan')/sqrt(length(TS7_24day_beta_TRC(:,1)))








%%%%%% figure 2, ploting average LRC  %and disurbance LRC


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
h1 = histogram(SRS6_24day_beta_MM(:,2)*-1,'EdgeColor','none',Normalization="percentage")
h1.BinWidth = 0.01;
h2 = histogram(TS7_24day_beta_MM(:,2)*-1,'EdgeColor','none',Normalization="percentage")
h2.BinWidth = 0.01;
xlabel('Quantum Yield (µmol J^-^1)')
ylabel('Relative Percentage')
ytickformat("percentage")
ntitle('(c) ','location','northeast');
set(gca, 'XDir','reverse')
box on

subplot(2,2,4)
hold on
h1 = histogram(SRS6_24day_beta_MM(:,3)*-1,'EdgeColor','none',Normalization="percentage")
h1.BinWidth = 2;
h2 = histogram(TS7_24day_beta_MM(:,3)*-1,'EdgeColor','none',Normalization="percentage")
h2.BinWidth = 2;
xlabel('Amax (µmol m^-^2s^-^1)')
ylabel('Relative Percentage')
ytickformat("percentage")
ntitle('(d) ','location','northeast');
set(gca, 'XDir','reverse')
box on








%%%%%% figure 3, ploting average TRC 


rb_mean_srs6 = mean(SRS6_24day_beta_TRC(:,1),'omitnan');
e0_mean_srs6 = mean(SRS6_24day_beta_TRC(:,2),'omitnan');


rb_mean_ts7 = mean(TS7_24day_beta_TRC(:,1),'omitnan');
e0_mean_ts7 = mean(TS7_24day_beta_TRC(:,2),'omitnan');



clear x_ppdf_values
x_ppdf_values = 5:35;


y_trc_srs6 = rb_mean_srs6.*exp(e0_mean_srs6.*((1./(15--46.02)-(1./(x_ppdf_values--46.02)))));
y_trc_ts7 = rb_mean_ts7.*exp(e0_mean_ts7.*((1./(15--46.02)-(1./(x_ppdf_values--46.02)))));


subplot(3,1,1)
hold on
plot(x_ppdf_values,y_trc_srs6)
plot(x_ppdf_values,y_trc_ts7,'Color',[0.8500 0.3250 0.0980])

box on
ntitle('(a) ','location','southeast');
ylabel({'Temperature Based R_e_c_o';'(µmol m^-^2s^-^1)'})
xlabel('Air Temperature (^{\circ}C)')
legend('Tall Forest','Scrub Forest','Location','northwest')


subplot(3,1,2)
hold on
h1 = histogram(SRS6_24day_beta_TRC(:,1),'EdgeColor','none',Normalization="percentage")
h1.BinWidth = 0.25;
h2 = histogram(TS7_24day_beta_TRC(:,1),'EdgeColor','none',Normalization="percentage")
h2.BinWidth = 0.25;
xlabel('rb (µmol m^-^2s^-^1)')
ylabel('Relative Percentage')
ytickformat("percentage")
ntitle('(b) ','location','northeast');
box on


subplot(3,1,3)
hold on
h1 = histogram(SRS6_24day_beta_TRC(:,2),'EdgeColor','none',Normalization="percentage")
h1.BinWidth = 25;
h2 = histogram(TS7_24day_beta_TRC(:,2),'EdgeColor','none',Normalization="percentage")
h2.BinWidth = 25;
xlabel('E0 (µmol m^-^2s^-^1 ^{\circ}C^-^1)')
ylabel('Relative Percentage')
ytickformat("percentage")
ntitle('(c) ','location','northeast');
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








%%%%%% figure 4 LAI histogram and LAI regressions


subplot (3,1,1)
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


subplot(3,1,2)
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


%fake data for legend
plot(nan,nan,'.','Color',[0 0.4470 0.7410],'MarkerSize',12)
plot(nan,nan,'-','Color',[0 0.4470 0.7410])
plot(nan,nan,':','Color',[0 0.4470 0.7410])
plot(nan,nan,'.','Color',[0.8500 0.3250 0.0980],'MarkerSize',12)
plot(nan,nan,'-','Color',[0.8500 0.3250 0.0980])
plot(nan,nan,':','Color',[0.8500 0.3250 0.0980])

%plot(ecosystem_LAI,ecosystem_MM_1,'.k')
plot(TS7_modis_24day.LAIqc,TS7_24day_beta_MM(:,1),'.','Color',[0.8500 0.3250 0.0980],'MarkerSize',12)
plot(SRS6_modis_24day.LAIqc,SRS6_24day_beta_MM(:,1),'.','Color',[0 0.4470 0.7410],'MarkerSize',12)

plot(xy_plot_SRS6_nonds(:,1),xy_plot_SRS6_nonds(:,2),'-','Color',[0 0.4470 0.7410])
plot(xy_plot_SRS6_ds(:,1),xy_plot_SRS6_ds(:,2),':','Color',[0 0.4470 0.7410])


plot(xy_plot_TS7_nonds(:,1),xy_plot_TS7_nonds(:,2),'-','Color',[0.8500 0.3250 0.0980])
plot(xy_plot_TS7_ds(:,1),xy_plot_TS7_ds(:,2),':','Color',[0.8500 0.3250 0.0980])

legend('Tall Forest','Tall Model','Tall Disturbance Model','Scrub Forest','Scrub Model','Scrub Disturbance Model','Location','northwest')

ylabel('Light Based R_e_c_o (µmol m^-^2s^-^1)')
xlabel('LAI (m^2 m^-^2)')
ntitle('(b) ','location','northeast');
xlim([1 7.5])
box on



subplot(3,1,3)
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


plot(TS7_modis_24day.LAIqc,TS7_24day_beta_MM(:,3)*-1,'.','Color',[0.8500 0.3250 0.0980],'MarkerSize',12)
plot(SRS6_modis_24day.LAIqc,SRS6_24day_beta_MM(:,3)*-1,'.','Color',[0 0.4470 0.7410],'MarkerSize',12)
%plot(SRS6_modis.LAIqc(index_ds),SRS6_8day_beta_MM(index_ds,3),'.r','MarkerSize',10)

plot(xy_plot_SRS6_nonds(:,1),xy_plot_SRS6_nonds(:,2)*-1,'-','Color',[0 0.4470 0.7410])
plot(xy_plot_SRS6_ds(:,1),xy_plot_SRS6_ds(:,2)*-1,':','Color',[0 0.4470 0.7410])


plot(xy_plot_TS7_nonds(:,1),xy_plot_TS7_nonds(:,2)*-1,'-','Color',[0.8500 0.3250 0.0980])
plot(xy_plot_TS7_ds(:,1),xy_plot_TS7_ds(:,2)*-1,':','Color',[0.8500 0.3250 0.0980])

ylabel('Amax (µmol m^-^2s^-^1)')
xlabel('LAI (m^2 m^-^2)')
ntitle('(c) ','location','northeast');
xlim([1 7.5])
ylim([-62 0])
set(gca, 'YDir','reverse')
box on








%%%%% SI Figure 13

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
plot(SRS6_24day_annual_qy*-1,'Color',[0 0.4470 0.7410])
plot(TS7_24day_annual_qy*-1,'Color',[0.8500 0.3250 0.0980])

plot(SRS6_24day_beta_MM(1:15,2)*-1,'.','Color',[0 0.4470 0.7410])
plot(SRS6_24day_beta_MM(16:27,2)*-1,'.','Color',[0 0.4470 0.7410]) % hurricane on index 28
plot(SRS6_24day_beta_MM(28:30,2)*-1,'.','Color',[0 0.4470 0.7410])
plot(SRS6_24day_beta_MM(31:45,2)*-1,'.','Color',[0 0.4470 0.7410])
plot(SRS6_24day_beta_MM(46:60,2)*-1,'.','Color',[0 0.4470 0.7410])
plot(SRS6_24day_beta_MM(61:75,2)*-1,'.','Color',[0 0.4470 0.7410])
plot(SRS6_24day_beta_MM(76:87,2)*-1,'.','Color',[0 0.4470 0.7410])
plot(SRS6_24day_beta_MM(88:90,2)*-1,'.','Color',[0 0.4470 0.7410])
plot(SRS6_24day_beta_MM(88:90,2)*-1,'.','Color',[0 0.4470 0.7410])
plot(SRS6_24day_beta_MM(91:105,2)*-1,'.','Color',[0 0.4470 0.7410])
plot(SRS6_24day_beta_MM(106:120,2)*-1,'.','Color',[0 0.4470 0.7410])

plot(SRS6_24day_beta_MM(196:210,2)*-1,'.','Color',[0 0.4470 0.7410])
plot(SRS6_24day_beta_MM(211:225,2)*-1,'.','Color',[0 0.4470 0.7410])
plot(SRS6_24day_beta_MM(226:240,2)*-1,'.','Color',[0 0.4470 0.7410])
plot(SRS6_24day_beta_MM(241:255,2)*-1,'.','Color',[0 0.4470 0.7410])
plot(SRS6_24day_beta_MM(256:270,2)*-1,'.','Color',[0 0.4470 0.7410])
plot(SRS6_24day_beta_MM(271:285,2)*-1,'.','Color',[0 0.4470 0.7410])
plot(SRS6_24day_beta_MM(286:300,2)*-1,'.','Color',[0 0.4470 0.7410])



plot(TS7_24day_beta_MM(196:210,2)*-1,'.','Color',[0.8500 0.3250 0.0980])
plot(TS7_24day_beta_MM(211:225,2)*-1,'.','Color',[0.8500 0.3250 0.0980])
plot(TS7_24day_beta_MM(226:240,2)*-1,'.','Color',[0.8500 0.3250 0.0980])
plot(TS7_24day_beta_MM(241:255,2)*-1,'.','Color',[0.8500 0.3250 0.0980])
plot(TS7_24day_beta_MM(256:270,2)*-1,'.','Color',[0.8500 0.3250 0.0980])
plot(TS7_24day_beta_MM(271:285,2)*-1,'.','Color',[0.8500 0.3250 0.0980])
plot(TS7_24day_beta_MM(286:300,2)*-1,'.','Color',[0.8500 0.3250 0.0980])

box on
xticks([1,6,11,15])
xticklabels({'','','',''})
ylabel('Quantum Yield (µmol J^-^1)')
ntitle('(b) ','location','northeast');
xlim([0.5,15.5])
legend('Mangrove Forest','Mangrove Scrub','Location','northwest')
set(gca, 'YDir','reverse')

subplot(3,1,3)
hold on
plot(SRS6_24day_annual_amax*-1,'Color',[0 0.4470 0.7410])

plot(SRS6_24day_beta_MM(1:15,3)*-1,'.','Color',[0 0.4470 0.7410])
plot(SRS6_24day_beta_MM(16:27,3)*-1,'.','Color',[0 0.4470 0.7410]) % hurricane on index 28
plot(SRS6_24day_beta_MM(28:30,3)*-1,'.','Color',[0 0.4470 0.7410])
plot(SRS6_24day_beta_MM(31:45,3)*-1,'.','Color',[0 0.4470 0.7410])
plot(SRS6_24day_beta_MM(46:60,3)*-1,'.','Color',[0 0.4470 0.7410])
plot(SRS6_24day_beta_MM(61:75,3)*-1,'.','Color',[0 0.4470 0.7410])
plot(SRS6_24day_beta_MM(76:87,3)*-1,'.','Color',[0 0.4470 0.7410])
plot(SRS6_24day_beta_MM(88:90,3)*-1,'.','Color',[0 0.4470 0.7410])
plot(SRS6_24day_beta_MM(88:90,3)*-1,'.','Color',[0 0.4470 0.7410])
plot(SRS6_24day_beta_MM(91:105,3)*-1,'.','Color',[0 0.4470 0.7410])
plot(SRS6_24day_beta_MM(106:120,3)*-1,'.','Color',[0 0.4470 0.7410])

plot(SRS6_24day_beta_MM(196:210,3)*-1,'.','Color',[0 0.4470 0.7410])
plot(SRS6_24day_beta_MM(211:225,3)*-1,'.','Color',[0 0.4470 0.7410])
plot(SRS6_24day_beta_MM(226:240,3)*-1,'.','Color',[0 0.4470 0.7410])
plot(SRS6_24day_beta_MM(241:255,3)*-1,'.','Color',[0 0.4470 0.7410])
plot(SRS6_24day_beta_MM(256:270,3)*-1,'.','Color',[0 0.4470 0.7410])
plot(SRS6_24day_beta_MM(271:285,3)*-1,'.','Color',[0 0.4470 0.7410])
plot(SRS6_24day_beta_MM(286:300,3)*-1,'.','Color',[0 0.4470 0.7410])

plot(TS7_24day_annual_amax*-1,'Color',[0.8500 0.3250 0.0980])

plot(TS7_24day_beta_MM(196:210,3)*-1,'.','Color',[0.8500 0.3250 0.0980])
plot(TS7_24day_beta_MM(211:225,3)*-1,'.','Color',[0.8500 0.3250 0.0980])
plot(TS7_24day_beta_MM(226:240,3)*-1,'.','Color',[0.8500 0.3250 0.0980])
plot(TS7_24day_beta_MM(241:255,3)*-1,'.','Color',[0.8500 0.3250 0.0980])
plot(TS7_24day_beta_MM(256:270,3)*-1,'.','Color',[0.8500 0.3250 0.0980])
plot(TS7_24day_beta_MM(271:285,3)*-1,'.','Color',[0.8500 0.3250 0.0980])
plot(TS7_24day_beta_MM(286:300,3)*-1,'.','Color',[0.8500 0.3250 0.0980])

box on
xticks([1,6,11,15])
xticklabels({'Jan','May','Sept','Dec'})
ylabel('Amax (µmol m^-^2s^-^1)')
ntitle('(c) ','location','northeast');
xlim([0.5,15.5])
set(gca, 'YDir','reverse')







%%%%% figure 5   LAI, Reco, QY, and Amax parament rates


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
ylabel('LRC R_e_c_o (µmol m^-^2s^-^1)')
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
plot(1:15,SRS6_24day_TRCmodel_Reco_dailyave(index_24day_ds_minusyr1(16:30)),'^','Color',[0 0.4470 0.7410],'MarkerSize',4)
plot(16:30,SRS6_24day_TRCmodel_Reco_dailyave(index_24day_ds_yr1(16:30)),'^','Color',[0 0.4470 0.7410],'MarkerSize',4)
plot(31:45,SRS6_24day_TRCmodel_Reco_dailyave(index_24day_ds_yr2(16:30)),'^','Color',[0 0.4470 0.7410],'MarkerSize',4)
plot(46:60,SRS6_24day_TRCmodel_Reco_dailyave(index_24day_ds_yr3(16:30)),'^','Color',[0 0.4470 0.7410],'MarkerSize',4)
plot(61:75,SRS6_24day_TRCmodel_Reco_dailyave(index_24day_ds_yr4(16:30)),'^','Color',[0 0.4470 0.7410],'MarkerSize',4)

plot(1:15,TS7_24day_TRCmodel_Reco_dailyave(index_24day_ds_minusyr1(16:30)),'^','Color',[0.8500 0.3250 0.0980],'MarkerSize',4)
plot(16:30,TS7_24day_TRCmodel_Reco_dailyave(index_24day_ds_yr1(16:30)),'^','Color',[0.8500 0.3250 0.0980],'MarkerSize',4)
plot(31:45,TS7_24day_TRCmodel_Reco_dailyave(index_24day_ds_yr2(16:30)),'^','Color',[0.8500 0.3250 0.0980],'MarkerSize',4)
plot(46:60,TS7_24day_TRCmodel_Reco_dailyave(index_24day_ds_yr3(16:30)),'^','Color',[0.8500 0.3250 0.0980],'MarkerSize',4)
plot(61:75,TS7_24day_TRCmodel_Reco_dailyave(index_24day_ds_yr4(16:30)),'^','Color',[0.8500 0.3250 0.0980],'MarkerSize',4)


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
ylabel('TRC R_e_c_o (µmol m^-^2s^-^1)')
ntitle(' (d)','location','northwest');


subplot(2,2,3)
hold on
plot(1:15,SRS6_24day_beta_MM(index_24day_ds_minusyr1(1:15),3)*-1,'.','Color',[0 0.4470 0.7410],'MarkerSize',12)
plot(1:15,SRS6_24day_beta_MM(index_24day_ds_minusyr1(16:30),3)*-1,'.','Color',[0 0.4470 0.7410],'MarkerSize',12)
plot(16:30,SRS6_24day_beta_MM(index_24day_ds_yr1(1:15),3)*-1,'.','Color',[0 0.4470 0.7410],'MarkerSize',12)
plot(16:30,SRS6_24day_beta_MM(index_24day_ds_yr1(16:30),3)*-1,'.','Color',[0 0.4470 0.7410],'MarkerSize',12)
plot(31:45,SRS6_24day_beta_MM(index_24day_ds_yr2(1:15),3)*-1,'.','Color',[0 0.4470 0.7410],'MarkerSize',12)
plot(31:45,SRS6_24day_beta_MM(index_24day_ds_yr2(16:30),3)*-1,'.','Color',[0 0.4470 0.7410],'MarkerSize',12)
plot(46:60,SRS6_24day_beta_MM(index_24day_ds_yr3(1:15),3)*-1,'.','Color',[0 0.4470 0.7410],'MarkerSize',12)
plot(46:60,SRS6_24day_beta_MM(index_24day_ds_yr3(16:30),3)*-1,'.','Color',[0 0.4470 0.7410],'MarkerSize',12)
plot(61:75,SRS6_24day_beta_MM(index_24day_ds_yr4(1:15),3)*-1,'.','Color',[0 0.4470 0.7410],'MarkerSize',12)
plot(61:75,SRS6_24day_beta_MM(index_24day_ds_yr4(16:30),3)*-1,'.','Color',[0 0.4470 0.7410],'MarkerSize',12)

plot(1:15,TS7_24day_beta_MM(index_24day_ds_minusyr1(16:30),3)*-1,'.','Color',[0.8500 0.3250 0.0980],'MarkerSize',12)
plot(16:30,TS7_24day_beta_MM(index_24day_ds_yr1(16:30),3)*-1,'.','Color',[0.8500 0.3250 0.0980],'MarkerSize',12)
plot(31:45,TS7_24day_beta_MM(index_24day_ds_yr2(16:30),3)*-1,'.','Color',[0.8500 0.3250 0.0980],'MarkerSize',12)
plot(46:60,TS7_24day_beta_MM(index_24day_ds_yr3(16:30),3)*-1,'.','Color',[0.8500 0.3250 0.0980],'MarkerSize',12)
plot(61:75,TS7_24day_beta_MM(index_24day_ds_yr4(16:30),3)*-1,'.','Color',[0.8500 0.3250 0.0980],'MarkerSize',12)

%LRC modeled data
plot(1:15,SRS6_LRCmodel_Amax(index_24day_ds_minusyr1(16:30))*-1,'o','Color',[0 0.4470 0.7410],'MarkerSize',4)
plot(16:30,SRS6_LRCmodel_Amax(index_24day_ds_yr1(16:30))*-1,'o','Color',[0 0.4470 0.7410],'MarkerSize',4)
plot(31:45,SRS6_LRCmodel_Amax(index_24day_ds_yr2(16:30))*-1,'o','Color',[0 0.4470 0.7410],'MarkerSize',4)
plot(46:60,SRS6_LRCmodel_Amax(index_24day_ds_yr3(16:30))*-1,'o','Color',[0 0.4470 0.7410],'MarkerSize',4)
plot(61:75,SRS6_LRCmodel_Amax(index_24day_ds_yr4(16:30))*-1,'o','Color',[0 0.4470 0.7410],'MarkerSize',4)

plot(1:15,TS7_LRCmodel_Amax(index_24day_ds_minusyr1(16:30))*-1,'o','Color',[0.8500 0.3250 0.0980],'MarkerSize',4)
plot(16:30,TS7_LRCmodel_Amax(index_24day_ds_yr1(16:30))*-1,'o','Color',[0.8500 0.3250 0.0980],'MarkerSize',4)
plot(31:45,TS7_LRCmodel_Amax(index_24day_ds_yr2(16:30))*-1,'o','Color',[0.8500 0.3250 0.0980],'MarkerSize',4)
plot(46:60,TS7_LRCmodel_Amax(index_24day_ds_yr3(16:30))*-1,'o','Color',[0.8500 0.3250 0.0980],'MarkerSize',4)
plot(61:75,TS7_LRCmodel_Amax(index_24day_ds_yr4(16:30))*-1,'o','Color',[0.8500 0.3250 0.0980],'MarkerSize',4)

%add fancy lines
plot([15,15],[-60,0],"--k","LineWidth", 2)   %15 is the number of 24-day periods in one year
%nanmean(SRS6_24day_beta_MM(index_24day_ds_minusyr1,3))
plot([0,15],[-28.77,-28.77],"LineWidth", 2,'Color',[0 0.4470 0.7410]) %nondisutrbance mean Amax 28.77
plot([0,15],[-6.65,-6.65],"LineWidth", 2,'Color',[0.8500 0.3250 0.0980]) %nondisutrbance mean Amax 6.65
%nanmean(TS7_LRCmodel_Amax(index_24day_ds_minusyr1))
plot([0,15],[-32.97,-32.97],":","LineWidth", 2,'Color',[0 0.4470 0.7410]) %nondisutrbance mean Reco  32.97
plot([0,15],[-9.06,-9.06],":","LineWidth", 2,'Color',[0.8500 0.3250 0.0980]) %nondisutrbance mean Reco 9.06
%add fancy smoothin
plot(16:75,SRS6_Amax_fouryear_smooth*-1,"LineWidth", 2,'Color',[0 0.4470 0.7410],'MarkerSize',12)
plot(16:75,TS7_Amax_fouryear_smooth*-1,"LineWidth", 2,'Color',[0.8500 0.3250 0.0980],'MarkerSize',12)
plot(16:75,SRS6_LRCmodel_Amax_fouryear_smooth*-1,":","LineWidth", 2,'Color',[0 0.4470 0.7410])
plot(16:75,TS7_LRCmodel_Amax_fouryear_smooth*-1,":","LineWidth", 2,'Color',[0.8500 0.3250 0.0980])

xticks([0 15 30 45 60 75])
xticklabels({'Year = -1','Hurricane','Year = 1','Year = 2','Year = 3','Year = 4'})
xlim([0 75])
ylim([-40 0])
box on
ylabel('Amax (µmol m^-^2s^-^1)')
ntitle(' (c)','location','northwest');
set(gca, 'YDir','reverse')









%%%%%%%%%%%%% code for Figure 6 NEE recovery debt for LRC and TRC models
%%%%% 30 min index
%pre wilma 1:31392
%    wilma 31393:52608
%post wilma, pre irma 52609:239616
%    irma 239617:280512
%post irma 280513:350640



year_ln = 17520;

index_baseline = [31392-year_ln:31392,239616-year_ln:239616];

index_wilma_y1 = 31393:(31393+year_ln);
index_wilma_y2 = (31393+year_ln+1):(31393+year_ln*2);
index_wilma_y3 = (31393+year_ln*2+1):(31393+year_ln*3);
index_wilma_y4 = (31393+year_ln*3+1):(31393+year_ln*4);

index_irma_y1 = 239617:(239617+year_ln);
index_irma_y2 = (239617+year_ln+1):(239617+year_ln*2);
index_irma_y3 = (239617+year_ln*2+1):(239617+year_ln*3);
index_irma_y4 = (239617+year_ln*3+1):(239617+year_ln*4);


% index_baseline = and(model_day > 2010, model_day < 2016);
% 
% index_wilma_y1 = and(model_day > 2006, model_day < 2007);
% index_wilma_y2 = and(model_day > 2007, model_day < 2008);
% index_wilma_y3 = and(model_day > 2008, model_day < 2009);
% index_wilma_y4 = and(model_day > 2009, model_day < 2010);




% % plot to check index values
% hold on
% plot(model_day,SRS6_LRCmodel_NEP_30min)
% plot(model_day(index_baseline),SRS6_LRCmodel_NEP_30min(index_baseline))
% 
% plot(model_day(index_wilma_y1),SRS6_LRCmodel_NEP_30min(index_wilma_y1))
% plot(model_day(index_wilma_y2),SRS6_LRCmodel_NEP_30min(index_wilma_y2))
% plot(model_day(index_wilma_y3),SRS6_LRCmodel_NEP_30min(index_wilma_y3))
% plot(model_day(index_wilma_y4),SRS6_LRCmodel_NEP_30min(index_wilma_y4))
% 
% plot(model_day(index_irma_y1),SRS6_LRCmodel_NEP_30min(index_irma_y1))
% plot(model_day(index_irma_y2),SRS6_LRCmodel_NEP_30min(index_irma_y2))
% plot(model_day(index_irma_y3),SRS6_LRCmodel_NEP_30min(index_irma_y3))
% plot(model_day(index_irma_y4),SRS6_LRCmodel_NEP_30min(index_irma_y4))






% LRC
% SRS6
SRS6_debt_LRC_wilma_yr1 = sum(mean(SRS6_LRCmodel_NEP_30min(index_baseline),'omitnan') - (SRS6_LRCmodel_NEP_30min(index_wilma_y1)),'omitnan');
SRS6_debt_LRC_wilma_yr2 = sum(mean(SRS6_LRCmodel_NEP_30min(index_baseline),'omitnan') - (SRS6_LRCmodel_NEP_30min(index_wilma_y2)),'omitnan');
SRS6_debt_LRC_wilma_yr3 = sum(mean(SRS6_LRCmodel_NEP_30min(index_baseline),'omitnan') - (SRS6_LRCmodel_NEP_30min(index_wilma_y3)),'omitnan');
SRS6_debt_LRC_wilma_yr4 = sum(mean(SRS6_LRCmodel_NEP_30min(index_baseline),'omitnan') - (SRS6_LRCmodel_NEP_30min(index_wilma_y4)),'omitnan');


%SRS6_debt_LRC_wilma_yr1 = mean(SRS6_LRCmodel_NEP_30min(index_wilma_y1),'omitnan') - mean(SRS6_LRCmodel_NEP_30min(index_baseline),'omitnan');
%SRS6_debt_LRC_wilma_yr2 = mean(SRS6_LRCmodel_NEP_30min(index_wilma_y2),'omitnan') - mean(SRS6_LRCmodel_NEP_30min(index_baseline),'omitnan');
%SRS6_debt_LRC_wilma_yr3 = mean(SRS6_LRCmodel_NEP_30min(index_wilma_y3),'omitnan') - mean(SRS6_LRCmodel_NEP_30min(index_baseline),'omitnan');
%RS6_debt_LRC_wilma_yr4 = mean(SRS6_LRCmodel_NEP_30min(index_wilma_y4),'omitnan') - mean(SRS6_LRCmodel_NEP_30min(index_baseline),'omitnan');

SRS6_debt_LRC_wilma_total = SRS6_debt_LRC_wilma_yr1 + SRS6_debt_LRC_wilma_yr2 + SRS6_debt_LRC_wilma_yr3 + SRS6_debt_LRC_wilma_yr4;
SRS6_debt_LRC_wilma = [SRS6_debt_LRC_wilma_yr1,SRS6_debt_LRC_wilma_yr2,SRS6_debt_LRC_wilma_yr3,SRS6_debt_LRC_wilma_yr4];
SRS6_debt_LRC_wilma_gCm2 = SRS6_debt_LRC_wilma *12.0107 / 1000000 * 1800;
% units 12.0107 *NEE / 1000000 * 1800,



SRS6_debt_LRC_irma_yr1 = sum(mean(SRS6_LRCmodel_NEP_30min(index_baseline),'omitnan') - (SRS6_LRCmodel_NEP_30min(index_irma_y1)),'omitnan');
SRS6_debt_LRC_irma_yr2 = sum(mean(SRS6_LRCmodel_NEP_30min(index_baseline),'omitnan') - (SRS6_LRCmodel_NEP_30min(index_irma_y2)),'omitnan');
SRS6_debt_LRC_irma_yr3 = sum(mean(SRS6_LRCmodel_NEP_30min(index_baseline),'omitnan') - (SRS6_LRCmodel_NEP_30min(index_irma_y3)),'omitnan');
SRS6_debt_LRC_irma_yr4 = sum(mean(SRS6_LRCmodel_NEP_30min(index_baseline),'omitnan') - (SRS6_LRCmodel_NEP_30min(index_irma_y4)),'omitnan');

SRS6_debt_LRC_irma_total = SRS6_debt_LRC_irma_yr1 + SRS6_debt_LRC_irma_yr2 + SRS6_debt_LRC_irma_yr3 + SRS6_debt_LRC_irma_yr4;
SRS6_debt_LRC_irma = [SRS6_debt_LRC_irma_yr1,SRS6_debt_LRC_irma_yr2,SRS6_debt_LRC_irma_yr3,SRS6_debt_LRC_irma_yr4];
SRS6_debt_LRC_irma_gCm2 = SRS6_debt_LRC_irma *12.0107 / 1000000 * 1800;
% units 12.0107 *NEE / 1000000 * 1800,

% TS7
TS7_debt_LRC_wilma_yr1 = sum(mean(TS7_LRCmodel_NEP_30min(index_baseline),'omitnan') - (TS7_LRCmodel_NEP_30min(index_wilma_y1)),'omitnan');
TS7_debt_LRC_wilma_yr2 = sum(mean(TS7_LRCmodel_NEP_30min(index_baseline),'omitnan') - (TS7_LRCmodel_NEP_30min(index_wilma_y2)),'omitnan');
TS7_debt_LRC_wilma_yr3 = sum(mean(TS7_LRCmodel_NEP_30min(index_baseline),'omitnan') - (TS7_LRCmodel_NEP_30min(index_wilma_y3)),'omitnan');
TS7_debt_LRC_wilma_yr4 = sum(mean(TS7_LRCmodel_NEP_30min(index_baseline),'omitnan') - (TS7_LRCmodel_NEP_30min(index_wilma_y4)),'omitnan');


TS7_debt_LRC_wilma_total = TS7_debt_LRC_wilma_yr1 + TS7_debt_LRC_wilma_yr2 + TS7_debt_LRC_wilma_yr3 + TS7_debt_LRC_wilma_yr4;
TS7_debt_LRC_wilma = [TS7_debt_LRC_wilma_yr1,TS7_debt_LRC_wilma_yr2,TS7_debt_LRC_wilma_yr3,TS7_debt_LRC_wilma_yr4];
TS7_debt_LRC_wilma_gCm2 = TS7_debt_LRC_wilma *12.0107 / 1000000 * 1800;
% units 12.0107 *NEE / 1000000 * 1800,



TS7_debt_LRC_irma_yr1 = sum(mean(TS7_LRCmodel_NEP_30min(index_baseline),'omitnan') - (TS7_LRCmodel_NEP_30min(index_irma_y1)),'omitnan');
TS7_debt_LRC_irma_yr2 = sum(mean(TS7_LRCmodel_NEP_30min(index_baseline),'omitnan') - (TS7_LRCmodel_NEP_30min(index_irma_y2)),'omitnan');
TS7_debt_LRC_irma_yr3 = sum(mean(TS7_LRCmodel_NEP_30min(index_baseline),'omitnan') - (TS7_LRCmodel_NEP_30min(index_irma_y3)),'omitnan');
TS7_debt_LRC_irma_yr4 = sum(mean(TS7_LRCmodel_NEP_30min(index_baseline),'omitnan') - (TS7_LRCmodel_NEP_30min(index_irma_y4)),'omitnan');

TS7_debt_LRC_irma_total = TS7_debt_LRC_irma_yr1 + TS7_debt_LRC_irma_yr2 + TS7_debt_LRC_irma_yr3 + TS7_debt_LRC_irma_yr4;
TS7_debt_LRC_irma = [TS7_debt_LRC_irma_yr1,TS7_debt_LRC_irma_yr2,TS7_debt_LRC_irma_yr3,TS7_debt_LRC_irma_yr4];
TS7_debt_LRC_irma_gCm2 = TS7_debt_LRC_irma *12.0107 / 1000000 * 1800;
% units 12.0107 *NEE / 1000000 * 1800,





% TRC
% SRS6
SRS6_debt_TRC_wilma_yr1 = sum(mean(SRS6_TRCmodel_NEP_30min(index_baseline),'omitnan') - (SRS6_TRCmodel_NEP_30min(index_wilma_y1)),'omitnan');
SRS6_debt_TRC_wilma_yr2 = sum(mean(SRS6_TRCmodel_NEP_30min(index_baseline),'omitnan') - (SRS6_TRCmodel_NEP_30min(index_wilma_y2)),'omitnan');
SRS6_debt_TRC_wilma_yr3 = sum(mean(SRS6_TRCmodel_NEP_30min(index_baseline),'omitnan') - (SRS6_TRCmodel_NEP_30min(index_wilma_y3)),'omitnan');
SRS6_debt_TRC_wilma_yr4 = sum(mean(SRS6_TRCmodel_NEP_30min(index_baseline),'omitnan') - (SRS6_TRCmodel_NEP_30min(index_wilma_y4)),'omitnan');


%SRS6_debt_TRC_wilma_yr1 = mean(SRS6_TRCmodel_NEP_30min(index_wilma_y1),'omitnan') - mean(SRS6_TRCmodel_NEP_30min(index_baseline),'omitnan');
%SRS6_debt_TRC_wilma_yr2 = mean(SRS6_TRCmodel_NEP_30min(index_wilma_y2),'omitnan') - mean(SRS6_TRCmodel_NEP_30min(index_baseline),'omitnan');
%SRS6_debt_TRC_wilma_yr3 = mean(SRS6_TRCmodel_NEP_30min(index_wilma_y3),'omitnan') - mean(SRS6_TRCmodel_NEP_30min(index_baseline),'omitnan');
%RS6_debt_TRC_wilma_yr4 = mean(SRS6_TRCmodel_NEP_30min(index_wilma_y4),'omitnan') - mean(SRS6_TRCmodel_NEP_30min(index_baseline),'omitnan');

SRS6_debt_TRC_wilma_total = SRS6_debt_TRC_wilma_yr1 + SRS6_debt_TRC_wilma_yr2 + SRS6_debt_TRC_wilma_yr3 + SRS6_debt_TRC_wilma_yr4;
SRS6_debt_TRC_wilma = [SRS6_debt_TRC_wilma_yr1,SRS6_debt_TRC_wilma_yr2,SRS6_debt_TRC_wilma_yr3,SRS6_debt_TRC_wilma_yr4];
SRS6_debt_TRC_wilma_gCm2 = SRS6_debt_TRC_wilma *12.0107 / 1000000 * 1800;
% units 12.0107 *NEE / 1000000 * 1800,



SRS6_debt_TRC_irma_yr1 = sum(mean(SRS6_TRCmodel_NEP_30min(index_baseline),'omitnan') - (SRS6_TRCmodel_NEP_30min(index_irma_y1)),'omitnan');
SRS6_debt_TRC_irma_yr2 = sum(mean(SRS6_TRCmodel_NEP_30min(index_baseline),'omitnan') - (SRS6_TRCmodel_NEP_30min(index_irma_y2)),'omitnan');
SRS6_debt_TRC_irma_yr3 = sum(mean(SRS6_TRCmodel_NEP_30min(index_baseline),'omitnan') - (SRS6_TRCmodel_NEP_30min(index_irma_y3)),'omitnan');
SRS6_debt_TRC_irma_yr4 = sum(mean(SRS6_TRCmodel_NEP_30min(index_baseline),'omitnan') - (SRS6_TRCmodel_NEP_30min(index_irma_y4)),'omitnan');

SRS6_debt_TRC_irma_total = SRS6_debt_TRC_irma_yr1 + SRS6_debt_TRC_irma_yr2 + SRS6_debt_TRC_irma_yr3 + SRS6_debt_TRC_irma_yr4;
SRS6_debt_TRC_irma = [SRS6_debt_TRC_irma_yr1,SRS6_debt_TRC_irma_yr2,SRS6_debt_TRC_irma_yr3,SRS6_debt_TRC_irma_yr4];
SRS6_debt_TRC_irma_gCm2 = SRS6_debt_TRC_irma *12.0107 / 1000000 * 1800;
% units 12.0107 *NEE / 1000000 * 1800,

% TS7
TS7_debt_TRC_wilma_yr1 = sum(mean(TS7_TRCmodel_NEP_30min(index_baseline),'omitnan') - (TS7_TRCmodel_NEP_30min(index_wilma_y1)),'omitnan');
TS7_debt_TRC_wilma_yr2 = sum(mean(TS7_TRCmodel_NEP_30min(index_baseline),'omitnan') - (TS7_TRCmodel_NEP_30min(index_wilma_y2)),'omitnan');
TS7_debt_TRC_wilma_yr3 = sum(mean(TS7_TRCmodel_NEP_30min(index_baseline),'omitnan') - (TS7_TRCmodel_NEP_30min(index_wilma_y3)),'omitnan');
TS7_debt_TRC_wilma_yr4 = sum(mean(TS7_TRCmodel_NEP_30min(index_baseline),'omitnan') - (TS7_TRCmodel_NEP_30min(index_wilma_y4)),'omitnan');


TS7_debt_TRC_wilma_total = TS7_debt_TRC_wilma_yr1 + TS7_debt_TRC_wilma_yr2 + TS7_debt_TRC_wilma_yr3 + TS7_debt_TRC_wilma_yr4;
TS7_debt_TRC_wilma = [TS7_debt_TRC_wilma_yr1,TS7_debt_TRC_wilma_yr2,TS7_debt_TRC_wilma_yr3,TS7_debt_TRC_wilma_yr4];
TS7_debt_TRC_wilma_gCm2 = TS7_debt_TRC_wilma *12.0107 / 1000000 * 1800;
% units 12.0107 *NEE / 1000000 * 1800,



TS7_debt_TRC_irma_yr1 = sum(mean(TS7_TRCmodel_NEP_30min(index_baseline),'omitnan') - (TS7_TRCmodel_NEP_30min(index_irma_y1)),'omitnan');
TS7_debt_TRC_irma_yr2 = sum(mean(TS7_TRCmodel_NEP_30min(index_baseline),'omitnan') - (TS7_TRCmodel_NEP_30min(index_irma_y2)),'omitnan');
TS7_debt_TRC_irma_yr3 = sum(mean(TS7_TRCmodel_NEP_30min(index_baseline),'omitnan') - (TS7_TRCmodel_NEP_30min(index_irma_y3)),'omitnan');
TS7_debt_TRC_irma_yr4 = sum(mean(TS7_TRCmodel_NEP_30min(index_baseline),'omitnan') - (TS7_TRCmodel_NEP_30min(index_irma_y4)),'omitnan');

TS7_debt_TRC_irma_total = TS7_debt_TRC_irma_yr1 + TS7_debt_TRC_irma_yr2 + TS7_debt_TRC_irma_yr3 + TS7_debt_TRC_irma_yr4;
TS7_debt_TRC_irma = [TS7_debt_TRC_irma_yr1,TS7_debt_TRC_irma_yr2,TS7_debt_TRC_irma_yr3,TS7_debt_TRC_irma_yr4];
TS7_debt_TRC_irma_gCm2 = TS7_debt_TRC_irma *12.0107 / 1000000 * 1800;
% units 12.0107 *NEE / 1000000 * 1800,




% LRC_TRC
% SRS6
SRS6_debt_LRC_TRC_wilma_yr1 = sum(mean(SRS6_LRC_TRCmodel_NEP_30min(index_baseline),'omitnan') - (SRS6_LRC_TRCmodel_NEP_30min(index_wilma_y1)),'omitnan');
SRS6_debt_LRC_TRC_wilma_yr2 = sum(mean(SRS6_LRC_TRCmodel_NEP_30min(index_baseline),'omitnan') - (SRS6_LRC_TRCmodel_NEP_30min(index_wilma_y2)),'omitnan');
SRS6_debt_LRC_TRC_wilma_yr3 = sum(mean(SRS6_LRC_TRCmodel_NEP_30min(index_baseline),'omitnan') - (SRS6_LRC_TRCmodel_NEP_30min(index_wilma_y3)),'omitnan');
SRS6_debt_LRC_TRC_wilma_yr4 = sum(mean(SRS6_LRC_TRCmodel_NEP_30min(index_baseline),'omitnan') - (SRS6_LRC_TRCmodel_NEP_30min(index_wilma_y4)),'omitnan');


%SRS6_debt_LRC_TRC_wilma_yr1 = mean(SRS6_LRC_TRCmodel_NEP_30min(index_wilma_y1),'omitnan') - mean(SRS6_LRC_TRCmodel_NEP_30min(index_baseline),'omitnan');
%SRS6_debt_LRC_TRC_wilma_yr2 = mean(SRS6_LRC_TRCmodel_NEP_30min(index_wilma_y2),'omitnan') - mean(SRS6_LRC_TRCmodel_NEP_30min(index_baseline),'omitnan');
%SRS6_debt_LRC_TRC_wilma_yr3 = mean(SRS6_LRC_TRCmodel_NEP_30min(index_wilma_y3),'omitnan') - mean(SRS6_LRC_TRCmodel_NEP_30min(index_baseline),'omitnan');
%RS6_debt_LRC_TRC_wilma_yr4 = mean(SRS6_LRC_TRCmodel_NEP_30min(index_wilma_y4),'omitnan') - mean(SRS6_LRC_TRCmodel_NEP_30min(index_baseline),'omitnan');

SRS6_debt_LRC_TRC_wilma_total = SRS6_debt_LRC_TRC_wilma_yr1 + SRS6_debt_LRC_TRC_wilma_yr2 + SRS6_debt_LRC_TRC_wilma_yr3 + SRS6_debt_LRC_TRC_wilma_yr4;
SRS6_debt_LRC_TRC_wilma = [SRS6_debt_LRC_TRC_wilma_yr1,SRS6_debt_LRC_TRC_wilma_yr2,SRS6_debt_LRC_TRC_wilma_yr3,SRS6_debt_LRC_TRC_wilma_yr4];
SRS6_debt_LRC_TRC_wilma_gCm2 = SRS6_debt_LRC_TRC_wilma *12.0107 / 1000000 * 1800;
% units 12.0107 *NEE / 1000000 * 1800,



SRS6_debt_LRC_TRC_irma_yr1 = sum(mean(SRS6_LRC_TRCmodel_NEP_30min(index_baseline),'omitnan') - (SRS6_LRC_TRCmodel_NEP_30min(index_irma_y1)),'omitnan');
SRS6_debt_LRC_TRC_irma_yr2 = sum(mean(SRS6_LRC_TRCmodel_NEP_30min(index_baseline),'omitnan') - (SRS6_LRC_TRCmodel_NEP_30min(index_irma_y2)),'omitnan');
SRS6_debt_LRC_TRC_irma_yr3 = sum(mean(SRS6_LRC_TRCmodel_NEP_30min(index_baseline),'omitnan') - (SRS6_LRC_TRCmodel_NEP_30min(index_irma_y3)),'omitnan');
SRS6_debt_LRC_TRC_irma_yr4 = sum(mean(SRS6_LRC_TRCmodel_NEP_30min(index_baseline),'omitnan') - (SRS6_LRC_TRCmodel_NEP_30min(index_irma_y4)),'omitnan');

SRS6_debt_LRC_TRC_irma_total = SRS6_debt_LRC_TRC_irma_yr1 + SRS6_debt_LRC_TRC_irma_yr2 + SRS6_debt_LRC_TRC_irma_yr3 + SRS6_debt_LRC_TRC_irma_yr4;
SRS6_debt_LRC_TRC_irma = [SRS6_debt_LRC_TRC_irma_yr1,SRS6_debt_LRC_TRC_irma_yr2,SRS6_debt_LRC_TRC_irma_yr3,SRS6_debt_LRC_TRC_irma_yr4];
SRS6_debt_LRC_TRC_irma_gCm2 = SRS6_debt_LRC_TRC_irma *12.0107 / 1000000 * 1800;
% units 12.0107 *NEE / 1000000 * 1800,

% TS7
TS7_debt_LRC_TRC_wilma_yr1 = sum(mean(TS7_LRC_TRCmodel_NEP_30min(index_baseline),'omitnan') - (TS7_LRC_TRCmodel_NEP_30min(index_wilma_y1)),'omitnan');
TS7_debt_LRC_TRC_wilma_yr2 = sum(mean(TS7_LRC_TRCmodel_NEP_30min(index_baseline),'omitnan') - (TS7_LRC_TRCmodel_NEP_30min(index_wilma_y2)),'omitnan');
TS7_debt_LRC_TRC_wilma_yr3 = sum(mean(TS7_LRC_TRCmodel_NEP_30min(index_baseline),'omitnan') - (TS7_LRC_TRCmodel_NEP_30min(index_wilma_y3)),'omitnan');
TS7_debt_LRC_TRC_wilma_yr4 = sum(mean(TS7_LRC_TRCmodel_NEP_30min(index_baseline),'omitnan') - (TS7_LRC_TRCmodel_NEP_30min(index_wilma_y4)),'omitnan');


TS7_debt_LRC_TRC_wilma_total = TS7_debt_LRC_TRC_wilma_yr1 + TS7_debt_LRC_TRC_wilma_yr2 + TS7_debt_LRC_TRC_wilma_yr3 + TS7_debt_LRC_TRC_wilma_yr4;
TS7_debt_LRC_TRC_wilma = [TS7_debt_LRC_TRC_wilma_yr1,TS7_debt_LRC_TRC_wilma_yr2,TS7_debt_LRC_TRC_wilma_yr3,TS7_debt_LRC_TRC_wilma_yr4];
TS7_debt_LRC_TRC_wilma_gCm2 = TS7_debt_LRC_TRC_wilma *12.0107 / 1000000 * 1800;
% units 12.0107 *NEE / 1000000 * 1800,



TS7_debt_LRC_TRC_irma_yr1 = sum(mean(TS7_LRC_TRCmodel_NEP_30min(index_baseline),'omitnan') - (TS7_LRC_TRCmodel_NEP_30min(index_irma_y1)),'omitnan');
TS7_debt_LRC_TRC_irma_yr2 = sum(mean(TS7_LRC_TRCmodel_NEP_30min(index_baseline),'omitnan') - (TS7_LRC_TRCmodel_NEP_30min(index_irma_y2)),'omitnan');
TS7_debt_LRC_TRC_irma_yr3 = sum(mean(TS7_LRC_TRCmodel_NEP_30min(index_baseline),'omitnan') - (TS7_LRC_TRCmodel_NEP_30min(index_irma_y3)),'omitnan');
TS7_debt_LRC_TRC_irma_yr4 = sum(mean(TS7_LRC_TRCmodel_NEP_30min(index_baseline),'omitnan') - (TS7_LRC_TRCmodel_NEP_30min(index_irma_y4)),'omitnan');

TS7_debt_LRC_TRC_irma_total = TS7_debt_LRC_TRC_irma_yr1 + TS7_debt_LRC_TRC_irma_yr2 + TS7_debt_LRC_TRC_irma_yr3 + TS7_debt_LRC_TRC_irma_yr4;
TS7_debt_LRC_TRC_irma = [TS7_debt_LRC_TRC_irma_yr1,TS7_debt_LRC_TRC_irma_yr2,TS7_debt_LRC_TRC_irma_yr3,TS7_debt_LRC_TRC_irma_yr4];
TS7_debt_LRC_TRC_irma_gCm2 = TS7_debt_LRC_TRC_irma *12.0107 / 1000000 * 1800;
% units 12.0107 *NEE / 1000000 * 1800,



SRS6_debt_ave = mean([SRS6_debt_LRC_wilma_gCm2;SRS6_debt_LRC_irma_gCm2;SRS6_debt_LRC_TRC_wilma_gCm2;SRS6_debt_LRC_TRC_irma_gCm2])*-1;
SRS6_debt_se = std([SRS6_debt_LRC_wilma_gCm2;SRS6_debt_LRC_irma_gCm2;SRS6_debt_LRC_TRC_wilma_gCm2;SRS6_debt_LRC_TRC_irma_gCm2]) / sqrt((length(SRS6_debt_ave)));
TS7_debt_ave = mean([TS7_debt_LRC_wilma_gCm2;TS7_debt_LRC_irma_gCm2;TS7_debt_LRC_TRC_wilma_gCm2;TS7_debt_LRC_TRC_irma_gCm2])*-1;
TS7_debt_se = std([TS7_debt_LRC_wilma_gCm2;TS7_debt_LRC_irma_gCm2;TS7_debt_LRC_TRC_wilma_gCm2;TS7_debt_LRC_TRC_irma_gCm2]) / sqrt((length(TS7_debt_ave)));


%wilma only
mean([SRS6_debt_LRC_wilma_gCm2;SRS6_debt_LRC_TRC_wilma_gCm2]);
std([SRS6_debt_LRC_wilma_gCm2;SRS6_debt_LRC_TRC_wilma_gCm2;SRS6_debt_LRC_TRC_irma_gCm2]) / sqrt((length(2)));
mean([TS7_debt_LRC_wilma_gCm2;TS7_debt_LRC_TRC_wilma_gCm2]);
std([TS7_debt_LRC_wilma_gCm2;TS7_debt_LRC_TRC_wilma_gCm2]) / sqrt((length(2)));

%irma only
mean([SRS6_debt_LRC_irma_gCm2;SRS6_debt_LRC_TRC_irma_gCm2]);
std([SRS6_debt_LRC_irma_gCm2;SRS6_debt_LRC_TRC_irma_gCm2]) / sqrt((length(2)));
mean([TS7_debt_LRC_irma_gCm2;TS7_debt_LRC_TRC_irma_gCm2]);
std([TS7_debt_LRC_irma_gCm2;TS7_debt_LRC_TRC_irma_gCm2]) / sqrt((length(2)));







%%%%% figure 6 site-level recovery debt


subplot(1,2,1)
hold on
plot(nan,nan,'Color',[0 0.4470 0.7410]) %for the legend
plot(nan,nan,'Color',[0.8500 0.3250 0.0980]) %for the legend
plot(nan,nan,'ok') %for the legend
plot(nan,nan,'^k') %for the legend

 

patch([0:4 fliplr(0:4)], [0 SRS6_debt_ave+SRS6_debt_se  fliplr(SRS6_debt_ave-SRS6_debt_se) 0], [0.9  0.9  0.9], 'EdgeColor', 'none')
patch([0:4 fliplr(0:4)], [0 TS7_debt_ave+TS7_debt_se  fliplr(TS7_debt_ave-TS7_debt_se) 0], [0.9  0.9  0.9], 'EdgeColor', 'none')
plot([0:4],[0,(SRS6_debt_ave)],'Color',[0 0.4470 0.7410])
plot([0:4],[0,(TS7_debt_ave)],'Color',[0.8500 0.3250 0.0980])


%LRC
plot([0:4],[0,(SRS6_debt_LRC_wilma_gCm2)]*-1,'o','Color',[0 0.4470 0.7410])
plot([0:4],[0,(SRS6_debt_LRC_irma_gCm2)]*-1,'o','Color',[0 0.4470 0.7410])

plot([0:4],[0,(TS7_debt_LRC_wilma_gCm2)]*-1,'o','Color',[0.8500 0.3250 0.0980])
plot([0:4],[0,(TS7_debt_LRC_irma_gCm2)]*-1,'o','Color',[0.8500 0.3250 0.0980])

%LRC_TRC
plot([0:4],[0,(SRS6_debt_LRC_TRC_wilma_gCm2)]*-1,'^','Color',[0 0.4470 0.7410])
plot([0:4],[0,(SRS6_debt_LRC_TRC_irma_gCm2)]*-1,'^','Color',[0 0.4470 0.7410])

plot([0:4],[0,(TS7_debt_LRC_TRC_wilma_gCm2)]*-1,'^','Color',[0.8500 0.3250 0.0980])
plot([0:4],[0,(TS7_debt_LRC_TRC_irma_gCm2)]*-1,'^','Color',[0.8500 0.3250 0.0980])

plot([-1,5],[0,0],':k')
legend('Tall Forest','Scrub Forest','LRC','LRC+TRC','Location','southwest')
ylabel('Recovery Debt (g C m^-^2)')
xlabel('Years Since Landfall')
xticks([0:4])
ntitle('(a) ','location','northeast');
box on
xlim([-0.3 4.3])
ylim([-600 450])


subplot(1,2,2)
hold on
patch([0:4 fliplr(0:4)], [0 cumsum(SRS6_debt_ave+SRS6_debt_se)  fliplr(cumsum(SRS6_debt_ave-SRS6_debt_se)) 0], [0.9  0.9  0.9], 'EdgeColor', 'none')
patch([0:4 fliplr(0:4)], [0 cumsum(TS7_debt_ave+TS7_debt_se)  fliplr(cumsum(TS7_debt_ave-TS7_debt_se)) 0], [0.9  0.9  0.9], 'EdgeColor', 'none')

plot([0:4],[0,cumsum(SRS6_debt_ave)],'Color',[0 0.4470 0.7410])
plot([0:4],[0,cumsum(TS7_debt_ave)],'Color',[0.8500 0.3250 0.0980])

%LRC
plot([0:4],[0,cumsum(SRS6_debt_LRC_wilma_gCm2)]*-1,'o','Color',[0 0.4470 0.7410])
plot([0:4],[0,cumsum(SRS6_debt_LRC_irma_gCm2)]*-1,'o','Color',[0 0.4470 0.7410])

plot([0:4],[0,cumsum(TS7_debt_LRC_wilma_gCm2)]*-1,'o','Color',[0.8500 0.3250 0.0980])
plot([0:4],[0,cumsum(TS7_debt_LRC_irma_gCm2)]*-1,'o','Color',[0.8500 0.3250 0.0980])

%LRC_TRC
plot([0:4],[0,cumsum(SRS6_debt_LRC_TRC_wilma_gCm2)]*-1,'^','Color',[0 0.4470 0.7410])
plot([0:4],[0,cumsum(SRS6_debt_LRC_TRC_irma_gCm2)]*-1,'^','Color',[0 0.4470 0.7410])

plot([0:4],[0,cumsum(TS7_debt_LRC_TRC_wilma_gCm2)]*-1,'^','Color',[0.8500 0.3250 0.0980])
plot([0:4],[0,cumsum(TS7_debt_LRC_TRC_irma_gCm2)]*-1,'^','Color',[0.8500 0.3250 0.0980])

plot([-1,5],[0,0],':k')
ylabel({'Cumulative';'Recovery Debt (g C m^-^2)'})
xlabel('Years Since Landfall')
xticks([0:4])
ntitle('(b) ','location','northeast');
box on
xlim([-0.3 4.3])
ylim([-1400 500])







%%%%%%%%%%%%%  Figure 5 NEE mean rates recovery


%smoothing post-distrubance data
SRS6_NEE_fouryear_smooth = smooth(mean([SRS6_24day_NEE_dailyave(wilma_fouryear_ind)',SRS6_24day_NEE_dailyave(irma_fouryear_ind)'],2,"omitnan"),0.5,'rloess');
TS7_NEE_fouryear_smooth = smooth(TS7_24day_NEE_dailyave(irma_fouryear_ind),0.5,'rloess');
SRS6_NEE_fouryear_smooth(1:8)=nan;


SRS6_LRCmodel_NEE_fouryear_smooth = smooth(mean([SRS6_24day_LRCmodel_NEE_dailyave(wilma_fouryear_ind)',SRS6_24day_LRCmodel_NEE_dailyave(irma_fouryear_ind)'],2,"omitnan"),0.5,'rloess');
TS7_LRCmodel_NEE_fouryear_smooth = smooth(TS7_24day_LRCmodel_NEE_dailyave(irma_fouryear_ind),0.5,'rloess');
%SRS6_LRCmodel_NEE_fouryear_smooth(1:6)=nan;


SRS6_LRC_TRCmodel_NEE_fouryear_smooth = smooth(mean([SRS6_24day_LRC_TRCmodel_NEE_dailyave(wilma_fouryear_ind)',SRS6_24day_LRC_TRCmodel_NEE_dailyave(irma_fouryear_ind)'],2,"omitnan"),0.5,'rloess');
TS7_LRC_TRCmodel_NEE_fouryear_smooth = smooth(TS7_24day_LRC_TRCmodel_NEE_dailyave(irma_fouryear_ind),0.5,'rloess');

%non-disturbance means
%mean(SRS6_24day_NEE_dailyave(~or(wilma_fouryear_ind,irma_fouryear_ind)),"omitnan") -2.9956
%mean(TS7_24day_NEE_dailyave(~irma_fouryear_ind),"omitnan") -1.1308

%mean(SRS6_24day_LRCmodel_NEP_dailyave(~or(wilma_fouryear_ind,irma_fouryear_ind)),"omitnan") 1.6616
%mean(TS7_24day_LRCmodel_NEP_dailyave(~irma_fouryear_ind),"omitnan") 1.6563


%nanmean(SRS6_24day_NEE_dailyave(index_24day_ds_minusyr1)) -3.4097
%nanmean(TS7_24day_NEE_dailyave(index_24day_ds_minusyr1)) -1.1780

%nanmean(SRS6_24day_LRCmodel_NEP_dailyave(index_24day_ds_minusyr1)) 2.4004
%nanmean(TS7_24day_LRCmodel_NEP_dailyave(index_24day_ds_minusyr1)) 2.5586

%nanmean(SRS6_24day_LRC_TRCmodel_NEP_dailyave(index_24day_ds_minusyr1)) 3.9557
%nanmean(TS7_24day_LRC_TRCmodel_NEP_dailyave(index_24day_ds_minusyr1)) 2.2547

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
ylabel({'LRC NEE';'(µmol m^-^2s^-^1)'})
ntitle(' (b)','location','northwest');



subplot(3,1,3)
hold on
plot(SRS6_24day_LRC_TRCmodel_NEE_dailyave(wilma_fiveyear_ind),'^','Color',[0 0.4470 0.7410],'MarkerSize',4)
plot(SRS6_24day_LRC_TRCmodel_NEE_dailyave(irma_fiveyear_ind),'^','Color',[0 0.4470 0.7410],'MarkerSize',4)

plot(TS7_24day_LRC_TRCmodel_NEE_dailyave(irma_fiveyear_ind),'^','Color',[0.8500 0.3250 0.0980],'MarkerSize',4)
%add fancy lines
plot([15,15],[-8,4],"--k","LineWidth", 2)   %15 is the number of 24-day periods in one year
plot([0,15],[-3.9557,-3.9557],":","LineWidth", 2,'Color',[0 0.4470 0.7410]) %nondisutrbance mean NEP 3.9557
plot([0,15],[-2.2547,-2.2547],":","LineWidth", 2,'Color',[0.8500 0.3250 0.0980]) %nondisutrbance mean NEP 2.2547
%add fancy smoothin
plot(16:75,SRS6_LRC_TRCmodel_NEE_fouryear_smooth,":","LineWidth", 2,'Color',[0 0.4470 0.7410],'MarkerSize',12)
plot(16:75,TS7_LRC_TRCmodel_NEE_fouryear_smooth,":","LineWidth", 2,'Color',[0.8500 0.3250 0.0980],'MarkerSize',12)

xticks([0 15 30 45 60 75])
xticklabels({'Year = -1','Hurricane','Year = 1','Year = 2','Year = 3','Year = 4'})
ylim([-6 0])
xlim([0 75])
box on
ylabel({'LRC+TRC NEE';'(µmol m^-^2s^-^1)'})
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



%LRC NEE
sum(mean(SRS6_24day_LRCmodel_NEE_dailyave(index_24day_ds_minusyr1),'omitnan')-SRS6_24day_LRCmodel_NEE_dailyave(wilma_fouryear_ind),'omitnan')*3600*48*24*(1/1000000)*12
sum(mean(SRS6_24day_LRCmodel_NEE_dailyave(index_24day_ds_minusyr1),'omitnan')-SRS6_24day_LRCmodel_NEE_dailyave(irma_fouryear_ind),'omitnan')*3600*48*24*(1/1000000)*12
sum(mean(TS7_24day_LRCmodel_NEE_dailyave(index_24day_ds_minusyr1),'omitnan')-TS7_24day_LRCmodel_NEE_dailyave(wilma_fouryear_ind),'omitnan')*3600*48*24*(1/1000000)*12
sum(mean(TS7_24day_LRCmodel_NEE_dailyave(index_24day_ds_minusyr1),'omitnan')-TS7_24day_LRCmodel_NEE_dailyave(irma_fouryear_ind),'omitnan')*3600*48*24*(1/1000000)*12











%%%% write output tables


SRS6_LRCmodel_QY_output=ones(300,1)*SRS6_LRCmodel_QY;
SRS6_TRCmodel_Eo_output=ones(300,1)*SRS6_TRCmodel_Eo;

TS7_LRCmodel_QY_output=ones(300,1)*TS7_LRCmodel_QY;
TS7_TRCmodel_Eo_output=ones(300,1)*TS7_TRCmodel_Eo;




Time2 = datetime(2004,1,1,00,00,0):duration(0,30,0):datetime(2023,12,31,23,00,0);
Time2=Time2';

Time = datetime(compose("%d",SRS6_data.Date),'InputFormat','yyyyMMddHHmm');
SRS6_datatable_flux=timetable(Time,SRS6_data.NEE,'VariableNames',{'NEE'});

SRS6_datatable_LAI=timetable(SRS6_modis_24day.Date,SRS6_modis_24day.LAIqc,'VariableNames',{'LAI'});
%SRS6_datatable_flux_parms=timetable(SRS6_modis_24day.Date,SRS6_24day_beta_MM(:,1),SRS6_24day_beta_MM(:,2),SRS6_24day_beta_MM(:,3),SRS6_24day_beta_TRC(:,1),SRS6_24day_beta_TRC(:,2),'VariableNames',{'LRC_Reco','LRC_QY','LRC_Amax','TRC_R_base','TRC_temp_sensitivity'});
SRS6_datatable_model_flux_parms=timetable(SRS6_modis_24day.Date,SRS6_LRCmodel_Reco,SRS6_LRCmodel_QY_output,SRS6_LRCmodel_Amax,SRS6_TRCmodel_rb,SRS6_TRCmodel_Eo_output,'VariableNames',{'LRC_Reco','LRC_QY','LRC_Amax','TRC_R_base','TRC_temp_sensitivity'});
SRS6_datatable_LAI_filled=retime(SRS6_datatable_LAI,Time2,"previous");
SRS6_datatable_model_flux_parms_filled=retime(SRS6_datatable_model_flux_parms,Time2,"previous");



SRS6_output = synchronize(rmmissing(SRS6_datatable_flux),ERA5_data_30min,SRS6_datatable_LAI_filled,SRS6_datatable_model_flux_parms_filled);
SRS6_output = renamevars(SRS6_output,["ERA5_2T","ERA5_SW_IN"],["TA","SW_IN"]);






Time = datetime(compose("%d",TS7_data.Date),'InputFormat','yyyyMMddHHmm');
TS7_datatable_flux=timetable(Time,TS7_data.NEE,'VariableNames',{'NEE'});

TS7_datatable_LAI=timetable(TS7_modis_24day.Date,TS7_modis_24day.LAIqc,'VariableNames',{'LAI'});
%TS7_datatable_flux_parms=timetable(TS7_modis_24day.Date,TS7_24day_beta_MM(:,1),TS7_24day_beta_MM(:,2),TS7_24day_beta_MM(:,3),TS7_24day_beta_TRC(:,1),TS7_24day_beta_TRC(:,2),'VariableNames',{'LRC_Reco','LRC_QY','LRC_Amax','TRC_R_base','TRC_temp_sensitivity'});
TS7_datatable_model_flux_parms=timetable(TS7_modis_24day.Date,TS7_LRCmodel_Reco,TS7_LRCmodel_QY_output,TS7_LRCmodel_Amax,TS7_TRCmodel_rb,TS7_TRCmodel_Eo_output,'VariableNames',{'LRC_Reco','LRC_QY','LRC_Amax','TRC_R_base','TRC_temp_sensitivity'});
TS7_datatable_LAI_filled=retime(TS7_datatable_LAI,Time2,"previous");
TS7_datatable_model_flux_parms_filled=retime(TS7_datatable_model_flux_parms,Time2,"previous");


TS7_output = synchronize(rmmissing(TS7_datatable_flux),ERA5_data_30min,TS7_datatable_LAI_filled,TS7_datatable_model_flux_parms_filled);
TS7_output = renamevars(TS7_output,["ERA5_2T","ERA5_SW_IN"],["TA","SW_IN"]);






%remove first ten lines due to time zone fix, after moving values to end of year
SRS6_output(end-9:end,2:3) = SRS6_output(1:10,2:3);
SRS6_output(1:10,:) = [];

TS7_output(end-9:end,2:3) = TS7_output(1:10,2:3);
TS7_output(1:10,:) = [];


writetimetable(SRS6_output,'SRS6_datatable.csv')
writetimetable(TS7_output,'TS7_datatable.csv')

