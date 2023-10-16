import pandas as pd
import numpy as np

# 1
tennis_ex = pd.read_csv('tennis.csv')
target = tennis_ex['play']
predictors = tennis_ex.drop('play', axis = 1)
print(tennis_ex)
print(target)
print(predictors)

# 2

import math


def calculate_entropy(feature):

    # Calculate the frequency of each unique value in the vector
    value_counts = {}
    n = len(feature)
    for value in feature:
        if value in value_counts:
            value_counts[value] += 1
        else:
            value_counts[value] = 1

    # Calculate the entropy
    entropy = 0
    for count in value_counts.values():
        #only looking at values in the dictionary value_counts(which correspond to number of occurences of a value)
        p = count / n
        #calculate probability of getting a value of a feature
        entropy -= p * math.log2(p)

    return entropy

# 3
#IG = Entropy(parent) – Average Entropy(children)


# calculate the entropy of the target variable
target_entropy = calculate_entropy(tennis_ex['play'])
print('target entropy is :', target_entropy)

# loop through each feature and calculate information gain except 'play'
for feature in tennis_ex.columns[:-1]:
    # calculate the entropy of the feature split
    feature_entropy = 0
    for value in tennis_ex[feature].unique():
        value_subset = tennis_ex[tennis_ex[feature] == value]['play']
        value_entropy = calculate_entropy(value_subset)
        feature_entropy += (len(value_subset) / len(tennis_ex)) * value_entropy

    # calculate the information gain
    information_gain = target_entropy - feature_entropy

    # print the result
    print("Information gain for {}: {}".format(feature, information_gain))

# 4
#outlook has most inforamtion gain
subsets = {}
for value in tennis_ex['outlook'].unique():
    subsets[value] = tennis_ex[tennis_ex['outlook'] == value].drop('outlook', axis=1)

print(subsets)

# 5
subset_sunny = subsets['sunny']
subset_overcast = subsets['overcast']
subset_rainy = subsets['rainy']

subsets_new = [subset_sunny,subset_overcast,subset_rainy]
print(subsets_new)

for subset in subsets_new:

    subset_entropy = calculate_entropy(subset['play'])
    subset_samples = len(subset)

    # Compute distribution of target values
    target_counts = subset['play'].value_counts()
    target_distribution = {value: count / subset_samples for value, count in target_counts.items()}

    # Print statistics for this subset
    print(f"Subset size: {subset_samples}")
    print(f"Target distribution: {target_distribution}")
    print(f"Subset entropy: {subset_entropy}")
    print()


#Compute and print statistics (entropy, number of sample,
#distribution of target values) for each of the classes resulted from the
#split.



