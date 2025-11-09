# Machine Learning Possible Function Usage Guide

## Overview
This include how to use these function

## Key Functions
1.  check_na_zero
2.  replace_na_with_zero
3.  IQR_outlier
4.  kNN Imputation
      {initialize_distance_find_best_k | 
      initialize_not_na_index | 
      initialize_test_k_index | 
      find_best_k | 
      kNN_Imputation}
5.  check_mutilineariality
6.  three_set_partition
7.  three_set_partition_no_target
8.  ensemble_train_partition
9.  check_class_imbalance
10. backward_p_lr
11. backward_p_mlr
12. make_ensemble_predict
13. check_model_performance
14. find_best_threshold
15. ensemble_weight_F1
16. ensemble_weight_RMSE
          {reverse_num | 
          ensemble_weight_RMSE}          
17. emsemble_result_with_weight
18. create_stack_model_mlr
19. stack_test_mlr

## Technologies Used
- **R** 
- **R Markdown**
- **GitHub**

## Author
**Xi Zhang**  
📧 zhang.xi6@northeastern.edu  
📍 Northeastern University

## Required Packages
None


### Function 1. check_na_zero(df)
1. Purpose: Check to see if Data Frame has NA value 
2. Input: 1). Data Frame
3. Return: nothing, but will show if data frame has zero/NA value
4. Usage Example: 

`df<-read.csv(file="xxx.csv",header=TRUE,stringsAsFactors = TRUE)`

`check_na_zero(df)`

### Function 2. replace_na_with_zero(df,ignore_cols)
1. Purpose: Change zero values that considered as missing value into NA for later imputation
2. Input: 1). data frame with zero value 
          2). zero value that does not need to be changed into NA
3. Return:1). df: data frame with designated columns' zero value replaced into na
4. Usage Example:

`df<-replace_na_with_zero(df,ignore_cols=c("col1","col2"))`

### Function 3. IQR_outlier(df,variables)
1. Purpose: For not normally distributed feature, replace their outliers based on quartiles, act only on assigned features (variable)
2. Input: 1). df: Data Frame with Outliers
          2). variables: Features in Data Frame that need outlier Treatment
3. Return:1). df: return data frame with variables' outliers treated
4. Usage Example:

`variables<-c("col1","col2")`

`df<-IQR_outlier(df,variables)`

### Function 4. kNN Imputation
1. Purpose: Replace NA value with kNN Imputation (work on data set if their features could relate to each other)
2. Usage Example: 

`target_feature<-df$col_name`

`df_distance<-initialize_distance_find_best_k(df)`

`not_na_index<-initialize_not_na_index(target_feature)`

`test_k_index<-initialize_test_k_index(888,0.1,not_na_index)`

`smallest_k<-find_best_k(20,test_k_index,df_distance,not_na_index,target_feature)`

`df$col_name<-kNN_Imputation(df,smallest_k,target_feature,df_distance)`

       * Function 4.1 initialize_distance_find_best_k(df)
              Purpose: Get Euclidean Data Frame from features that does not have NA value for later imputation
              Input: 1). df: data frame that need to be treated
              Return:1). df_distance: the euclidean distance list that will be used
              Usage Example:

                     `df_distance<-initialize_distance_find_best_k(df)`
                     
       * Function 4.2 initialize_not_na_index(target_feature)
              Purpose: Get target features index that are not NA for find best k
              Input: 1). target_feature: specific feature that need to find not na value
              Return:1). not_na_index: target_feature's all index that are not na
              Usage Example:

                     `not_na_index<-initialize_not_na_index(target_feature)`

       * Function 4.3 initialize_test_k_index(seed_num,test_proportion,not_na_index)
              Purpose: From index that does not have NA value, randomly choose certain portion of data to test the best k for this feature
              Input: 1). seed_num: number you want to set seed for
                     2). test_proportion: proportion you want to select from not_na_index to test best k
                     3). not_na_index: the not_na_index you get from previous function
              Return:1).test_k_index: the index you wanna use to test best k
              Usage Example:

                     `test_k_index<-initialize_test_k_index(888,0.1,not_na_index)`
              
       * Function 4.4 find_best_k(max_k,test_k_index,df_distance,not_na_index,target_feature)
              Purpose: Use the index earlier to find the best k for this feature that give smallest error
              Input: 1). max_k: number of k you wanna test
                     2). test_k_index: the index you wanna use to test best k
                     3). df_distance: the euclidean distance matrix build before
                     4). not_na_index: the not_na_index you get from previous function
              Return:1). smallest_k used for kNN imputation
              Usage Example:

                     `smallest_k<-find_best_k(20,test_k_index,df_distance,not_na_index,target_feature)`
                     
       * Function 4.5 kNN_Imputation(df,smallest_k,target_feature,df_distance)
              Purpose: Use the best k perform kNN imputation
              Input: 1). df: data frame that need NA kNN imputation treatment
                     2). smallest_k: the best k calculate before
                     3). target_feature: specific column that need NA kNN imputation
                     4). df_distance: the euclidean distance matrix made before
              Return:1). target_feature: feature value that successfully imputated
              Usage Example:

                     `df$feature<-kNN_Imputation(df,smallest_k,target_feature,df_distance)`

