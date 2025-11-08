# Input: 1). logistic_model_list: the logistic regression model you create with your ensemble list
#        2). df: the data frame you use to make prediction
#        3). index: the index you wanna try with this model (usually test & val index)
#        4). weight_list: the weight you get for each ensemble
# Return:1). ensemble_predictions: list of prediction (in probability) made 
#            with ensemble Logistic Regression model
get_emsemble_result<-function(logistic_model_list,df,index,weight_list) {
   prediction_val<-list()

  for (i in 1:length(logistic_model_list)) {
    prediction_val[[i]]<-predict(logistic_model_list[[i]], df[index,], type="response")
    prediction_val[[i]]<-prediction_val[[i]]*weight_list[[i]]
  }
  ensemble_predictions<-Reduce("+",prediction_val)
  return(ensemble_predictions)
}
