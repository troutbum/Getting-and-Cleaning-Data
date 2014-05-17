# Getting and Cleaning Data
# Week 2 Quiz

library(httr)
library(httpuv)
library(jsonlite)

# authentication step for GitHub
# creates and stores a token on disk
myapp <- oauth_app("github", "20e38d750fc50cb0a619", "7d69ed95da7fda0f4f8060022d67b9865b18ef32")
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

# access API example
req <- GET("https://api.github.com/rate_limit", config(token = github_token))
stop_for_status(req)
content(req)

# Question 1 
#
# Register an application with the Github API here 
# https://github.com/settings/applications. Access the API to get information on
# your instructors repositories (hint: this is the url you want 
# "https://api.github.com/users/jtleek/repos"). Use this data to find the time 
# that the datasharing repo was created. What time was it created? 
#This tutorial may be useful (https://github.com/hadley/httr/blob/master/demo/oauth2-github.r). 

# First attempt at getting answer
# Get JSON object of prof's repos
url <- "https://api.github.com/users/jtleek/repos"
req <-GET(url, config(token = github_token))
stop_for_status(req)
content(req)
#foo <- content(req, as= "parsed")
# this method not easy to read or parse without further
# understanding of API

# Easy method to get dataframe of prof's GitHub repos
data <- fromJSON(url)
dfNames <- names(data)
dfNames
subdata <- subset(data, name == "datasharing")  # just get repo in question

# Answer
subdata$created_at  # "2013-11-07T13:25:07Z"

