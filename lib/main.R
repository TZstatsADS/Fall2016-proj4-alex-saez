
##############################################################################################################
#################################### CODE FOR COMPLETING ASSIGNMENT ##########################################
##############################################################################################################


library(rhdf5)
source('../lib/predict_words.R')
load('../output/gbm_classifier_15.RData')
load('../output/topicmodel_15.RData')

datadir = '../data/songs/'
all_songs = list.files(datadir, recursive=TRUE)

# loop over songs in directory:
X = data.frame()
for(i in 1:length(all_songs)){
  
  print(i)
  
  song = h5read(paste("../data/songs/", all_songs[i], sep=""), '/analysis')
  
  p_words = predict_words(song=song, topicmodel=tm, classifier=topic_classifier)
  cat(names(sort(p_words, decreasing=T)[1:20]))
}

