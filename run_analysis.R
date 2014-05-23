
## 0. Read datas
features <- read.table("features.txt")
activity.labels <- read.table("activity_labels.txt")

X.train <- read.table("./train/X_train.txt")
Y.train <- read.table("./train/Y_train.txt")
subject.train <- read.table("./train/subject_train.txt")

X.test <- read.table("./test/X_test.txt")
Y.test  <- read.table("./test/Y_test.txt")
subject.test  <- read.table("./test/subject_test.txt")

## 1. Merges the training and the test sets to create one data set.
X.merged <- rbind(X.train, X.test)
features.name <-  features[,2]
colnames(X.merged) <- features.name

subject.merged <- rbind(subject.train, subject.test)
X.merged <- cbind(X.merged, subject.merged)
colnames(X.merged)[length(X.merged)] <- "subject"


## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
extracted.name<-as.vector(NULL)

for(i in 1:length(features.name)){
      if(grepl("Freq", features.name[i])) {} # to exclude meanFreq
      
      else if(grepl("mean", features.name[i]) | 
           grepl("std", features.name[i]) )
      {extracted.name<-cbind(extracted.name, i)}
}

X.extracted <- X.merged[,c(extracted.name, length(X.merged))]


## 3. Uses descriptive activity names to name the activities in the data set
Y.merged<-rbind(Y.train, Y.test)
XY.merged<-cbind(X.extracted, Y.merged)
colnames(XY.merged)[length(XY.merged)] <- "activity"


## 4. Appropriately labels the data set with descriptive activity names. 
XY.merged$activity[XY.merged$activity==1] <- "WALKING"
XY.merged$activity[XY.merged$activity==2] <- "WALKING_UPSTAIRS"
XY.merged$activity[XY.merged$activity==3] <- "WALKING_DOWNSTAIRS"
XY.merged$activity[XY.merged$activity==4] <- "SITTING"
XY.merged$activity[XY.merged$activity==5] <- "STANDING"
XY.merged$activity[XY.merged$activity==6] <- "LAYING"


## 5. Creates a second, independent tidy data set with the average of each variable 
## for each activity and each subject. 

library(reshape2)

XY.melted <- melt(XY.merged, id=c("subject", "activity"), na.rm=TRUE)
Result.project <- dcast(XY.melted, subject + activity ~ variable, fun.aggregate=mean)

write.table(Result.project, file="HAR mean summary.txt", sep="\t")
