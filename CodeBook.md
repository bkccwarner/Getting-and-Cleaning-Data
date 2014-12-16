#Codebook

##Getting-and-Cleaning-Data
=========================


Experiments were carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person 
performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING). These 
activity names and their numeric representations, (1-6) respectively, are contained in a file named activity_labels.txt.

The training and test subjects' numeric activity representation are recorded in files with a 'y_' followed by either 
train (y_train.txt) or test (y_test.txt) representing each group. The y_test and y_train files are updated with the
activity names in the activity_labels.txt file that correspond to the activity numbers in the each dataset.

The experimental trial data for both the training and test subjects is contained in a files represented by 'x_' followed by
either train (x_train) or test (x_test).  Each subject had a series of 561 recorded features.  However, x_train and 
x_test datasets do not contain descriptive feature names.  The column of features are represented by variable names
V1-V561. 

The features.txt file contains the names of the features recorded for each subject in the experimental datasets of
x_train and x_test.  These variable names are used to update the x_train and x_test data set with feature names
instead of the V1-V561 place holder names.

A subject_train.txt and subject_test.txt file identifies the subject who performed the activity in the training and
test cohorts. Its range is from 1 to 30. The subject numbers are added to the x_train and x_test dataset as a new column
with the name **Subjects**.

The y_train and y_test activities are added to the x_train and x_test data sets as a new column with the name **Activity** 
and the training and test datasets are put together in one file.


The resulting dataset has feature variable names that use prefix 't' to denote time and prefix 'f' to denote frequency.  
For clarity, these prefixes are replaced with the more descriptive names of time and frequency.  Additionally, special 
characters including -, (, and ) are removed from each variable that contains them.  Features that represent the 
mean or the standard deviation are the only features of interest for this analysis.  Therefore, all other features are
removed from the dataset.

Finally, the average of all remaining features are taken.  These average are grouped by activity and subject. The 
result is written to a final dataset named tidydata1.txt.
