
library(dplyr)
library(rhdf5)

extract_features = function(song){
  # Extract relevant features from song and return them as data frame
  # INPUT: song in h5 format
  # OUTPUT: single-row data frame of relevant song features
  
  gen_features = song$songs %>% select(key, loudness, mode, tempo, time_signature)
  
  pitches = rowMeans(song$segments_pitches)
  pitches = data.frame(pitch = matrix(pitches, nrow=1))
  
  timbres = rowMeans(song$segments_timbre)
  timbres = data.frame(timbre = matrix(timbres, nrow=1))
  
  loudness = rep(0, 12)
  loudness_vals = table(findInterval(song$segments_loudness_max, seq(-20, 0, length.out=11)))
  loudness[as.integer(names(loudness_vals))+1] = loudness_vals/sum(loudness_vals)
  loudness = data.frame(loudness = matrix(loudness, nrow=1))
  
  return(cbind(gen_features, pitches, timbres, loudness))
}


# loop over all songs and create X matrix
all_songs = list.files('../data/songs/')
X = data.frame()
for(i in 1:length(all_songs)){
  print(i)
  song = h5read(paste("../data/songs/", all_songs[i], sep=""), '/analysis')
  X = rbind(X, extract_features(song))
}

# create column with song ids:
X = data.frame(song_id = gsub('.h5', '', all_songs), X)

save(X, file='../output/features.RData')


