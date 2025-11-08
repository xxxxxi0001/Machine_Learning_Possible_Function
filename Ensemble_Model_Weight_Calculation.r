# Input: 1). num_ensemble: the number of ensemble you create
#        2). logistic_model_list: the logistic regression model you create with your ensemble list
#        3). df: the data frame you use to make prediction
#        4). test_index: the index of 25% testing
#        5). best_threshold: the best threshold you get after run function "find_best_threshold"
#        6). target_col: the target column that need to make prediction
#        7). positive: target positive value
#        8). negative: target negative value
# Return:1). Each Ensemble Model's Weight
ensemble_weight<-function(num_ensemble, logistic_model_list, df,test_index, best_threshold, target_col, positive, negative) {
  
  # Initialize a list to store F1 value
  F1_list<-list()
  prediction_list<-list()
  
  # Loop over all ensemble model
  for (i in 1:num_ensemble) {
    
    # Make prediction with each model using test data set
    prediction_list[[i]]<-predict(logistic_model_list[[i]], df[test_index,], type="response")
    prediction<-ifelse(prediction_list[[i]] >= best_threshold,positive,negative)
    real_value<-df[[target_col]][test_index]
    
    # Calculate F1 with true value and predicted value and get it into list
    TP<-sum(prediction==positive&real_value==positive)
    FP<-sum(prediction==positive&real_value==negative)
    FN<-sum(prediction==negative&real_value==positive)
    precision<-TP/(TP+FP)
    recall<-TP/(TP+FN)
    F1<-2*(precision*recall)/(precision+recall)
    F1_list[[i]]<-F1
  }
  # Calculate weight and get it into list
  F1_vector<-unlist(F1_list)
  F1_weights<-F1_vector/sum(F1_vector)
  weight_list<-as.list(F1_weights)
  return(weight_list)
}
