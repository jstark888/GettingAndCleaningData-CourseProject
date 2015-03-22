run_analysis <- function(data_dir) {
  
  ## Set working directory to where the UCI HAR Dataset is
  setwd(data_dir)
  
  ## Read the activity labels
  activity_labels <- read.table("activity_labels.txt", sep="")
  ## Read the names of the features
  features <- read.table("features.txt",sep="")
  
  ## Read the test subject dataset
  test_subjects <- read.table("test/subject_test.txt",sep="")
  ## Read the test activity dataset
  test_y <- read.table("test/y_test.txt",sep="")
  ## Read the test features dataset
  test_x <- read.table("test/x_test.txt", sep="")
  
  ## Set the column name to 'subject' for test subject dataset
  names(test_subjects) <- "subject"
  
  ## Set the column name to 'activity' for the test activity dataset
  names(test_y) <- "activity"
  ## Make the activity column in the test activity dataset a column of factors
  test_y$activity <- as.factor(test_y$activity)
  ## Make the levels of the activity column in the test activity dastaset
  ## the activity labels
  levels(test_y$activity) <- as.character(activity_labels$V2)
  
  ## Set the column names of the test features dataset 
  ## to the names of the features
  names(test_x) <- features$V2
  
  ## Combine the test subject, activity and features dataset
  ## into a single test dataset
  test <- cbind(test_subjects,test_y,test_x)
  
  ## Recover some memory by removing objects that are no longer needed
  rm(test_subjects)
  rm(test_y)
  rm(test_x)
  
  ## Read the train subject dataset
  train_subjects <- read.table("train/subject_train.txt",sep="")
  ## Read the train activity dataset
  train_y <- read.table("train/y_train.txt",sep="")
  ## Read the train features dataset
  train_x <- read.table("train/X_train.txt", sep="")
  
  ## Set the column name to 'subject' for train subject dataset
  names(train_subjects) <- "subject"
  
  ## Set the column name to 'activity' for the train activity dataset
  names(train_y) <- "activity"
  ## Make the activity column in the train activity dataset a column of factors
  train_y$activity <- as.factor(train_y$activity)
  ## Make the levels of the activity column in the train activity dastaset
  ## the activity labels
  levels(train_y$activity) <- as.character(activity_labels$V2)
  
  ## Set the column names of the train features dataset 
  ## to the names of the features
  names(train_x) <- features$V2
  
  ## Combine the train subject, activity and features dataset
  ## into a single train dataset
  train <- cbind(train_subjects,train_y,train_x)
  
  ## Recover some memory by removing objects that are no longer needed
  rm(train_subjects)
  rm(train_y)
  rm(train_x)
  
  ## Combine the test and train datasets into a single complete dataset
  complete_data <- rbind(test, train)
  
  ## Recover some memory by removing objects that are no longer needed
  rm(test)
  rm(train)
  
  ## Get the names of all the columns that have 'mean' in their name
  mean_col_names <- colnames(complete_data)[grepl("mean[()]",colnames(complete_data))]
  ## Get the names of all the columns that have 'std' in their name
  std_col_names <- colnames(complete_data)[grepl("std[()]",colnames(complete_data))]
  ## Create a data frame with only the subject, activity, mean and std values
  mean_and_std <- complete_data[c("subject", "activity", mean_col_names, std_col_names)]
  
  ## Recover memory
  rm(complete_data)
  
  ## Prepare to aggregate the data by creating a data frame that will be an argument
  ## to the aggregate function and only includes the mean and std columns
  ## so that the subject and activity columns don't get averaged
  temp_for_agg <- mean_and_std[,3:ncol(mean_and_std)]
  
  ## Aggregate by subject and activity applying the mean function
  mean_and_std_by_subject_and_activity <- aggregate(temp_for_agg,list(mean_and_std$subject,mean_and_std$activity),FUN=mean,na.rm=TRUE)
  
  ## Recover memory
  rm(temp_for_agg)
  
  ## Set column name of first column in aggregated dataset to "subject"
  names(mean_and_std_by_subject_and_activity)[1] = "subject"
  ## Set column name of second column in aggregated dataset to "activity"
  names(mean_and_std_by_subject_and_activity)[2] = "activity"
  ## Order dataset by subject
  mean_and_std_by_subject_and_activity_ordered <- mean_and_std_by_subject_and_activity[order(mean_and_std_by_subject_and_activity$subject),]
  
  ## Recover memory
  rm(mean_and_std_by_subject_and_activity)
  
  ## Write dataset to file
  write.table(mean_and_std_by_subject_and_activity_ordered, file="MeanAndStdBySubjectAndActivity.txt",row.name=FALSE)

}