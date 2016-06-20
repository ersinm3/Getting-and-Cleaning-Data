##
## Assume setwd() has been set correctly for the right data directory
## Then read data

# if (!file.exists("./data")) {dir.create("./data")}
# url1 <- "https://??source/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
# download.file(url1, "dataset1.zip")
# unzip("dataset1.zip")

## Read data in
subtest <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")
Xtest <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
Ytest <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
subtrain <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")
Xtrain <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
Ytrain <- read.table("./data/UCI HAR Dataset/train/y_train.txt")

## Merge data
subjects <- rbind(subtrain, subtest)
X <- rbind(Xtrain, Xtest)
Y <- rbind(Ytrain, Ytest)

subj_activity <- data.frame(subjects[, 1], Y[, 1])

## Give it appropriate names
## Use "activity_labels.txt" for appropriate names
colnames(subj_activity) <- c("subject", "activity")
levels(subj_activity) <- c("Walking", "WalkingUpstairs", "WalkingDownstairs", "Sitting", "Standing", "Laying")

## Extract all mean and standard deviation data 
## Use the "features.txt" to find these columns. We come up with
## tBodyAcc-mean-XYZ -- 1, 2, 3
## tBodyAcc-std-XYZ -- 4, 5, 6
## tGravityAcc-mean-XYZ -- 41, 42, 43
## tGravityAcc-std-XYZ -- 44, 45, 46
## tBodyAccJerk-mean-XYZ -- 81, 82 83
## tBodyAccJerk-std-XYZ -- 84, 85, 86
## tBodyGyro-mean-XYZ -- 121, 122, 123
## tBodyGyro-std-XYZ -- 124, 125, 126
## tBodyGyroJerk-mean-XYZ -- 161, 162, 163
## tBodyGyroJerk-std-XYZ -- 164, 165, 166
## tBodyAccMag-mean -- 201
## tBodyAccMag-std -- 202
## tGravityAccMag-mean -- 214
## tGravityAccMag-std -- 215
## tBodyAccJerkMag-mean -- 227
## tBodyAccJerkMag-std -- 228
## tBodyGyroMag-mean -- 240
## tBodyGyroMag-std -- 241
## tBodyGyroJerkMag-mean -- 253
## tBodyGyroJerkMag-std -- 254
## fBodyAcc-mean-XYZ -- 266, 267, 268
## fBodyAcc-std-XYZ -- 269, 270, 271
## fBodyAcc-meanFreq-XYZ -- 294, 295, 296
## fBodyAccJerk-mean-XYZ -- 345, 346, 347
## fBodyAccJerk-std-XYZ -- 348, 349, 350
## fBodyAccJerk-meanFreq-XYZ -- 373, 374, 375
## fBodyGyro-mean-XYZ -- 424, 425, 426
## fBodyGyro-std-XYZ -- 427, 428, 429
## fBodyGyro-meanFreq-XYZ -- 452, 453, 454
## fBodyAccMag-mean -- 503
## fBodyAccMag-std -- 504
## fBodyAccMag-meanFreq -- 513
## fBodyBodyAccJerkMag-mean -- 516
## fBodyBodyAccJerkMag-std -- 517
## fBodyBodyAccJerkMag-meanFreq -- 526
## fBodyBodyGyroMag-mean -- 529
## fBodyBodyGyroMag-std -- 530
## fBodyBodyGyroMag-meanFreq -- 539
## fBodyBodyGyroJerkMag-mean -- 542
## fBodyBodyGyroJerkMag-std -- 543
## fBodyBodyGyroJerkMag-meanFreq -- 552
## angle(tBodyAccMean, gravity) -- 555
## angle(tBodyAccJerkMean, gravityMean) -- 556
## angle(tBodyGyroMean, gravityMean) -- 557
## angle(tBodyGyroJerkMean, gravityMean) -- 558
## angle(XYZ, gravityMean) -- 559, 560, 561
## 86 columns

# keepcols are the columns to keep
keepcols <- c(1:6, 41:46, 81:86, 121:126, 161:166, 201, 202, 214, 215, 227, 228, 240, 241, 253, 
              254, 266:271, 294:296, 345:350, 373:375, 424:429, 452:454, 503, 504, 513, 516, 517, 
              526, 529, 530, 539, 542, 543, 552, 555, 556:561)

# keepnames are the names of these columns
keepnames <- c("tBodyAcc-mean-X", "tBodyAcc-mean-Y", "tBodyAcc-mean-Z", 
               "tBodyAcc-std-X", "tBodyAcc-std-Y", "tBodyAcc-std-Z")
