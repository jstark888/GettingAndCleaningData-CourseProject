The dataset that was transformed is the Human Activity Recognition Using Smartphones Data Set from the University of California at Irving.

This dataset has subject, activity and feature variables (measurements and statistics) data tables split between test and training groups (prepared for machine learning analysis). Also included are tables for the activity and feature labels.

The subject tables have a column of subject identifiers (1 - 30), where each row in the column is for a particular measurement of the subject doing a particular activity.

The activity tables have a column of activity identifiers (1 - 6), where each row in the column is for a particulre measurement taken while a particular subject is performing the activity.

The features tables have columns for each measurement (561), where each row are the measurements taken for a particular subject peforming a particular activity at a particular time.

The activity labels table has the following labels: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, and LAYING.

The feature labels table has 561 labels each descriptively identifying a particular feature measurement. The document, features_info.txt, included in this repositorary, has details on what the features are.

The table returned by the script run_analysis.R is produced from the original dataset in the following way:

*Both the test and training subject tables are are given the descriptive column heading "subject".
*Both the test and training activity tables are given the description column heading "activity".
*Both the test and training activity tables are modified so that the activity identifiers are replaced with the corresponding activity label.
*Both the test and training feature variables tables are given descriptive column headings from the feature labels table.
*The test and training tables are merged into a single table.
*From the merged table those columns with mean and standard deviation data are selected to produce a new table.
*From this new table the average is taken of the data in each column, for each subject and activity, producing the final table that is returned.




