# Getting and Cleaning Data
# Week 2 Quiz

library(httr)
library(httpuv)
library(jsonlite)


myapp <- oauth_app("github", "20e38d750fc50cb0a619", "7d69ed95da7fda0f4f8060022d67b9865b18ef32")
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

# access API example
req <- GET("https://api.github.com/rate_limit", config(token = github_token))
stop_for_status(req)
content(req)

# Question 1
req <- GET("https://api.github.com/users/jtleek/repos", config(token = github_token))
stop_for_status(req)
content(req)

req <- GET("https://api.github.com/users/jtleek/datasharing/stats", config(token = github_token))
# GET /repos/:owner/:repo/stats/contributors

req <- GET("https://api.github.com/users/jtleek/repos", config(token = github_token))
stop_for_status(req)
content(req)


#url <- "https://api.github.com/search/repositories?q=tetris+language:assembly&sort=stars&order=desc"
url <- "https://api.github.com/search/repositories?q=datasharing+jtleek"


url <- "http://biostat.jhsph.edu/~jleek/contact.html" 

url <- "https://api.github.com/users/jtleek/repos"

req <-GET(url, config(token = github_token))
stop_for_status(req)
content(req)
foo <- content(req, as= "parsed")



