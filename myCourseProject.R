if(!file.exists("./data")){dir.create("./data")}

if(!file.exists("./data/zipdata.zip")){
      fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
      download.file(fileUrl, "./data/zipdata.zip")
}

library(zip)
unzip("./data/zipdata.zip", exdir = "./data")

#1. Merges the training and the test sets to create one data set.
test_x <- read.table("./data/UCI HAR Dataset/test/X_test.txt", 
                     colClasses = "numeric")
train_x <- read.table("./data/UCI HAR Dataset/train/X_train.txt", 
                      colClasses = "numeric")


test_y <- read.table("./data/UCI HAR Dataset/test/y_test.txt", 
                     colClasses = "numeric")
train_y <- read.table("./data/UCI HAR Dataset/train/y_train.txt", 
                      colClasses = "numeric")


bigX <- rbind(train_x, test_x)
bigY <- rbind(train_y, test_y)

dataset <- cbind(bigX, bigY)

# for (i in ncol(dataset))
#       dataset[, i] <- as.numeric(dataset[, i])
write.csv(dataset, file = "./data/dataset.csv")

#2 Extracts only the measurements on the mean and standard deviation 
#for each measurement.

mean <- colMeans(dataset)
sd <- sapply(dataset, sd)


#3. Uses descriptive activity names to name the activities in the data set

