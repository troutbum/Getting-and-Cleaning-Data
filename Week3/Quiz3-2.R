# Getting and Cleaning Data
# May 2014
# Quiz 3

# Question 2
# Using the jpeg package read in the following picture of your instructor into R 
# 
# https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg 
# 
# Use the parameter native=TRUE. What are the 30th and 80th quantiles of the resulting data?
# 10904118 -594524
# -15259150 -10575416
# -15259150 -594524
# -14191406 -10904118

# create a data subdirectory if it does not exist
if (!file.exists("data")) {
        dir.create("data")
}
filePath <- "./data/"

# download file
fileName <- "getdata-jeff"
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg "
xFile <- paste0(filePath, fileName)

if (!file.exists(xFile)) {
        download.file(fileUrl, destfile = xFile, method ="curl")
        dateDownloaded <- date()
}

library(jpeg)
x <- readJPEG(xFile, native = TRUE)
