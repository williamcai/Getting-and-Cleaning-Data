# Description of program
 Requirements:
 1.Merges the training and the test sets to create one data set.
 2.Extracts only the measurements on the mean and standard deviation for each 
   measurement. 
 3.Uses descriptive activity names to name the activities in the data set
 4.Appropriately labels the data set with descriptive variable names. 
 5.Creates a second, independent tidy data set with the average of each 
   variable for each activity and each subject. 

---------------------------------------------------------------------------
read activity labels
read features names
---------------------------------------------------------------------------
read training data set 
	data:    X_train.txt
	activity:y_train.txt
	subject :subject_train.txt
merge descriptive activity names to name the activities in the data set
make train data all in one
label each variable names
---------------------------------------------------------------------------
read test data set
	data:    X_test.txt
	activity:y_test.txt
	subject :subject_test.txt
merge descriptive activity names to name the activities in the data set
make test data all in one
label each variable names
---------------------------------------------------------------------------
Merges the training and the test sets to create one data set.
---------------------------------------------------------------------------

---------------------------------------------------------------------------
Extracts only the measurements on the mean and standard deviation for each 
  measurement. 
  grep feature label for "mean" and "std"
---------------------------------------------------------------------------

---------------------------------------------------------------------------
Creates a second, independent tidy data set with the average of each 
  variable for each activity and each subject. 
---------------------------------------------------------------------------
Output tidyData
---------------------------------------------------------------------------