### Function 5. check_mutilineariality(variables_df,threshold=0.8)
1. Purpose: Check multilineariality that will introduce bia to logistic regression model
2. Input: 1). variables_df: variables selected for multilineariality checking (has to be numerical)
3. Return:Nothing will return but will tell you what features are highly correlated
4. Usage Example:

`variables<-df_LR[,c("col1","col2")]`

`check_mutilineariality(variables)`

### Function 6. three_set_partition(df,seed_num, target_col, train_portion, test_portion,positive,negative)
1. Purpose: Randomly split data into designated training portion, test portion and the rest is validation portion with stratified split method which avoid class imbalance
2. Input: 1). df: data frame that used for partition
          2). seed_num: desired seeding number
          3). target_col: specific column that you don't want to fall in class
              imbalance (usually column used for prediction)
          4). train_portion: portion of data select for training
          5). test_portion: portion of data select for testing 
              (rest for validation)
          6). positive: target column's positive value
          7). negative: target column's negative value
3. Return:1). A list contain Training Index, Test Index & Validation Index
4. Usage Example:

`partition_result<-three_set_partition(df_encoded_LR,888,"DONATED",0.5,0.25)`

### Function 7. three_set_partition_no_target(df,seed_num, train_portion, test_portion)
1. Purpose: Randomly split data into designated training portion, test portion and the rest is validation portion.
2. Input: 1). df: data frame that used for partition
          2). seed_num: desired seeding number
          3). train_portion: portion of data select for training
          4). test_portion: portion of data select for testing 
            (rest for validation)
3. Return:1). A list contain Training Index, Test Index & Validation Index
4. Usage Example:

`partition_result<-three_set_partition_no_target(df_encoded,888,0.5,0.25)`

### Function 8. ensemble_train_partition(df,seed_num,train_index,sub_num,sub_portion)
1. Purpose: From training index, randomly selected designated number of ensemble data set with designated portion
2. Input: 1). df: data frame that used for training partition
          2). seed_num: desired seeding number
          3). train_index: the overall training index that you gonna selected from
          4). sub_num: number of ensemble list
          5). sub_portion: portion of overall training you want to select as sub-list
3. Return:1). A list contain sub_num number of training index
4. Usage Example:

`train_partitions_index<-ensemble_train_partition(df_encoded_LR,888,train_index_encoded,10,0.6)`

### Function 9. check_class_imbalance(df,index_list,target_col,positive,negative)
1. Purpose: Check if there is class imbalance happened in partitioned dataset (can handle list & numeric)
2. Input: 1). df: the data frame those index fall into
          2). index_list: the list of index you want to check if fall into class imbalance
          3). target_col: the column that used to check class imbalance 
          4). positive: positive value of target_col
          5). negative: negative value of target_col
3. Return: No Return, but will output result
4. Usage Example:

`check_class_imbalance(df_encoded_LR,train_partitions_index,"col_name",1,0)`

### Function 10. backward_p_lr(df,train_index,target_col,positive,positive_weight,negative_weight)
1. Purpose: Use ensemble data set train logistic regression model with backward p, that only keep important feature in model
2. Input: 1). df: the data frame those index fall into
          2). train_index: the index for ensemble/not ensemble train 
          3). target_col: the target column that need to be predicted
          4). positive: positive value of target_col
          5). positive_weight: if class imbalance within data set, add weight based on portion
          6). negative_weight: if class imbalance within data set, add weight based on portion 
3. Return:1). A list of trained emseble Logistic Model Based on List of Index you provide
4. Usage Example:

* For List of Models:

`positive_weight<-(positive_portion)/(negative_portion)`

`logistic_model_list<-backward_p_lr(df_encoded_LR,train_partitions_index,"col_name",1,positive_weight,1)`

* For Specific Model:

`one_set<-unlist(train_partitions_index[[1]])`

`logistic_model<-backward_p(df_encoded_LR,one_set,"col_name",1,positive_weight,1)`

### Function 11. backward_p_mlr(df,train_index,target_col)
1. Purpose: Train multiple linear regression model with backward p
2. Input: 1). df: the data frame those index fall into
          2). train_index: the index for ensemble/not ensemble train 
          3). target_col: the target column that need to be predicted
3. Return:1). A list of trained emseble Logistic Model Based on List of Index you provide
4. Usage Example:

`mlr_list<-backward_p_mlr(df_encoded,train_partition_index,"col_name")`


### Function 12. make_ensemble_predict(model_list,df,test_index)
1. Purpose: Use ensembled logistic regression model make prediction
2. Input: 1). model_list: list of logistic regression model
          2). df:  the data frame those index fall into
          3). test_index: the list of index for ensemble train
3. Return:1). Mean Prediction made by number of ensemble's logistic model
4. Usage Example:

`ensemble_predictions<-make_ensemble_predict(logistic_model_list,df_encoded_LR,test_index_encoded)`

