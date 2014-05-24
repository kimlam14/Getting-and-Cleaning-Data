
#########################################
## Function to calculate the column means for a given set
#########################################

calculateColumnMean <- function (the_set,groups) {
    
    numeric_columns <- names(the_set) %in% groups
    
    
    res <- colMeans(the_set[,!numeric_columns],na.rm=TRUE)
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
## Merge x_train and x_test, y_train and y_test,subject_train and subject_test
#########################################
x <- rbind(x_train,x_test)
y <- rbind(y_train,y_test)
subject <- rbind(subject_train,subject_test)


#########################################
## Rename columns in data extracts
#########################################

## activity_labels, Activity code to description mapping
names(activity_labels) <- c("Activity Code","Activity Description")

## y = activity code, i.e. code for walking, sitting etc.
names(y) <- c("Activity Code")

## subject = subject number, i.e. person performing the test
names(subject) = c("Subject Number")

## x = features
names(x)<- features_column_names$cleaned_column_names


#########################################
## Filter x to only include measurement about mean and 
## standard deviation(std)
## Searching for the term "mean" include "meanFreq" as well. meanFreq is 
## calculated as the average frequency which can be understood as mean as well.
## Hence they have been included.
#########################################
features <- subset(x,select=grepl("mean|std",colnames(x)))

#########################################
## Stick subject and activity code to the feature lists
#########################################
features <- cbind(subject,y,features)


#########################################
## merge features with activity label
## already done checking that unique activity code are
## 1,2,3,4,5,6 which activity labels can cover.
#########################################
features <- merge(features,activity_labels,by=c("Activity Code"),all=FALSE,sort=FALSE)

# clean the description to get rid of the _. Replace with space
features$"Activity Description" <- gsub("_"," ",features$"Activity Description")


#########################################
## for each subject, each activity (i.e. walking, walking upstairs etc.)
## take average for every variable in the extract
#########################################

#for checking calculation and groupings
#test <- features[,c(1,2,3,4)]
#write.csv(test,file="test.csv")

result <-do.call(rbind,
    by( features[,!names(features) %in% "Activity Code"] 
        # take every column except activity code 
    ,features[,c("Subject Number","Activity Description")] 
        # group by subject number and activity
    ,calculateColumnMean
        ,groups=c("Subject Number","Activity Description")
   )
)

#########################################
## create a text file from the averaging result
#########################################
write.table(result,file="CleanedMean.txt",sep="\t",row.names=FALSE)

