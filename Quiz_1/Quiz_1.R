setwd("C:/Users/Riccardo/Rworkspace/coursera/Downloading_datasets_course/Quiz_1")

## QUESTION 1
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileUrl, destfile="Idaho_housing_2006.csv")
data <- read.table("Idaho_housing_2006.csv", sep=",", header=TRUE)
values <- data$VAL
clean_values <- values[!is.na(values)]
expensive <- clean_values[clean_values==24] ## 53

## QUESTION 2
fes <- data$FES
head(fes)
class(fes)

## QUESTION 3
library(xlsx)
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
download.file(fileUrl, destfile="naturalgas_2.xlsx", mode="wb") ## downloaded in binary!!
data_2 <- read.xlsx("naturalgas_2.xlsx", sheetIndex=1, header=TRUE)
partialdata <- read.xlsx("naturalgas_2.xlsx", sheetIndex=1, header=TRUE, colIndex=7:15, rowIndex=18:23)
dat <- partialdata
sum(dat$Zip*dat$Ext,na.rm=T)  ## 36534720

## QUESTION 4
library(XML)
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
download.file(fileUrl, destfile="restaurants.xml") 
doc <- xmlTreeParse("restaurants.xml", useInternal = TRUE)
zip <- xpathSApply(rootNode, "//zipcode", xmlValue)
myzip <- zip[zip==21231] ## 127 elements as requested

## QUESTION 5
library(data.table)
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(fileUrl, destfile="Idaho_state.csv") 

DT <- fread("Idaho_state.csv")

time_elapsed <- data.frame()
## 1
fun1 <- function(X){tapply(X$pwgtp15,X$SEX,mean)}
time1 <- system.time( replicate(100, fun1(DT) ) )
time_elapsed[1,] <- time1

## 2
fun2 <- function(X){mean(X[X$SEX==1,]$pwgtp15); mean(X[X$SEX==2,]$pwgtp15)}
time2 <- system.time( replicate(100, fun2(DT) ) )

## 3
fun3 <- function(X){rowMeans(X[X$SEX==1],na.rm = TRUE); rowMeans(X[X$SEX==2], na.rm = TRUE)}
time3 <- system.time( replicate(100, fun3(DT) ) )

## 4
fun4 <- function(X){sapply(split(X$pwgtp15,X$SEX),mean)}
time4 <- system.time( replicate(100, fun4(DT) ) )

## 5
fun5 <- function(X){X[,mean(pwgtp15),by=SEX]}
time5 <- system.time( replicate(100, fun5(DT) ) )

## 6
fun6 <- function(X){mean(X$pwgtp15,by=X$SEX)}
time6 <- system.time( replicate(100, fun6(DT) ) )
tmp <- proc.time()
fun5(DT) 
proc.time() - tmp

