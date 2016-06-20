The R script runanalysis.R is for the Data and Cleaning Data course.


It assumes setwd() has been set correctly for the right data directory

To get the data in R do
# if (!file.exists("./data")) {dir.create("./data")}
# url1 <- "https://??source/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
# download.file(url1, "dataset1.zip")
# unzip("dataset1.zip")
Then run the script.

The script will:

Merge the training and the test sets to create one data set, called
"sub_act_data". 
It contais only the measurements on the mean and standard deviation for 
each measurement. 
A second independent data set of the average of each variable for each 
activity and subject is in a data set called "b".
