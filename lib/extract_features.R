
library(dplyr)

extract_features = function(song){
  # Extract relevant features from song
  
  features1 = song$songs %>% select(danceability, energy, key, loudness, mode, tempo, time_signature)
  
  pitches = rowSums(song$segments_pitches)/sum(song$segments_pitches)
  pitches = data.frame(pitch = matrix(pitches, nrow=1))
  
  timbres = rowSums(song$segments_timbre)/sum(song$segments_timbre)
  timbres = data.frame(timbre = matrix(timbres, nrow=1))
  
}