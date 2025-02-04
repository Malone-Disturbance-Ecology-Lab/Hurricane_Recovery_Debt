library(terra)
#load list of files
list.tif <- list.files(file.path("data","data_date"), pattern = ".tif$", full.names = T)
#separate out variable files
list.tif.qc <- grep(pattern = "FparLai_QC", x = list.tif, value = T)
list.tif.std <- grep(pattern = "LaiStdDev_500m", x = list.tif, value = T)
list.tif.extra.qc <- grep(pattern = "FparExtra_QC", x = list.tif, value = T)
list.tif.lai <- grep(pattern = "Lai_500m", x = list.tif, value = T)
#stack all dates together for given variable
#QC
r.qc.all <- rast(list.tif.qc)
#StD, apply scaling factor 0.1
r.std.all <- rast(list.tif.std)*0.1
#extra QC
r.extra.qc.all <- rast(list.tif.extra.qc)
#LAI, apply scaling factor
r.lai.all <- rast(list.tif.lai)*0.1
#save stacked rasters
writeRaster(r.qc.all, filename = file.path("data", "data_date_stacked", "MCD15A3H.061_FparLAI_QC_stackedDates_aid0001.tif"))
writeRaster(r.std.all, filename = file.path("data", "data_date_stacked", "MCD15A3H.061_LaiStdDev_500m_stackedDates_aid0001.tif"))
writeRaster(r.extra.qc.all, filename = file.path("data", "data_date_stacked", "MCD15A3H.061_FparExtra_QC_stackedDates_aid0001.tif"))
writeRaster(r.lai.all, filename = file.path("data", "data_date_stacked", "MCD15A3H.061_Lai_500m_stackedDates_aid0001.tif"))