### Codebook for the file - HAR mean summary.txt

Please refer to brief introduction in README.md before reviewing this document.
This is the description of the file - HAR mean summary.txt, and it is a tidy data set which is required from course project of Getting and Cleaning Data

##### 1. data
This is a tidy data set with the average of each variable in Human Activity Recognition for each activity and each subject. 
Tidy data set is in the file format of txt. Each variable is separated by tab. And head of each variable is provided.

##### 2. Variables
1. subject
  * Identifier who performed the activity for each window sample. Its range is from 1 to 30.
2. activity
  * Class labels with their activity name (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING)
3. The average of each variable in Human Activity Recognition as described below (variable 3~variable68)
  * These signals were used to estimate variables of the feature vector for each pattern: '-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

    - tBodyAcc-XYZ
    - tGravityAcc-XYZ
    - tBodyAccJerk-XYZ
    - tBodyGyro-XYZ
    - tBodyGyroJerk-XYZ
    - tBodyAccMag
    - tGravityAccMag
    - tBodyAccJerkMag
    - tBodyGyroMag
    - tBodyGyroJerkMag
    - fBodyAcc-XYZ
    - fBodyAccJerk-XYZ
    - fBodyGyro-XYZ
    - fBodyAccMag
    - fBodyAccJerkMag
    - fBodyGyroMag
    - fBodyGyroJerkMag

  * The set of variables that were estimated from these signals are: 

    - mean(): Mean value
    - std(): Standard deviation

##### 3. Getting and Cleaning Data

These are the more detailed strategy to get tidy data set from original data - https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

1. Read data sets
  * read all the necessary data sets with read.table function. 
  * The used data sets are - features, activity_labels, X_train, Y_train, subject_train, X_test, Y_test, subject_test
2. Merges the training and the test sets to create one data set.
  * Merged X.train and X.test as one data sets
  * Named each variable names with feature file
  * Merged subject files as well and added subject variable to data set
3. Extracts only the measurements on the mean and standard deviation for each measurement.
  * Made a fuction which can extract feature name with word - "mean" and "std"
  * Before the step above excluded the word "Freq" to make sure "meanFreq" is not included with "mean"
  * Extracted data set from the feature names made by the fuction above.
4. Uses descriptive activity names to name the activities in the data set.
  * Merged Y.train and Y.test to get activity number  
  * Added activity variable to original data set
5. Appropriately labels the data set with descriptive activity names
  * Labeled each activities name according to its number
6. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
  * Used melt() and dcast() function in library(reshape2)
  * melted data set with two variable - subject and activity
  * Finally made tidy data set with the average of each variable with dcast() function
  * Wrote data set as HAR mean summary.txt



