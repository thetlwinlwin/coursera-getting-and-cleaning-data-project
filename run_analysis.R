library(dplyr)
fileUrl <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
fileName <- 'rawData.zip'
download.file(fileUrl,fileName)

#unzip the zip file
unzip(fileName)

#load labels and features
Dir <- 'UCI HAR Dataset'
activity_label <- read.table(paste0(Dir,'/activity_labels.txt'),col.names = c('factor','activity'))
features <- read.table(paste0(Dir,'/features.txt'))
colnames(features)<-c('n','functions')
sub_test <- read.table(paste0(Dir,'/test/subject_test.txt'))
colnames(sub_test) <-'subject'
x_test <-read.table(paste0(Dir,'/test/X_test.txt'))
colnames(x_test) <-features$functions
y_test <-read.table(paste0(Dir,'/test/y_test.txt'),col.names = 'code')
sub_train <-read.table(paste0(Dir,'/train/subject_train.txt'),col.names = 'subject')
x_train<-read.table(paste0(Dir,'/train/X_train.txt'))
colnames(x_train)<-features$functions
y_train<-read.table(paste0(Dir,'/train/y_train.txt'))
colnames(y_train)<-'code'
head(y_train)


#merging the data
X <- rbind(x_train,x_test)
Y <- rbind(y_train,y_test)

#checking the number of rows
dim(x_train)[1]+dim(x_test)[1] == dim(X)[1]
dim(X)[2] == dim(x_train)[2] & dim(X)[2] == dim(x_test)[2]


Sub <- rbind(sub_train,sub_test)
mergeData <- cbind(Sub,Y,X)
length(names(mergeData))

#getting mean and std out from merged dataset
tidyingData <- mergeData%>% select(subject,code,contains('mean'),contains('std'))
length(names(tidyingData))

#activity names to name the activites in dataset
tidyingData$code <- activity_label[tidyingData$code,2]
table(tidyingData$code)

#labels the data with descriptive variable names
names(tidyingData)[2] = 'activity'
names(tidyingData)<-gsub('Acc',"Accelerometer",names(tidyingData))
names(tidyingData)<-gsub("Gyro", "Gyroscope", names(tidyingData))
names(tidyingData)<-gsub("BodyBody", "Body", names(tidyingData))
names(tidyingData)<-gsub("Mag", "Magnitude", names(tidyingData))
names(tidyingData)<-gsub("^t", "Time", names(tidyingData))
names(tidyingData)<-gsub("^f", "Frequency", names(tidyingData))
names(tidyingData)<-gsub("tBody", "TimeBody", names(tidyingData))
names(tidyingData)<-gsub("-mean()", "Mean", names(tidyingData), ignore.case = TRUE)
names(tidyingData)<-gsub("-std()", "STD", names(tidyingData), ignore.case = TRUE)
names(tidyingData)<-gsub("-freq()", "Frequency", names(tidyingData), ignore.case = TRUE)
names(tidyingData)<-gsub("angle", "Angle", names(tidyingData))
names(tidyingData)<-gsub("gravity", "Gravity", names(tidyingData))


#creating 2nd independent tidy data set with avg of each variable for each activity
finalData <- tidyingData%>%
  group_by(subject,activity)%>%
  summarise_all(list(mean= mean))
write.table(finalData,"FinalTidyData.txt",row.names= FALSE)
head(finalData)
