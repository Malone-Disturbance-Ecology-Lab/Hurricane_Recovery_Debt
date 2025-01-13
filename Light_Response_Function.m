function [beta_MM,resnorm,residual] = Light_Response_Function(NetRad,Fc)

%Runs Michaelis Menten
%Inputs
%NetRad, measured Fc_AmrFlxUnits
%(time series directly from logger, can have gaps)
%Fc_AmrFlxUnits currently has the correct units
%
%
%
%Outputs
%NEP_output = PM modeled ET flux
%resnorm = squared 2-norm of the residual
%residual = residual
%beta_MM = fitted parameters (delta,ga,gs)
%
%
%
%
%Calls NEP_MM_1PredVar_Model.m
%
%
%Created May, 2012
%david reed


%switching signs on Fc
Fc=-Fc;




loc=1:length(Fc);


loc_nan=loc(~isnan(Fc));
NetRad_nan=NetRad(~isnan(Fc));
Fc_nan=Fc(~isnan(Fc));

loc_nan=loc_nan(~isnan(NetRad_nan));
Fc_nan=Fc_nan(~isnan(NetRad_nan));
NetRad_nan=NetRad_nan(~isnan(NetRad_nan));







%Rd
beta(1)=1;
%QuantumYield_gl
beta(2)=0.01;
%Amax
beta(3)=10;

%curvature parameter
%beta(4)=0.01;
%lb=[0,0,0,0.01];
%ub=[100,0.4,60,1];



options = optimset('FunValCheck','on','MaxFunEvals',2000);




lb=[0,0,0];
ub=[100,0.4,60];



% MM rectangualr model, three parameters
[beta_MM,resnorm,residual] = lsqcurvefit(@NEP_1PredVar_Model,beta,NetRad_nan,Fc_nan,lb,ub,options);



% MM nonrectangualr model, four parameters
%[beta_MM,resnorm,residual] = lsqcurvefit(@NEP_1PredVar_Nonrectangular_Model,beta,NetRad_nan,Fc_nan,lb,ub,options);




%if beta_MM(3)<min(Fc)
%    beta_MM(3)=beta_MM(3)*beta_MM(2)*max(NetRad)./(beta_MM(3) + beta_MM(2)*max(NetRad)) - beta_MM(1)
%end


