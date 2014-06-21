# ------------------------------------------------------------------------------
# 1.Merges the training and the test sets to create one data set.
# 2.Extracts only the measurements on the mean and standard deviation for each 
#   measurement. 
# 3.Uses descriptive activity names to name the activities in the data set
# 4.Appropriately labels the data set with descriptive variable names. 
# 5.Creates a second, independent tidy data set with the average of each 
#   variable for each activity and each subject. 
# ------------------------------------------------------------------------------

# read activity labels
#act_label <- read.table("UCI HAR Dataset/activity_labels.txt")
act_label <- read.table("activity_labels.txt")
# read features
#feature_label <- read.table("UCI HAR Dataset/features.txt",stringsAsFactors = FALSE)
feature_label <- read.table("features.txt",stringsAsFactors = FALSE)

# read training data
#train     <- read.table("UCI HAR Dataset/train/X_train.txt")
#train_act <- read.table("UCI HAR Dataset/train/y_train.txt") 
#train_sub <- read.table("UCI HAR Dataset/train/subject_train.txt")
train     <- read.table("X_train.txt")
train_act <- read.table("y_train.txt") 
train_sub <- read.table("subject_train.txt")

# ------------------------------------------------------------------------------
# 3.Uses descriptive activity names to name the activities in the data set
# ------------------------------------------------------------------------------
data <- merge(x = train_act, y = act_label, by.x = "V1", by.y = "V1" )

data1 <- data.frame(cbind(train, data[,2],train_sub))

# ------------------------------------------------------------------------------
# 4.Appropriately labels the data set with descriptive variable names. 
# ------------------------------------------------------------------------------
names(data1) <- c(feature_label[,2],"activity","subject")

# read test data
#test      <- read.table("UCI HAR Dataset/test/X_test.txt")
#test_act  <- read.table("UCI HAR Dataset/test/y_test.txt") 
#test_sub  <- read.table("UCI HAR Dataset/test/subject_test.txt")
test      <- read.table("X_test.txt")
test_act  <- read.table("y_test.txt") 
test_sub  <- read.table("subject_test.txt")

# ------------------------------------------------------------------------------
# 3.Uses descriptive activity names to name the activities in the data set
# ------------------------------------------------------------------------------
data <- merge(x = test_act, y = act_label, by.x = "V1", by.y = "V1" )
data2 <- data.frame(cbind(test, data[,2],test_sub))

# ------------------------------------------------------------------------------
# 4.Appropriately labels the data set with descriptive variable names. 
# ------------------------------------------------------------------------------
names(data2) <- c(feature_label[,2],"activity","subject")

# ------------------------------------------------------------------------------
# 1.Merges the training and the test sets to create one data set.
# ------------------------------------------------------------------------------
data <- data.frame(rbind(data1,data2))

# ------------------------------------------------------------------------------
# 2.Extracts only the measurements on the mean and standard deviation for each 
#   measurement. 
# ------------------------------------------------------------------------------
sub <- c(grep("mean",feature_label[,2]),
         grep("std",feature_label[,2]))
subsetData <- data[,sub]
subsetData$subject  <- data$subject
subsetData$activity <- data$activity

# ------------------------------------------------------------------------------
# 5.Creates a second, independent tidy data set with the average of each 
#   variable for each activity and each subject. 
# ------------------------------------------------------------------------------
v_sub <- data.frame()
v_act <- data.frame()
v_col <- ncol(subsetData)-2

for (i in 1:v_col) {
  v_sub <- rbind(v_sub,tapply(subsetData[,i],subsetData$subject,mean))
  v_act <- rbind(v_act,tapply(subsetData[,i],subsetData$activity,mean))
  if (i == v_col) {
    names(v_sub) <- names(tapply(subsetData[,i],subsetData$subject,mean))
    names(v_act) <- names(tapply(subsetData[,i],subsetData$activity,mean))
  }
}
v_a <- cbind(feature=feature_label[,2],v_act)
v_s <- cbind(feature=feature_label[,2],v_sub)

tidyData <- cbind(v_a,v_s[,2:ncol(v_s)])
write.table(tidyData,file="tidyData.txt",sep=",",row.names = FALSE)