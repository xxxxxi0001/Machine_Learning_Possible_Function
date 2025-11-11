# Input: 1). df: data frame with zero value 
#        2). ignore_cols: zero value that does not need to be changed into NA
# Return:1). df: data frame with designated columns' zero value replaced into na
replace_zero_with_na<-function(df,ignore_cols) {
  
  # For only column that their zero value need to change into NA
  for (i in 1:ncol(df)) {
  if (is.numeric(df[[i]]) && !(colnames(df)[i] %in% ignore_cols)){
     
    # If their zero value is above 0, return result & change them into NA
    zero_count<-length(which(df[[i]] == 0))
    if (zero_count>0) {
      cat("Total", zero_count, "Zero value in column", colnames(df)[i],"has successfully changed into NA","\n")
      df[[i]][df[[i]]==0]<-NA
      }
    }
  }
 return(df) 
}
