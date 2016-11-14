library(ggplot2)
library(topicmodels)

load('../output/features.RData')
load('../output/topicmodel_5.RData')

# select songs included in topic model (i.e. songs in English)
X = X[X$song_id %in% tm@documents, -1]

terms = terms(tm, 50)
topics = topics(tm, 2)

pc = prcomp(X, scale=TRUE, center=TRUE)

topic_ind = topics[1,] %in% c(2,3)
qplot(pc$x[topic_ind,1], pc$x[topic_ind,2], col=as.factor(topics[1,topic_ind]))


