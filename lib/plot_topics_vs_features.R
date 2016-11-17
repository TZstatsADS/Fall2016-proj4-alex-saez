
##############################################################################################################
###################### PLOT MAIN TOPIC OF SONG VS PRINCIPAL COMPONENTS OF FEATURES ###########################
##############################################################################################################

library(ggplot2)

load('../output/features.RData')
load('../output/topicmodel_15.RData')

# select songs included in topic model (i.e. songs in English)
X = X[X$song_id %in% tm@documents, -1]


if(nrow(X) != tm@Dim[1])
  stop('Number of documents in features does not match number of documents in topicmodel')

topics = as.factor(topics(tm, 1))

X = X[-c(619, 854, 1137, 1180, 1426),]
topics = topics[-c(619, 854, 1137, 1180, 1426)]

pc = prcomp(X, scale=TRUE, center=TRUE)

topic_ind = topics %in% c(1,7,9,12) # select subset of topic to plot
x = pc$x[topic_ind,1]
y = pc$x[topic_ind,2]
z = topics[topic_ind]

qplot(x, y, col=z) 
qplot(pc$x[topic_ind,1], pc$x[topic_ind,2], col=topics[topic_ind], geom = "density2d")


df = data.frame(x=x, y=y, z=z)
gg = merge(df, aggregate(cbind(mean.x=x,mean.y=y)~z,FUN=mean), by="z")
ggplot(gg, aes(x,y,color=z))+geom_point(size=1)+
  geom_point(aes(x=mean.x,y=mean.y),size=5)+
  geom_segment(aes(x=mean.x, y=mean.y, xend=x, yend=y))

