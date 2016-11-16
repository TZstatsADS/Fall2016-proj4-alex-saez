
load('../output/tree_classifier_10.RData')
classifier = treemodel
load('../output/topicmodel_10.RData')
topicmodel=tm

predict_words = function(song, topicmodel, classifier){
   # INPUT: 
   #   - song: analysis part of song in h5 format (e.g. song = h5read(filename, '/analysis'))
   #   - topicmodel
   #   - classifier
   # OUTPUT: 
   #   - p: word probabilities
  
  library(rpart)
  library(topicmodels)
  source('../lib/extract_features.R')
  
  if(classifier$parms$prior != topicmodel@k)
    stop('Number of topics in topicmodel must match number of classifier categories')
  
  X = extract_features(song)
  p_topics = predict(classifier, newdata = X)
  
  
  
}
