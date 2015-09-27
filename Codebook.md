---
title: Codebook.md
output: html_document
---

This is an R Markdown document called Codebook.md for the R script run_analysis.R. This R script will use the raw "Human Activity Recognition Using Smartphones" data stored in folder UCI HAR Dataset in the working directory and turn it into tidy data. 


History of the raw data set:
The raw data has been collected on a group of 30 volunteers within an age bracket of 19-49 years. Each person carried out six activities (walking, walking_upstairs, walking_downstairs, sitting, standing and laying) while wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz was captured. The experiments were video-recorded to label the data manually. The obtained dataset was randomly partitioned into two sets, where 70% of the volunteers were selected for generating the training data and 30% the test data. 
The three-dimensional sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.


Experimental design of R script run_analysis.R:
This R script "run_analysis.R"" calculates the mean of each variable grouping the data set according to the personal ID number of the volunteer (VolunteerID) and the activity performed (Activity). Only magnitude or Fast Fourier Transformed (FFT) values that were calculated based on the three-dimensional sensor signals are used for this analysis. 
Briefly, run_analysis.R uses the raw files in a folder UCI HAR Dataset stored the working directory and reads the required raw files in a table format. These files will be merged into a single data set. Only the columns containing measurements on the mean and standard deviation for each magnitude or FFT variable are extracted from the rest of the data. Finally, tidy data set is created by averaging each variable values grouping the data set according to the Activity and VolunteerID. 


Variable names:
Activity - activity performed while wearing the smartphone
VolunteerID - Personal code assingned to each volunteer
timeBodyAccMagnitudeMean - Mean of body linear acceleration magnitude mean (time domain feature)
timeGravityAccMagnitudeMean - Mean of the gravity linear acceleration magnitude mean (time domain feature)
timeBodyAccJerkMagnitudeMean - Mean of the body linear acceleration Jerk magnitude mean (time domain feature)
timeBodyGyroMagnitudeMean - Mean of the body angular velocity magnitude mean (time domain feature)
timeBodyGyroJerkMagnitudeMean - Mean of the body angular velocity Jerk magnitude mean (time domain feature)
frequencyBodyAccMagnitudeMean - Mean of the body linear acceleration magnitude mean (frequency feature)
frequencyBodyBodyAccJerkMagnitudeMean - Mean of the body body linear acceleration magnitude mean (frequency feature)
frequencyBodyBodyGyroMagnitudeMean - Mean of the body body angular velocity magnitude mean (frequency feature)
frequencyBodyBodyGyroJerkMagnitudeMean - Mean of the body body angular velocity Jerk magnitude mean (frequency feature)
timeBodyAccMagnitudeStd - Mean of body linear acceleration magnitude standard deviation (time domain feature)
timeGravityAccMagnitudeStd - Mean of the gravity linear acceleration magnitude standard deviation (time domain feature)
timeBodyAccJerkMagnitudeStd Mean of the body linear acceleration Jerk magnitude standard deviation (time domain feature)
timeBodyGyroMagnitudeStd - Mean of the body angular velocity magnitude standard deviation (time domain feature)
timeBodyGyroJerkMagnitudeStd - Mean of the body angular velocity Jerk magnitude standard deviation (time domain feature)
frequencyBodyAccMagnitudeStd - Mean of the body linear acceleration magnitude standard deviation (frequency feature)
frequencyBodyBodyAccJerkMagnitudeStd - Mean of the body body linear acceleration magnitude standard deviation (frequency feature)
frequencyBodyBodyGyroMagnitudeStd - Mean of the body body angular velocity magnitude standard deviation (frequency feature)
frequencyBodyBodyGyroJerkMagnitudeStd - Mean of the body body angular velocity Jerk magnitude standard deviation (frequency feature)

Variable units:
Variables Activity and VolunteerID are factors and do not have units. The rest of the variables have been normalised to the scale of [-1, 1], and are thus relative values and do not have units. 