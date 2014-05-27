# Getting and Cleaning Data
# May 2014
# Quiz 4

# Question 3
# In the data set from Question 2 what is a regular expression that would allow
# you to count the number of countries whose name begins with "United"? Assume
# that the variable with the country names in it is named countryNames. How many
# countries begin with United?
#
# grep("United$",countryNames), 3
# grep("*United",countryNames), 5
# grep("^United",countryNames), 3
# grep("*United",countryNames), 2

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

#
# Big problems in Quiz 3 with mixed datatypes in columns
# (Need to prevent creation of factor levels)

# read in data
data <- read.csv(xFile, stringsAsFactors=FALSE,skip=4,nrows=190)

# fix bad values
data[99,4] <- "Cote d'Ivoire"
data[99,4]
data[186,4] <- "Sao Tome and Principe"
data[186,4]

countryNames <- data[,4]


grep("United$",countryNames) #, 3
grep("*United",countryNames) #, 5
grep("^United",countryNames) #, 3
grep("*United",countryNames) #, 2


