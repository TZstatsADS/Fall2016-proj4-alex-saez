##############################################################################################################
################# CODE FOR TUNING AND FITTING TOPIC CLASSIFIER BASED ON FEATURES #############################
##############################################################################################################


library('xgboost')

load('../output/features.RData')
load('../output/topicmodel_15.RData')


X = as.matrix(X[X$song_id %in% tm@documents, -1])
y = topics(tm, 1) - 1


######################## USE THIS SECTION FOR CV TUNING OF GBM PARAMETERS ####################################

# CV params:
K = 5 
n = length(y)
size_fold = floor(n/K)
s = sample(rep(1:K, c(rep(size_fold, K-1), n-(K-1)*size_fold)))  

shrinkages = seq(.1, .9, .2)
I = length(shrinkages)
accuracy = rep(NA, I)
for(i in 1:I){
  print(i)
  cv_acc = rep(NA, K)
  for (k in 1:K){
    X_train = X[s != k,]
    y_train = y[s != k]
    X_test = X[s == k,]
    y_test = y[s == k]
    
    par = list(objective = "multi:softmax", # use hard assignments for tuning
               num_class = tm@k,
               max_depth = 4,
               eta = shrinkages[i],
               subsample = 0.8)
    dtrain = xgb.DMatrix(data = X_train, label = y_train, missing=NA)
    fit = xgb.train(data=dtrain, params=par, nrounds=100)

    pred = predict(fit, newdata = X_test, missing=NA)
    
    cv_acc[k] = mean(pred == y_test) 
  }			
  accuracy[i] = mean(cv_acc)
}
accuracy


########################## NOW FIT GBM TO WHOLE DATA WITH BEST PARAMETERS ####################################


par = list(objective = "multi:softprob", # switch to soft assignments for prediction
           num_class = tm@k,
           max_depth = 2,
           eta = .1,
           subsample = 1)

datamat = xgb.DMatrix(data=X, label=y, missing=NA)

topic_classifier = xgb.train(data=datamat, params=par, nrounds=100)

save(topic_classifier, file='../output/gbm_classifier_15.RData')



