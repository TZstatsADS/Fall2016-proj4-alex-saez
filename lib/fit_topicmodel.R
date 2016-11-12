library(tm)
library(topicmodels)
load("../data/lyr.RData")
song_ids = lyr$`dat2$track_id`
lyr = lyr[, -c(1:3,6:30)]

# convert lyr into a  document-term matrix in order to use 'topicmodels'
songs = apply(lyr, 1, function(x){paste(rep(names(x)[x>0], x[x>0]), collapse=' ')})
corp = VCorpus(VectorSource(songs))
dtm = DocumentTermMatrix(corp, control = list(wordLengths = c(0, Inf)))

# setdiff(names(lyr), dtm$dimnames$Terms)

# fit LDA models with different numbers of topics
topicmodel_10 = LDA(dtm, k=10, method="Gibbs")
topicmodel_20 = LDA(dtm, k=20, method="Gibbs")
topicmodel_30 = LDA(dtm, k=30, method="Gibbs")
topicmodel_40 = LDA(dtm, k=40, method="Gibbs")

# select best model using perplexity measure:
p_10 = perplexity(topicmodel_10, newdata = dtm)
p_20 = perplexity(topicmodel_20, newdata = dtm)
p_30 = perplexity(topicmodel_30, newdata = dtm)
p_40 = perplexity(topicmodel_40, newdata = dtm)
plot(c(p_10, p_20, p_30, p_40))
