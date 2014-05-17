# Getting and Cleaning Data
# Week 2 Quiz (Questions 2 & 3 using sqldf package)

# Question 2 
# The sqldf package allows for execution of SQL commands on R data
# frames. We will use the sqldf package to practice the queries we might send
# with the dbSendQuery command in RMySQL. Download the American Community Survey
# data and load it into an R object called acs
# 
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv
# 
# Which of the following commands will select only the data for the probability
# weights pwgtp1 with ages less than 50?

# create a data subdirectory if it does not exist
if (!file.exists("data")) {
        dir.create("data")
}
# download file if it isn't already there
if (!file.exists("data/rawdata.csv")) {
        fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
        download.file(fileUrl, destfile = "./data/rawdata.csv", method ="curl")
        dateDownloaded <- date()
}
# read in csv file and put into object called "acs"
acs <- read.csv("./data/rawdata.csv")

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
