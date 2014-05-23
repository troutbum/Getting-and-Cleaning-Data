# Getting and Cleaning Data
# Course Project

# 
# http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
#
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
# 
# create a data subdirectory if it does not exist
if (!file.exists("data")) {
        dir.create("data")
}
# download file if it isn't already there
if (!file.exists("data/rawdata.csv")) {
        fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        download.file(fileUrl, destfile = "./data/rawdata.csv", method ="curl")
        dateDownloaded <- date()
}
# read in csv file and put into object called "acs"
y_test <- read.csv("./UCI HAR Dataset/test/y_test.txt")
X_test <- read.csv("./UCI HAR Dataset/test/X_test.txt")

# sub(pattern, replacement, x) gsub(pattern, replacement, x) Replace the first
# occurrence of a pattern with sub or replace all occurrences with gsub. pattern
# – A pattern to search for, which is assumed to be a regular expression. Use an
# additional argument fixed=TRUE to look for a pattern without using regular
# expressions. replacement – A character string to replace the occurrence (or
# occurrences for gsub) of pattern. x – A character vector to search for
# pattern. Each element will be searched separately.



library(sqldf)
answer1 <- sqldf("select pwgtp1 from acs where AGEP < 50")
answer2 <- sqldf("select * from acs")
answer3 <- sqldf("select * from acs where AGEP < 50 and pwgtp1")
answer4 <- sqldf("select pwgtp1 from acs")
str(answer1)  # answer1

# Question 3 
# Using the same data frame you created in the previous problem, what
# is the equivalent function to unique(acs$AGEP)

control <- unique(acs$AGEP)
answerA <- sqldf("select distinct pwgtp1 from acs")
answerB <- sqldf("select unique * from acs")
answerC <- sqldf("select distinct AGEP from acs")
answerD <- sqldf("select AGEP where unique from acs")
# answerC (91 observations of 1 variable)
