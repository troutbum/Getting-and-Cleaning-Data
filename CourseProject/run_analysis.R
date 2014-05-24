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

# read in column variable names
features.txt <- read.table("./UCI HAR Dataset/features.txt")            # column labels for dataset
variable.names <- as.character(features.txt[,2])                        # create char vector of column labels

# create logical vector to subset columns
contains.mean <- grepl("mean()",variable.names,fixed=TRUE)      # returns logical vector containing "mean()"
contains.std <- grepl("std()",variable.names,fixed=TRUE)        # and "std()"                                 
selected.cols <- contains.mean | contains.std                   # use this logical vector to subset columns

# initial clean up of variable names
names <- gsub("()","",variable.names,fixed=TRUE)            # finds and replaces bad chars
names <- gsub("-","",names,fixed=TRUE)
names <- gsub("mean",".Mean",names,fixed=TRUE)
names <- gsub("std",".Std",names,fixed=TRUE)

# read in measurement data and append column cleaned names
measurements <- read.table("./UCI HAR Dataset/test/X_test.txt",
                           col.names=as.character(names))  # raw measurements (2947 rows)
measurements.subset <- measurements[,selected.cols == TRUE]


# activity ID for each observation
activity.id <- read.table("./UCI HAR Dataset/test/y_test.txt",   
                              col.names=c("id"))

# description labels for the 6 possible activities
activity.labels <- read.table("./UCI HAR Dataset/activity_labels.txt",
                              col.names=c("id","activity")) 

# subject ID for each observation (30 possible volunteers)
subject.id <- read.table("./UCI HAR Dataset/test/subject_test.txt",
                         col.names=c("subject.id"))  

# join tables to get better activity descriptors
library(plyr)
activity = join(activity.id, activity.labels)

# add subject.id and activity columns to dataset
x <- cbind(activity$activity, measurements.subset )
x <- cbind(subject.id, x)





