# Input: 1). data frame
# Return: nothing, but will show if data frame has zero/NA value
check_na_zero<-function(df){
  for (i in 1:ncol(df)) {
  if (is.numeric(df[[i]])){
      na_count <-sum(is.na(df[[i]]))
      if (na_count>0) {
      cat("There are total", na_count ,"NA value in column", colnames(df)[i],"\n")
      }
      
      zero_count<-length(which(df[[i]] == 0))
      if (zero_count>0) {
      cat("There are total", zero_count, "Zero value in column", colnames(df)[i], "\n")
      }
    }
  }
}
