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

# Input: 1). model_list: the logistic regression model you create with your ensemble list
#        2). df: the data frame you use to make prediction
#        3). index: the index you wanna try with this model (usually test & val index)
#        4). weight_list: the weight you get for each ensemble
# Return:1). ensemble_predictions: list of prediction (in probability) made 
#            with ensemble Logistic Regression model
emsemble_result_with_weight<-function(model_list,df,index,weight_list,target_treatment="none") {
  
  # Initialization
  prediction_val<-list()
  # Make prediction with each model and have them contribute differently based on weight
  for (i in 1:length(model_list)) {
    prediction_val[[i]]<-predict(model_list[[i]], df[index,], type="response")
    prediction_val[[i]]<-prediction_val[[i]]*weight_list[[i]]
  }
  
  # Calculate ensemble model's mean as final prediciton value
  # If no transformation occur, return original value
  # If transformation occured, return value that reversed back
  if (tolower(target_treatment)=="none") {
    ensemble_predictions<-Reduce("+",prediction_val)
  }
  else {
    ensemble_predictions<-Reduce("+",prediction_val)
    ensemble_predictions<-reverse_num(ensemble_predictions,target_treatment)
  }
  return(ensemble_predictions)
}
