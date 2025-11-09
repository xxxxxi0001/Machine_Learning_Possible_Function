# Input: 1). df: data frame that used for training partition
#        2). seed_num: desired seeding number
#        3). train_index: the overall training index that you gonna selected from
#        4). sub_num: number of ensemble list
#        5). sub_portion: portion of overall training you want to select as sub-list
# Return:1). A list contain sub_num number of training index
ensemble_train_partition<-function(df,seed_num,train_index,sub_num,sub_portion) {
  
  # Initialization
  set.seed(seed_num)
  partitions<-list()
  
  # Randomly choose designated number (sub_num) of subset from training index 
  # with designated portion (sub_portion) of number
  for (i in 1:sub_num){
    nt<-length(train_index)
    subset_train_index<-sample(train_index,size=floor(sub_portion*nt))
    partitions[[i]]<-list(train=subset_train_index)
  }
  
  # Return a list of partition index
  return(partitions)
}
