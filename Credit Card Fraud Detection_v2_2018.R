#Project Name - Credit Card Fraud Detection
#Name - Smits Gupta

#Importing libraries

library("tidyr")
library("dplyr")
library("ggplot2")
library("vroom")

#Reading the data
credit_card_tbl <- vroom("data/creditcard.csv")

head(credit_card_tbl)
names(credit_card_tbl)
max(credit_card_tbl$Amount)

data = credit_card_tbl[,2:29]
names(data)

#Analyzing the correlation between the different numerical features
library(corrplot)
corrplot(cor(data[,2:28]),method = 'number')


#Checking the statistics - fraud vs no fraud
table(credit_card_tbl$Class)

install.packages("unbalanced")
library(unbalanced)
install.packages("ROSE")
library(ROSE)

str(credit_card_tbl)

credit_card_tbl$Class <- as.factor(credit_card_tbl$Class)

library(caret)

credit_card_tbl = credit_card_tbl[,-1]

head(credit_card_tbl)

# Spliting the data to create a train-test sample 
set.seed(1234)
trainIndex = createDataPartition(credit_card_tbl$Class,p=0.5,list=F,times = 1)

dataTrain = credit_card_tbl[trainIndex,]
dataTest = credit_card_tbl[-trainIndex,]

head(dataTrain)
head(dataTest)

table(dataTrain$Class)

table(dataTest$Class)

# setting up cross validation 
control <- trainControl(method = 'repeatedcv',number=3,repeats = 3)

# setting up accuracy
metric <-"Accuracy"

# selecting the pre-processing method
preProcess <- c("center",'scale')

# linear discriminant analysis
#LDA makes predictions by estimating the probability that a new set of inputs belongs to each class. 
#The class that gets the highest probability is the output class and a prediction is made.

set.seed(1234)
library(MASS)
fit.lda <- train(Class~.,data=dataTrain,method = 'lda',metric = metric,preprocess = preProcess,trControl = control)
fit.lda

fit.lda$results

# Logistic regression analysis
set.seed(1234)
library(MASS)
fit.glm <- train(Class~.,data=dataTrain,method = 'glm',metric = metric,trControl = control)
fit.glm

fit.glm$results

# Support Vector Machine 
install.packages("kernlab")
library(kernlab)
set.seed(1234)
fit.svm <- train(Class~.,data=dataTrain,method = 'svmRadial',metric = metric,
                 preprocess = preProcess,trControl = control,fit=F)


#KNN for classification
install.packages("class")
library(class)
set.seed(1234)
fit.knn <- train(Class~.,data=dataTrain,method = 'knn',metric = metric,
                 preprocess = preProcess,trControl = control)

fit.knn$results

# Naive Bayes
set.seed(1234)
install("klaR")
library(klaR)
fit.nb<-train(Class~.,data=dataTrain,method = 'nb',metric = metric,trControl = control)

fit.nb$results

# CART
set.seed(1234)
install.packages("rpart")
library(rpart)
fit.cart<-train(Class~.,data=dataTrain,method = 'rpart',metric = metric,trControl = control)

fit.cart$results

#Tree based model C5.0
set.seed(1234)
install.packages("C50")
library(C50)
fit.c50<-train(Class~.,data=dataTrain,method = 'C5.0',metric = metric,trControl = control)

fit.c50$results

# Bagging CART
set.seed(1234)
install.packages("ipred")
library(ipred)
fit.treebag <-train(Class~.,data=dataTrain,method = 'treebag',metric = metric,trControl = control)

fit.treebag$results

# Random forest
set.seed(1234)
fit.rf <- train(Class~.,data=dataTrain,method = 'rf',metric = metric,trControl = control)

fit.rf$results

# gradient boosting model
set.seed(1234)
fit.gbm <- train(Class~.,data=dataTrain,method = 'gbm',metric = metric,trControl = control)

fit.gbm$results

# neural network model
set.seed(1234)
install.packages("nnet")
library(nnet)
fit.nnet<-train(Class~.,data=dataTrain,method = 'nnet',metric = metric,trControl = control)

fit.nnet$results

# comparison of models
results <- resamples(list(lda=fit.lda,
                          logistic=fit.glm,
                          svm=fit.svm,
                          knn = fit.knn,
                          nb=fit.nb,
                          cart=fit.cart,
                          c50=fit.c50,
                          baggingcart=fit.treebag,
                          randomforest=fit.rf,
                          gbm=fit.gbm,
                          nnet=fit.nnet))

# comparing the results
summary(results)

# consistency of all the resampling results
bwplot(results)
