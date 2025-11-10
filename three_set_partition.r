```{r}
# Input: 1). df: data frame that used for partition
#        2). seed_num: desired seeding number
#        3). target_col: specific column that you don't want to fall in class
#            imbalance (usually column used for prediction)
#        4). train_portion: portion of data select for training
#        5). test_portion: portion of data select for testing 
#            (rest for validation)
#        6). positive: target column's positive value
#        7). negative: target column's negative value
# Return:1). A list contain Training Index, Test Index & Validation Index
three_set_partition<-function(df,seed_num, target_col, train_portion, test_portion,positive,negative){
  
  # Set seed for repeat
  set.seed(seed_num)

  # Get positive/negative index
  donated_index<-which(df[[target_col]]==positive)
  not_donated_index<-which(df[[target_col]]==negative)

  # initialization for partition
  n_donated<-length(donated_index)
  n_n_donated<-length(not_donated_index)

  # Randomly selected 50% samples' index
  donated_train<-sample(donated_index,size=floor(train_portion*n_donated))
  n_donated_train<-sample(not_donated_index,size=floor(train_portion*n_n_donated))
  train_index_encoded<-c(donated_train,n_donated_train)
  # shuffle
  train_index_encoded<-sample(train_index_encoded)

  # Get rest index
  rest_dona_i<-setdiff(donated_index,donated_train)
  rest_n_dona_i<-setdiff(not_donated_index,n_donated_train)
  
  # For rest
  nr_dona<-length(rest_dona_i)
  nr_n_dona<-length(rest_n_dona_i)

  # choose 50% for testing
  test_num<-test_portion/(1-train_portion)
  donated_test<-sample(rest_dona_i,size=floor(test_num*nr_dona))
  n_donated_test<-sample(rest_n_dona_i,size=floor(test_num*nr_n_dona))
  test_index_encoded<-c(donated_test,n_donated_test)
  # shuffle
  test_index_encoded<-sample(test_index_encoded)

  # rest is validation
  donated_val<-setdiff(rest_dona_i,donated_test)
  n_donated_val<-setdiff(rest_n_dona_i,n_donated_test)
  validation_index_encoded<-c(donated_val,n_donated_val)
  # shuffle
  validation_index_encoded<-sample(validation_index_encoded)
  
  # Return train, test, validation index as a list
  return(list(
    train_index=train_index_encoded,
    test_index=test_index_encoded,
    validation_index=validation_index_encoded
  ))
}

```
