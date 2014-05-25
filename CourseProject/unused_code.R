# Getting and Cleaning Data
# May 2014
# Course Project
#
# Additional unused code

# alternative way to analyze by taking the means 
# for each subject across all activities and
# and for each activity across all subjects

library(reshape)
mresults <- melt(results, id=c("subject.id","activity"))
subject.means <- cast(mresults, subject.id~variable, mean)
activity.means <- cast(mresults, activity~variable, mean)


## Verify row binding of datasets
#
identical(head(data.train),head(data))

identical(tail(data.test,n=1, addrownums = FALSE),             # BUG? can't suppress added row.names
         tail(data,n=1,addrownums = FALSE))

t1 <- tail(data.test, n=100, addrownums = FALSE)              # FIX BUG using row.names(t1) <- NULL
t2 <- tail(data, n=100, addrownums = FALSE)
row.names(t1) <- NULL
row.names(t2) <- NULL
identical(t1,t2)