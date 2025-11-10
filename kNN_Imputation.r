# kNN Imputation (completely 5 functions)

# Function 1
# Input: 1). df: data frame that need to be treated
# Return:1). df_distance: the euclidean distance list that will be used
initialize_distance_find_best_k<-function(df){
  
  # Find all numerical column
  numerical_columns<-names(df)[sapply(df,is.numeric)]
  # Find all numerical col with NA
  excluded_columns<-names(df)[colSums(is.na(df))>0]
  # Exlude column with NA
  target_columns<-setdiff(numerical_columns,excluded_columns)
  # Normalization & calculate euclidean distance
  df_matrix<-as.matrix(df[,target_columns])
  df_matrix<-scale(df[, target_columns])
  df_distance<-as.matrix(dist(df_matrix, method="euclidean"))
  return(df_distance)
}

# Function 2
# Input: 1). target_feature: specific feature that need to find not na value
# Return:1). not_na_index: target_feature's all index that are not na
initialize_not_na_index<-function(target_feature){
    
    # Find index that are not na
    not_na_index<-which(!is.na(target_feature))
    return(not_na_index)
}

# Function 3
# Input: 1). seed_num: number you want to set seed for
#        2). test_proportion: proportion you want to select from not_na_index to test best k
#        3). not_na_index: the not_na_index you get from previous function
# Return:1).test_k_index: the index you wanna use to test best k
initialize_test_k_index<-function(seed_num,test_proportion,not_na_index) {
  
  # For repeat
  set.seed(seed_num)
  # From index does not have na, randomly select certain portion of index 
  test_k_index<-sample(not_na_index,size=floor(test_proportion*length(not_na_index)))
  return(test_k_index)
}

# Function 4
# Input: 1). max_k: number of k you wanna test
#        2). test_k_index: the index you wanna use to test best k
#        3). df_distance: the euclidean distance matrix build before
#        4). not_na_index: the not_na_index you get from previous function
#        5). target_feature: the feature need to find best k
# Return:1). smallest_k used for kNN imputation
find_best_k<-function(max_k,test_k_index,df_distance,not_na_index,target_feature){
  
  # Initialize
  smallest_RMSE<-Inf
  smallest_k<-Inf
  df_temp<-df_distance
  
  # We gonna test k from 1 to 20
  for (k in 1:max_k) {
  
    # Initialization for total standard error
    se_total<-0

    # loop over all test k index that randomly selected earlier
    for (j in test_k_index){
    
      # Set self to Inf so it won't be considered in smallest euclidean distance 
      df_temp[j,j]<-Inf
    
      # Get all distance of this specific index
      total_distance<-df_temp[j,not_na_index]
    
      # Ordered them the distance
      ordered_dist<-order(total_distance)
    
      # Choose the closest k's distance and get their original index in original data set
      original_index<-not_na_index[ordered_dist][1:k]
    
      # and calculate closest k's distance's mean value
      # This is our prediction value
      test_value<-round(mean(target_feature[original_index]))
    
      # Get actual value
      actual_value<-target_feature[j]
    
      # Add up the standard error for later RMSE calculation 
      se_total<-se_total+(actual_value-test_value)^2
    }
  
    # Get RMSE value for prediction's accuracy
    RMSE<-sqrt(se_total/length(test_k_index))
  
    # If this k's RMSE is smaller than any previous RMSE
    if (RMSE < smallest_RMSE){
    
      # update RMSE
      smallest_RMSE<-RMSE
    
      # update k
      smallest_k<-k
    }
  }
  # print out the best k we find and have its RMSE as additional value
  cat("The best k is", smallest_k,"which give smallest error of", smallest_RMSE)
  
  # clear vector storage
  gc()
  
  
  return(smallest_k)
}

# Function 5
# Input: 1). df: data frame that need NA kNN imputation treatment
#        2). smallest_k: the best k calculate before
#        3). target_feature: specific column that need NA kNN imputation
#        4). df_distance: the euclidean distance matrix made before
# Return:1). target_feature: feature value that successfully imputated
kNN_Imputation<-function(df,smallest_k,target_feature,df_distance){
  # Initialization
  k<-smallest_k
  na_cols<-which(is.na(target_feature))
  na_rows<-which(is.na(target_feature))
  df_temp<-df_distance
  
  # For all values in target_feature
  for (i in na_rows) {
  
    # Ignore self
    df_temp[i,i]<-Inf
  
    # Ignore self's NA value
    df_temp[i,na_cols]<-Inf
  
    # Get smallest best k euclidean distance
    closest_k<-order(df_temp[i,])[1:k]
  
    # Impute the mean value of these k numbers
    target_feature[i]<-round(mean(target_feature[closest_k]))
  }
  return(target_feature)
}
