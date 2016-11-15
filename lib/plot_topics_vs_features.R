library(ggplot2)

load('../output/features.RData')
load('../output/topicmodel_10.RData')

# select songs included in topic model (i.e. songs in English)
X = X[X$song_id %in% tm@documents, -1]

terms = terms(tm, 100)
topics = as.factor(topics(tm, 1))

pc = prcomp(X, scale=TRUE, center=TRUE)

topic_ind = topics %in% 1:10 #c(2,3)
qplot(pc$x[topic_ind,1], pc$x[topic_ind,2], col=topics[topic_ind])
qplot(pc$x[topic_ind,1], pc$x[topic_ind,2], col=topics[topic_ind], geom = "density2d")

# fit tree model
library(rpart)
XX = cbind(topic = topics, X)
tree = rpart(topic~., data=XX, control = list())
a = predict(tree, newdata = XX[100,])
