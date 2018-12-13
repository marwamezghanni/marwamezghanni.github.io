library(maptools)
library(sp)
library(shapefiles)
library(raster)
library(readxl)
library(readr)
library(scales)
library(ggplot2)
library(rgdal)
library(rgeos)

tn_deleg<-"/Users/Marwa/Downloads/Maps-of-Tunisia-delagations-master/Maps-of-Tunisia-delagations-master/Tunisie_snuts4.shp"
m_deleg <- readShapePoly(tn_deleg)
plot(m_deleg)

code=read_csv("delegationTotclean1.csv")
View(code)

base <- read_excel("base.xlsx")
base=base[-1,]
base=base[,-1]
i=match(base$Région,code$deg)
base$hasc=code$HASC_2a[i]
View(base)



m_deleg2<- getData(name="GADM",  country="TUN", level=2)
plot(m_deleg2)
tn_deleg_fr <- fortify(m_deleg2,region = "HASC_2")
j=match(tn_deleg_fr$id,base$hasc)
tn_deleg_fr$Valeur=base$Valeur[j]


p2<-ggplot(tn_deleg_fr, aes(x=long, y=lat, group=group))+geom_polygon(aes(fill=Valeur),color = "black")+labs(x="",y="")+ theme_bw()+coord_fixed()
p2<-p2+ theme(legend.position="right")
p2+labs(fill = "Nombre des logements distant plus de 2 Km depuisle plus proche centre sportif")
