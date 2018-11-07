library(jsonlite)
library(tidyverse)

train_df <- read.csv("ProjectData/train.csv",stringsAsFactors = FALSE , colClasses = ("fullVisitorId" = "character"))
test_df <- read.csv("ProjectData/test.csv", stringsAsFactors = FALSE,colClasses = ("fullVisitorId" = "character"))

summary(train_df)

#Extract data from the json columns in TRAIN
device_json_df <- paste("[", paste(train_df$device, collapse = ","), "]") %>% 
                    fromJSON(flatten = T)

geo_network_json_df <- paste("[", paste(train_df$geoNetwork, collapse = ","), "]") %>% 
                    fromJSON(flatten = T)

total_json_df <- paste("[", paste(train_df$totals, collapse = ","), "]") %>% 
                    fromJSON(flatten = T)

traffic_json_df <- paste("[", paste(train_df$trafficSource, collapse = ","), "]") %>% 
                      fromJSON(flatten = T)

train_df <- cbind(train_df,device_json_df,geo_network_json_df,total_json_df,traffic_json_df)


#Drop the json columns
train_df <- select(train_df,  -one_of(c("device","geoNetwork","totals","trafficSource")))  

#Extract data from the json columns in TEST
device_json_df <- paste("[", paste(test_df$device, collapse = ","), "]") %>% 
  fromJSON(flatten = T)

geo_network_json_df <- paste("[", paste(test_df$geoNetwork, collapse = ","), "]") %>% 
  fromJSON(flatten = T)

total_json_df <- paste("[", paste(test_df$totals, collapse = ","), "]") %>% 
  fromJSON(flatten = T)

traffic_json_df <- paste("[", paste(test_df$trafficSource, collapse = ","), "]") %>% 
  fromJSON(flatten = T)

test_df <- cbind(test_df,device_json_df,geo_network_json_df,total_json_df,traffic_json_df)

test_df <- select(test_df,  -one_of(c("device","geoNetwork","totals","trafficSource"))) 

summary(train_df)

rm(device_json_df,geo_network_json_df,total_json_df,traffic_json_df)

glimpse(train_df)

unique_length <- function (x){
  #Function to calculate no. of unique values in a variable
  length(unique(x))
}

sapply(train_df, unique_length) %>% as.data.frame()
sapply(test_df, unique_lenght) %>% as.data.frame()
unique(train_df$mobileDeviceModel)
