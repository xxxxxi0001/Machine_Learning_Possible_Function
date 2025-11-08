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

### Function 4. 
