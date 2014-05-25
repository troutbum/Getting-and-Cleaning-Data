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


# create a data subdirectory if it does not exist
if (!file.exists("data")) {
        dir.create("data")
}
filePath <- "./data/"

# download codebook
fileName <- "getdata-data-PUMSDataDict06.pdf"
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf"
if (!file.exists(paste0(filePath, fileName))) {
        download.file(fileUrl, destfile = paste0(filePath, fileName), method ="curl")
        dateDownloaded <- date()
}

# download dataset
fileName <- "getdata-data-ss06hid.csv"
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
if (!file.exists(paste0(filePath, fileName))) {
        download.file(fileUrl, destfile = paste0(filePath, fileName), method ="curl")
        dateDownloaded <- date()
}

# read in dataset
x <- read.csv(paste0(filePath, fileName))

# create logical vectors
acres <- x$ACR == 3                     # from codebook > 10 acres
summary(acres)
sales <- x$AGS == 6                     # from codebook > $10K sales
summary(sales)
agricultureLogical = acres & sales
summary(agricultureLogical)

which(agricultureLogical)
