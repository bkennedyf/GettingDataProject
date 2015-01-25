# CodeBook for GettingDataProject
Project for Coursera Class: Getting and Cleaning Data

# The script run_analysis.R loads in several files, combines the data, selects a subset of data that is either a mean() or std() measurement and then averages the results for each subject and activity.

The data can be found in the data frame, "summaryData".  The first and second variables in the data frame are: "subject"" and "activities", the remaining 79 are various measurments.  The subject is identified by a number (1-30) and the activities are specified with 1 of 6 descriptive terms (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS SITTING, STANDING, LAYING ).

The remaining measurements are the mean() of the following measurement types:
tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

which were reported as mean(), meanFreq() and/or std().