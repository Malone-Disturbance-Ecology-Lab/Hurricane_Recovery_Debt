# Hurricane_Recovery_Debt

** Hurricane_Debt_Site.m **
MATLAB code that reads in AmeriFlux, MODIS, and ERA5 data from mangrove sites, works through data aggregation analysis, estimates light response curve and temperature response curve parameters, models site level carbon exchange based on LAI, radiation and temperature, and then makes figures.
This code calls Light_Reponse_Function.m and Temp_Response_Funtion.m.

** Light_Reponse_Function.m **
Estimates light response curve paraments when given radiation and NEE data. This function calls NEP_1PredVar_Model.m.

** Temp_Reponse_Function.m **
Estimates light response curve paraments when given temperature and NEE data.

** NEP_1PredVar_Model.m **
Defines nonrectangular light response function used in Light_Reponse_Function.m.
