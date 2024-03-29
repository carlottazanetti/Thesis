##PACCHETTI DEL CODICE DI RANDOM FOREST
# Packages for spatial data processing & visualization
library(rgdal)
library(gdalUtils)
library(raster)
library(sf)
library(sp)
library(RStoolbox)
library(getSpatialData)
library(rasterVis)
library(mapview)

library(RColorBrewer)
library(plotly)
library(grDevices)

# Machine learning packages
library(caret)
library(randomForest)
library(ranger)
library(MLmetrics)
library(nnet)
library(NeuralNetTools)
library(LiblineaR)

# Packages for general data processing and parallel computation
library(data.table)
library(dplyr)
library(stringr)
library(doParallel)
library(snow)
library(parallel)
library(tidyr)


###IF THE PACKAGES ARE NOT INSTALLED YET, PLEASE INSTALL THEM USING THE FOLLOWING CODE
# Packages for spatial data processing & visualization
install.packages('rgdal')
devtools::install_github("gearslaboratory/gdalUtils")
install.packages('raster')
install.packages('sf')
install.packages('sp')
install.packages('RStoolbox')
devtools::install_github("16EAGLE/getSpatialData")
install.packages('rasterVis')
install.packages('mapview')

install.packages('RColorBrewer')
install.packages('plotly')
install.packages('grDevices')

# Machine learning packages
install.packages('caret')
install.packages('randomForest')
install.packages('ranger')
install.packages('MLmetrics')
install.packages('nnet')
install.packages('NeuralNetTools')
install.packages('LiblineaR')

# Packages for general data processing and parallel computation
install.packages('data.table')
install.packages('dplyr')
install.packages('stringr')
install.packages('doParallel')
install.packages('snow')
install.packages('parallel')
####

#PACCHETTI DEL CODICE CLASSIFICATORE
library(raster)
library(rgdal)
library(sf)
library(sp)
library(RStoolbox)
library(rasterVis)
library(mapview)
library(data.table)
library(RColorBrewer)
library(plotly)
library(grDevices)
library(caret)
library(randomForest)#mis
library(ranger)
library(MLmetrics)
library(nnet)
library(NeuralNetTools)
library(LiblineaR)
library(data.table)
library(dplyr)
library(stringr)
library(doParallel)
library(snow)
library(parallel)
library(tidyr)
library(maptools)



b2<-raster("C:/Users/MicTorresani/Desktop/R10m/T31UFS_20210530T104619_B02_10m.jp2")
b3<-raster("C:/Users/MicTorresani/Desktop/R10m/T31UFS_20210530T104619_B03_10m.jp2")
b4<-raster("C:/Users/MicTorresani/Desktop/R10m/T31UFS_20210530T104619_B04_10m.jp2")
#b5<-raster("C:/Users/MicTorresani/Desktop/R20m/T31UFS_20210614T105031_B05_20m.jp2")
#b6<-raster("C:/Users/MicTorresani/Desktop/R20m/T31UFS_20210614T105031_B06_20m.jp2")
#b7<-raster("C:/Users/MicTorresani/Desktop/R20m/T31UFS_20210614T105031_B07_20m.jp2")
b8<-raster("C:/Users/MicTorresani/Desktop/R10m/T31UFS_20210530T104619_B08_10m.jp2")
#b11<-raster("C:/Users/MicTorresani/Desktop/R20m/T31UFS_20210614T105031_B11_20m.jp2")
#b12<-raster("C:/Users/MicTorresani/Desktop/R20m/T31UFS_20210614T105031_B12_20m.jp2")

brick_for_prediction_norm<-stack(b2,b3,b4,b8)

aoi_circolare<-shapefile("C:/Users/MicTorresani/OneDrive - Scientific Network South Tyrol/unibo/master students/roberta diesi/dati/a_nuovo_test_felix/risultati/provvisori/cambiati/shp/aoi_circolari/buffer_wy2.shp")
brick_for_prediction_norm<-crop(brick_for_prediction_norm,extent(aoi_circolare))
brick_for_prediction_norm<-mask(brick_for_prediction_norm, aoi_circolare)

poly<-shapefile("C:/Users/MicTorresani/OneDrive - Scientific Network South Tyrol/unibo/master students/roberta diesi/dati/a_nuovo_test_felix/risultati/provvisori/cambiati/shp/habitat/wy2.shp")
poly@data$id <- as.integer(factor(poly@data$id))
setDT(poly@data)

brick_for_prediction_norm<-crop(brick_for_prediction_norm, poly)

ptsamp1<-subset(poly, id == "1") #seleziono solo i poigoni con id=1
ptsamp1_1 <- spsample(ptsamp1, 750, type='regular') # lancio 750 punti a caso nei poligoni con id=1 
ptsamp1_1$class <- over(ptsamp1_1, ptsamp1)$id #do il valore di id=1 ai punti random
#saveRDS(ptsamp1_1, file=paste0 ("C:/Users/MicTorresani/OneDrive - Scientific Network South Tyrol/unibo/master students/roberta/dati/punti_random", nome, "_ptsamp1_1.rds"))

