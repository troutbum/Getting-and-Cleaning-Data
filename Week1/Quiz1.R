


# if (!file.exists("data")) {
#         dir.create("data")
# }
# fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
# download.file(fileUrl, destfile = "./data/housing.csv", method ="curl")
# dateDownloaded <- date()
# fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf"
# download.file(fileUrl, destfile = "./data/codebook.pdf", method ="curl")

data <- read.csv("./data/housing.csv")

bighouses <- subset(data, VAL == 24)  # House values > $1M is code 24


# Question 3
#
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
download.file(fileUrl, destfile = "./data/NGAP.xlsx", method ="curl")

library(xlsx)
rowIndex <- 18:23
colIndex <- 7:15
dat <- read.xlsx("./data/NGAP.xlsx,sheetIndex=1,colIndex=colIndex,rowIndex=rowIndex")
