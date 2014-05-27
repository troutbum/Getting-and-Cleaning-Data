# Getting and Cleaning Data
# May 2014
# Quiz 4
# 
# Question 4
# Load the Gross Domestic Product data for the 190 ranked countries in this data set: 
#         
#         https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv 
# 
# Load the educational data from this data set: 
#         
#         https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv 
# 
# Match the data based on the country shortcode. Of the countries for which the
# end of the fiscal year is available, how many end in June?
# 
# Original data sources: 
#         http://data.worldbank.org/data-catalog/GDP-ranking-table 
#         http://data.worldbank.org/data-catalog/ed-stats
# 15
# 8
# 7
# 13



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
# this dataset has problem values!!!
#
GDP <- read.csv(xFile, stringsAsFactors=FALSE,skip=4,nrows=190)

# fix bad values
GDP[99,4] <- "Cote d'Ivoire"
GDP[186,4] <- "Sao Tome and Principe"

# download dataset
fileName <- "getdata-data-EDSTATS_Country.csv"
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
xFile <- paste0(filePath, fileName)
if (!file.exists(xFile)) {
        download.file(fileUrl, destfile = xFile, method ="curl")
        dateDownloaded <- date()
}
# read in dataset
ED <- read.csv(xFile, stringsAsFactors=FALSE)

# fix bad values
ED[38,2] <- "Republic of Cote d'Ivoire"
ED[195,2] <- "Democratic Republic of Sao Tome and Principe"
ED[223,2] <- "Republica Bolivariana de Venezuela"

EDx <- subset(ED,, c(CountryCode, Long.Name, Special.Notes))     # remove extraneous columns

# cleanup GDP df
names(GDP)[1] <- "CountryCode"
names(GDP)[2] <- "Rank"                         
GDPx <- subset(GDP,, c(CountryCode, Rank))      # remove extraneous columns
                                       
library(plyr)
joint = join(GDPx, EDx, by="CountryCode")                                          # 190 matches, Spain is 13th
print(head(joint[,1:2], n=20))

# look for June FY
containsFY <- grep("*Fiscal|FY",joint$Special.Notes)
containsJune <- grep("*June",joint$Special.Notes)
both <- intersect(containsFY,containsJune)
both
str(both)
JuneFY <- joint[both,c(1,2,4)]
row.names(JuneFY) <- NULL                                      # remove row.names system added column
JuneFY

# look for June in Special.Notes without Fiscal
diff <- setdiff(containsJune,both)
JuneOnly <- joint[both,c(1,2,4)]
row.names(JuneOnly) <- NULL  
