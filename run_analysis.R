### Getting and cleaning data assignment ###

## test set
subject_test <- read.table('E:/Daniel/Coursera/Getting and Cleaning Data/assignment/UCI HAR Dataset/test/subject_test.txt',
                           header=F, sep="") # who performed the activity
colnames(subject_test) <- c('Person')
x_test <- read.table('E:/Daniel/Coursera/Getting and Cleaning Data/assignment/UCI HAR Dataset/test/x_test.txt',
                           header=F, sep="") # test data
y_test <- read.table('E:/Daniel/Coursera/Getting and Cleaning Data/assignment/UCI HAR Dataset/test/y_test.txt',
                     header=F) # label for activity
colnames(y_test) <- c('Activity')
column_names <- read.table('E:/Daniel/Coursera/Getting and Cleaning Data/assignment/UCI HAR Dataset/features.txt',
                           header=F)
# add colnames, persons and activity to test set
colnames(x_test) <- column_names[,2]
x_test <- cbind(x_test,subject_test)
x_test <- cbind(x_test, y_test)
head(x_test)
dim(x_test)

## training set
subject_train <- read.table('E:/Daniel/Coursera/Getting and Cleaning Data/assignment/UCI HAR Dataset/train/subject_train.txt')
colnames(subject_train) <- c('Person')
x_train <- read.table('E:/Daniel/Coursera/Getting and Cleaning Data/assignment/UCI HAR Dataset/train/x_train.txt')
y_train <- read.table('E:/Daniel/Coursera/Getting and Cleaning Data/assignment/UCI HAR Dataset/train/y_train.txt')
colnames(y_train) <- c('Activity')
# add colnames, persons and activity to test set
colnames(x_train) <- column_names[,2]
x_train <- cbind(x_train, subject_train)
x_train <- cbind(x_train, y_train)
head(x_train)
dim(x_train)

## merge test and training sets
full_data_set <- rbind(x_train, x_test)
head(full_data_set)
dim(full_data_set)

 ## extract columns with mean and std and name column 'Person' and 'Activity
data_mean <- full_data_set[,grep('mean',colnames(full_data_set))]
data_std <- full_data_set[,grep('std', colnames(full_data_set))]
dim(data_mean)
dim(data_std)
reduced_data <- cbind(full_data_set[,562], full_data_set[,563],data_mean, data_std)
colnames(reduced_data)[1] <- 'Person'
colnames(reduced_data)[2] <- 'Activity'
head(reduced_data)
dim(reduced_data)

## rename activities with names
class(reduced_data$Activity)
reduced_data$Activity <- as.factor(reduced_data$Activity)
attributes(reduced_data$Activity)
reduced_data$Activity <- factor(reduced_data$Activity, levels=c('1','2','3','4','5','6'),
                                labels=c('walking','walking_upstairs','walking_downstairs',
                                         'sitting','standing','laying'))
reduced_data[,2]
head(reduced_data)

## create a data set with the average of each variable for each activity and each subject
library(dplyr)
data_set_mean <- group_by(reduced_data, Person, Activity) %>% summarise_each(funs(mean))
dim(data_set_mean)
write.table(data_set_mean, file='E:/Daniel/Coursera/Getting and Cleaning Data/assignment/data_set_mean.txt', row.name=F)
