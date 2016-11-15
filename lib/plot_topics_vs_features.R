library(ggplot2)
library(topicmodels)

load('../output/english_songs.RData')
load('../output/features.RData')
load('../output/topicmodel_10.RData')

# select songs included in topic model (i.e. songs in English)
X = X[X$song_id %in% tm@documents, -1]

terms = terms(tm, 100)
topics = topics(tm, 2)

pc = prcomp(X, scale=TRUE, center=TRUE)

topic_ind = topics[1,] %in% c(2,3)
qplot(pc$x[topic_ind,1], pc$x[topic_ind,2], col=as.factor(topics[1,topic_ind]))

library(servr)
library(LDAvis)
# create the JSON object to feed the visualization:
phi = exp(tm@beta)/rowSums(exp(tm@beta))
doc.length = sapply(songs, function(x){length(strsplit(x, ' ')[[1]])})
term.frequency = colSums(as.matrix(tm@wordassignments))

json = createJSON(phi = phi, 
                   theta = tm@gamma, 
                   doc.length = doc.length, 
                   vocab = tm@terms, 
                   term.frequency = term.frequency)

serVis(json, out.dir = 'vissample', open.browser = T)

