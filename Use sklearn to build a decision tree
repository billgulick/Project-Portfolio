import pandas as pd
from sklearn.preprocessing import LabelEncoder
from sklearn.model_selection import train_test_split
from sklearn.tree import DecisionTreeClassifier
from sklearn.metrics import accuracy_score
from sklearn.metrics import classification_report
from sklearn.metrics import confusion_matrix
import seaborn as sns
import matplotlib.pyplot as plt
import csv
import warnings
warnings.filterwarnings("ignore")
import sys


df = pd.read_csv('data_banknote_authentication.txt', sep=',', header=None)
df.to_csv('bank_data.csv', index=False)

bank = pd.read_csv('bank_data.csv')

#assign names
bank.columns = ['x1', 'x2', 'x3', 'x4', 'target']
print(bank)

# printing the dataset shape
print ('-'*40 + 'Start Console' + '-'*40 + '\n')

print("Dataset No. of Rows: ", bank.shape[0])
print("Dataset No. of Columns: ", bank.shape[1])

# printing the dataset observations
print("Dataset first few rows:\n ")
print(bank.head())

print ('-'*80 + '\n')

# printing the struture of the dataset
print("Dataset info:\n ")
print(bank.info())
print ('-'*80 + '\n')
# printing the summary statistics of the dataset
print(bank.describe(include='all'))
print ('-'*80 + '\n')

#%%-----------------------------------------------------------------------
# split the dataset
# separate the target variable
X = bank.values[:, 0:4]
y = bank.values[:, 4]

# encloding the class with sklearn's LabelEncoder
class_le = LabelEncoder()

# fit and transform the class
y = class_le.fit_transform(y)

# split the dataset into train and test
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.3, random_state=100)

#%%-----------------------------------------------------------------------
# perform training with giniIndex.
# creating the classifier object
clf_gini = DecisionTreeClassifier(criterion="gini", random_state=100, max_depth=3, min_samples_leaf=5)

# performing training
clf_gini.fit(X_train, y_train)
#%%-----------------------------------------------------------------------
# perform training with entropy.
# Decision tree with entropy
clf_entropy = DecisionTreeClassifier(criterion="entropy", random_state=100, max_depth=10, min_samples_leaf=20)

# Performing training
clf_entropy.fit(X_train, y_train)
#%%-----------------------------------------------------------------------
#%%-----------------------------------------------------------------------
# make predictions
# predicton on test using gini
y_pred_gini = clf_gini.predict(X_test)

# predicton on test using entropy
y_pred_entropy = clf_entropy.predict(X_test)
#%%-----------------------------------------------------------------------
# calculate metrics gini model
print("\n")
print("Results Using Gini Index: \n")
print("Classification Report: ")
print(classification_report(y_test,y_pred_gini))
print("\n")
print("Accuracy : ", accuracy_score(y_test, y_pred_gini) * 100)
print("\n")
print ('-'*80 + '\n')
# calculate metrics entropy model
print("\n")
print("Results Using Entropy: \n")
print("Classification Report: ")
print(classification_report(y_test,y_pred_entropy))
print("\n")
print("Accuracy : ", accuracy_score(y_test, y_pred_entropy) * 100)
print ('-'*80 + '\n')
#%%-----------------------------------------------------------------------
# confusion matrix for gini model
conf_matrix = confusion_matrix(y_test, y_pred_gini)
class_names = bank.target.unique()
df_cm = pd.DataFrame(conf_matrix, index=class_names, columns=class_names )

plt.figure(figsize=(5,5))
hm = sns.heatmap(df_cm, cbar=False, annot=True, square=True, fmt='d', annot_kws={'size': 20}, yticklabels=df_cm.columns, xticklabels=df_cm.columns)
hm.yaxis.set_ticklabels(hm.yaxis.get_ticklabels(), rotation=0, ha='right', fontsize=20)
hm.xaxis.set_ticklabels(hm.xaxis.get_ticklabels(), rotation=0, ha='right', fontsize=20)
plt.ylabel('True label',fontsize=20)
plt.xlabel('Predicted label',fontsize=20)
plt.tight_layout()
plt.show()
#%%-----------------------------------------------------------------------

# confusion matrix for entropy model
conf_matrix = confusion_matrix(y_test, y_pred_entropy)
class_names = bank.target.unique()
df_cm = pd.DataFrame(conf_matrix, index=class_names, columns=class_names )

plt.figure(figsize=(5,5))
hm = sns.heatmap(df_cm, cbar=False, annot=True, square=True, fmt='d', annot_kws={'size': 20}, yticklabels=df_cm.columns, xticklabels=df_cm.columns)
hm.yaxis.set_ticklabels(hm.yaxis.get_ticklabels(), rotation=0, ha='right', fontsize=20)
hm.xaxis.set_ticklabels(hm.xaxis.get_ticklabels(), rotation=0, ha='right', fontsize=20)
plt.ylabel('True label',fontsize=20)
plt.xlabel('Predicted label',fontsize=20)
plt.tight_layout()
plt.show()

