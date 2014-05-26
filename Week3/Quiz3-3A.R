# Getting and Cleaning Data
# May 2014
# Quiz 3

# REDO QUIZ - NEED TO FIGURE OUT CRAZY R BEHAVIOR WITH WONKY DATA

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
GDP <- read.csv(xFile, skip=4)       # BIG LESSON limit row reads with wonky data
#GDP <- read.csv(xFile, skip=4, nrows=190)       # weird unstable behavior downstream

# download dataset
fileName <- "getdata-data-EDSTATS_Country.csv"
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
xFile <- paste0(filePath, fileName)
if (!file.exists(xFile)) {
        download.file(fileUrl, destfile = xFile, method ="curl")
        dateDownloaded <- date()
}
# read in dataset
ED <- read.csv(xFile)

# subset DFs to just CountryCode vectors for comparison
e <-as.character(ED[,1])
g <-as.character(GDP[,1])

# how many empty elements
summary(!(e %in% c("")))
summary(!(g %in% c("")))

# strip out empty elements
g <- g[g != ""]
summary(!(g %in% c("")))

# compare intersection of these vectors
matches <- intersect(e,g)
str(matches)

# subset GDP to observations with Rank (190 observations)
gg <- GDP[1:190,]
matches2 <- intersect(e,gg[,1])
str(matches2)