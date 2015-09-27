##1 Importing libraries
library(plyr)
library(dplyr)


##2 Reading files required for the analysis (from folder UCI HAR Dataset in the working directory)
##2A Reading test data files in a table format
TestSetFile <- read.table("UCI HAR Dataset/test/X_test.txt", sep = "", colClasses = "numeric")
TestLabels <- read.table("UCI HAR Dataset/test/y_test.txt", sep = "\t", colClasses = "factor")
TestSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt", sep = "\t", colClasses = "factor")

##2B Reading training data files in a table format
TrainingSetFile <- read.table("UCI HAR Dataset/train/X_train.txt", sep = "", colClasses = "numeric")
TrainingLabels <- read.table("UCI HAR Dataset/train/y_train.txt", sep = "\t", colClasses = "factor")
TrainingSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt", sep = "\t", colClasses = "factor")


##3 Merging files into single data set called CompleteFile
##3A Merging test data files using cbind()
TestFileCombined <- cbind(TestSubjects, TestLabels, TestSetFile)

##3B Merging training data files using cbind()
TrainingFileCombined <- cbind(TrainingSubjects, TrainingLabels, TrainingSetFile)

##3C Merging previously combined test and training data files using rbind()
CompleteFile <- rbind(TestFileCombined, TrainingFileCombined)


##4 Cleaning information to replace column names (variable names)
##4A Reading features data file (containing column names and corresponding column locations) in a table format
AllFeatures <- read.table("UCI HAR Dataset/features.txt", sep = "")

##4B Filtering out column names containing a text pattern -mean() or -std()
Filteredfeatures <- rbind((AllFeatures[grep("mean()", AllFeatures$V2), ]), (AllFeatures[grep("std()", AllFeatures$V2), ]))

##4C Removing column names containing a text pattern meanFreq, X, Y, or Z
Finalfeatures <- Filteredfeatures[(grep("meanFreq|X|Y|Z", Filteredfeatures$V2, invert = TRUE)), ]

##4D Creating a variable ColumnsToUse that is a vector of column numbers to use for the analysis
ColumnsToUse <- Finalfeatures$V1

##4E Extracting columns corresponding to the names in the ColumnsToUse variable
## In addition, keeping the first two columns of the CompleteFile that correspond to VolunteerID and Activity
FilteredFile <- cbind (CompleteFile[[1]], CompleteFile[[2]], CompleteFile[, ColumnsToUse+2])

##5 Shortening and replacing column names
ShortColumnNames = c("tBodyAccMagMean", "tGravityAccMagMean", "tBodyAccJerkMagMean",
                    "tBodyGyroMagMean", "tBodyGyroJerkMagMean", "fBodyAccMagMean", 
                    "fBodyBodyAccJerkMagMean", "fBodyBodyGyroMagMean", 
                    "fBodyBodyGyroJerkMagMean", "tBodyAccMagStd", 
                    "tGravityAccMagStd", "tBodyAccJerkMagStd", "tBodyGyroMagStd", 
                    "tBodyGyroJerkMagStd", "fBodyAccMagStd", "fBodyBodyAccJerkMagStd",
                    "fBodyBodyGyroMagStd", "fBodyBodyGyroJerkMagStd") 
colnames(FilteredFile) <- c("VolunteerID", "Activity", ShortColumnNames)

##6 Generating a summary file that contains the mean values for each column
## while the data set is grouped by the Activity and VolunteerID. Column names are replaced with 
## longer, but descriptive variable names
grouping <- group_by(FilteredFile, Activity, VolunteerID)
FinalFile <- summarize(grouping, 
                       timeBodyAccMagnitudeMean = mean(tBodyAccMagMean, na.rm = TRUE),
                       timeGravityAccMagnitudeMean = mean(tGravityAccMagMean, na.rm = TRUE),
                       timeBodyAccJerkMagnitudeMean = mean(tBodyAccJerkMagMean, na.rm = TRUE),
                       timeBodyGyroMagnitudeMean = mean(tBodyGyroMagMean, na.rm = TRUE),
                       timeBodyGyroJerkMagnitudeMean = mean(tBodyGyroJerkMagMean, na.rm = TRUE),
                       frequencyBodyAccMagnitudeMean = mean(fBodyAccMagMean, na.rm = TRUE),
                       frequencyBodyBodyAccJerkMagnitudeMean = mean(fBodyBodyAccJerkMagMean, na.rm = TRUE),
                       frequencyBodyBodyGyroMagnitudeMean = mean(fBodyBodyGyroMagMean, na.rm = TRUE),
                       frequencyBodyBodyGyroJerkMagnitudeMean = mean(fBodyBodyGyroJerkMagMean, na.rm = TRUE),
                       timeBodyAccMagnitudeStd = mean(tBodyAccMagStd, na.rm = TRUE),
                       timeGravityAccMagnitudeStd = mean(tGravityAccMagStd, na.rm = TRUE),
                       timeBodyAccJerkMagnitudeStd = mean(tBodyAccJerkMagStd, na.rm = TRUE),
                       timeBodyGyroMagnitudeStd = mean(tBodyGyroMagStd, na.rm = TRUE),
                       timeBodyGyroJerkMagnitudeStd = mean(tBodyGyroJerkMagStd, na.rm = TRUE),
                       frequencyBodyAccMagnitudeStd = mean(fBodyAccMagStd, na.rm = TRUE),
                       frequencyBodyBodyAccJerkMagnitudeStd = mean(fBodyBodyAccJerkMagStd, na.rm = TRUE),
                       frequencyBodyBodyGyroMagnitudeStd = mean(fBodyBodyGyroMagStd, na.rm = TRUE),
                       frequencyBodyBodyGyroJerkMagnitudeStd = mean(fBodyBodyGyroJerkMagStd, na.rm = TRUE))

##7 Replacing Activity factors with descriptive variable names
FinalFile$Activity <- mapvalues(FinalFile$Activity, from = c("1", "2", "3", "4", "5", "6"), 
          to = c("walking", "walking_upstairs", "walking_downstairs", 
                 "sitting", "standing", "laying"))

##8 Exporting the tidy table. This table will be exported into working directory and named as FinalTable.txt
write.table(FinalFile, file = "FinalTable.txt", row.name = FALSE, sep = "\t")