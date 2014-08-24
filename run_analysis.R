library(plyr)

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
dataDir <- "./data"
zipFile <- paste(dataDir, "dataset.zip", sep = "/")
dirName <- paste(dataDir, "UCI HAR Dataset", sep = "/")

# Prepare data directory, download zip file and extract it.
if (!file.exists(dataDir)) {
  dir.create(dataDir)
}
if (!file.exists(zipFile)) {
  download.file(url = fileUrl, destfile = zipFile, method = "curl", quiet = TRUE)
}
if (!file.exists(dirName)) {
  unzip(zipFile, exdir = dataDir)
}

readDataset <- function(dataset) {
  data <- read.table(paste(dirName, dataset, 
                           paste("X_", dataset, ".txt", sep = ""), sep = "/"))
  subjects <- read.table(paste(dirName, dataset, 
                               paste("subject_", dataset, ".txt", sep = ""), sep = "/"),
                         col.names = c("subject"))
  results <- read.table(paste(dirName, dataset,
                              paste("y_", dataset, ".txt", sep = ""), sep = "/"),
                        col.names = c("activity"))
  cbind(subjects, results, data)
}

# 1. Merge the training set and the test set to create one data set
datasets <- rbind(readDataset("test"), readDataset("train"))

# 2. Extract only the measurements on the mean and standard deviation for each measurement
features <- read.table(paste(dirName, "features.txt", sep = "/"), col.names = c("colname", "feature"))
features$colname <- paste("V", features$colname, sep = "")
features <- features[grepl("mean\\(\\)|std\\(\\)", features$feature),]
features$feature <- gsub("[()]", "", gsub("-", "_", features$feature))

datasets <- datasets[, c("activity", "subject", features$colname)]

# 3. Use descriptive activity names to name the activities in the data set
activityLabels <- read.table(paste(dirName, "activity_labels.txt", sep = "/"), col.names = c("id", "activity"))
activityMap <- setNames(as.character(activityLabels$activity), activityLabels$id)
datasets$activity <- activityMap[datasets$activity]

# 4. Appropriately label the data set with descriptive variable names
featuresMap <- setNames(as.character(features$feature), features$colname)
datasets <- rename(datasets, featuresMap)

# datasets is a tidy data set at this moment.

# 5. Create a second, independent tidy data set with the average of each variable for each activity and each subject
tidy <- ddply(datasets, .(activity, subject), numcolwise(mean))
write.table(tidy, file = paste(dataDir, "tidy_set.txt", sep = "/"), row.name=FALSE)
