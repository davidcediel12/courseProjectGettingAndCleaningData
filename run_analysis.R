library(zip)
library(dplyr)
library(tibble)
#Creating the 'data' folder
if(!file.exists("./data")){dir.create("./data")}


#Downloading and unzipping the data
if(!file.exists("./data/zipdata.zip")){
      fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
      download.file(fileUrl, "./data/zipdata.zip")
      unzip("./data/zipdata.zip", exdir = "./data")
}




#1. Merges the training and the test sets to create one data set.
test_x <- read.table("./data/UCI HAR Dataset/test/X_test.txt", 
                     colClasses = "numeric")
train_x <- read.table("./data/UCI HAR Dataset/train/X_train.txt", 
                      colClasses = "numeric")


test_y <- read.table("./data/UCI HAR Dataset/test/y_test.txt", 
                     colClasses = "numeric")
train_y <- read.table("./data/UCI HAR Dataset/train/y_train.txt", 
                      colClasses = "numeric")

#In the end I merge X and Y to construct the big dataset

bigX <- rbind(train_x, test_x)

bigY <- rbind(train_y, test_y)



#2 Extracts only the measurements on the mean and standard deviation 
#for each measurement.

features_names <- read.table("./data/UCI HAR Dataset/features.txt")
#This name is only temporary, later I clean this names 
colnames(bigX) <- features_names[, 2]

bigX <- select(bigX, contains(c("mean()", "std()")))

#3. Uses descriptive activity names to name the activities in the data set

names(bigY) <- "activity"
changeNames <- function(number){
      name = NULL
      if(number == 1)
            name = "walking"
      else if(number == 2)
            name = "walkingUpstairs"
      else if(number == 3)
            name = "walkingDownstairs"
      else if(number == 4)
            name = "sitting"
      else if(number == 5)
            name = "standing"
      else if(number == 6)
            name = "laying"
      name
}

bigY <- sapply(bigY$activity, changeNames)

# for(i in seq(nrow(bigY))){
#       bigY[i, ] <- changeNames(bigY[i,])
# }

#4.Appropriately labels the data set with descriptive variable names.


names(features_names) <- c("featureNumber", "featureName")

#Making the names readable, eliminating special symbols and
#abbreviations
features_names <- features_names %>% 
      filter(grepl("mean\\(\\)", featureName) | 
             grepl("std\\(\\)", featureName)) %>%
      mutate(featureName = gsub("-", "", featureName)) %>%
      mutate(featureName = gsub("\\(\\)", "", featureName)) %>%
      mutate(featureName = sub("^t", "time", featureName)) %>%
      mutate(featureName = sub("^f", "frequency", featureName)) %>%
      mutate(featureName = sub("Acc", "acceleration", featureName)) %>%
      mutate(featureName = sub("std", "standarddeviation", featureName)) %>%
      mutate(featureName = tolower(featureName))
                  
                  
                  
names(bigX) <- features_names$featureName   


#5.From the data set in step 4, creates a second, independent tidy data set 
#with the average of each variable for each activity and each subject


activities <- factor(bigY)
dataset <- cbind(bigX, bigY)
dataset <- rename(dataset, activities = bigY)

by_activity <- group_by(dataset, activities)

means <- summarize_all(by_activity, mean)

write.csv(dataset, file = "./data/bigDataset.csv")
write.csv(means, file ="./data/means.csv")
