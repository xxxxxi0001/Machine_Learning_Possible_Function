# Input: 1). df: Data Frame with Outliers
#        2). variables: Features in Data Frame that need outlier Treatment
# Return:1). df: return data frame with variables' outliers treated
IQR_outlier<-function(df,variables){
  for (i in variables) {
  
  # Identify first quartile, third quartile and IQR
  Q1<-quantile(df[[i]],0.25)
  Q3<-quantile(df[[i]],0.75)
  IQR<-Q3-Q1
  
  # Identify lower quartile and upper quartile
  low_q<-Q1-1.5*IQR
  up_q<-Q3+1.5*IQR
  
  # Collect outliers information
  outlier<-sum(df[[i]]<low_q) + sum(df[[i]]>up_q)

  # Get 5% value and 95% value for replacement
  caps<-quantile(df[[i]],probs=c(0.05,0.95))
  
  # For below lower quartile replaced by 5%
  df[[i]][df[[i]]<low_q]<-caps[1]
  # For above upper quatile repplaced by 95%
  df[[i]][df[[i]]>up_q]<-caps[2]
  
  cat("There are total",outlier, "outliers detected for feature", i, ". Above upper quartile ", up_q, "is replaced into ", caps[2], ". Below lower quartile", low_q, "is replaced into", caps[1], "\n")
  }
  return(df)
}
