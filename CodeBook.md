Course Project CodeBook
==================================================

This is a technical document that describes the variables, the data and any transformation of work performed within run_analysis.R.

## Data

The data is collected in a project about wearable computing. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. 

Following is some description from the original project data:

<i>
"The features selected come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 
</i>

<i>
Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 
</i>

<i>
Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 
</i>

<i>
These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.
</i>

* Time domain
  * tBodyAcc.XYZ
  * tGravityAcc.XYZ
  * tBodyAccJerk.XYZ
  * tBodyGyro.XYZ
  * tBodyGyroJerk.XYZ
  * tBodyAccMag
  * tGravityAccMag
  * tBodyAccJerkMag
  * tBodyGyroMag
  * tBodyGyroJerkMag
* Frequency domain
  * fBodyAcc.XYZ
  * fBodyAccJerk.XYZ
  * fBodyGyro.XYZ
  * fBodyAccMag
  * fBodyAccJerkMag
  * fBodyGyroMag
  * fBodyGyroJerkMag

<i>  
The set of variables that were estimated from these signals are: 
</i>

* mean: Mean value
* std: Standard deviation
* mad(): Median absolute deviation 
* max(): Largest value in array
* min(): Smallest value in array
* sma(): Signal magnitude area
* energy(): Energy measure. Sum of the squares divided by the number of values. 
* iqr(): Interquartile range 
* entropy(): Signal entropy
* arCoeff(): Autorregresion coefficients with Burg order equal to 4
* correlation(): correlation coefficient between two signals
* maxInds(): index of the frequency component with largest magnitude
* meanFreq(): Weighted average of the frequency components to obtain a mean frequency
* skewness(): skewness of the frequency domain signal 
* kurtosis(): kurtosis of the frequency domain signal 
* bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
* angle(): Angle between to vectors.

<i>
Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:
</i>

* gravityMean
* tBodyAccMean
* tBodyAccJerkMean
* tBodyGyroMean
* tBodyGyroJerkMean
"

For the scope of this project, only measurements that are related to mean or standard deviations are included from the original data. 

In summary, each signals from the time domain will have the following variables estimated:
* mean: Mean value
* std: Standard deviation

Each signals from the frequency domain will have the following variables estimated:
* mean: Mean value
* std: Standard deviation
* meanFreq: Weighted average of the frequency components to obtain a mean frequency

The person whom the data was collected from was stored within the variable "Subject Number" while the variable "Activity Description" had the activity of the subject while data was collected.

The original dataset includes the inertial signals that generate the features described above. These signals have not been included in the analysis because they are just source to the features generated.

## run_analysis.R
The analysis steps are documented as below:

##### 1. Load data into R

There are 8 files involved, 6 for the measurements readings and 2 reference files. Each file is loaded into individual data frames in R.

### Reference file
There are two reference files. 
* features.txt: Contains the measurement names
* activity_labels.txt: Maps from activity code used in the measurement file to actual activity description.

### Measurement data
The measurement data is split into the training and testing group. Both groups have exactly the same file structure, each consists of the x_(test/train).txt, y_(test/train).txt and subject(test/train).txt.

* x_(test/train).txt: The features measurements per subject and activity
* y_(test/train).txt: The activity that the subject was undertaking when data was collected
* subject_(test/train).txt: The person whom data was collected from in each record

##### 2. Merge training and testing dataset

##### 3. Rename columns in the data extracts to meaningful column names

The column names follow the variable measurement names listed above. Brackets have been removed while hyphens (-) and commas(,) are replaced by a dot (.).

##### 4. Filter the data extracts such that only variables related to mean or standard deviation measurements are included

Note that in the Course project specification, the requirement specifies that variables on the mean and standard deviation of measurements are to be taken. Because meanFreq is the weighted average frequency, it is considered to have similar meaning as "mean". Therefore, it has been included in the project's scope as well. On the other hand, angle between mean vectors are not considered to be mean mathematically. Hence, angle variables have not been included.

##### 5. Combine the subject, activity code with the measurements

##### 6. Enrich the data with activity description by activity code

##### 7. Calculate the average per measurement by subject and by activity

##### 8. Output data to text file for upload

The output file is a tab-delimited file named CleanedMean.txt. It will be stored in the working directory.
