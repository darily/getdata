run_analysis <- function() {
  
  # Load library for melting and casting the dataset later on
  library(reshape2)
  zip_file_name = 'getdata-projectfiles-UCI HAR Dataset.zip'
  unzip(zip_file_name)
  
  # Read the test and train files. Assign feature names to column names for both test and training set. Link data to activity and subject labels, both for test and training set
  test<-read.csv('UCI HAR Dataset/test/X_test.txt',header=F,sep='')
  names(test)<-read.csv('UCI HAR Dataset/features.txt',header=F,sep='')[,2]
  test$activity<-read.csv('UCI HAR Dataset/test/y_test.txt',header=F)[,1]
  test$subject<-read.csv('UCI HAR Dataset/test/subject_test.txt',header=F)[,1]
  
  train<-read.csv('UCI HAR Dataset/train/X_train.txt',header=F,sep='')
  names(train)<-read.csv('UCI HAR Dataset/features.txt',header=F,sep='')[,2]
  train$activity<-read.csv('UCI HAR Dataset/train/y_train.txt',header=F)[,1]
  train$subject<-read.csv('UCI HAR Dataset/train/subject_train.txt',header=F)[,1]
  
  # Create a new dataframe with the observations from both the test and train datasets, as required in step 1 (they are stored in a temporary dataframe for now and will be assigned to the new dataframe later on)
  tmp<-rbind(test,train)
  
  # Create a new dataframe with only the required variables and with descriptive variable names, as required in step 2 and 3/4
  newDf<-data.frame(tmp$activity,tmp$subject)
  names(newDf)<-as.vector(c('activity','subject'))
  for (i in 1:561){
    name<-names(tmp)[i]
    if(((grepl('mean()',name ) | grepl('std()',name)))&!grepl('meanFreq',name)){ # Only include the variables with mean and standard deviation
      newName=''
      if (substr(name,1,1)=='t'){
        newName<-paste0(newName,'Time')
      }
      if(substr(name,1,1)=='f'){
        newName<-paste0(newName,'Frequency')
      }
      if (grepl('Body',name)){
        newName<-paste(newName,'Body')
      }
      if (grepl('Gravity',name)){
        newName<-paste(newName,'Gravity')
      }
      if(grepl('Gyro',name)){
        newName<-paste(newName,'Gyroscope')
      }
      if(grepl('Acc',name)){
        newName<-paste(newName,'Accelerometer')
      }
      if(grepl('Jerk',name)){
        newName<-paste(newName,'Jerk')
      }
      if(grepl('Mag',name)){
        newName<-paste(newName,'Mag')
      }
      if(grepl('mean()',name)){
        newName<-paste(newName,'mean')
      }
      if(grepl('std',name)){
        newName<-paste(newName,'std')
      }
      if(grepl('X',name)){
        newName<-paste(newName,'X')
      }
      if(grepl('Y',name)){
        newName<-paste(newName,'Y')
      }
      if(grepl('Z',name)){
        newName<-paste(newName,'Z')
      }
      
      newDf[[newName]]<-tmp[[name]]
    }
  }
    
  # Create a file with the means of the measurements for each combination of subject and activity. 
  melt<-melt(newDf,id=c('activity','subject'))
  means<-dcast(melt,activity+subject~variable,mean)
  for (i in 3:68){
    names(means)[i]<-paste(names(means)[i],'- mean')
  }
  
  # Store means as means.txt. This is the second tidy dataset required in step 5 which is also the one that will be uploaded.
  write.table(means, 'means.txt', row.names=FALSE)
}