# Input: 1). model_list: list of logistic regression model
#        2). df:  the data frame those index fall into
#        3). test_index: the list of index for ensemble train
#        4). target_treatment: if target feature is transformed in feature transformation
# Return:1). Mean Prediction made by number of ensemble's logistic model
make_ensemble_predict<-function (model_list,df,test_index,target_treatment="none") {
  
  # Initialization
  prediction_list<-list()
  
  # For each model in ensemble model, make prediction
  for (i in 1:length(model_list)) {
    prediction_list[[i]]<-predict(model_list[[i]], df[test_index,], type="response")
  }
  
  #  & calculate mean
  ensemble_predictions<-Reduce("+",prediction_list)/length(model_list)
  
  # check if transformation occured or not
  if (tolower(target_treatment)!="none") {
    ensemble_predictions<-reverse_num(ensemble_predictions)
  }
  
  return(ensemble_predictions)
}
