library(plyr)

# 0. set working directory
setwd("C:/Users/André/OneDrive/coursera/GettingAndCleaningData/")

# 1. Merge the training and test sets to create one data set

x_train <- read.table("data/train/X_train.txt")
y_train <- read.table("data/train/y_train.txt")
subject_train <- read.table("data/train/subject_train.txt")

x_test <- read.table("data/test/X_test.txt")
y_test <- read.table("data/test/y_test.txt")
subject_test <- read.table("data/test/subject_test.txt")

# create datasets
x_data <- rbind(x_train, x_test)
y_data <- rbind(y_train, y_test)
subject_data <- rbind(subject_train, subject_test)

# 2. Extract only the measurements on the mean and standard deviation for each measurement

features <- read.table("data/features.txt")

# only clmns with mean or std
mean_and_std_features <- grep("-(mean|std)\\(\\)", features[, 2])
x_data <- x_data[, mean_and_std_features]
names(x_data) <- features[mean_and_std_features, 2]


# 3. Use descriptive activity names to name the activities in the data set

activities <- read.table("data/activity_labels.txt")
y_data[, 1] <- activities[y_data[, 1], 2]
names(y_data) <- "activity"


# 4. Appropriately label the data set with descriptive variable names

names(subject_data) <- "subject"
all_data <- cbind(x_data, y_data, subject_data)


# 5. Create a second, independent tidy data set with the average of each variable for each activity and each subject

average_data <- ddply(all_data, .(subject, activity), function(x) colMeans(x[, 1:66]))
write.table(averages_data, "average_data.txt", row.name=FALSE)

# TADA - Be Happy! ;)