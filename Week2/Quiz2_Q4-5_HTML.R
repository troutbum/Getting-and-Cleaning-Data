# Getting and Cleaning Data
# Week 2 Quiz

# Question 4
# How many characters are in the 10th, 20th, 30th and 100th lines of HTML from this page: 
#         
#         http://biostat.jhsph.edu/~jleek/contact.html 
# 
# (Hint: the nchar() function in R may be helpful)

con = url("http://biostat.jhsph.edu/~jleek/contact.html")
htmlCode = readLines(con)
close(con)
htmlCode


answer <- c(nchar(htmlCode[10]),
            nchar(htmlCode[20]),
            nchar(htmlCode[30]),
            nchar(htmlCode[100]))
answer
# [1] 45 31  7 25


# Question 5
# Read this data set into R and report the sum of the numbers in the fourth column. 
# 
# https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for 
# 
# Original source of the data: http://www.cpc.ncep.noaa.gov/data/indices/wksst8110.for 
# 
# (Hint this is a fixed width file format)


# create a data subdirectory if it does not exist
if (!file.exists("data")) {
        dir.create("data")
}
# download file if it isn't already there
if (!file.exists("data/fixedwidth.for")) {
        fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"
        download.file(fileUrl, destfile = "./data/fixedwidth.for", method ="curl")
        dateDownloaded <- date()
}

data <- read.fwf("./data/fixedwidth.for", 
                 widths=c(10,-5,4,4,-5,4,4,-5,4,4,-5,4,4),
                 skip=4,
                 col.names=c("Date","N1sst","N1ssta","N2sst","N2ssta","N3sst","N3ssta","N4sst","N4ssta"))

View(data)
sum(data[,4])
# [1] 32426.7 <<-- ANSWER

sum(data[,4])/1254  #reasonability check
#[1] 25.85861