# Input: 1). stack_model: the stack model you build earlier with ensemble models
#        2). model_list: the list of ensemble model you made ealier
#        3). df: data frame that you use to make prediction
#        4). validation_index: index used for validation purpose
#        5). target_col: the feature you want to make prediction with
#        6). target_treatment: if target has been transformed, what type? 
#            accept "log","sqrt","square","none"
# Return:1). prediction_value: stack model's predict value
#        2). true_value: the actual value 
# Print: 1). rmse: error between true value and prediction value
stack_test_mlr<-function (stack_model,model_list,df,validation_index,target_col,target_treatment) {
  
  stack_df_val<-data.frame(matrix(nrow=length(validation_index),ncol=0))
  
  for (i in 1:length(model_list)) {
    stack_df_val[[paste0("model",i)]]<-predict(model_list[[i]],df[validation_index,])
  }
  
  prediction_value<-predict(stack_model,newdata=stack_df_val)
  true_value<-df[[target_col]][validation_index]
  
  # Call `reverse_num` function, change them back to their original value
  prediction_value<-reverse_num(prediction_value,target_treatment)
  true_value<-reverse_num(true_value,target_treatment)
  
  rmse<-sqrt(mean((true_value-prediction_value)^2))
  
  cat("The rmse for stack model of these",length(model_list),"models is",rmse,".")
  
  return(list(
    prediction_value=prediction_value,
    true_value=true_value
  ))
}
