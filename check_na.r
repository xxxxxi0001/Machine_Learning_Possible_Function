# Input: 1). df: data frame
# Return: nothing, but will show if data frame has zero/NA value
check_na_zero<-function(df){
  
  # Ignore non-numerical column
  for (i in 1:ncol(df)) {
  if (is.numeric(df[[i]])){
    
    # Count NA, if appear, show which column has NA
    na_count <-sum(is.na(df[[i]]))
    if (na_count>0) {
      cat("There are total", na_count ,"NA value in column", colnames(df)[i],"\n")
      }
    
    # Count zero value, if appear, show which column has zero value
    zero_count<-length(which(df[[i]] == 0))
    if (zero_count>0) {
      cat("There are total", zero_count, "Zero value in column", colnames(df)[i], "\n")
      }
    }
  }
}
