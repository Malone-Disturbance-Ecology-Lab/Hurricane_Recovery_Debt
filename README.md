# Hurricane_Recovery_Debt

### 00_Hurricane_Debt_Site_Data.m
Reads in and processes AmeriFlux, MODIS, and ERA5 data from mangrove sites

### 01_Hurricane_Debt_Site_Aggregation.m
Aggregates data on 8-day, 24-day, and 40-day timescales.

### 02_Hurricane_Debt_Site_ResponseCurves.m
Estimates light response curve and temperature response curve parameters, using radiation and temperature data. This code calls Light_Reponse_Function.m and Temp_Response_Funtion.m.

### 03_Hurricane_Debt_Site_LAIModelNEE.m
Models site level carbon exchange based on LAI and reponse curve parameters. 
 
### 04_Hurricane_Debt_Site_NonStationarity.m
Calculates Relative NonStationarity value for variables, creates SI NonStationarity figures, and outputs.

### 04_Hurricane_Debt_Site_FiguresTablesOuputs.m
Creats figures, summerizes data for tables, and writes output data files.

### Light_Reponse_Function.m
Estimates light response curve paraments when given radiation and NEE data. This function calls NEP_1PredVar_Model.m.

### Temp_Reponse_Function.m
Estimates light response curve paraments when given temperature and NEE data.

### NEP_1PredVar_Model.m
Defines nonrectangular light response function used in Light_Reponse_Function.m.
