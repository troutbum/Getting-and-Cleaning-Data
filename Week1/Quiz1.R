
# Question 1
# The American Community Survey distributes downloadable data about United States communities. Download the 2006 microdata survey about housing for the state of Idaho using download.file() from here: 
#         
#         https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv 
# 
# and load the data into R. The code book, describing the variable names is here: 
#         
#         https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf 
# 
# How many housing units in this survey were worth more than $1,000,000?

if (!file.exists("data")) {
        dir.create("data")
}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileUrl, destfile = "./data/housing.csv", method ="curl")
dateDownloaded <- date()

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf"
download.file(fileUrl, destfile = "./data/codebook.pdf", method ="curl")

data <- read.csv("./data/housing.csv")
bighouses <- subset(data, VAL == 24)  # House values > $1M is code 24
#
# Answer = 53

# Question 3
# Download the Excel spreadsheet on Natural Gas Aquisition Program here: 
#         
#         https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx 
# 
# Read rows 18-23 and columns 7-15 into R and assign the result to a variable called:
#         dat 
# What is the value of:
#         sum(dat$Zip*dat$Ext,na.rm=T) 
# (original data source: http://catalog.data.gov/dataset/natural-gas-acquisition-program)

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
download.file(fileUrl, destfile = "./data/NGAP.xlsx", method ="curl")

library(xlsx)
rowIndex <- 18:23
colIndex <- 7:15
dat <- read.xlsx("./data/NGAP.xlsx", 1, colIndex=colIndex, rowIndex=rowIndex)
sum(dat$Zip*dat$Ext,na.rm=T)
#
# Answer = 36534720


# Question 4
# Read the XML data on Baltimore restaurants from here: 
#         
#         https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml 
# 
# How many restaurants have zipcode 21231?

# Good resource on XML
# http://www.stat.berkeley.edu/~statcur/Workshop2/Presentations/XML.pdf

library(XML)
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
download.file(fileUrl, destfile = "./data/restaurants.xml", method ="curl")
doc <- xmlTreeParse("./data/restaurants.xml", useInternal=TRUE)
rootNode <- xmlRoot(doc)

xmlName(rootNode)
# [1] "response"

names(rootNode)
# row 
# "row" 

rootNode[[1]]         # returns all the data

rootNode[[1]][[1]]    # returns a restaurant
# <row _id="1" _uuid="93CACF6F-C8C2-4B87-95A8-8177806D5A6F" _position="1" _address="http://data.baltimorecity.gov/resource/k5ry-ef3g/1">
#         <name>410</name>
#         <zipcode>21206</zipcode>
#         <neighborhood>Frankford</neighborhood>
#         <councildistrict>2</councildistrict>
#         <policedistrict>NORTHEASTERN</policedistrict>
#         <location_1 human_address="{&quot;address&quot;:&quot;4509 BELAIR ROAD&quot;,&quot;city&quot;:&quot;Baltimore&quot;,&quot;state&quot;:&quot;MD&quot;,&quot;zip&quot;:&quot;&quot;}" needs_recoding="true"/>
#         </row> 

names(rootNode[[1]][[1]])
# name           zipcode      neighborhood   councildistrict    policedistrict        location_1 
# "name"         "zipcode"    "neighborhood" "councildistrict"  "policedistrict"      "location_1" 


rootNode[[1]][[1]][[2]]
# <zipcode>21206</zipcode> 

names(rootNode[[1]][[1]][[1]])
# text 
# "text" 

# get all the data
xmlSApply(rootNode,xmlValue)   

# get all the zip codes
zips <- xpathSApply(rootNode, "//zipcode", xmlValue)
answer <- zips == "21231"
sum(answer)
# Answer = 127

# get names of restaurants in chosen zipcode
xpathSApply(rootNode, "//row[zipcode=21231]/name", xmlValue)

# Question 5
# The American Community Survey distributes downloadable data about United States communities. Download the 2006 microdata survey about housing for the state of Idaho using download.file() from here: 
#         
#         https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv 
# 
# using the fread() command load the data into an R object
#   DT 
# Which of the following is the fastest way to calculate the average value of the variable
#   pwgtp15 
# broken down by sex using the data.table package?

# mean(DT[DT$SEX==1,]$pwgtp15); mean(DT[DT$SEX==2,]$pwgtp15)
# tapply(DT$pwgtp15,DT$SEX,mean)
# sapply(split(DT$pwgtp15,DT$SEX),mean)
# DT[,mean(pwgtp15),by=SEX]
# mean(DT$pwgtp15,by=DT$SEX)
# rowMeans(DT)[DT$SEX==1]; rowMeans(DT)[DT$SEX==2]

library(data.table)
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv "
download.file(fileUrl, destfile = "./data/ss06pid.csv", method ="curl")
DT <- fread("./data/ss06pid.csv")

system.time({mean(DT[DT$SEX==1,]$pwgtp15); mean(DT[DT$SEX==2,]$pwgtp15)})
# user  system elapsed 
# 0.047   0.001   0.048 

system.time(tapply(DT$pwgtp15,DT$SEX,mean))
# user  system elapsed 
# 0.001   0.000   0.001  

system.time(sapply(split(DT$pwgtp15,DT$SEX),mean))
# user  system elapsed 
# 0.000   0.000   0.001 

system.time(DT[,mean(pwgtp15),by=SEX])
# user  system elapsed 
# 0.002   0.000   0.002 

system.time(mean(DT$pwgtp15,by=DT$SEX))
# user  system elapsed 
# 0       0       0 

system.time({rowMeans(DT)[DT$SEX==1]; rowMeans(DT)[DT$SEX==2]})
# Error in rowMeans(DT) : 'x' must be numeric
# Timing stopped at: 0.662 0.013 0.677 
                
# Answer = sapply(split(DT$pwgtp15,DT$SEX),mean)