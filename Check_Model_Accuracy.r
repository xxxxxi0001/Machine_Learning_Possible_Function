# Input: 1). predict_prob: the prediction result (in probability/response)
#        2). threshold: above what number is positive
#        3). positive: target's positive value 
#        4). negative: target's negative value
#        5). df: the data frame you use to make prediction
#        6). test_index: the index you select for test
#        7). target_col: your target name 
# Return:No return but will automatically give you how accurate your model is with accuracy, tpr, tnr, F1 value
check_model_performance<-function (predict_prob,threshold,positive,negative,df,test_index,target_col) {
  
  prediction<-ifelse(predict_prob>=threshold,positive,negative)
  true_value<-df[[target_col]][test_index]
  
  TN<-sum(prediction==negative&true_value==negative)  
  TP<-sum(prediction==positive&true_value==positive)
  FP<-sum(prediction==positive&true_value==negative)
  FN<-sum(prediction==negative&true_value==positive)
  
  precision<-ifelse(TP+FP==0, 0, TP/(TP+FP))
  recall<-ifelse(TP+FN==0, 0, TP/(TP+FN))
  
  F1<-ifelse(precision+recall==0, 0, round(2*precision*recall/(precision+recall),2))
  accuracy<-round(((TP+TN)/(TP+TN+FP+FN))*100,2)
  tpr<-round((TP/(TP+FN))*100,2)
  tnr<-round((TN/(TN+FP))*100,2)

  cat("The accuracy for is", accuracy, "%. The True Positive Rate is ", tpr, "%. And the True Negative Rate is ", tnr, "% and the F1 score is", F1,".")
}
