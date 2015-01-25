# run_analysis.R
# requires working directory to have either: (1) the subdirectories listed below,
# or (2) the files in the working directory
# on my manchine the working directory should be set to:
# setwd("/home/brian/Documents/Coursera/Getting Data/Project/GettingDataProject")
trainDirectory = "./UCI HAR Dataset/train/";
trainDataFile = "X_train.txt";
trainSubjectsFile = "subject_train.txt";
trainActivitiesFile = "y_train.txt";

testDirectory = "./UCI HAR Dataset/test/";
testDataFile = "X_test.txt";
testSubjectsFile = "subject_test.txt";
testActivitiesFile = "y_test.txt";

descriptiveDirectory = "./UCI HAR Dataset/";
activityLabelFile = "activity_labels.txt";
featureLabelFile = "features.txt";

outputFile = "summarizedData.txt";


# Activities
# 1 WALKING, 2 WALKING_UPSTAIRS, 3 WALKING_DOWNSTAIRS, 4 SITTING, 5 STANDING, 6 LAYING

# figure out if the data is in the working directory; if so, don't look in the expected directories below
if (file.exists(trainDataFile)) {
  trainDirectory = "";
}

if (file.exists(testDataFile)) {
  testDirectory = "";
}

if (file.exists(activityLabelFile)) {
  descriptiveDirectory = "";
}

trainingData = read.table(paste(trainDirectory, trainDataFile, sep = ""));
# assume that all the related data is in the same directory
trainingSubjectMap = read.table(paste(trainDirectory, trainSubjectsFile, sep = ""));
trainingActivitiesMap = read.table(paste(trainDirectory, trainActivitiesFile, sep = ""));

testingData = read.table(paste(testDirectory, testDataFile, sep = ""));
# assume that all the related data is in the same directory
testingSubjectMap = read.table(paste(testDirectory, testSubjectsFile, sep = ""));
testingActivitiesMap = read.table(paste(testDirectory, testActivitiesFile, sep = ""));

activityLabels = read.table(paste(descriptiveDirectory, activityLabelFile, sep = ""));
featureLabels = read.table(paste(descriptiveDirectory, featureLabelFile, sep = ""));

# Step 1: Create 1 data set (merge all the test and training data)
# might want to use the function rbind() which "adds rows" and merge() which "adds columns"
testData = cbind(testingSubjectMap, testingActivitiesMap, testingData);
trainData = cbind(trainingSubjectMap, trainingActivitiesMap, trainingData);

combinedData = rbind(trainData, testData);

# Step 4: Label the data set with descriptive variable names
names(combinedData) <- paste(c("subject", "activities", as.character(featureLabels$V2)))

# Step 3: Use descriptive activity names
combinedData$activities = activityLabels$V2[combinedData$activities];

# Step 2: Extract the mean and standard deviation for each measurement
#summaryMean = array();
#summaryStandardDeviation = array();

#nVariables = dim(combinedData)[2];
#for (measurement in (1+2):nVariables){
#  summaryMean[measurement-2] = mean(combinedData[,measurement]);
#  summaryStandardDeviation[measurement-2] = sd(combinedData[,measurement]);
#}

# "Extracts only the measurements on the mean and standard deviation for each measurement"

meanVariables = grepl("mean()", featureLabels$V2);
stdVariables = grepl("std()", featureLabels$V2);
meanOrStd = meanVariables | stdVariables;

selectedVariables = c(TRUE, TRUE, meanOrStd); # first two TRUE are for subject and activity

selectedData = combinedData[,selectedVariables];

# Step 5: Create a new data set with the average of each variable for each activity and each subject

selectedData

summaryData = data.frame();
subjects = array();
activities = array();
resultCount = 0;
for (subjectDex in 1:30){
  for (activityDex in 1:6){
    subjectPointer = selectedData$subject == subjectDex;
    activityPointer = selectedData$activities == activityLabels$V2[activityDex];
    pointer = subjectPointer & activityPointer; # select on both subject and activity
    
    result = sapply(selectedData[which(pointer), 3:81], mean);
    resultCount = resultCount+1;
    subjects[resultCount] = subjectDex;
    activities[resultCount] = activityDex;
    
    summaryData = rbind(summaryData, result);
  }
}

summaryData = cbind(subjects, activities, summaryData);
names(summaryData) = names(selectedData);

summaryData$activities = activityLabels$V2[summaryData$activities];

write.table(summaryData, file = outputFile, row.name = FALSE)