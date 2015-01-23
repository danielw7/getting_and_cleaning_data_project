# getting_and_cleaning_data_project
coursera project for course getting and cleaning data

The R script starts with reading the test set 'subject_test' and naming the column ('Person'). Then I read the x and y test set and merge the data in 'x_test' with subjects in 'subject_test' and activities in 'y_test'. I do the same for the training set.

Then I merge test and training sets using rbind(). I use the grep() function to subtract all columns with 'mean' or 'std' in the column names and merge them together with subjects and activities to a data set called 'reduced_data'.

After that, I changed the class of activities from integer to factor and renamed factor levels to 'walking', 'walking_upstairs',...  with the factor() function.

The last step was to create the tidy data set with the average of each variable for each activity and each subject. To achieve this, I used the dplyr package and the group_by() and summarise.each() functions. With write.table(), I stored my result as .txt.
