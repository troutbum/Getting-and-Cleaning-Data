# Getting and Cleaning Data
# May 2014
# Quiz 3

# Question 3
# Load the Gross Domestic Product data for the 190 ranked countries in this data set: 
#         
#         https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv 
# 
# Load the educational data from this data set: 
#         
#         https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv 
# 
# Match the data based on the country shortcode. How many of the IDs match? Sort
# the data frame in descending order by GDP rank. What is the 13th country in
# the resulting data frame?
# 
# Original data sources: 
#       http://data.worldbank.org/data-catalog/GDP-ranking-table 
#       http://data.worldbank.org/data-catalog/ed-stats
#
# 190, St. Kitts and Nevis
# 189, St. Kitts and Nevis
# 189, Spain
# 234, St. Kitts and Nevis
# 234, Spain
# 190, Spain


# create a data subdirectory if it does not exist
if (!file.exists("data")) {
        dir.create("data")
}
filePath <- "./data/"

# download dataset
fileName <- "getdata-data-GDP.csv"
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
xFile <- paste0(filePath, fileName)
if (!file.exists(xFile)) {
        download.file(fileUrl, destfile = xFile, method ="curl")
        dateDownloaded <- date()
}
# read in dataset
x <- read.csv(xFile)

# download dataset
fileName <- "getdata-data-EDSTATS_Country.csv"
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
xFile <- paste0(filePath, fileName)
if (!file.exists(xFile)) {
        download.file(fileUrl, destfile = xFile, method ="curl")
        dateDownloaded <- date()
}
# read in dataset
y <- read.csv(xFile)


