library(tm)
library(RCurl)
library(XML)
library(rvest)
library(RSelenium)
library(stringr)
library(stringi)
library(SnowballC)
library(devtools)
library(lubridate)
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
ranking <- data.frame("sport" = c("Swimming", "Athletics", "Gymnastics", "Basketball", "Soccer", "Volleyball", "Rowing", "Tennis", "Table Tennis"), "ranking" = 1:9)

schedule_df[indices,] -> relevant_games

