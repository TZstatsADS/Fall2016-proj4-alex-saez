## Project: Words 4 Music

### This directory contains all the R code used for this project. Below is a description of what each script is used for, in the order in which it was used


**discard_non_english.R** (script) - Saves a modified version of lyr.RData where all non-English songs have been removed

**extract_features.R** (function) - Extracts all the relevant features from song file used later for topic prediction

**build_feature_matrix.R** (script) - Loops over all songs and applies extract_features.R to each one

**fit_topicmodel.R** (script) - Fits a topic model on the corpus of songs using *topicmodels* package. Saves the model

**plot_topic_model.R** (script) - Utility for visualizing fitted topic models using *LDAvis* 

**plot_topics_vs_features.R** (script) - Utility script that plots the main topic of a song vs the 2 top PCs of song features

**topic_classifier.R** (script) - Code for tuning and fitting final topic classifier based on song features 

**predict_words.R** (function) - Assigns ranks (low = more probable) to each word in a list given the features of a song 

**main.R** (script) - Ranks word list for each song in test set 


