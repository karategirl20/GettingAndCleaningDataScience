# This script will perform the following steps on the UCI HAR Dataset downloaded from 
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
# 1. Merge the training and the test sets to create one data set.
rm(list=ls())
setwd('./UCI HAR dataset')
library(reshape)
library(reshape2)
library(plyr)
features = read.table('features.txt', header = FALSE)
#get the value of features dataset that we created
features
#understand the data structure of the features data set: this is a data.frame':	561 obs. of  2 variables:
str(features)
activityLabels = read.table('activity_labels.txt', header = FALSE)
#get the value of activityLables dataset that we created
activityLabels
#understand the data structure of the activityLabels data set: this is a data.frame':	data.frame':	6 obs. of  2 variables:
str(activityLabels)
###########obtain data from Training dataset
subject_train = read.table('./train/subject_train.txt', header = FALSE)
#get the value of features dataset that we created
subject_train
#understand the data structure of the subject_train data set: 'data.frame':	7352 obs. of  1 variable:
str(subject_train)
X_train = read.table('./train/X_train.txt', header = FALSE)
X_train
# understand the data structure of the X_train data set:    'data.frame':	7352 obs. of  561 variables:
str(X_train)
Y_train = read.table('./train/Y_train.txt', header = FALSE)
Y_train
# understand the data structure of the Y_train data set: 	data.frame':	7352 obs. of  1 variable:
str(Y_train)
###########obtain data from Testing dataset
subject_test = read.table('./test/subject_test.txt', header = FALSE)
#get the value of features dataset that we created
subject_test
#understand the data structure of the subject_test data set: 'data.frame':	7352 obs. of  1 variable:
str(subject_test)
X_test = read.table('./test/X_test.txt', header = FALSE)
X_test
# understand the data structure of the X_train data set:    'data.frame':	7352 obs. of  561 variables:
str(X_test)
Y_test = read.table('./test/Y_test.txt', header = FALSE)
Y_test
# understand the data structure of the Y_train data set: 	data.frame':	2947 obs. of  1 variable:
str(Y_test)

#name the header columns for the training data sets
colnames(activityLabels)  = c('activityId','activityType')
colnames(subject_train)  = "subjectId"
colnames(X_train)        = features[,2] 
colnames(Y_train)        = "activityId"

#name the header columns for the test data sets
colnames(subject_test)  = "subjectId"
colnames(X_test)        = features[,2] 
colnames(Y_test)        = "activityId"

#make a training dataset by merging Y_train,subject_train, and X_train
trainingData = cbind(Y_train,subject_train,X_train); 
trainingData

#make a test dataset by merging Y_test, subject_Test, and X_test
testData = cbind(Y_test,subject_test,X_test); 
testData
### Combining the  TrainingData and Testdata datasets, we need to find the dimensions in order to join them
### 7352  563

### 2947  563
dim(trainingData)
dim(testData)
#Both have 563 column variables 
FinalData = rbind(trainingData,testData)
names(FinalData)
str(FinalData)
## FinalData'data.frame':	10299 obs. of  563 variables:
# 2. Extract only the measurements on the mean and standard deviation for each measurement. 
Extract <- grep("mean|std|subject|activity", names(FinalData))
Extract
ExtractCols <- FinalData[Extract]
#### 3.Uses descriptive activity names to name the activities in the data set, use the dplyr:join
Activitynames <- join(ExtractCols, activityLabels, by = "activityId", match = "first")
head(Activitynames)
# Cleaning up the variable names
dim(Activitynames)
names(Activitynames)
names(Activitynames) <- gsub('mean', 'Mean',names(Activitynames))
names(Activitynames) <- gsub('std', 'Std', names(Activitynames))
names(Activitynames) <- gsub('[-()]', '', names(Activitynames))
names(Activitynames) <- gsub("^(t)","time",names(Activitynames))
names(Activitynames) <- gsub("^(f)","freq",names(Activitynames))

##From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


str(Activitynames)
Activitynames <- Activitynames[,1:81]
Activitynames$activityId <- factor(Activitynames$activityId, levels = activityLabels[,1], labels = activityLabels[,2])
Activitynames$subjectId <- as.factor(Activitynames$subjectId)
Activitynames.melted <- melt(Activitynames, id = c("subjectId", "activityId"))
Activitynames.mean <- dcast(Activitynames.melted, subjectId + activityId ~ variable, mean)
head(Activitynames.mean, 20)
dim(Activitynames.mean)

write.table(Activitynames.mean, file = "tidyData.txt")
