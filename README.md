# Machine Learning Possible Function Usage Guide

## Overview
This include how to use these function

## Key Functions
1. check_na_zero
2. replace_na_with_zero
3. IQR_outlier
4. kNN Imputation
5.   initialize_distance_find_best_k
6.   initialize_not_na_index
7.   initialize_test_k_index
8.   find_best_k
9.   kNN_Imputation
10. check_mutilineariality
11. three_set_partition
12. ensemble_train_partition
13. check_class_imbalance
14. backward_p
15. make_ensemble_predict
16. check_model_performance
17. find_best_threshold
18. ensemble_weight

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
Purpose: Check to see if Data Frame has NA value 
Input: 1). Data Frame
Return: nothing, but will show if data frame has zero/NA value
Usage Example: 

`df<-read.csv(file="xxx.csv",header=TRUE,stringsAsFactors = TRUE)`

`check_na_zero(df)`

### Function 2. replace_na_with_zero(df,ignore_cols)
Purpose: Change zero values that considered as missing value into NA for later imputation
Input: 1). data frame with zero value 
       2). zero value that does not need to be changed into NA
Return:1). df: data frame with designated columns' zero value replaced into na
Usage Example:

`df<-replace_na_with_zero(df,ignore_cols=c("col1","col2"))`

### Function 3. IQR_outlier(df,variables)
Purpose: For not normally distributed feature, replace their outliers based on quartiles, act only on assigned features (variable)
Input: 1). df: Data Frame with Outliers
       2). variables: Features in Data Frame that need outlier Treatment
Return:1). df: return data frame with variables' outliers treated
Usage Example:

`variables<-c("col1","col2")`

`df<-IQR_outlier(df,variables)`

### Function 4. kNN Imputation
Purpose: Replace NA value with kNN Imputation (work on data set if their features could relate to each other)
Usage Example: 

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

### Function 5. check_mutilineariality(variables_df)
Purpose: Check multilineariality that will introduce bia to logistic regression model
Input: 1). variables_df: variables selected for multilineariality checking (has to be numerical)
Return:Nothing will return but will tell you what features are highly correlated
Usage Example:

`variables<-df_LR[,c("col1","col2")]`

`check_mutilineariality(variables)`

### Function 6. three_set_partition(df,seed_num, target_col, train_portion, test_portion)
Purpose: Randomly split data into designated training portion, test portion and the rest is validation portion with stratified split method which avoid class imbalance
Input: 1). df: data frame that used for partition
       2). seed_num: desired seeding number
       3). target_col: specific column that you don't want to fall in class
           imbalance (usually column used for prediction)
       4). train_portion: portion of data select for training
       5). test_portion: portion of data select for testing 
           (rest for validation)
Return:1). A list contain Training Index, Test Index & Validation Index
Usage Example:

`partition_result<-three_set_partition(df_encoded_LR,888,"DONATED",0.5,0.25)`

### Function 7. ensemble_train_partition(df,seed_num,train_index,sub_num,sub_portion)
Purpose: From training index, randomly selected designated number of ensemble data set with designated portion
Input: 1). df: data frame that used for training partition
       2). seed_num: desired seeding number
       3). train_index: the overall training index that you gonna selected from
       4). sub_num: number of ensemble list
       5). sub_portion: portion of overall training you want to select as sub-list
Return:1). A list contain sub_num number of training index
Usage Example:

`train_partitions_index<-ensemble_train_partition(df_encoded_LR,888,train_index_encoded,10,0.6)`

### Function 8. check_class_imbalance(df,index_list,target_col,positive,negative)
Purpose: Check if there is class imbalance happened in partitioned dataset (can handle list & numeric)
Input: 1). df: the data frame those index fall into
       2). index_list: the list of index you want to check if fall into class imbalance
       3). target_col: the column that used to check class imbalance 
       4). positive: positive value of target_col
       5). negative: negative value of target_col
Return: No Return, but will output result
Usage Example:

`check_class_imbalance(df_encoded_LR,train_partitions_index,"col_name",1,0)`

### Function 9. backward_p(df,num_ensemble,train_index_list,target_col,positive,positive_weight,negative_weight)
Purpose: Use ensemble data set train logistic regression model with backward p, that only keep important feature in model
Input: 1). df: the data frame those index fall into
       2). num_ensemble: number of ensemble data set that used to train
       3). train_index_list: the list of index for ensemble train 
       4). target_col: the target column that need to be predicted
       5). positive: positive value of target_col
       6). positive_weight: if class imbalance within data set, add weight based on portion
       7). negative_weight: if class imbalance within data set, add weight based on portion 
Return:1). A list of trained emseble Logistic Model Based on List of Index you provide
Usage Example:

`positive_weight<-(positive_portion)/(negative_portion)`

`logistic_model_list<-backward_p(df_encoded_LR,10,train_partitions_index,"col_name",1,positive_weight,1)`

### Function 10. make_ensemble_predict(num_ensemble,logistic_model_list,df,test_index)
Purpose: Use ensembled logistic regression model make prediction
Input: 1). num_ensemble: number of ensemble you create
       2). logistic_model_list: list of logistic regression model
       3). df:  the data frame those index fall into
       4). test_index: the list of index for ensemble train
Return:1). Mean Prediction made by num_ensemble's logistic model
Usage Example:

`ensemble_predictions<-make_ensemble_predict(10,logistic_model_list,df_encoded_LR,test_index_encoded)`

### Function 11. check_model_performance(predict_prob, threshold, positive, negative, df, test_index, target_col)
Purpose: Calculate and output accuracy, tpr, tnr, F1 value to monitor model's performance
Input: 1). predict_prob: the prediction result (in probability/response)
       2). threshold: above what number is positive
       3). positive: target's positive value 
       4). negative: target's negative value
       5). df: the data frame you use to make prediction
       6). test_index: the index you select for test
       7). target_col: your target name 
Return:No return but will automatically give you how accurate your model is with accuracy, tpr, tnr, F1 value
Usage Example:

`check_model_performance(ensemble_predictions,0.5,1,0,df_encoded_LR,test_index_encoded,"col_name")`

### Function 12. find_best_threshold(predict_prob, df,test_index, target_col, positive, negative)
Purpose: Find the best threshold for this model to make a prediction with F1 value
Reminder: target must be numerical value
Input: 1). predict_prob: the prediction result (in probability/response)
       2). df: the data frame you use to make prediction
       3). test_index: the index you select for test
       4). target_col: your target name
       5). positive: target positive value
       6). negative: target negative value
Return:1). best F1 value
Usage Example:

`best_threshold<-find_best_threshold(ensemble_predictions,df_encoded_LR,test_index_encoded,"col_name",1,0)`

### Function 13. ensemble_weight(num_ensemble, logistic_model_list, df,test_index, best_threshold, target_col, positive, negative)
Purpose: Calculate each ensemble's weight for later tuning
Input: 1). num_ensemble: the number of ensemble you create
       2). logistic_model_list: the logistic regression model you create with your ensemble list
       3). df: the data frame you use to make prediction
       4). test_index: the index of 25% testing
       5). best_threshold: the best threshold you get after run function "find_best_threshold"
       6). target_col: the target column that need to make prediction
       7). positive: target positive value
       8). negative: target negative value
Return:1). Each Ensemble Model's Weight
Usage Example:

`weight_list<-ensemble_weight(10,logistic_model_list,df_encoded_LR,test_index_encoded,best_threshold,"col_name",1,0)`

