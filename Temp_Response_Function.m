function [beta_TRC,resnorm,residual] = Temp_Response_Function(Ta,Fc_night)

%Runs Michaelis Menten
%Inputs
%Ta, timenight NEE
%(time series directly from logger, can have gaps)
%Fc_AmrFlxUnits currently has the correct units
%
%
%
%Outputs
%resnorm = squared 2-norm of the residual
%residual = residual
%beta_MM = fitted parameters (delta,ga,gs)
%
%
%
%
%
%Created May, 2012
%david reed






loc=1:length(Fc_night);


loc_nan=loc(~isnan(Fc_night));
Ta_nan=Ta(~isnan(Fc_night));
Fc_night_nan=Fc_night(~isnan(Fc_night));

loc_nan=loc_nan(~isnan(Ta_nan));
Fc_night_nan=Fc_night_nan(~isnan(Ta_nan));
Ta_nan=Ta_nan(~isnan(Ta_nan));







%rb
beta(1)=100;
%Eo
beta(2)=mean(Fc_night,"omitnan");




options = optimset('FunValCheck','on','MaxFunEvals',2000);




lb=[0,50];
ub=[1000,400];


fun = @(beta,Ta_nan)beta(1).*exp(beta(2).*((1./(15--46.02)-(1./(Ta_nan--46.02)))));


% TRC  model using Arrhenius-type model
[beta_TRC,resnorm,residual] = lsqcurvefit(fun,beta,Ta_nan,Fc_night_nan,lb,ub,options);



