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
#Store current date
date <- format(Sys.Date(),"%Y%m%d")

#set url for day
url = str_c("http://www.espn.com/olympics/summer/2016/schedule/_/date/", date, sep = "")

#read in url and create the dataframe
schedule <- read_html(url)
schedule_df <- schedule %>% html_nodes("table") %>% .[[1]] %>% html_table(trim = FALSE)
schedule_df[,c(1,5)] <- NULL

#Set search critera for best games: first medal games then our rankings
schedule %>% html_nodes("table") %>% .[[1]]  %>% html_nodes("tr") -> medal_games
indices <- grep('class=\"olympics-medal gold\"', medal_games)
indices - 1 -> indices
ranking <- data.frame("Sport" = c("Swimming", "Athletics", "Gymnastics", "Basketball", "Soccer", "Volleyball", "Rowing", "Tennis", "Table Tennis", "Weightlifting", "Shooting", "Cycling - Road","Shooting", "Diving", "Judo", "Archery", "Fencing"), "ranking" = 1:17)

(schedule_df[indices,] -> relevant_games)

(published_table <- merge (relevant_games, ranking))
(published_table <- published_table %>% group_by(Sport) %>% summarise(ranking = max(ranking)) %>% arrange(ranking))
(published_table <- published_table[1:3,])

#relevant_games %>% filter(Sport == published_table[1,1])

tweet_table <- sapply(1:3, function(x) {
  sport <- relevant_games %>% filter(Sport == as.character(published_table[x,1]))
  return(sport[1,])
})
tweet_table <- t(tweet_table) %>% as.data.table(byrow=TRUE)

tweet_table$`time (EST)` -> tweet_table$time
tweet_table$`time (EST)` <- NULL
str_c("Watch the ", tweet_table$Sport[1], " today at ", tweet_table$time[1])


api_key <- "1Uj0WI9I5En6sfdDKIQf4s1NF"

api_secret <- "wiLlk5sPulNlym83wF2u9YHfSAEwbk9sWVdJaERQPcDwLR9Zx1"

access_token <- "761956823482114048-k20LounPHDjSADagfJ77OdZtUUQe3RU"

access_token_secret <- "V24K29PRSrfqdcUC4DD6OJ4tbTsym2T3PJdo9BFoHQjGT"

setup_twitter_oauth(api_key,api_secret,access_token,access_token_secret)