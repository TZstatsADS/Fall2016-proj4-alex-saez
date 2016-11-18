
##############################################################################################################
#################################### CODE FOR COMPLETING ASSIGNMENT ##########################################
##############################################################################################################


library(rhdf5)
source('../lib/predict_words.R')
load('../output/gbm_classifier_15.RData')
load('../output/topicmodel_15.RData')

table_submit = read.csv('../data/sample_submission.csv')
word_list = colnames(table_submit[-c(1,2)])
N = length(word_list)

datadir = '../data/TestSongFile100/'
all_songs = list.files(datadir, recursive=TRUE)

# loop over songs in directory and collect word ranks into table_submit
for(i in 1:length(all_songs)){
  print(i)
  
  song = h5read(paste(datadir, all_songs[i], sep=""), '/analysis')
  
  songname = strsplit(all_songs[i], '.h5')[[1]][1]
  ind = which(table_submit$dat2.track_id == songname)
  
  table_submit[ind, 3:(N+2)] = predict_words(song=song, topicmodel=tm, classifier=topic_classifier, wordlist=word_list)
}

table_submit = table_submit[1:100,]

# save table: 
write.csv(table_submit, file='../output/ranks_final_submit.csv', row.names=FALSE)
