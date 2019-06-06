Getting and Cleaning Data Course Project
Data Set Information
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

Attribute Information:
For each record in the dataset it is provided:

Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
Triaxial Angular velocity from the gyroscope.
A 561-feature vector with time and frequency domain variables.
Its activity label.
An identifier of the subject who carried out the experiment.
Measures.
Subject -

'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.

'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis.

'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration.

'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second.

Course Project Objective
Merge the training and the test sets to create one data set.
Extracts only the measurements on the mean and standard deviation for each measurement.
Uses descriptive activity names to name the activities in the data set
Appropriately labels the data set with descriptive variable names.
From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
1. Merge the training and the test data
After setting the source directory for the files, read into tables the data located in

features.txt
activity_labels.txt
subject_train.txt
x_train.txt
y_train.txt
subject_test.txt
x_test.txt
y_test.txt
# This script will perform the following steps on the UCI HAR Dataset downloaded from 
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
# 1. Merge the training and the test sets to create one data set. Downoad the packages reshape,reshape2 and plyr
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
ExtractCols <- finalData[Extract]
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

