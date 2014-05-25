# Getting and Cleaning Data
# May 2014
# Quiz 3

# Question 1
# The American Community Survey distributes downloadable data about United
# States communities. Download the 2006 microdata survey about housing for the
# state of Idaho using download.file() from here:
#         
#         https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv 
# 
# and load the data into R. The code book, describing the variable names is
# here:
# 
#         https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf 
# 
# Create a logical vector that identifies the households on greater than 10
# acres who sold more than $10,000 worth of agriculture products. Assign that
# logical vector to the variable agricultureLogical. Apply the which() function
# like this to identify the rows of the data frame where the logical vector is
# TRUE. which(agricultureLogical)
# 
# What are the first 3 values that result?
# 59, 460, 474
# 153 ,236, 388
# 125, 238,262
# 25, 36, 45


fileName <- "getdata-data-ss06hid.csv"
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"

fileName <- "getdata-data-PUMSDataDict06.pdf"
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf"

# download file if it isn't already there
if (!file.exists("getdata-projectfiles-UCI HAR Dataset.zip")) {
        download.file(fileUrl, destfile=fileName, method ="curl")
        unzip(fileName)
        dateDownloaded <- date()
}

x <- read.csv("~/CourseraHW/Getting-and-Cleaning-Data/Week3/data/getdata-data-ss06hid.csv")


acres <- x$ACR == 3
summary(acres)

sales <- x$AGS == 6
summary(sales)

agricultureLogical = acres & sales
summary(agricultureLogical)

which(agricultureLogical)
