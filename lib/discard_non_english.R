
##############################################################################################################
############################### CODE FOR DISCARDING SONGS NOT IN ENGLISH #####################################
##############################################################################################################


load("../data/lyr.RData")

song_ids = lyr$`dat2$track_id`
lyr = lyr[, -c(1:3,6:30)]

# create character vector of songs
songs = apply(lyr, 1, function(x){paste(rep(names(x)[x>0], x[x>0]), collapse=' ')})
names(songs) = song_ids

# discard non-english language songs:
ind_not_german = !grepl(' und ',songs) & !grepl(' ich ',songs) & !grepl(' auf ',songs)
ind_not_french = !grepl(' je ',songs) & !grepl(' les ',songs) & !grepl(' au ',songs) & !grepl(' quon ',songs) & !grepl(' deux ',songs)
ind_not_spanish = !grepl(' tu ',songs) & !grepl(' el ',songs) & !grepl(' que ',songs) & !grepl(' como ',songs) & !grepl(' te ',songs) & !grepl(' una ',songs)
ind_not_italian = !grepl(' che ',songs) & !grepl(' alla ',songs)
ind_english = ind_not_german & ind_not_french & ind_not_spanish & ind_not_italian
songs = songs[ind_english]
lyr = lyr[ind_english,]
lyr = lyr[, colSums(lyr)!=0]

# now remove also words with special characters:
lyr = lyr[, !is.na(iconv(names(lyr), '', 'ASCII'))]

# add song IDs back to 1st column
lyr = cbind(data.frame(song_id = names(songs), stringsAsFactors=FALSE), lyr)


save(lyr, file='../output/lyr_english.RData')

