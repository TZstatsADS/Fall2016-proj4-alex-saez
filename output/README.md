## Project: Words 4 Music

### This directory contains the processed data and the trained models used for generating the final submission. It includes:

**lyr_english.RData**  - Song lyrics file analogous to ./data/lyr.RData after removing all non-English songs

**features.RData**  - Musical features extraced from songs used for training the GBM classifier

**topicmodel_XX.RData**  - Topic models fitted to corpus of song lyrics, where XX is the number of topics in the model K=5, 10, 15 or 20

**gbm_classifier_15.RData**  - GBM classifier trained to assign probable topics (for K=15) based on musical features

**ranks_final_submit.csv**  - Table of word ranks for each test song for final submission

