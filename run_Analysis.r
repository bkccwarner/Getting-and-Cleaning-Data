#Install needed package and libraries
install.packages("plyr")
install.packages("dplyr")
install.packages("data.table")
#install.packages("sqldf")
#library(sqldf)
library(data.table)
library(plyr)
library(dplyr)

#Get to working directory
setwd("C://Users//KathyWarner.KATHYSDESKTOP//Documents//R//Working//Coursera")

#Get the activity labels and features
setwd(".//CleaningData//UCI HAR Dataset")
activitylabels<-read.table("activity_labels.txt", sep="", header=FALSE)

features<-read.table("features.txt", sep="", header=FALSE)
names(features)


#Get the Training and Test datasets and Merge  into AllTrain

subjecttrain<-read.table("subject_train.txt", sep="", header=FALSE)
xtrain<-read.table("X_train.txt", sep="",header=FALSE)
ytrain<-read.table("y_train.txt", sep="",header=FALSE)

subjectest<-read.table("subject_test.txt", sep="", header=FALSE)
xtest<-read.table("X_test.txt", sep="",header=FALSE)
ytest<-read.table("y_test.txt", sep="",header=FALSE)



#Extract the feature names and put into a list
featureslist <- features[,2]
class(featureslist)
featureslist<-as.character(featureslist)

#Take out the special characters in the list
featureslist<-tolower(featureslist)
featureslist<-gsub("\\-|\\(|\\)|\\,","",featureslist)
featureslist<-gsub("^f","frequency",featureslist)
featureslist<-gsub("^t","time",featureslist)

#Add row names of feature file as columns in training and test data files
colnames(xtrain) <- featureslist
colnames(xtest)<-featureslist

#Merge the Activities with ytrain and ytest data sets

ytrain$Activity<-ifelse(ytrain$V1==1,"WALKING", 
                        ifelse(ytrain$V1==2,"WALKING_UPSTAIRS",
                               ifelse(ytrain$V1==3,"WALKING_DOWNSTAIRS",
                                      ifelse(ytrain$V1==4,"SITTING",
                                             ifelse(ytrain$V1==5,"STANDING", "LAYING")))))


names(ytrain)
ytrain$V1<-NULL
tail(ytrain,50)


ytest$Activity<-ifelse(ytest$V1==1,"WALKING", 
                       ifelse(ytest$V1==2,"WALKING_UPSTAIRS",
                              ifelse(ytest$V1==3,"WALKING_DOWNSTAIRS",
                                     ifelse(ytest$V1==4,"SITTING",
                                            ifelse(ytest$V1==5,"STANDING", "LAYING")))))
ytest$V1<-NULL
names(ytest)


#Add Activities column to training and test data set
xtrain<-cbind(ytrain,xtrain)
head(xtrain)

xtest<-cbind(ytest,xtest)
head(xtest)


#Add Subject number to the training and test data sets
colnames(subjecttrain)[1]<-"Subjects"
xtrain<-cbind(subjecttrain,xtrain)

colnames(subjectest)[1]<-"Subjects"
xtest<-cbind(subjectest,xtest)

#Combine the training and test datasets

alldata <- rbind(xtrain,xtest)
nrow(alldata)
names(alldata)


#Extract only the measurements on the mean and standard deviation for each measurement.
alldata1<-alldata[, grep("[Mm]ean|[Ss]td[^meanFreq]", names(alldata))] 
names(alldata1)
nrow(alldata1)
ncol(alldata1)


alldata2<-alldata[, c(1,2)]
nrow(alldata2)
ncol(alldata2)
names(alldata2)

tidydata<-cbind(alldata2,alldata1)
nrow(tidydata)
ncol(tidydata)

tidydata<-tbl_df(tidydata)
nrow(tidydata)
ncol(tidydata)
tail(tidydata[,1:2],100)
names(tidydata)

tidydata$Activity<-as.factor(tidydata$Activity)
class(tidydata$Activity)

tidydata$Subjects<-as.factor(tidydata$Subjects)
class(tidydata$Subjects)

tidydata1=tidydata%>%
        group_by(Activity,Subjects)%>%
        summarise_each(funs(mean),matches("mean|std"))





write.table(tidydata1, "tidydata1.txt", sep=",")



