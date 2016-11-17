library(topicmodels)
library(servr)
library(LDAvis)

load('../output/lyr_english.RData')
load('../output/topicmodel_5.RData')


# create the JSON object to feed the visualization:
phi = exp(tm@beta)/rowSums(exp(tm@beta))
doc.length = rowSums(lyr[,-1])
term.frequency = colSums(lyr[,-1])

json = createJSON(phi = phi, 
                   theta = tm@gamma, 
                   doc.length = doc.length, 
                   vocab = tm@terms, 
                   term.frequency = term.frequency)

serVis(json, out.dir = 'vissample', open.browser = T)

