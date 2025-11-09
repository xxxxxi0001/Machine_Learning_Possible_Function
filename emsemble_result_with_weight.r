# Input: 1). model_list: the logistic regression model you create with your ensemble list
#        2). df: the data frame you use to make prediction
#        3). index: the index you wanna try with this model (usually test & val index)
#        4). weight_list: the weight you get for each ensemble
# Return:1). ensemble_predictions: list of prediction (in probability) made 
#            with ensemble Logistic Regression model
emsemble_result_with_weight<-function(model_list,df,index,weight_list) {
  
  # Initialization
  prediction_val<-list()
  # Make prediction with each model and have them contribute differently based on weight
  for (i in 1:length(model_list)) {
    prediction_val[[i]]<-predict(model_list[[i]], df[index,], type="response")
    prediction_val[[i]]<-prediction_val[[i]]*weight_list[[i]]
  }
  
  # Calculate ensemble model's mean as final prediciton value
  ensemble_predictions<-Reduce("+",prediction_val)
  return(ensemble_predictions)
}