ptsamp2<-subset(poly, id == "2") #seleziono solo i poigoni con id=2
ptsamp2_2 <- spsample(ptsamp2, 750, type='regular') # lancio 750 punti a caso nei poligoni con id=2 
ptsamp2_2$class <- over(ptsamp2_2, ptsamp2)$id #do il valore di id=2 ai punti random
#saveRDS(ptsamp1_1, file=paste0 ("C:/Users/MicTorresani/OneDrive - Scientific Network South Tyrol/unibo/master students/roberta/dati/punti_random", nome, "_ptsamp1_1.rds"))

ptsamp3<-subset(poly, id == "3") #seleziono solo i poigoni con id=3
ptsamp3_3 <- spsample(ptsamp3, 750, type='regular') # lancio 750 punti a caso nei poligoni con id=3 
ptsamp3_3$class <- over(ptsamp3_3, ptsamp3)$id #do il valore di id=3 ai punti random
#saveRDS(ptsamp3_3, file=paste0 ("C:/Users/MicTorresani/OneDrive - Scientific Network South Tyrol/unibo/master students/roberta/dati/punti_random", nome, "_ptsamp3_3.rds"))

ptsamp4<-subset(poly, id == "4") #seleziono solo i poigoni con id=4
ptsamp4_4 <- spsample(ptsamp4, 750, type='regular') # lancio 750 punti a caso nei poligoni con id=4 
ptsamp4_4$class <- over(ptsamp4_4, ptsamp4)$id #do il valore di id=4 ai punti random
#saveRDS(ptsamp4_4, file=paste0 ("C:/Users/MicTorresani/OneDrive - Scientific Network South Tyrol/unibo/master students/roberta/dati/punti_random", nome, "_ptsamp4_4.rds"))




#in quest parte prendo le informazioni dei pixel dove il punto random è caduto e lo salvo in un dataframe. 
dt1 <- brick_for_prediction_norm %>% 
  raster::extract(y = ptsamp1_1) %>% 
  as.data.table %>% 
  .[, id_cls := ptsamp1_1@data] # add the class names to each row

dt2 <- brick_for_prediction_norm %>% 
  raster::extract(y = ptsamp2_2) %>% 
  as.data.table %>% 
  .[, id_cls := ptsamp2_2@data]

dt3 <- brick_for_prediction_norm %>% 
  raster::extract(y = ptsamp3_3) %>% 
  as.data.table %>% 
  .[, id_cls := ptsamp3_3@data] # add the class names to each row

dt4 <- brick_for_prediction_norm %>% 
  raster::extract(y = ptsamp4_4) %>% 
  as.data.table %>% 
  .[, id_cls := ptsamp4_4@data] # add the class names to each row


#merge i due dataframe in un unio dataframe. Do il nome fiori e grass all'id 1 e 2
dt<-rbind(dt1, dt2)
names(dt)[names(dt) == 'id_cls'] <- 'class'
dt<-dt %>% drop_na()
dt$class <- factor(dt$class, labels=c('a','b'))


#inizio random forest
set.seed(321)
# A stratified random split of the data
idx_train <- createDataPartition(dt$class,
                                 p = 0.7, # percentage of data as training
                                 list = FALSE)


dt_train <- dt[idx_train]
dt_test <- dt[-idx_train]


# create cross-validation folds (splits the data into n random groups)
n_folds <- 10
set.seed(321)
folds <- createFolds(1:nrow(dt_train), k = n_folds)
# Set the seed at each resampling iteration. Useful when running CV in parallel.
seeds <- vector(mode = "list", length = n_folds + 1) # +1 for the final model
for(i in 1:n_folds) seeds[[i]] <- sample.int(1000, n_folds)
seeds[n_folds + 1] <- sample.int(1000, 1) # seed for the final model


ctrl <- trainControl(summaryFunction = multiClassSummary,
                     method = "cv",
                     number = n_folds,
                     search = "grid",
                     classProbs = TRUE, # not implemented for SVM; will just get a warning
                     savePredictions = TRUE,
                     index = folds,
                     seeds = seeds)

model_rf <- caret::train(class ~ . , method = "rf", data = dt_train, #neural network o vector machine
                                                  importance = TRUE,
                                                  tuneGrid = data.frame(mtry = c(2, 3, 4, 5, 8)),
                                                  trControl = ctrl)


#saveRDS(model_rf, file = paste0("C:/Users/MicTorresani/OneDrive - Scientific Network South Tyrol/unibo/master students/roberta/dati/modello/","model_rf_","si1",".rds")) 


predict_rf <- raster::predict(object = brick_for_prediction_norm,
                              model = model_rf, type = 'raw')
writeRaster(predict_rf, paste0("C:/Users/MicTorresani/OneDrive - Scientific Network South Tyrol/unibo/master students/roberta diesi/dati/a_nuovo_test_felix/risultati/provvisori/cambiati/raster","_wy2_classification",".tiff"),overwrite=T )
