## Project: Words 4 Music

### This directory contains all the R code used for this project. Below is a description of what each script is used for.

**extract_features.R** (function) - Extracts all the relevant features from song file used later for topic prediction

**build_feature_matrix.R** (script) - Loops over all songs and applies extract_features.R to each one

**discard_non_english.R** (script) - Saves a modified version of lyr.RData where all non-English songs have been removed

**fit_topicmodel.R** (script) - Fits a topic model on the corpus of songs using *topicmodels* package. Saves the model

**main.R** (script) - Assigns ranks (low = more probable) to each word in a list given the features of a song 

**plot_topic_model.R** (script) - Utility for visualizing fitted topic models using *LDAvis* 

**plot_topics_vs_features.R** (script) - Utility script that plots the main topic of a song vs the 2 top PCs of song features