### Function 13. check_model_performance(predict_prob, threshold, positive, negative, df, test_index, target_col)
1. Purpose: Calculate and output accuracy, tpr, tnr, F1 value to monitor model's performance
2. Input: 1). predict_prob: the prediction result (in probability/response)
          2). threshold: above what number is positive
          3). positive: target's positive value 
          4). negative: target's negative value
          5). df: the data frame you use to make prediction
          6). test_index: the index you select for test
          7). target_col: your target name 
3. Return:No return but will automatically give you how accurate your model is with accuracy, tpr, tnr, F1 value
4. Usage Example:

`check_model_performance(ensemble_predictions,0.5,1,0,df_encoded_LR,test_index_encoded,"col_name")`

### Function 14. find_best_threshold(predict_prob, df,test_index, target_col, positive, negative)
1. Purpose: Find the best threshold for this model to make a prediction with F1 value
2. Reminder: target must be numerical value
3. Input: 1). predict_prob: the prediction result (in probability/response)
          2). df: the data frame you use to make prediction
          3). test_index: the index you select for test
          4). target_col: your target name
          5). positive: target positive value
          6). negative: target negative value
4. Return:1). best F1 value
5. Usage Example:

`best_threshold<-find_best_threshold(ensemble_predictions,df_encoded_LR,test_index_encoded,"col_name",1,0)`

### Function 15. ensemble_weight_F1(logistic_model_list, df,test_index, best_threshold, target_col, positive, negative)
1. Purpose: Calculate each ensemble's weight for later tuning
2. Input: 1). logistic_model_list: the logistic regression model you create with your ensemble list
          2). df: the data frame you use to make prediction
          3). test_index: the index of 25% testing
          4). best_threshold: the best threshold you get after run function "find_best_threshold"
          5). target_col: the target column that need to make prediction
          6). positive: target positive value
          7). negative: target negative value
3. Return:1). Each Ensemble Model's Weight
4. Usage Example:

`weight_list<-ensemble_weight_F1(logistic_model_list,df_encoded_LR,test_index_encoded,best_threshold,"col_name",1,0)`

### Function 16. ensemble_weight_RMSE
1. Purpose: Use RMSE to define how each ensemble model should be weight
      * Function 16.1 reverse_num(x,treatment)
              Input: 1). x: the variable that's been or not been transformed
                     2). treatment: could be "log","sqrt","square","none"
              Return:1). Transform back original value
              Usage Example:

                    `real_value<-reverse_num(real_value,target_treatment)`
      * Function 16.2  ensemble_weight_RMSE(model_list,df,test_index,target_col,target_treatment)
              Input: 1). model_list: the list of ensemble model
                     2). df: data frame that you use to make prediction
                     3). test_index: the test index selected earlier
                     4). target_col: that column that you want to make prediction for
                     5). target_treatment: if target column has been transformed, what method it use
              Return:1). weight_list: how each model should contribute to overall prediction
              Usage Example:

              `weight_list<-ensemble_weight_RMSE(mlr_list,df_encoded,test_index,"col_name","log")`

### Function 17. emsemble_result_with_weight(logistic_model_list,df,index,weight_list)
1. Purpose: Try Emsembled Logistic Regression Model with different index (could be test & validation data set)
2. Input: 1). logistic_model_list: the logistic regression model you create with your ensemble list
          2). df: the data frame you use to make prediction
          3). index: the index you wanna try with this model (usually test & val index)
          4). weight_list: the weight you get for each ensemble
3. Return:1). ensemble_predictions: list of prediction (in probability) made with ensemble Logistic Regression model
4. Usage Example:

`emsemble_result_with_weight(logistic_model_list,df_encoded_LR,validation_index_encoded,weight_list)`

### Function 18. create_stack_model_mlr (df,target_col,test_index,model_list)
1. Purpose: Generate a stack model with ensemble linear regression model
2. Input: 1). df: data frame that you use to make prediction
          2). target_col: that column that you want to make prediction for
          3). test_index: the test index selected earlier
          4). model_list: the list of ensemble model you made ealier
3. Return:1). stack_model: stacked model you generate from ensemble models, which 
              automatically gives how each model should contribute to the overall prediction
4. Usage Example:

`stack_model<-create_stack_model_mlr(df_encoded,"col_name",test_index,mlr_list)`

### Function 19. stack_test_mlr (stack_model,model_list,df,validation_index,target_col,target_treatment)
1. Purpose: Use stack model make prediction with validation data set
2. Input: 1). stack_model: the stack model you build earlier with ensemble models
          2). model_list: the list of ensemble model you made ealier
          3). df: data frame that you use to make prediction
          4). validation_index: index used for validation purpose
          5). target_col: the feature you want to make prediction with
          6). target_treatment: if target has been transformed, what type? 
              accept "log","sqrt","square","none"
3. Return:1). prediction_value: stack model's predict value
          2). true_value: the actual value 
4. Print: 1). rmse: error between true value and prediction value
5. Usage Example:

`result<-stack_test_mlr(stack_model,mlr_list,df_encoded,validation_index,"col_name","log")`

`prediction_value<-result$prediction_value`

`true_value<-result$true_value`

