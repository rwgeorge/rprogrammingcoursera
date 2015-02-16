## This function calculates the mean of a pollutant (sulfate or nitrate) 
## accross a specified list of monitors.  It takes three arguments:
## direcotry: the directory where the data files are located.
## pollutant: a character vector of length 1 indicating the name
##            of the pollutant for which we will calculate the mean (sulfate or nitrae).
## id: an integer vector indicating which monitor data to use.
## The function returns the mean of the plooutant accross all monitors in the list (ignoring NA).
pollutantmean <- function(directory, pollutant, id = 1:332) {
    files <- list.files(directory, full.names = TRUE)
    
    all_data <- data.frame()
    for (i in id) {
        all_data <- rbind(all_data, read.csv(files[i]))  
    }
    
    if (pollutant == "nitrate") {
        result <- mean(all_data[, "nitrate"], na.rm = TRUE)  
    } else if (pollutant == "sulfate") {
        result <- mean(all_data[, "sulfate"], na.rm = TRUE)
    } else {
        sprintf("ERROR: the given pollutant must be nitrate or sulfate.")
    }
    
    round(result, 3)
}