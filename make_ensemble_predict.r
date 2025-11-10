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
