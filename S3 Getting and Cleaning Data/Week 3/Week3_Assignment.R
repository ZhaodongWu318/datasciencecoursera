rm(list=ls())
library(dplyr)
dat<-read.csv("getdata_data_ss06hid (1).csv",header = TRUE)
dat <-dat %>%
  mutate(agricultureLogical= (ACR==3 & AGS==6)) %>%

which(dat$agricultureLogical) #125  238  262

library(jpeg)
url<-"getdata_jeff.jpg"
res<-readJPEG(url,native=TRUE)
res<-quantile(res,probs = c(0.3,0.8))

dat1<-read.csv("getdata_data_GDP.csv",header = TRUE,skip = 4,nrows = 190)
dat2<-read.csv("getdata_data_EDSTATS_Country.csv",header = TRUE)

dat3<-dat1 %>%
  inner_join(dat2,by=c("X"="CountryCode")) %>%
  arrange(desc(X.1))

dat3$X.3[13] # St. Kitts and Nevis

dat3 %>%
  filter(Income.Group %in% c("High income: OECD","High income: nonOECD")) %>%
  group_by(Income.Group) %>%
  summarize(m=mean(X.1))

#1 High income: OECD      33.0
#2 High income: non-OECD  91.9

breaks <- quantile(dat3$X.1, probs = seq(0, 1, 1/5),na.rm = TRUE)
dat3$rank_split<-cut(dat3$X.1,breaks)
table(dat3$rank_split,dat3$Income.Group) # 5

