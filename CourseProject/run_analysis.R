# Getting and Cleaning Data
# Course Project

# The purpose of this project is to demonstrate your ability to collect, work
# with, and clean a data set. The goal is to prepare tidy data that can be used
# for later analysis. You will be graded by your peers on a series of yes/no
# questions related to the project. You will be required to submit: 1) a tidy
# data set as described below, 2) a link to a Github repository with your script
# for performing the analysis, and 3) a code book that describes the variables,
# the data, and any transformations or work that you performed to clean up the
# data called CodeBook.md. You should also include a README.md in the repo with
# your scripts. This repo explains how all of the scripts work and how they are
# connected.
# 
# One of the most exciting areas in all of data science right now is wearable
# computing - see for example this article . Companies like Fitbit, Nike, and
# Jawbone Up are racing to develop the most advanced algorithms to attract new
# users. The data linked to from the course website represent data collected
# from the accelerometers from the Samsung Galaxy S smartphone. A full
# description is available at the site where the data was obtained:
# 
# http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
# 
# Here are the data for the project:
# 
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
# 
# You should create one R script called run_analysis.R that does the following. 
# Merges the training and the test sets to create one data set. Extracts only
# the measurements on the mean and standard deviation for each measurement. Uses
# descriptive activity names to name the activities in the data set 
# Appropriately labels the data set with descriptive activity names. Creates a
# second, independent tidy data set with the average of each variable for each
# activity and each subject.




# download file if it isn't already there
if (!file.exists("getdata-projectfiles-UCI HAR Dataset.zip")) {
        fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        fileName <- "getdata-projectfiles-UCI HAR Dataset.zip"
        download.file(fileUrl, destfile=fileName, method ="curl")
        unzip(fileName)
        dateDownloaded <- date()
}

# unzip file

# read in variable names
filePath <- "./UCI HAR Dataset/"
features.txt <- read.table(paste(filePath,"features.txt",sep=""))    # use for column names
variable.names <- as.character(features.txt[,2])                # column labels for dataset

# create logical vector to extract a subset of columns
contains.mean <- grepl("mean()",variable.names,fixed=TRUE)      # returns logical vector containing "mean()"
contains.std <- grepl("std()",variable.names,fixed=TRUE)        # and "std()"                                 
selected.cols <- contains.mean | contains.std                   

# initial clean up of variable names
names <- gsub("()","",variable.names,fixed=TRUE)                # finds and replaces bad characters
names <- gsub("-","",names,fixed=TRUE)                          # from dataset
names <- gsub("mean",".Mean",names,fixed=TRUE)
names <- gsub("std",".Std",names,fixed=TRUE)

# read in training measurements (7352 rows)
measurements.train <- read.table(paste(filePath,"train/X_train.txt",sep=""), 
                        col.names=as.character(names))  
# read in test measurements (2947 rows)
measurements.test <- read.table(paste(filePath,"test/X_test.txt",sep=""),
                         col.names=as.character(names))   

# extract columns of interest using logical vector
data.train <- measurements.train[,selected.cols == TRUE]
data.test <- measurements.test[,selected.cols == TRUE]
data = rbind(data.train, data.test)                             # combine training and test rows

# subject ID for each observation (30 possible volunteers)
subject.id.train <- read.table(paste(filePath,"train/subject_train.txt",sep=""),
                         col.names=c("subject.id"))  
subject.id.test <- read.table(paste(filePath,"test/subject_test.txt",sep=""),
                         col.names=c("subject.id"))  
subject.id = rbind(subject.id.train, subject.id.test)           


# activity ID for each observation
activity.id.train <- read.table(paste(filePath,"train/y_train.txt",sep=""),   
                              col.names=c("id"))
activity.id.test <- read.table(paste(filePath,"test/y_test.txt",sep=""),   
                          col.names=c("id"))
activity.id = rbind(activity.id.train, activity.id.test)        

# description labels for the 6 possible activities
activity.labels <- read.table(paste(filePath,"activity_labels.txt",sep=""),
                              col.names=c("id","activity")) 

# join tables to get activity description instead of activity number
library(plyr)
activity = join(activity.id, activity.labels)

# combine dataset with Subject ID and Activity columns
x <- cbind(activity$activity, data )
names(x)[1] <- "activity"                                       # rename added column
y <- cbind(subject.id, x)

# sort dataset by (subject.id, activity)
results <- y[order(y$subject.id, y$activity),]
row.names(results) <- NULL                                      # remove row.names system added column


results$subject.id <-factor(results$subject.id)                 # convert subject.id to factor



write.csv(results, "results.csv",row.names=FALSE)               # caution: row.names added by default
verify.results <- read.csv("results.csv")
identical(results,verify.results)


## Verify row binding of datasets
#
#identical(head(data.train),head(data))
#
#identical(tail(data.test,n=1, addrownums = FALSE),             # BUG? can't suppress added row.names
#          tail(data,n=1,addrownums = FALSE))
#
# t1 <- tail(data.test, n=100, addrownums = FALSE)              # FIX BUG using row.names(t1) <- NULL
# t2 <- tail(data, n=100, addrownums = FALSE)
# row.names(t1) <- NULL
# row.names(t2) <- NULL
# identical(t1,t2)

