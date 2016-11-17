
predict_words = function(song, topicmodel, classifier, wordlist){
  # INPUT: 
  #   - song: song in h5 format (e.g. song = h5read(filename, '/analysis'))
  #   - topicmodel: topic model built using topicmodels::LDA
  #   - classifier: trained GBM model
  #   - wordlist (optional): character vector of words to rank from most to least probable to occur
  # OUTPUT: 
  #   - word_ranks: if argument wordlist supplied, ranks words in wordlist from most to least probable; 
  #   OR,
  #   - p_words: if argument wordlist missing, word probabilities for the terms in topicmodel 
  
  library(rpart)
  library(topicmodels)
  source('../lib/extract_features.R')
  
  
  X = as.matrix(extract_features(song))
  p_topics = predict(classifier, newdata=X, missing=NA)

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
