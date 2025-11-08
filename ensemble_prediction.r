
# Input: 1). num_ensemble: number of ensemble you create
#        2). logistic_model_list: list of logistic regression model
#        3). df:  the data frame those index fall into
#        4). test_index: the list of index for ensemble train
# Return:1). Mean Prediction made by num_ensemble's logistic model
make_ensemble_predict<-function (num_ensemble,logistic_model_list,df,test_index) {
  prediction_list<-list()
  for (i in 1:num_ensemble) {
    prediction_list[[i]]<-predict(logistic_model_list[[i]], df[test_index,], type="response")
  }
  ensemble_predictions<-Reduce("+",prediction_list)/num_ensemble
  return(ensemble_predictions)
}
