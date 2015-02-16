## This function takes a directory of data files and a threshold for
## complete cases and calculates the correlation between sulfate and
## nitrate for monitor locations where the number of completely
## observed cases (on all variables) is greater than the threshold.
## It returns a vector of correlations for the monitors that meet
## the threshold requirement.  If no monitors meet the threshold
## requirement, then a numneric vecotr of length 0 is returned.
corr <- function(directory, threshold = 0) {
    result <- numeric()
    
    files <- list.files(directory, full.names = TRUE)
    
    complete_results <- complete(directory)
    monitors_with_enough_cases <- subset(complete_results, nobs > threshold)
    valid_monitors <- monitors_with_enough_cases[1]

    for (valid_monitor in valid_monitors$id) {
        
        current_file_data <- data.frame()
        current_file_data <- rbind(current_file_data, read.csv(files[valid_monitor]))
        
        complete_cases <- current_file_data[complete.cases(current_file_data),]
        cor_result <- cor(complete_cases[["nitrate"]], complete_cases[["sulfate"]])
        result <- append(result, cor_result)
    }

    result
}