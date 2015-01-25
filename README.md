# GettingDataProject
Project for Coursera Class: Getting and Cleaning Data

# the script run_analysis.R takes several data files and combines the information together in a data frame called "combinedData" and then also creates a summary of a subset, which is just the mean on each of the variables that have either: (1) "mean()" or (2) "std" in their name broken down (grouped) by subject and activity.

# The script run_analysis.R expects the files to be either: (1) in the working directory of R, or (2) in the file structure that the data came with, where the folder "UCI HAR Dataset" is in the working directory.

# the required files are:
subject_train.txt
y_train.txt
X_test.txt
subject_test.txt
y_test.txt
activity_labels.txt
features.txt