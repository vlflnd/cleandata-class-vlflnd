library(dplyr)

# Changes the "Activity" column type from numeric to factor according to
# labels defined in activity_labels.txt.
ApplyActivityFactor <- function(data) {
    activity_labels <- as.vector(read.table("activity_labels.txt", header = FALSE)$V2)
    data$Activity <- factor(sapply(data$Activity, function(a) { activity_labels[a] }))
    data
}

# Loads a single set of data (either test or training).
LoadSet <- function(directory, suffix) {
    x_name <- file.path(directory, paste("X_", suffix, ".txt", sep = ""))
    y_name <- file.path(directory, paste("y_", suffix, ".txt", sep = ""))

    subject = read.table(file.path(directory, paste("subject_", suffix, ".txt", sep = "")), header = FALSE)
    x = read.table(x_name, header = FALSE)
    y = read.table(y_name, header = FALSE)

    x_names <- as.vector(read.table("features.txt", header = FALSE)[,2])
    x_relevant_names <- x_names[grepl("mean\\(\\)|std\\(\\)", x_names)]

    names(subject) <- c("Subject")
    names(x) <- x_names
    names(y) <- c("Activity")

    x <- x[, x_relevant_names]

    cbind(x, y, subject)
}

# Loads and combines test and tranining data to a single data set.
LoadData <- function() {
    test <- LoadSet("test", "test")
    train <- LoadSet("train", "train")

    data <- rbind(test, train)
    ApplyActivityFactor(data)
}

# Aggregates the means of all the variables for each permutation of
# activity and subject.
AggregateData <- function(data = NULL) {
    if (is.null(data)) {
        data <- LoadData()
    }

    split_data <- split(data, list(data$Activity, data$Subject))
    agg <- data.frame()
    lapply(split_data, function(block) {
        row = c(colMeans(select(block, -(Activity:Subject))), Activity = block$Activity[[1]], Subject = block$Subject[[1]])
        agg <<- rbind(agg, row)
    })

    names(agg) <- names(data)
    ApplyActivityFactor(agg)
}
