Getting-and-Cleaning-Data-course-project
========================================
The file CodeBook.md contains a description of the variables included in the dataset means.txt

The code in the file run_analysis.R downloads, cleans, reshapes and stores the Samsung data as required in the assignment. It performs the following steps:

- Load library for melting and casting the dataset later on
- unzip the data
- Read the test and train files. Assign feature names to column names for both test and training set. Link data to activity and subject labels, both for test and training set
- Create a file with the means of the measurements for each combination of subject and activity. 
- Store means as means.txt. This is the second tidy dataset required in step 5 which is also the one that will be uploaded.
