
extract_features = function(song){
  # Extract relevant features from song and return them as data frame
  # INPUT: song in h5 format (e.g. song = h5read(filename, '/analysis'))
  # OUTPUT: single-row data frame of relevant song features
  
  # general features
  gen_features = song$songs[, c('key', 
                                'loudness', 
                                'mode', 
                                'tempo', 
                                'time_signature')]
  
  # pitch means
  pitchMean = rowMeans(song$segments_pitches) 
  pitchMean = data.frame(pitchMean = matrix(pitchMean, nrow=1))
  
  # pitch variances
  pitchVar = apply(song$segments_pitches, 1, var) 
  pitchVar = data.frame(pitchVar = matrix(pitchVar, nrow=1))
  
  # timbre mean
  timbreMean = rowMeans(song$segments_timbre) 
  timbreMean = data.frame(timbreMean = matrix(timbreMean, nrow=1))
  
  # timbre variances
  timbreVar = apply(song$segments_timbre, 1, var) 
  timbreVar = data.frame(timbreVar = matrix(timbreVar, nrow=1))
  
  # loudness as 12-bin histogram
  loudness = rep(0, 12)
  loudness_vals = table(findInterval(song$segments_loudness_max, seq(-20, 0, length.out=11)))
  loudness[as.integer(names(loudness_vals))+1] = loudness_vals/sum(loudness_vals)
  loudness = data.frame(loudness = matrix(loudness, nrow=1))
  
  # time periodicities of bars, beats, segs and tatums
  freqs = data.frame(bar_freq = mean(diff(song$bars_confidence)),
                     beat_freq = mean(diff(song$beats_confidence)),
                     seg_freq = mean(diff(song$segments_confidence)),
                     tatum_freq = mean(diff(song$tatums_confidence)))

  # confidence measures for bars, beats, segs and tatums
  confidences = data.frame(bar_conf = mean(song$bars_confidence),
                           beat_conf = mean(song$beats_confidence),
                           seg_conf = mean(song$segments_confidence),
                           tatum_conf = mean(song$tatums_confidence))
  
  return(cbind(gen_features, 
               pitchMean, pitchVar,
               timbreMean, timbreVar,
               loudness, 
               freqs, 
               confidences))
}


