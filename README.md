*GOAL*
=======
The goal of the project is to prepare tidy data that can be used for later analysis from an initial dataset from other experiment.

*SOURCE*
=========

The original information comes from this source:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

*DATASET INFORMATION*
=====================

The initial data is a subset of the Human Activity Recognition Using Smartphones Data Set ("UCI HAR Dataset" directory located in the working directory after downloaded from the source).

The experiments were carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

From the initial readings (not used in this project), a vector of features was obtained by calculating variables from the time and frequency domain.

From that original vector of features, the measurements on the mean and standard deviation for each measurement were extracted to get an initial tidy data set (r_train_test) with descriptive activity names and descriptive variable names.

Finally, from the "r_train_test" a second, independent tidy data set was created, "summary_average_table", with the average of each variable for each activity and each subject.


Check the CodeBook.md file for further details about the features.


*The dataset includes the following files:*


- 'README.md'

- 'CodeBook.md': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features from the original source.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.


*SCRIPT*
========

I include here the comments from the script, that shows how it works.

a)Prior to running the script you need to install the data.table. mgsub and plyr
packages for the script to run properly. I assume for this project that they
where previously installed so I only load the libraries here

b) Read the x and y data (X_train, y_train, X_test, y_test  )

c) Merge X and y train and test sets by column, maintaining all of them
  
d) merge x y train and test data by row (putting one set below the other)

e)Read the features file

f)Extract the columns from the feature vector,only containing the mean and 
standard deviation measures. To obtain this I use the grep function

h) With the columns obtained before we can gest a reduced data set that contains
the a first columns with the activity number and the other columns are the
variables that only have mean() and std() measurements
It needed to add one to the ex_columns vector because we included the activity
column at the beginning of the data set.

i) Read the activity labels file
  
j)Include descriptive activity names to name the activities in the data set.
For this I used the mgsub package and the mgsub function that allows to replace 
values in a column with a multiple string associated.

k)Appropriately labels the data set with descriptive variable names. For this
I used the names provided in the reduced. I used here the data.table package
that has the setnames function

l)From the tidy data set obtained before, an independent new
tidy data set was created with the average of each variable for each activity 
and each subject.For this I used the ddply from the plyr package that allows to get column wise 
summaries of information.

m)Change the variable names of the summary table to consider that they are the 
average of variable of the first tidy set. To do this I used the rename_at 
function from the dplyr package

n)Print the head of the output tidy data that needs to be submitted for the course project
  
o)Although not needed for the script. I added the a script line for creating the
txt file that we have to upload.





Notes: 
======
- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.
- Prior to running the script you need to install the data.table. mgsub and plyr
packages for the script to run properly. I assume for this project that they
where previously installed so I only load the libraries in it.
library(data.table)
library(mgsub)
library(plyr)
library(dplyr)