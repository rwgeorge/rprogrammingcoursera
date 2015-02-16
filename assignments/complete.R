## This function reads a directory full of files and reports the number
## of completely observerd cases in each data file.  It returns a data
## frame where the first column is the name of the file and the second
## is the number of complete cases in that file.
complete <- function(directory, id = 1:332) {
    files <- list.files(directory, full.names = TRUE)
    
    result <- data.frame()
    for (i in id) {
        all_data <- data.frame()
        all_data <- rbind(all_data, read.csv(files[i]))
        complete_cases <- all_data[complete.cases(all_data),]
        
        result <- rbind(result, c(i, length(complete_cases$Date)))
    }
    
    names(result) <- c("id", "nobs")
    result
}