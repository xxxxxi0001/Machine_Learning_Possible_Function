# Input: 1). df: data frame that used for partition
#        2). seed_num: desired seeding number
#        3). train_portion: portion of data select for training
#        4). test_portion: portion of data select for testing 
#            (rest for validation)
# Return:1). A list contain Training Index, Test Index & Validation Index
three_set_partition_no_target<-function(df,seed_num, train_portion, test_portion){
  
  # Set seed for repeat
  set.seed(seed_num)

  # Initialize total size
  n<-nrow(df)
  
  # Initialize train size
  train_size<-floor(n*train_portion)
  
  # Get Train Index
  train_index<-sample(1:n,size=train_size)
  
  # Get Rest Index
  rest_index<-setdiff(1:n, train_index)
  
  # From rest, get test_index
  nr<-length(rest_index)
  test_num<-test_portion/(1-train_portion)
  test_size<-nr*test_num
  test_index<-sample(rest_index,size=test_size)
  
  # Lest is validation
  validation_index<-setdiff(setdiff(1:n,train_index),test_index)
  
  # Return train, test, validation index as a list
  return(list(
    train_index=train_index,
    test_index=test_index,
    validation_index=validation_index
  ))
}

