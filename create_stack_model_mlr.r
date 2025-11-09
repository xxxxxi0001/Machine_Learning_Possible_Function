# Input: 1). df: data frame that you use to make prediction
#        2). target_col: that column that you want to make prediction for
#        3). test_index: the test index selected earlier
#        4). model_list: the list of ensemble model you made ealier
# Return:1). stack_model: stacked model you generate from ensemble models, which 
#            automatically gives how each model should contribute to the overall prediction
create_stack_model_mlr<-function (df,target_col,test_index,model_list) {
  
  # Create an empty stack_df with length of test_index
  stack_df<-data.frame(true_value=df[[target_col]][test_index])
  
  # For every model, make prediction with data set of test_index
  # and collect their result in stack_df in format of 
  # mi<-prediction value
  for (i in 1:length(model_list)) {
    stack_df[[paste0("model",i)]]<-predict(model_list[[i]],df[test_index,])
  }
  
  # Find relationship between true value and each predicted 
  # value that generated from each model
  # The stack model will automatically tells you how each model 
  # should contribute to the overall final prediction
  stack_model<-lm(true_value~., data=stack_df)
  return (stack_model)
}
