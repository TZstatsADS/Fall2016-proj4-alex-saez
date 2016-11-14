library(tm)
library(topicmodels)
load("../data/lyr.RData")
song_ids = lyr$`dat2$track_id`
lyr = lyr[, -c(1:3,6:30)]

# convert lyr into 2 document-term matrices (train and test) in order to use 'topicmodels'
songs = apply(lyr, 1, function(x){paste(rep(names(x)[x>0], x[x>0]), collapse=' ')})
train_ind = sample(2350, 2000)
corp_Tr = VCorpus(VectorSource(songs[train_ind]))
corp_Te = VCorpus(VectorSource(songs[-train_ind]))
dtm_Tr = DocumentTermMatrix(corp_Tr, control = list(wordLengths = c(0, Inf)))
dtm_Te = DocumentTermMatrix(corp_Te, control = list(wordLengths = c(0, Inf)))

# setdiff(names(lyr), dtm$dimnames$Terms)

# fit LDA models with different numbers of topics
topicmodel_10 = LDA(dtm_Tr, k=10, method="Gibbs")
topicmodel_20 = LDA(dtm_Tr, k=20, method="Gibbs")
topicmodel_30 = LDA(dtm_Tr, k=30, method="Gibbs")
topicmodel_40 = LDA(dtm_Tr, k=40, method="Gibbs")
topicmodel_50 = LDA(dtm_Tr, k=50, method="Gibbs")
topicmodel_80 = LDA(dtm_Tr, k=80, method="Gibbs")
topicmodel_100 = LDA(dtm_Tr, k=100, method="Gibbs")
topicmodel_120 = LDA(dtm_Tr, k=120, method="Gibbs")

# select best model using perplexity measure on testing set:
p_10 = perplexity(topicmodel_10, newdata = dtm_Te)
p_20 = perplexity(topicmodel_20, newdata = dtm_Te)
p_30 = perplexity(topicmodel_30, newdata = dtm_Te)
p_40 = perplexity(topicmodel_40, newdata = dtm_Te)
p_50 = perplexity(topicmodel_50, newdata = dtm_Te)
p_80 = perplexity(topicmodel_80, newdata = dtm_Te)
p_100 = perplexity(topicmodel_100, newdata = dtm_Te)
p_120 = perplexity(topicmodel_120, newdata = dtm_Te)
plot(c(p_10, p_20, p_30, p_40, p_50, p_80, p_100, p_120))

topicmodels = list(tm10 = topicmodel_10, 
                   tm20 = topicmodel_20, 
                   tm30 = topicmodel_30, 
                   tm40 = topicmodel_40, 
                   tm50 = topicmodel_50)

save(topicmodels, file='../output/topicmodels.RData')




