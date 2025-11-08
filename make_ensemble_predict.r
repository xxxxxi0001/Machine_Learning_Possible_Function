# Input: 1). logistic_model_list: list of logistic regression model
#        2). df:  the data frame those index fall into
#        3). test_index: the list of index for ensemble train
# Return:1). Mean Prediction made by number of ensemble's logistic model
make_ensemble_predict<-function (logistic_model_list,df,test_index) {
  prediction_list<-list()
  for (i in 1:length(logistic_model_list)) {
    prediction_list[[i]]<-predict(logistic_model_list[[i]], df[test_index,], type="response")
  }
  ensemble_predictions<-Reduce("+",prediction_list)/length(logistic_model_list)
  return(ensemble_predictions)
}
