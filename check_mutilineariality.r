# Input: 1). variables_df: variables selected for multilineariality checking (has to be numerical)
# Return:Nothing will return but will tell you what features are highly correlated
check_mutilineariality<-function(variables_df) {
  cor_df<-as.data.frame(as.table(cor(variables_df,use="complete.obs")))

  # Remove Duplicated Rows
  remove_rows<-c()
  for (i in 1:nrow(cor_df)) {
    for (j in 1:nrow(cor_df)) {
      if (as.character(cor_df[i,1])==as.character(cor_df[j,2]) && as.character(cor_df[i,2]) == as.character(cor_df[j,1]) && i<j) {
        remove_rows<-c(remove_rows,j)
      }
    }
  }
  cor_df<-cor_df[-remove_rows, ]

  # Display Result
  for (i in 1:nrow(cor_df)) {
    if (abs(cor_df[i,3])>=0.8 & cor_df[i,1] != cor_df[i,2]) {
      cat("There is a strong correlational relationship (", round(as.numeric(cor_df[i,3]),2),") occur betewen",as.character(cor_df[i,1]),"and",as.character(cor_df[i,2]),".\n")
    }
  }
}
