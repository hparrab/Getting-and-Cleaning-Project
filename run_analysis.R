# Getting and Cleaning Data Course Project
# Prior to running the script you need to install the data.table. mgsub and plyr
# packages for the script to run properly. I assume for this project that they
# where previously installed so I only load the libraries here
library(data.table)
library(mgsub)
library(plyr)
library(dplyr)

# Read the x and y data (X_train, y_train, X_test, y_test  )

xtrain <- read.csv("./UCI HAR Dataset/train/X_train.txt", header = FALSE, sep = "")
ytrain <- read.csv("./UCI HAR Dataset/train/y_train.txt", header = FALSE)
xtest <- read.csv("./UCI HAR Dataset/test/X_test.txt", header = FALSE, sep = "")
ytest <- read.csv("./UCI HAR Dataset/test/y_test.txt", header = FALSE)

# merge X and y train and test sets by column, maintaining all of them
x_y_train <- cbind(ytrain, xtrain)
x_y_test <- cbind(ytest, xtest)

# merge x_y_train and test data by row (putting one set below the other)
train_test <- rbind(x_y_train, x_y_test)

# Read the features file
features <- read.csv("./UCI HAR Dataset/features.txt", header = FALSE, sep = "")

# Extract the columns from the feature vector,only containing the mean and 
#standard deviation measures. To obtain this I use the grep function
ex_columns <- c(grep("mean[:(:]|std[:(:]", features[,2]))

# With the columns obtained before we can gest a reduced data set that contains
# the a first columns with the activity number and the other columns are the
# variables that only have mean() and std() measurements
# It needed to add one to the ex_columns vector because we included the activity
# column at the beginning of the data set.
r_train_test <- train_test[, c(1,ex_columns+1)]

# read the activity labels file
activities <- read.csv("./UCI HAR Dataset/activity_labels.txt", header = FALSE, sep = "")

# Include descriptive activity names to name the activities in the data set.
# For this I used the mgsub package and the mgsub function that allows to replace 
# values in a column
# with a multiple string associated.
r_train_test[,1] <- mgsub(as.character(r_train_test[,1]), c("1","2","3","4","5","6"), activities[,2])

# Appropriately labels the data set with descriptive variable names. For this
# I used the names provided in the reduced. I used here the data.table package
# that has the setnames function
r_train_test <- setnames(r_train_test, old = names(r_train_test), new = c("activities",features[grep("mean[:(:]|std[:(:]", features[,2]),2]))

#From the tidy data set obtained before (r_train_test), an independent new
# tidy data set was created with the average of each variable for each activity 
# and each subject.
# For this I used the ddply from the plyr package that allows to get column wise 
# summaries of information.
summary_average_table <- ddply(r_train_test, "activities", colwise(mean))
# Change the variable names of the summary table to consider that they are the 
# average of variable of the first tidy set. To do this I used the rename_at 
# function from the dplyr package
summary_average_table <- summary_average_table  %>% rename_at(2:67, ~ paste("Average", ., sep = "(")) %>% rename_at(2:67, ~ paste0(., ")"))

# Prints the head of the output tidy data set (summary_average_table) submitted 
#for the course project
print(head(summary_average_table))

# Although not needed for the script. I added the a script line for creating the
# txt file that we have to upload.
write.table(summary_average_table, file = "./summary_average_table.txt", col.names = TRUE,  row.name=FALSE)

