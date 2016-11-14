library(tm)
library(topicmodels)
load("../data/lyr.RData")
song_ids = lyr$`dat2$track_id`
lyr = lyr[, -c(1:3,6:30)]

# convert lyr into character vector
songs = apply(lyr, 1, function(x){paste(rep(names(x)[x>0], x[x>0]), collapse=' ')})
names(songs) = song_ids

# discard non-english language songs:
# German:
ind_not_german = !grepl(' und ',songs) & !grepl(' ich ',songs) & !grepl(' auf ',songs)
# French:
ind_not_french = !grepl(' je ',songs) & !grepl(' les ',songs) & !grepl(' au ',songs) & !grepl(' quon ',songs) & !grepl(' deux ',songs)
# Spanish:
ind_not_spanish = !grepl(' tu ',songs) & !grepl(' el ',songs) & !grepl(' que ',songs) & !grepl(' como ',songs) & !grepl(' te ',songs) & !grepl(' una ',songs)
# Italian:
ind_not_italian = !grepl(' che ',songs) & !grepl(' alla ',songs)

ind_english = ind_not_german & ind_not_french & ind_not_spanish & ind_not_italian
songs = songs[ind_english]


# create document-term matrice in order to use 'topicmodels'
corp = VCorpus(VectorSource(songs))
dtm = DocumentTermMatrix(corp, control = list(wordLengths = c(0, Inf)))
dtm$dimnames$Docs = names(songs)

# fit LDA:
tm = LDA(dtm, k=5, method="Gibbs")

save(tm, file='../output/topicmodel_5.RData')