keepnames <- c(keepnames, c("tGravityAcc-mean-X", "tGravityAcc-mean-Y", "tGravityAcc-mean-Z",
                            "tGravityAcc-std-X", "tGravityAcc-std-Y", "tGravityAcc-std-Z"))
keepnames <- c(keepnames, c("tBodyAccJerk-mean-X", "tBodyAccJerk-mean-Y", "tBodyAccJerk-mean-Z",
                            "tBodyAccJerk-std-X", "tBodyAccJerk-std-Y", "tBodyAccJerk-std-Z"))
keepnames <- c(keepnames, c("tBodyGyro-mean-X", "tBodyGyro-mean-Y", "tBodyGyro-mean-Z",
                            "tBodyGyro-std-X", "tBodyGyro-std-Y", "tBodyGyro-std-Z"))
keepnames <- c(keepnames, c("tBodyGyroJerk-mean-X", "tBodyGyroJerk-mean-Y", "tBodyGyroJerk-mean-Z",
                            "tBodyGyroJerk-std-X", "tBodyGyroJerk-std-Y", "tBodyGyroJerk-std-Z"))
keepnames <- c(keepnames, c("tBodyAccMag-mean", "tBodyAccMag-std"))
keepnames <- c(keepnames, c("tGravityAccMag-mean", "tGravityAccMag-std"))
keepnames <- c(keepnames, c("tBodyAccJerkMag-mean", "tBodyAccJerkMag-std"))
keepnames <- c(keepnames, c("tBodyGyroMag-mean", "tBodyGyroMag-std"))
keepnames <- c(keepnames, c("tBodyGyroJerkMag-mean", "tBodyGyroJerkMag-std"))
keepnames <- c(keepnames, c("fBodyAcc-mean-X", "fBodyAcc-mean-Y", "fBodyAcc-mean-Z"))
keepnames <- c(keepnames, c("fBodyAcc-std-X", "fBodyAcc-std-Y", "fBodyAcc-std-Z"))
keepnames <- c(keepnames, c("fBodyAcc-meanFreq-X", "fBodyAcc-meanFreq-Y", "fBodyAcc-meanFreq-Z"))
keepnames <- c(keepnames, c("fBodyAccJerk-mean-X", "fBodyAccJerk-mean-Y", "fBodyAccJerk-mean-Z"))
keepnames <- c(keepnames, c("fBodyAccJerk-std-X", "fBodyAccJerk-std-Y", "fBodyAccJerk-std-Z"))
keepnames <- c(keepnames, c("fBodyAccJerk-meanFreq-X", "fBodyAccJerk-meanFreq-Y", "fBodyAccJerk-meanFreq-Z"))
keepnames <- c(keepnames, c("fBodyGyro-mean-X", "fBodyGyro-mean-Y", "fBodyGyro-mean-Z"))
keepnames <- c(keepnames, c("fBodyGyro-std-X", "fBodyGyro-std-Y", "fBodyGyro-std-Z"))
keepnames <- c(keepnames, c("fBodyGyro-meanFreq-X", "fBodyGyro-meanFreq-Y", "fBodyGyro-meanFreq-Z"))
keepnames <- c(keepnames, c("fBodyAccMag-mean", "fBodyAccMag-std", "fBodyAccMag-meanFreq"))
keepnames <- c(keepnames, c("fBodyBodyAccJerkMag-mean", "fBodyBodyAccJerkMag-std", "fBodyBodyAccJerkMag-meanFreq"))
keepnames <- c(keepnames, c("fBodyBodyGyroMag-mean", "fBodyBodyGyroMag-std", "fBodyBodyGyroMag-meanFreq"))
keepnames <- c(keepnames, c("fBodyBodyGyroJerkMag-mean", "fBodyBodyGyroJerkMag-std", "fBodyBodyGyroJerkMag-meanFreq"))
keepnames <- c(keepnames, c("angle_tBodyAccMean", "angle_tBodyAccJerkMean"))
keepnames <- c(keepnames, c("angle_tBodyGyroMean", "angle_tBodyGyroJerkMean"))
keepnames <- c(keepnames, c("angleX", "angleY", "angleZ"))

# Now keep only the columns needed
X <- X[ , keepcols]
# And rename them
colnames(X) <- keepnames

## Merge them all together
subj_act_data <- data.frame(subj_activity, X)

## Average variables (just Body Accleration and Body Gyro here)
library(dplyr)
a <- arrange(subj_act_data, subject, activity)
b <- summarize(a, BodyAccMean=mean(tBodyAccMag.mean), BodyGyroMean=mean(tBodyGyroMag.mean))
