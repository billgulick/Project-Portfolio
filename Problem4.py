# %%%%%%%%%%%%% Random Forest  %%%%%%%%%%%%%%%%%%%%%%%%%%
#%%-----------------------------------------------------------------------
# Importing the required packages
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import confusion_matrix
from sklearn.metrics import accuracy_score
from sklearn.metrics import classification_report
from sklearn.metrics import roc_auc_score


#%%-----------------------------------------------------------------------
# import Dataset
# read data as panda dataframe
data = pd.read_csv('https://raw.githubusercontent.com/maxale/Data-Mining/master/09-Random%20Forest/1-Example_Exercise/titanic_data.csv', sep=',', header=0)

# printing the dataswet rows and columns
print("Dataset No. of Rows: ", data.shape[0])
print("Dataset No. of Columns: ", data.shape[1])

# printing the dataset obseravtions
print("Dataset first few rows:\n ")
print(data.head(2))

# printing the struture of the dataset
print("Dataset info:\n ")
print(data.info())

# printing the summary statistics of the dataset
print(data.describe(include='all'))

#%%-----------------------------------------------------------------------
#clean the dataset
print("Sum of NULL values in each column. ")
print(data.isnull().sum())

# drop unnnecessary columns
data.drop(["Cabin", "PassengerId", "Name", "Ticket"], axis=1, inplace=True)
print(data.head())
#encode male/female
data['Sex'] = data['Sex'].map({'male': 0, 'female': 1})
#what is Embarked
print(data['Embarked'].unique())
#drop Embarked as well
data.drop(["Embarked"], axis=1, inplace=True)
#check new data for NA
print("Sum of NULL values in each column. ")
print(data.isnull().sum())
#dataset is large enough to drop NAs
data = data.dropna()
print("Sum of NULL values in each column. Final")
print(data.isnull().sum())
#%%-----------------------------------------------------------------------
#split the dataset
# separate the predictor and target variable

X = data.values[:, 1:]
Y = data.values[:, 0]

# split the dataset into train and test
X_train, X_test, y_train, y_test = train_test_split(X, Y, test_size=0.3, random_state=100)
#%%-----------------------------------------------------------------------
#perform training with random forest with all columns
# specify random forest classifier
clf = RandomForestClassifier(n_estimators=100)

# perform training
clf.fit(X_train, y_train)
#%%-----------------------------------------------------------------------
#plot feature importances
# get feature importances
importances = clf.feature_importances_

# convert the importances into one-dimensional 1darray with corresponding df column names as axis labels
f_importances = pd.Series(importances, data.iloc[:, 1:].columns)

# sort the array in descending order of the importances
f_importances.sort_values(ascending=False, inplace=True)

# make the bar Plot from f_importances
f_importances.plot(x='Features', y='Importance', kind='bar', figsize=(16, 9), rot=90, fontsize=15)

# show the plot
plt.tight_layout()
plt.show()
#%%-----------------------------------------------------------------------
#make predictions

# predicton on test using all features
y_pred = clf.predict(X_test)
y_pred_score = clf.predict_proba(X_test)

# %%-----------------------------------------------------------------------
# calculate metrics gini model

print("\n")
print("Results Using All Features: \n")

print("Classification Report: ")
print(classification_report(y_test,y_pred))
print("\n")

print("Accuracy : ", accuracy_score(y_test, y_pred) * 100)
print("\n")

print("ROC_AUC : ", roc_auc_score(y_test,y_pred_score[:,1]) * 100)

# %%-----------------------------------------------------------------------
# confusion matrix for gini model
conf_matrix = confusion_matrix(y_test, y_pred)
class_names = data['Survived'].unique()


df_cm = pd.DataFrame(conf_matrix, index=class_names, columns=class_names )

plt.figure(figsize=(5,5))

hm = sns.heatmap(df_cm, cbar=False, annot=True, square=True, fmt='d', annot_kws={'size': 20}, yticklabels=df_cm.columns, xticklabels=df_cm.columns)

hm.yaxis.set_ticklabels(hm.yaxis.get_ticklabels(), rotation=0, ha='right', fontsize=20)
hm.xaxis.set_ticklabels(hm.xaxis.get_ticklabels(), rotation=0, ha='right', fontsize=20)
plt.ylabel('True label',fontsize=20)
plt.xlabel('Predicted label',fontsize=20)
# Show heat map
plt.tight_layout()
plt.show()

