# Detecting-Credit-Card-Fraud
I worked on this project in 2018 and updated it in 2019

Background - The datasets contains transactions made by credit cards in September 2013 by European cardholders.

This dataset presents transactions that occurred in two days, where we have 492 frauds out of 284,807 transactions. The dataset is highly unbalanced, the positive class (frauds) account for 0.172% of all transactions.
It contains only numerical input variables which are the result of a PCA transformation. Unfortunately, due to confidentiality issues, the original features and more background information about the data was not provided. Features V1, V2, … V28 are the principal components obtained with PCA, the only features which have not been transformed with PCA are 'Time' and 'Amount'. 
Feature 'Time' contains the seconds elapsed between each transaction and the first transaction in the dataset. The feature 'Amount' is the transaction Amount, this feature can be used for example-dependent cost-sensitive learning. Feature 'Class' is the response variable and it takes value 1 in case of fraud and 0 otherwise.
Introduction - Millions of people all over the world are subjected to identity theft and fraudulent credit card transactions. 

Banks have created firewalls, set up full-proof systems but hackers seem to find new ways to hack the system and get access to the customer data. 

In this project, I am attempting to detect those fraudulent transactions by build a robust system which would help detect those malicious behavior.

In the first part of the project, I will do some exploratory analysis to detect the outliers because they can be caused to unusual transactions. They can also help identify unusual patterns in the data. 

Anomalies can be detected by means of KNN algorithms, k-means algorithm and also isolation forest. 

I will investigate the fraud visually, use H20 for our machine learning algorithm and then I will visualize the results. 

In H20, I will use a variant of random forest algorithm which is called “Isolation Forest”.

The main idea behind Isolation Forest is that explicitly identifies anomalies instead of profiling normal data points. Isolation Forest, like any tree ensemble method, is built on the basis of decision trees. In these trees, partitions are created by first randomly selecting a feature and then selecting a random split value between the minimum and maximum value of the selected feature.
By using such random splits, they can be identified closer to the root of the tree (shorter average path length, i.e., the number of edges an observation must pass in the tree going from the root to the terminal node), with fewer splits necessary.

Machine Learning Model in R

2018 version 1 - Performed cross-validation and then ran linear discriminant analysis, logistic analysis, support vector machine, gradient boosting models and compared the results of these models

2018 - Version 2 - Performed isolation forest since it works well with the unbalanced data 

Machine Learning in Python 

Will update it shortly

