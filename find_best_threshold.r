# Reminder: target must be numerical value
# Input: 1). predict_prob: the prediction result (in probability/response)
#        2). df: the data frame you use to make prediction
#        3). test_index: the index you select for test
#        4). target_col: your target name
#        5). positive: target positive value
#        6). negative: target negative value
# Return:1). best F1 value
find_best_threshold<-function (predict_prob,df,test_index,target_col,positive,negative) {
  
  # Get true value
  real_value<-as.numeric(df[[target_col]][test_index])
  # Initialize Threshold & F1 for later use
  best_threshold<--Inf
  largest_F1<--Inf
  
  # Loop over all possible threshold
  for (i in seq(0.01,0.99,by=0.01)) {
    
    # Make prediction based on threshold i
    prediction_result<-ifelse(predict_prob >= i,positive,negative)
    
    # Calculate threshold i's F1
    TP<-sum(prediction_result==positive&real_value==positive)
    FP<-sum(prediction_result==positive&real_value==negative)
    FN<-sum(prediction_result==negative&real_value==positive)
    precision<-ifelse(TP+FP==0, 0, TP/(TP+FP))
    recall<-ifelse(TP+FN==0, 0, TP/(TP+FN))
    F1<-ifelse(precision+recall==0, 0, 2*precision*recall/(precision+recall))
    
    # If F1 larger than any previous F1
    if (!is.na(F1) && F1>largest_F1){
      
      # update F1
      largest_F1<-F1
      
      # update threshold
      best_threshold<-i
    }
  }
  
  # Output results
  cat("The best threshold is", best_threshold, "and it gives largest F1",round(largest_F1,3),".")
  return(best_threshold)
}
