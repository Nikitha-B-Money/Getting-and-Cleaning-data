#setting the directory of dataset

setwd("C:/Users/Nikky/Desktop/Data Science/UCI HAR Dataset")

#loading the libraries
library(dplyr)
library(tidyr)

#reading the tables
activity <- read.table("activity_labels.txt",col.names = c("activity","labels"))
features <- read.table("features.txt",col.names = c("obs","features"))

x_train <- read.table("./train/X_train.txt",col.names = features$features)
y_train <- read.table("./train/Y_train.txt",col.names="activity")

x_test <- read.table("./test/X_test.txt",col.names = features$features)
y_test <- read.table("./test/Y_test.txt",col.names="activity")
subject_train <- read.table("./train/subject_train.txt",col.names = "subject")
subject_test <- read.table("./test/subject_test.txt",col.names = "subject")

#merging the data
x <- rbind(x_train,x_test)
y <- rbind(y_train, y_test)
subject <-rbind(subject_train,subject_test)
data <- cbind(subject,y,x)

#changing the labels to its activity name in dataset
data$activity <- activity[data$activity, 2]


#converting the dataset into a 4 variable dataset
finaldata<-data %>%
   gather(features,value,-subject,-activity)%>%
   group_by(subject,activity,features) %>%
   summarize(value=sum(value)) 
write.table(finaldata,"./tidydata.txt", row.names = FALSE)
