### Backward p-value for Logistic Regression Model (func)
```{r}
# Input: 1). df: the data frame those index fall into
#        2). train_index: the index for ensemble/not ensemble train 
#        3). target_col: the target column that need to be predicted
#        4). positive: positive value of target_col
#        5). positive_weight: if class imbalance within data set, add weight based on portion
#        6). negative_weight: if class imbalance within data set, add weight based on portion 
# Return:1). A list of trained emseble Logistic Model Based on List of Index you provide
backward_p_lr<-function (df,train_index,target_col,positive,positive_weight,negative_weight) {
    if (is.list(train_index)) {
          logistic_model<-list()
          for (i in 1:length(train_index)) {
      
            # Initialize Index of Training
            index<-unlist(train_index[[i]])
      
            # Initialize Model
            logistic_model[[i]]<-glm(as.formula(paste(target_col, "~ .")), data=df[index,], family=binomial, weights = ifelse(df[[target_col]][index] == positive, positive_weight, negative_weight))
      
            # Initialize Coefficient
            coeffecient<-summary(logistic_model[[i]])$coefficients
      
            # Initialize p-value list
            p_values<-coeffecient[-1,"Pr(>|z|)"]
    
            # If non-significant p appear, run in loop
            if (max(p_values)>0.05) {
      
              repeat {
      
              # Get significant features, rerun model and write over model with new model
              significant_feature<-names(p_values[p_values<0.05])
              string_features<-as.formula(paste(target_col, "~", paste(significant_feature,collapse="+")))
              logistic_model[[i]]<-glm(string_features,data=df[index,],family=binomial,weights=ifelse(df[[target_col]][index]== positive, positive_weight, negative_weight))
      
              # write over coefficient with important coefficient
              coeffecient<-summary(logistic_model[[i]])$coefficients
     
              # write over p-value with important p
              p_values<-coeffecient[-1,"Pr(>|z|)"]
      
              # if all p are good, end loop 
              if (max(p_values)<0.05) break
              
              if (all(is.na(p_values))) {
                cat("All p-values are NA, this model is not working")
                break
              }
            }
          }
        }
      }
    if (is.numeric(train_index)) {
    
      # Initialize Index of Training
      index<-train_index
      # Initialize Model
      logistic_model<-glm(as.formula(paste(target_col, "~ .")), data=df[index,], family=binomial, weights = ifelse(df[[target_col]][index] == positive, positive_weight, negative_weight))
      # Initialize Coefficient
      coeffecient<-summary(logistic_model)$coefficients
      # Initialize p-value list
      p_values<-coeffecient[-1,"Pr(>|z|)"]
    
        # If non-significant p appear, run in loop
        if (max(p_values)>0.05) {
      
          repeat {
      
            # Get significant features, rerun model and write over model with new model
            significant_feature<-names(p_values[p_values<0.05])
            string_features<-as.formula(paste(target_col, "~", paste(significant_feature,collapse="+")))
            logistic_model<-glm(string_features,data=df[index,],family=binomial,weights=ifelse(df[[target_col]][index]== positive, positive_weight, negative_weight))
      
            # write over coefficient with important coefficient
            coeffecient<-summary(logistic_model)$coefficients
     
            # write over p-value with important p
            p_values<-coeffecient[-1,"Pr(>|z|)"]
      
            # if all p are good, end loop 
            if (max(p_values)<0.05) break
            if (all(is.na(p_values))) {
                cat("All p-values are NA, this model is not working")
                break
            }
          }
        }
      }
  return(logistic_model)  
}
```
