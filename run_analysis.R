##
## Assume setwd() has been set correctly for the right data directory
## Then read data

if (!file.exists("./data")) {dir.create("./data")}
url1 <- "https://??source/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url1, "./data/dataset1.zip")
## This will result in unpacking the zip file into the "UCI HAR Dataset" directory
unzip("./data/dataset1.zip")

## Read data in

## TEST DATA
## Each of these objects have 2947 rows (from number of lines in each file)
## N.B. Yes, the X_test file starts with a capitol "X" but the y_test starts with little "y"
subtest <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")
Xtest <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
Ytest <- read.table("./data/UCI HAR Dataset/test/y_test.txt")

## TRAINING DATA
## Each of these objects will have 7352 rows (from number of lines in each file)
## But otherwise are like the test data
subtrain <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")
Xtrain <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
Ytrain <- read.table("./data/UCI HAR Dataset/train/y_train.txt")

## Merge data to create one data set for subjects, X, and Y data
subjects <- rbind(subtrain, subtest)
X <- rbind(Xtrain, Xtest)
Y <- rbind(Ytrain, Ytest)

## Factor Y
## Use "activity_labels.txt" for appropriate names
activity_labels <- read.table("./data//UCI HAR Dataset/activity_labels.txt")
Y.f <- factor(Y$V1, labels = activity_labels[,2])
## Make a data.frame out subject and activity
subj_activity <- data.frame(subjects[, 1], Y.f)

## Give the columns appropriate names
colnames(subj_activity) <- c("Subject", "Activity")

## Extract all mean and standard deviation data 
## Use the "features.txt" to find these columns.
features <- read.table("./data/UCI HAR Dataset/features.txt")

## Now we look for only the fields with "mean" or "std" in the data
## "ms" means mean-standard-deviation and is a numeric vector
## This should give a number vector with 86 items
ms <- grep("mean|std", features[,2], ignore.case = TRUE)

## Get the names of these fields
nm <- features[ms,]
## Some of these names include characters that don't appear nice in R so let's rename them.
## Fortunately, the numbers in names do not appear in the mean and std variables.
## So, the rationale is:
## Replace the "t" that appears in the front of a name with "time".
## Replace the "f" with "FFT".
## Replace "angle(t*)" with "angle(time*".
## Note that when used for column names with double parenthesis, will be changed to ".."
## So, let's remove double parenthesis.
## Also note that dashes and single parenthesis will be changed to "." when used to
## make data.frame names. This looks ok, so leave it.
## The "BodyBody" in names look odd, but probably has meaning from the authors so leave it.
## There is also the single case of "angle(tBodyAccJerkMean),gravityMean)". 
## We need to remove the first closing paren from this name. And let's remove all closing
## parens from the "angle" names so the last closing paren does not end up as a period.
nm[,2] <- gsub("^t", "time-", nm[,2])
nm[,2] <- gsub("^F", "FFT-", nm[,2])
nm[,2] <- gsub("^angle\\(t", "angle(time.", nm[,2])
nm[,2] <- gsub("\\C\\)", "", nm[,2])
nm[,2] <- gsub("BodyAccJerkMean\\)", "BodyAccJerkMean", nm[,2])
nm[,2] <- gsub("\\)$", "", nm[,2])

# Now keep only the columns needed from X
X1 <- X[ , ms]
# And rename them
colnames(X1) <- nm[,2]

## Merge them all together and
## This becomes our tidy data set:
subj_act_data <- data.frame(subj_activity, X1)

