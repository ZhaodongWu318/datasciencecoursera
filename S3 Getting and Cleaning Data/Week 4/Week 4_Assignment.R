rm(list=ls())
dat1<-read.csv("getdata_data_ss06hid.csv",header=TRUE)

strsplit(colnames(dat1),"wgtp") # "" "15"

library(stringr)
dat2<-read.csv("getdata_data_GDP.csv",header = TRUE,skip=4,nrows = 190)
dat2$X.4<-str_trim(gsub(",","",dat2$X.4))
dat2$X.4<-as.numeric(dat2$X.4)
mean(dat2$X.4,na.rm = TRUE) # 377652.4

grep("^United",dat2$X.3) # 3 countries

dat3<-read.csv("getdata_data_GDP.csv",header = TRUE,skip=4,nrows = 190)
dat4<-read.csv("getdata_data_EDSTATS_Country.csv",header = TRUE)

dat5<-inner_join(dat3,dat4,by=c("X"="CountryCode"))
note<-dat5$Special.Notes[grep("June",dat5$Special.Notes)]
library(quantmod)
library(lubridate)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)

d1 <-sampleTimes[which(year(sampleTimes)=='2012')] 
length(d1) # 250
length(sampleTimes[which(weekdays(d1)=='Monday')]) # 47