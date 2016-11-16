
predict_words = function(song, topicmodel, classifier, wordlist){
  # INPUT: 
  #   - song: analysis part of song in h5 format (e.g. song = h5read(filename, '/analysis'))
  #   - topicmodel
  #   - classifier
  #   - wordlist (optional): character vector of words to rank from most to least probable to occur
  # OUTPUT: 
  #   - word_ranks: if argument wordlist supplied, ranks words in wordlist from most to least probable; 
  #   OR,
  #   - p_words: if argument wordlist missing, word probabilities for the terms in topicmodel 
  
  library(rpart)
  library(topicmodels)
  source('../lib/extract_features.R')
  
  if(length(classifier$parms$prior) != topicmodel@k)
    stop('Number of topics in topicmodel must match number of classifier categories')
  
  X = extract_features(song)
  p_topics = predict(classifier, newdata = X)
  
  p_words = p_topics %*% exp(topicmodel@beta)
  names(p_words) = topicmodel@terms
  
  if(!missing(wordlist)){
    probs_for_ranking = -p_words[wordlist]
    probs_for_ranking[is.na(probs_for_ranking)] = 0
    names(probs_for_ranking) = wordlist
    word_ranks = rank(probs_for_ranking, ties.method='average')
    return(word_ranks)
  }
  else
    return(p_words)
  
}
