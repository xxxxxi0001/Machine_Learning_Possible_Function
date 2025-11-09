# Input: 1). x: the variable that's been or not been transformed
#        2). treatment: could be "log","sqrt","square","none"
# Return:1). Transform back original value
reverse_num<-function(x,treatment) {
  if (treatment=="log") return(exp(x))
  if (treatment=="sqrt") return(x^2)
  if (treatment=="square") return(sqrt(x))
  if (treatment=="none") return(x)
}

# Input: 1). model_list: the list of ensemble model
#        2). df: data frame that you use to make prediction
#        3). test_index: the test index selected earlier
#        4). target_col: that column that you want to make prediction for
#        5). target_treatment: if target column has been transformed, what method it use
# Return:1). weight_list: how each model should contribute to overall prediction
ensemble_weight_RMSE<-function(model_list,df,test_index,target_col,target_treatment="none") {
  
  # Initialization
  prediction<-list()
  rmse<-numeric(length(model_list))
  weight_list<-numeric(length(model_list))
  rmse_total<-0
  
  # For each model, make prediction with test index & get their 
  # original value with function `reverse_num`
  # Then use original value calculate rmse & rmse total for 
  # later weight calculation
  for (i in 1:length(model_list)) {
    prediction[[i]]<-predict(model_list[[i]],df[test_index,])
    real_value<-df_encoded[[target_col]][test_index]
    prediction_value<-prediction[[i]]
    
    real_value<-reverse_num(real_value,target_treatment)
    prediction_value<-reverse_num(prediction_value,target_treatment)
    
    rmse[i]<-sqrt(mean((real_value-prediction_value)^2))
    cat("The model",i,"'s RMSE is",round(rmse[i],3),"\n")
    
    rmse_total<-rmse[i]+rmse_total
  }
  
  # Calculate weight and output result
  weight_list<-(1/rmse^2)/sum(1/rmse^2)
  cat("Each of their weight are",round(as.numeric(weight_list),3),".")
  
  # Return weight for later use
  return(as.list(weight_list))
}
