library(tm)
library(lda)
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


lyr = lyr[ind_english,]
format_corpus = function(x){
  ind = as.integer(which(x>0))
  return(matrix(c(ind, as.integer(x[ind])), nrow=2, byrow = TRUE))
}
documents = apply(lyr, 1, format_corpus)
vocab = names(lyr)

D <- length(documents)  # number of documents (2,000)
W <- length(vocab)  # number of terms in the vocab (14,568)
doc.length <- sapply(documents, function(x) sum(x[2, ]))  # number of tokens per document [312, 288, 170, 436, 291, ...]
term.frequency <- colSums(lyr)  # frequencies of terms in the corpus [8939, 5544, 2411, 2410, 2143, 

# fit LDA model:
K = 20
G = 5000
alpha = 0.02
eta = 0.02
t = Sys.time()
tm = lda.collapsed.gibbs.sampler(documents = documents, K = K, vocab = vocab, 
                                   num.iterations = G, alpha = alpha, 
                                   eta = eta, initial = NULL, burnin = 0,
                                   compute.log.likelihood = TRUE)
Sys.time() - t

theta <- t(apply(tm$document_sums + alpha, 2, function(x) x/sum(x)))
phi <- t(apply(t(tm$topics) + eta, 2, function(x) x/sum(x)))
MovieReviews <- list(phi = phi,
                     theta = theta,
                     doc.length = doc.length,
                     vocab = vocab,
                     term.frequency = term.frequency)

library(servr)
library(LDAvis)
# create the JSON object to feed the visualization:
json <- createJSON(phi = MovieReviews$phi, 
                   theta = MovieReviews$theta, 
                   doc.length = MovieReviews$doc.length, 
                   vocab = MovieReviews$vocab, 
                   term.frequency = MovieReviews$term.frequency)

serVis(json, out.dir = 'vissample2', open.browser = T)


