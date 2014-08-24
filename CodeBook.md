data/tidy_set.txt
=================

Output contains one row for each pair of activity and subject.
Columns:
activity - one of performed activities
subject - identifier of subject (person)

Rest of columns contain statistics all measruments for given (activity, subject) pair.
Columns *_mean_* contain mean value of all signals for given (activity, subject) pair.
Columns *_std_* contain mean value of standard deviation of all signals for given
(activity, subject) pair.
Columns *_X, *_Y and *_Z are splitted into 3D coordinates.
Columns starting with 't' contain data for time domain signals.
Columns starting with 'f' contain data for frequency domain signals.

There are following measurements in columns:
tBodyAcc
tGravityAcc
tBodyAccJerk
tBodyGyro
tBodyGyroJerk
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc
fBodyAccJerk
fBodyGyro
fBodyAccMag
fBodyBodyAccJerkMag
fBodyBodyGyroMag
fBodyBodyGyroJerkMag

Cleaning data
=============

Data is derived from original data shared by Samsung. There are following transformations
performed in run_analysis.R:
- training data set and testing data set are merged
- measurements are merged with subject numbers and performed activities
- activities are described in readable form
- only columns containing average value and standard deviation are retained, other columns
  are described
- columns are named based on features. Paranthesis are removed from labels and dashes
  are replaced with underscores
- finally all measurements for given (activity, subject) pair are grouped and their average
  is computed and stored in columns
