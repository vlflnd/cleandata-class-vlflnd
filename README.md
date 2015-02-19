Course Project: Getting and Cleaning Data
=========================================

Input
-----
Samsung data set needs to be available in the working directory. For details please see http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones.


Execution
---------
The script ("run_analysis.R") has two main methods:
* LoadData()
* AggregateData()

LoadData() loads the Samsung data set into a single data frame according to the course assignment. AggregateData() aggregates the data by activity and subject. AggregateData() has an optional parameter of data, which has to be the output of LoadData(). If not specified, AggregateData() will load the data using LoadData().

The run the script:

source("run_analysis.R")

data <- LoadData()

AggregateData(data)

Code Book
-------------------
See CodeBook.md for details about the output of AggregateData() transformation.
