library(dplyr)
library(tidyr)

orase <- c("Barlad","Bacau", "Botosani","Dorohoi","Falticeni","Husi","Iasi","MoinComan",
          "Onesti","Pascani","PiatraNeamt","Radauti","Roman","Suceava","Vaslui")

for(o in 1:length(orase)){
  
  tt <- list.files(path = paste0("/Users/vladalexandru/Documente/vlad_R/UCLAR/tabs/MODIS/",orase[o]), full.names = T,recursive = T, pattern = ".csv")
  
  df <- NULL
  
  for(i in 1:length(tt)){
    
    tab <- read.csv(tt[i])
    df <- rbind(df,tab)
  }
  saveRDS(df,paste0("data/tabs1/MODIS/",orase[o],"_cloud_pixels.rds"))
}

#### grids
orase <- c("Barlad","Bacau", "Botosani","Dorohoi","Falticeni","Husi","Iasi","MoinComan",
           "Onesti","Pascani","PiatraNeamt","Radauti","Roman","Suceava","Vaslui")

for(o in 1:length(orase)){
  
  rr <- list.files(path = paste0("/Users/vladalexandru/Documente/vlad_R/UCLAR/grids/MODIS/nc/filled"), full.names = T,recursive = T, pattern = ".tif")
  rr <- grep(orase[o], rr, value = T)
  rr <- grep("aux.xml",rr, value = T, invert = T)
  
  for(j in 1:length(rr)){
    
    dn <- strsplit(rr[j],"_|/")[[1]][17]
    mod <- strsplit(rr[j],"/|_")[[1]][16]
    
    g <- terra::rast(rr[j])
    
    g.df <- as.data.frame(g, xy = T)
    
    out <- paste0("data/grids1/MODIS/",orase[o],"/")
    
    if(!dir.exists(out)) dir.create(out)
    saveRDS(g.df,paste0(out,"LST_1km_",dn,"_",mod,".rds"))
    
  }
  
}


