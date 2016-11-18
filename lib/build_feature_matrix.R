##############################################################################################################
########################## CODE FOR BUILDING DATA FRAME WITH ALL SONG FEATURES ###############################
##############################################################################################################

library(rhdf5)
source('../lib/extract_features.R')
load('../output/lyr_english.RData')

all_songs = list.files('../data/songs/', recursive=TRUE)

# loop over all songs
X = data.frame()
for(i in 1:length(all_songs)){
  print(i)
  song = h5read(paste("../data/songs/", all_songs[i], sep=""), '/analysis')
  X = rbind(X, extract_features(song))
}

# create column with song ids:
song_ids = gsub('[A-Z]/', '', all_songs)
song_ids = gsub('.h5', '', song_ids)
X = cbind(song_id=song_ids, X)

# keep only features for songs in English:
X = X[X$song_id %in% lyr$song_id,]

save(X, file='../output/features.RData')

