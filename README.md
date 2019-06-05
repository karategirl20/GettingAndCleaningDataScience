# GettingAndCleaningDataScience
Parameters for the project
You should create one R script called run_analysis.R that does the following. 1.Merges the training and the test sets to create one data set. 2.Extracts only the measurements on the mean and standard deviation for each measurement. 3.Uses descriptive activity names to name the activities in the data set 4.Appropriately labels the data set with descriptive variable names. 5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip



Steps to reproduce this project
Open the R script run_analysis.r using a text editor.
Change the parameter of the setwd function call to the working directory/folder (i.e., the folder where these the R script file is saved).
Run the R script run_analysis.r. It calls the R Markdown file, run_analysis.Rmd, which contains the bulk of the code.
Outputs produced
Tidy dataset file DatasetHumanActivityRecognitionUsingSmartphones.txt (tab-delimited text)
Codebook file codebook.md (Markdown)
Repository file details
1. README.md -- containes details on executing the scripts
2. CodeBook.md -- containes details on data files
3. run_analysis.R -- containes script for Getting and Cleaning Data
4. tidydata.txt -- output of the clean data for further analysis 
Here are the steps that must be performed before
1. Download the zip file from Coursera site https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
2. Unzip the file and copy UCI HAR Dataset folder.
3. Paste the UCI HAR Dataset folder in working directory where we have run_analysis.R
4. source the file run_analysis.R
5. Run the Script run_analysis
6. Output file tidydata.txt will be generated in the current working folder. 
