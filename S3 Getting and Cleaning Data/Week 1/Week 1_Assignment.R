setwd("/cloud/project/S3 Getting and Cleaning Data/Week 1")
rm(list = ls())
data <- read.csv("getdata_data_ss06hid.csv",header = T)

table(data$VAL) # 53 properties are worth $1,000,000 or more

library(xlsx)
data2 <- read.xlsx("getdata_data_DATA.gov_NGAP.xlsx",
                   sheetName = "NGAP Sample Data", header = TRUE)

dat <- read.xlsx("getdata_data_DATA.gov_NGAP.xlsx",
                 sheetName = "NGAP Sample Data", header = TRUE, startRow = 18,
                 endRow = 23, colIndex = 7:15)
sum(dat$Zip*dat$Ext,na.rm=T) # 36534720

library(XML)
library(xml2)
library(data.table)

fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
# Use XML package
doc_<-xmlTreeParse(sub("s","",fileurl),useInternal = TRUE) # use http instead of https
rootnode <- xmlRoot(doc_)
zipcodes <- xpathSApply(rootnode, "//zipcode", xmlValue)
xmlzipcodeDT <- data.table(zipcode = zipcodes)
xmlzipcodeDT[zipcode == "21231", .N] # 127 restaurants have zipcode 21231

# Use xml2 package
doc <- read_xml(fileurl)
doc_xml <- xmlParse(doc)
dox_rest <- xmlToDataFrame(nodes = getNodeSet(doc_xml, "//zipcode"))
table(dox_rest) # SAME, 127 restaurants have zipcode 21231

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv", destfile = "data3.csv",
              method = "curl")
DT <- fread("data3.csv")
system.time(mean(DT$pwgtp15,by=DT$SEX))
system.time(sapply(split(DT$pwgtp15,DT$SEX),mean))
system.time(tapply(DT$pwgtp15,DT$SEX,mean))
# system.time({rowMeans(DT)[DT$SEX==1]; rowMeans(DT)[DT$SEX==2]})
system.time(DT[,mean(pwgtp15),by=SEX]) # fastest? 
system.time({mean(DT[DT$SEX==1,]$pwgtp15); mean(DT[DT$SEX==2,]$pwgtp15)})