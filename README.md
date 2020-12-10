# coursera-getting-and-cleaning-data-project
This repository is a **Thet Lwin** submission for Getting and Cleaning Data course project. 

##Dataset
The data for the project is from [UCI Maching Learning Repository](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

##Files
* `CodeBook.md` a code book that describes the variables and the data
* `run_analysis.R`does the following:
   * Download the dataset
   * Load the activity and feature info,the training and test datasets
   * Merge training and testing datasets to respectively
   * Attain the columns with mean and standard deviation
   * Convert the observation in activity column to to its corresponding name
   * Labels the data with descriptive variable names
   * Create asecond,independent tidy data set with the average of each variable for each activity and each subject.
* `FinalTidyData.txt` is the exported final data after going through all the sequences described above.
