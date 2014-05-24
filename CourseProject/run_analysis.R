# Getting and Cleaning Data
# Course Project

# 
# http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
#
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
# 

# download file if it isn't already there
if (!file.exists("getdata-projectfiles-UCI HAR Dataset.zip")) {
        fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        download.file(fileUrl, destfile = "./data/rawdata.csv", method ="curl")
        dateDownloaded <- date()
}

features.txt <- read.table("./UCI HAR Dataset/features.txt")            # column labels for dataset
variable.names <- as.character(features.txt[,2])                        # create char vector of column labels

names <- gsub("mean()","PICKME",variable.names,fixed=TRUE)  # finds and replaces
test <- grep("mean()",variable.names,fixed=TRUE)            # returns indices that contain pattern

test1 <- grepl("mean()",variable.names,fixed=TRUE)   # returns logical vector
test2 <- grepl("std()",variable.names,fixed=TRUE)
both <- test1 | test2


measurements <- read.table("./UCI HAR Dataset/test/X_test.txt",
                           col.names=as.character(variable.names))  # raw measurements (2947 rows)

activity.number <- read.table("./UCI HAR Dataset/test/y_test.txt")  # activity (number) corresponding to each measurements
subject.id <- read.table("./UCI HAR Dataset/test/subject_test.txt")  # subject ID (30 volunteers total)
activity.labels <- read.table("./UCI HAR Dataset/activity_labels.txt") # description labels for the 6 activities



# sub(pattern, replacement, x) gsub(pattern, replacement, x) Replace the first
# occurrence of a pattern with sub or replace all occurrences with gsub. pattern
# – A pattern to search for, which is assumed to be a regular expression. Use an
# additional argument fixed=TRUE to look for a pattern without using regular
# expressions. replacement – A character string to replace the occurrence (or
# occurrences for gsub) of pattern. x – A character vector to search for
# pattern. Each element will be searched separately.


