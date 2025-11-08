# Input: 1). df: the data frame those index fall into
#        2). index_list: the list of index you want to check if fall into class imbalance
#        3). target_col: the column that used to check class imbalance 
#        4). positive: positive value of target_col
#        5). negative: negative value of target_col
# Return: No Return, but will output result
check_class_imbalance<-function(df,index_list,target_col,positive,negative) {
  if (is.list(index_list)) {
    for (i in 1:length(index_list)) {
      index<-unlist(index_list[[i]])
      t<-round(mean(df[[target_col]][index]==positive)*100,2)
      f<-round(mean(df[[target_col]][index]==negative)*100,2)
      cat("In partition",i, "of", deparse(substitute(index_list)),"There are", t, "donated people in training data set and",f,"not donated people in training data set.","\n")
    }
  }
  if (is.numeric(index_list)) {
    index<-unlist(index_list)
    t<-round(mean(df[[target_col]][index]==positive)*100,2)
    f<-round(mean(df[[target_col]][index]==negative)*100,2)
    cat("In",deparse(substitute(index_list)),"There are", t, "donated people in training data set and",f,"not donated people in training data set.","\n")
  }
}
