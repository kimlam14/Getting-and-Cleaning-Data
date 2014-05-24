#########################################
## Function to calculate the column means for a given set
#########################################

calculateColumnMean <- function (the_set,groups) {
    res <- colMeans(the_set[,-groups],na.rm=TRUE)
    res <- cbind(unique(the_set[,groups]),t(res))
    res
}



#########################################
## Load data in to extracts: one file one extract
## According to the README.txt file included in the dataset ( 
## "From each window, a vector of features was obtained by calculating variables
##  from the time and frequency domain. See 'features_info.txt' for more 
##  details."), files in the Inertial signals folder are just the sources to 
##  generate the vector of features. Hence, they are not required and will not
##  be loaded.
#########################################

################
## train set
################
x_train <- read.table("UCI HAR Dataset\\train\\X_train.txt")
y_train <- read.table("UCI HAR Dataset\\train\\y_train.txt") # Activity label,
    # whether it is walking, sitting, standing etc.
subject_train <- read.table("UCI HAR Dataset\\train\\subject_train.txt") # the
    # person whose data was collected in that row

################
## test set
################
x_test <- read.table("UCI HAR Dataset\\test\\X_test.txt")
y_test <- read.table("UCI HAR Dataset\\test\\y_test.txt") # Activity label,
# whether it is walking, sitting, standing etc.
subject_test <- read.table("UCI HAR Dataset\\test\\subject_test.txt") # the
# person whose data was collected in that row

################
## features.txt - for renaming the columns in x_test and x_train
################
features_column_names <- read.table("UCI HAR Dataset\\features.txt")
# clean the features name such that there is no (),replace - with _,
# and replace , with _
features_column_names$cleaned_column_names <- 
        gsub(pattern="-",replacement=".",features_column_names$V2)
features_column_names$cleaned_column_names <- 
        gsub(pattern="\\(|\\)",replacement = ""
             ,features_column_names$cleaned_column_names)            
features_column_names$cleaned_column_names <- 
    gsub(pattern=",",replacement = "."
         ,features_column_names$cleaned_column_names)            

# Naming convention: Start with "t" is time domain. Start with "f" is 
# frequency domain

################
## activity_labels.txt - the description for the activity code
################
activity_labels <- read.table("UCI HAR Dataset\\activity_labels.txt")

#########################################
## Rename columns in data extracts
#########################################

## activity_labels, Activity code to description mapping
names(activity_labels) <- c("Activity Code","Activity Description")

## y_test, y_train = activity code, i.e. code for walking, sitting etc.
names(y_test) <- c("Activity Code")
names(y_train) <- c("Activity Code")

## subject_test, subject_train = subject number, i.e. person performing the test
names(subject_test) = c("Subject Number")
names(subject_train) = c("Subject Number")

## x_test, x_train
names(x_test) <- features_column_names$cleaned_column_names
names(x_train) <- features_column_names$cleaned_column_names    


#########################################
## Filter x_test and x_train to only include measurement about mean and 
## standard deviation(std)
## Searching for the term "mean" include "meanFreq" as well. meanFreq is 
## calculated as the average frequency which can be understood as mean as well.
## Hence they have been included.
#########################################
feature_test <- subset(x_test,select=grepl("mean|std",colnames(x_test)))
feature_train <- subset(x_train,select=grepl("mean|std",colnames(x_train)))

#########################################
## merge y_test and y_train with activity label
## already done checking that unique activity code in y_test and y_train are
## 1,2,3,4,5,6 which activity labels can cover.
#########################################
y_test <- merge(y_test,activity_labels,by=c("Activity Code"),all=FALSE)
y_train <- merge(y_train,activity_labels,by=c("Activity Code"),all=FALSE)

# clean the description to get rid of the _. Replace with space
y_test$"Activity Description" <- gsub("_"," ",y_test$"Activity Description")
y_train$"Activity Description" <- gsub("_"," ",y_train$"Activity Description")

#########################################
## Stick subject and activity code to the feature lists
#########################################
feature_test <- cbind(subject_test,y_test,feature_test)
feature_train <- cbind(subject_train,y_train,feature_train)

#########################################
## combine the extracts into one dataset
#########################################
features <- rbind(feature_test,feature_train)


#########################################
## for each subject, each activity (i.e. walking, walking upstairs etc.)
## take average for every variable in the extract
#########################################

#for checking calculation and groupings
#test <- features[,c(1,2,3,4)]
#write.csv(test,file="test.csv")

result <-do.call(rbind,
    by( features[,-c(2)] # take every column except activity code 
    ,features[,c(1,3)] # group by subject number and activity code
    ,calculateColumnMean
        ,groups=c(1,2)
   )
)


#########################################
## create a text file from the averaging result
#########################################
write.table(result,file="cleaned_average.txt",sep="\t",row.names=FALSE)


