# Medal count end of today
library(tm)
library(twitteR)
library(RCurl)
library(XML)
library(rvest)
library(RSelenium)
library(stringr)
library(stringi)
library(SnowballC)
library(devtools)
library(lubridate)
library(reshape2)
library(tidyr)
library(dplyr)

#read the url
url = "http://www.espn.com/olympics/summer/2016/medals"

#read in url and create the dataframe
table <- read_html(url)
table_df <- table %>% html_nodes("table") %>% .[[8]] %>% html_table(trim = FALSE)

#only take the top 3 teams. 
top_teams <- table_df[1:3,]

# Set-up tweet

## random greetings generator
greetings<-c("Here's the medal count so far:","What a tournament! medal count:","This is a close one!","w","Watch these Games", "You don't wanna miss these amazing events!", "grab few beers and get ready")
Opening <-sample(greetings, 1)
Str <- sapply(1:3, function(x) {
  top <- str_c(top_teams[x,1], " = ", top_teams[x,5], " total medals")
})


# set up the correct twitter account
api_key <- "1Uj0WI9I5En6sfdDKIQf4s1NF"
api_secret <- "wiLlk5sPulNlym83wF2u9YHfSAEwbk9sWVdJaERQPcDwLR9Zx1"
access_token <- "761956823482114048-k20LounPHDjSADagfJ77OdZtUUQe3RU"
access_token_secret <- "V24K29PRSrfqdcUC4DD6OJ4tbTsym2T3PJdo9BFoHQjGT"
setup_twitter_oauth(api_key,api_secret,access_token,access_token_secret)

# generate the tweet
Tweet_mes_med <- str_c(Openining, "\n", Str[1], "\n", Str[2], "\n", Str[3])
tweet(Tweet_mes_med)

