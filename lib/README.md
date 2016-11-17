# Project: Words 4 Music

### Code lib Folder

This directory contains all the R code used for this project. Below is a description of what each script is used for.

**extract_features.R** (function) - Extracts all the relevant features from song file used later for topic prediction
**build_feature_matrix.R** (script) - Loops over all songs and applies extract_features.R to each one
**discard_non_english.R** (script) - Saves a modified version of lyr.RData where all non-English songs have been removed
**fit_topicmodel.R** (script) - Fits a topic model on the corpus of songs using 'topicmodels' package. Saves the model

