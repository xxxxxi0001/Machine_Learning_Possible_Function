# Input: 1). stack_model: the stack model you build earlier with ensemble models
#        2). model_list: the list of ensemble model you made ealier
#        3). df: data frame that you use to make prediction
#        4). validation_index: index used for validation purpose
#        5). target_col: the feature you want to make prediction with
#        6). target_treatment: if target has been transformed, what type? 
#            accept "log","log1p","sqrt","square","none"
# Return:1). prediction_value: stack model's predict value
#        2). true_value: the actual value 
# Print: 1). rmse: error between true value and prediction value
stack_test_mlr<-function (stack_model,model_list,df,validation_index,target_col,target_treatment) {
  
  # Create an empty data frame with length of validation index
  stack_df_val<-data.frame(matrix(nrow=length(validation_index),ncol=0))
  
  # Input prediction value of each ensemble model made on validation index
  # in format of modeli<-prediction value
  for (i in 1:length(model_list)) {
    stack_df_val[[paste0("model",i)]]<-predict(model_list[[i]],df[validation_index,])
  }
  
  # Make prediction with stack model, each ensemble model contribute differently 
  # to the overall prediction, collect those value
  prediction_value<-predict(stack_model,newdata=stack_df_val)
  # Get their real value
  true_value<-df[[target_col]][validation_index]
  
  # Call `reverse_num` function if transformation occured
  # change them back to their original value
  if (tolower(target_treatment) != "none") {
    prediction_value<-reverse_num(prediction_value,target_treatment)
    true_value<-reverse_num(true_value,target_treatment)
  }
  
  # Calculate rmse based on prediction & real value & output result
  rmse<-sqrt(mean((true_value-prediction_value)^2))
  cat("The rmse for stack model of these",length(model_list),"models is",rmse,".")
  
  # Get prediction & true value for more possible testify like plot or cor
  return(list(
    prediction_value=prediction_value,
    true_value=true_value
  ))
}

# Input: 1). x: the variable that's been or not been transformed
#        2). treatment: could be "log","log1p","sqrt","square","none"
# Return:1). Transform back original value
reverse_num<-function(x,treatment) {
  if (tolower(treatment)=="log") {
    return(exp(x))
    }
  if (tolower(treatment)=="log1p") {
    return(exp(x)-1)
    }
  if (tolower(treatment)=="sqrt") {
    return(x^2)
    }
  if (tolower(treatment)=="square") {
    return(sqrt(x))
    }
  if (tolower(treatment)=="none") {
    return(x)
    }
}

