getwd()
setwd("C:/Users/USER/Desktop")

loadedNamespaces()
update.packages()

Fish_survey<- read.csv ("Fish_survey.csv", header = TRUE)
str(Fish_survey)
head(Fish_survey)

install.packages("tibble")
library(tibble)

install.packages("tidyr")
library(tidyr)

install.packages("Rcpp")
library(Rcpp)

installed.packages("dplyr")
library(dplyr)

install.packages("reshape2")
library(reshape2)


#1.	Use gather and spread, reshape package, melt and dcast
Fish_survey<-	read.csv("Fish_survey.csv",	header	=	TRUE)	
Fish_survey_long	<-	gather(Fish_survey,	Species,	Abundance,	4:6)		
str(Fish_survey_long)
Fish_survey_long
Fish_survey_wide	<-	spread(Fish_survey_long,	Species,	Abundance)	
head(Fish_survey_wide)


Fish_survey_long	<-	melt(Fish_survey,	
                      id.vars	=	c("Site","Month","Transect"),		
                      measure.vars	=	c("Trout","Perch","S+ckleback"),		
                      variable.name	=	"Species",	value.name	=	"Abundance")
str(Fish_survey_long)
head(Fish_survey_long)



#2.	Use inner join
Water_data<-	read.csv("Water_data.csv",	header	=	TRUE,	
                      stringsAsFactors=FALSE)	
GPS_locatioon<-	read.csv("GPS_data.csv",	header	=	TRUE,	
                       stringsAsFactors=FALSE)	
Fish_survey_long<-	read.csv("Fish_survey_long.csv",	header	=	TRUE,	
                            stringsAsFactors=FALSE)	
Fish_and_Water<-inner_join(Fish_survey_long, Water_data, by= c("Site", "Month"))
Fish_and_Water
str(Fish_and_Water)
head(Fish_and_Water)
Fish_survey_combined<- inner_join(Fish_and_Water, GPS_locatioon, by = c("Site", "Transect"))



#3.	Subset
Bird_Behaviour<- read.csv("Bird_Behaviour.csv", header = TRUE, stringsAsFactors=FALSE)
str(Bird_Behaviour)
Bird_Behaviour$log_FID<- log(Bird_Behaviour$FID)

Bird_Behaviour<- separate(Bird_Behaviour, Species, c("Genus", "Species"), sep="_", remove= TRUE)
str(Bird_Behaviour)

Bird_Behaviour[ ,1:4]
Bird_Behaviour[Bird_Behaviour$Sex == "male", ]
subset(Bird_Behaviour, FID < 10)
subset(Bird_Behaviour, FID < 10 & Sex == "male")
subset(Bird_Behaviour, FID > 10 | FID < 15, select = c(Ind, Sex, Year))
