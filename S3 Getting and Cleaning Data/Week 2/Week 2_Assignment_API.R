# Load Packages
library(jsonlite)
library(httpuv)
library(httr)

# Find OAuth settings for github:
oauth_endpoints("github")

# register at
# https://github.com/settings/developers. Use any URL for the homepage URL
# (http://github.com is fine) and  http://localhost:1410 as the callback url

# Replace your key and secret below.
myapp <- oauth_app(appname = "Coursera_JHU",
                   key = "1ce20c728156cdc93e6b",
                   secret = "584367a4d733e790c6008ec7fa58040a7fd2ad55")

# Get OAuth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

# Use API
gtoken <- config(token = github_token)
req <- GET("https://api.github.com/users/jtleek/repos", gtoken)

# Take action on http error
stop_for_status(req)

# Extract content from a request
json1 = content(req)

# Convert to a data.frame
gitDF = jsonlite::fromJSON(jsonlite::toJSON(json1))

# Subset data.frame
gitDF[gitDF$full_name == "jtleek/datasharing", "created_at"] 

# Answer: 
# 2013-11-07T13:25:07Z