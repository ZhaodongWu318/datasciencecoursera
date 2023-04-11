rm(list=ls())
library(dplyr)

filename <- "Coursera_D3.zip"

# Check if data already exists
if (!file.exists(filename)) {
  fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileurl,filename,method="curl")
}

# Check if the folder exists
if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}

# Then we need to assigning all data frames
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")

# Stage 1: Merges the training and the test sets to create one data set.
X <- rbind(x_train, x_test)
Y <- rbind(y_train, y_test)
subject <- rbind(subject_train, subject_test)
data <- cbind(subject, Y, X)

# Stage 2: Extracts only the measurements on the mean and standard deviation for each measurement
stat <- data %>% select(subject, code, contains("mean"), contains("std"))

# Stage 3: Uses descriptive activity names to name the activities in the data set
stat$code <- activities[stat$code, 2]

# Stage 4: Appropriately labels the data set with descriptive variable names
names(stat)[2] = "activity"
names(stat)<-gsub("Acc", "Accelerometer", names(stat))
names(stat)<-gsub("Gyro", "Gyroscope", names(stat))
names(stat)<-gsub("BodyBody", "Body", names(stat))
names(stat)<-gsub("Mag", "Magnitude", names(stat))
names(stat)<-gsub("^t", "Time", names(stat))
names(stat)<-gsub("^f", "Frequency", names(stat))
names(stat)<-gsub("tBody", "TimeBody", names(stat))
names(stat)<-gsub("-mean()", "Mean", names(stat), ignore.case = TRUE)
names(stat)<-gsub("-std()", "STD", names(stat), ignore.case = TRUE)
names(stat)<-gsub("-freq()", "Frequency", names(stat), ignore.case = TRUE)
names(stat)<-gsub("angle", "Angle", names(stat))
names(stat)<-gsub("gravity", "Gravity", names(stat))

# Stage 5: From the data set in step 4, creates a second, independent tidy data 
Finaldata <- stat %>%
    group_by(subject, activity) %>%
    summarise_all(mean)

write.table(Finaldata, "FinalData.txt", row.name=FALSE)