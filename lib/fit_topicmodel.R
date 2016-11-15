
library(tm)
library(topicmodels)

load("../output/lyr_english.RData")


# convert lyr into character vector of songs
songs = apply(lyr[,-1], 1, function(x){paste(rep(names(x)[x>0], x[x>0]), collapse=' ')})
names(songs) = lyr$song_id


# create document-term matrice in order to use 'topicmodels'
corp = VCorpus(VectorSource(songs))
dtm = DocumentTermMatrix(corp, control = list(wordLengths = c(0, Inf)))
dtm$dimnames$Docs = names(songs)

# fit LDA:
t = Sys.time()
tm = LDA(dtm, k=10, method="Gibbs")
Sys.time() - t

save(tm, file='../output/topicmodel_10.RData')


# tm = LDA(dtm, k=5, method="Gibbs")
# save(tm, file='../output/topicmodel_5.RData')
# tm = LDA(dtm, k=10, method="Gibbs")
# save(tm, file='../output/topicmodel_10.RData')
# tm = LDA(dtm, k=15, method="Gibbs")
# save(tm, file='../output/topicmodel_15.RData')
