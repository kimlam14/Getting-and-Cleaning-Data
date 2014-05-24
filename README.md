Getting-and-Cleaning-Data
==================================================
## Background
This is a folder created for the course project of the Coursera course "Getting and Cleaning Data". The goal of the project is to clean a dataset provided using R and output an analysis file. The course project's data is collected in a project about wearable computing. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

## Data/Script files
There are few files within the respository:
* README.md (The current file)
* run_analysis.R
* CleanedMean.txt
* CodeBook.md

### run_analysis.R
This is a R script that reads the data provided, cleans it and produces analysis out from the raw data. The script does not have any dependency on any other R script.

In order for the script to locate the data, data collected from the link above has to be unzipped and placed within the working directory of R. 

The script first cleans the data collected, then calculates the mean of measurements by subject and activity. Note that there are more than 500 measurements prsented in the original data. However, the scope of the Course project only requires those measurements that are related to mean or standard deviation. The analysis output will be written to a text file named "CleanedMean.txt" in the working directory.

### CleanedMean.txt
This is a tab delimited text file which contains the analysis result generated from the script run_analysis.R. It contains the mean of the extracted measurements. 

### CodeBook.md
This is a technical document that describes the variables, the data and any transformation of work performed within run_analysis.R.