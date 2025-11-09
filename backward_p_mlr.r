# Input: 1). df: the data frame those index fall into
#        2). train_index: the index for ensemble/not ensemble train 
#        3). target_col: the target column that need to be predicted
# Return:1). A list of trained emseble Logistic Model Based on List of Index you provide
backward_p_mlr<-function (df,train_index,target_col) {
    if (is.list(train_index)) {
          regression_model<-list()
          for (i in 1:length(train_index)) {
      
            # Initialize Index of Training
            index<-unlist(train_index[[i]])
      
            # Initialize Model
            regression_model[[i]]<-lm(as.formula(paste(target_col, "~ .")), data=df[index,],na.action=na.omit)
      
            # Initialize Coefficient
            coeffecient<-summary(regression_model[[i]])$coefficients
      
            # Initialize p-value list
            p_values<-coeffecient[-1,"Pr(>|t|)"]
    
            # If non-significant p appear, run in loop
            if (max(p_values)>0.05) {
      
              repeat {
      
              # Get significant features, rerun model and write over model with new model
              significant_feature<-names(p_values[p_values<0.05])
              string_features<-as.formula(paste(target_col, "~", paste(significant_feature,collapse="+")))
              regression_model[[i]]<-lm(string_features,data=df[index,],na.action=na.omit)
      
              # write over coefficient with important coefficient
              coeffecient<-summary(regression_model[[i]])$coefficients
     
              # write over p-value with important p
              p_values<-coeffecient[-1,"Pr(>|t|)"]
      
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
      regression_model<-lm(as.formula(paste(target_col, "~ .")), data=df[index,],na.action=na.omit)
      # Initialize Coefficient
      coeffecient<-summary(regression_model)$coefficients
      # Initialize p-value list
      p_values<-coeffecient[-1,"Pr(>|t|)"]
    
        # If non-significant p appear, run in loop
        if (max(p_values)>0.05) {
      
          repeat {
      
            # Get significant features, rerun model and write over model with new model
            significant_feature<-names(p_values[p_values<0.05])
            string_features<-as.formula(paste(target_col, "~", paste(significant_feature,collapse="+")))
            regression_model<-lm(string_features,data=df[index,],na.action=na.omit)
      
            # write over coefficient with important coefficient
            coeffecient<-summary(regression_model)$coefficients
     
            # write over p-value with important p
            p_values<-coeffecient[-1,"Pr(>|t|)"]
      
            # if all p are good, end loop 
            if (max(p_values)<0.05) break
            if (all(is.na(p_values))) {
                cat("All p-values are NA, this model is not working")
                break
            }
          }
        }
      }
  return(regression_model)  
}
