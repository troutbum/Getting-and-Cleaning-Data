# Getting and Cleaning Data
# May 2014
# Quiz 3




# download file if it isn't already there
if (!file.exists("getdata-projectfiles-UCI HAR Dataset.zip")) {
        fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        fileName <- "getdata-projectfiles-UCI HAR Dataset.zip"
        download.file(fileUrl, destfile=fileName, method ="curl")
        unzip(fileName)
        dateDownloaded <- date()
}