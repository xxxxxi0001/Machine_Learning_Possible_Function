# Input: 1). df: data frame that you use to make prediction
#        2). target_col: that column that you want to make prediction for
#        3). test_index: the test index selected earlier
#        4). model_list: the list of ensemble model you made ealier
# Return:1). stack_model: stacked model you generate from ensemble models, which 
#            automatically gives how each model should contribute to the overall prediction
create_stack_model_lm<-function (df,target_col,test_index,model_list) {
  stack_df<-data.frame(true_value=df[[target_col]][test_index])
  for (i in 1:length(model_list)) {
    stack_df[[paste0("model",i)]]<-predict(model_list[[i]],df[test_index,])
  }
  stack_model<-lm(true_value~., data=stack_df)
  return (stack_model)
}
