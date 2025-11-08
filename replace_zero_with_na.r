# Input: 1). data frame with zero value 
#        2). zero value that does not need to be changed into NA
# Return:1). df: data frame with designated columns' zero value replaced into na
replace_na_with_zero<-function(df,ignore_cols) {
  for (i in 1:ncol(df)) {
  if (is.numeric(df[[i]]) && !(colnames(df)[i] %in% ignore_cols)){
      zero_count<-length(which(df[[i]] == 0))
      if (zero_count>0) {
      cat("Total", zero_count, "Zero value in column", colnames(df)[i],"has successfully changed into NA","\n")
      df[[i]][df[[i]]==0]<-NA
      }
    }
  }
 return(df) 
}
