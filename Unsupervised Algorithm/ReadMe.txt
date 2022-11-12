Unsupervised Learning Algorithms

Unsupervised algorithms are relevant when we don’t have an outcome or labeled variable we are trying to predict.
They are helpful to find structures within our data set and when we want to partition our data set into smaller pieces. 

Dimensionality reduction is important in the context of large amounts of data.
The Curse of Dimensionality
In theory, a large number of features should improve performance. As models have more data to learn from, they should be more successful. But in practice, too many features lead to worse performance. There are several reasons why too many features end up leading to worse performance. If you have too many features, several things can be wrong, for example: 
- Some features can be spurious correlations, which means they correlate into the data set but not outside your data set, as long as new data comes in. 
- Too many features create more noise than signal.
- Algorithms find it hard to sort through non-meaningful features if you have too many features. 
- The number of training examples required increases exponentially with dimensionality.
- Higher dimensions slows performance.
- Larger data sets are computationally more expensive.
- Higher incidence of outliers. 
To fix these problems in real life, it's best to reduce the dimension of the data set. 
Similar to feature selection, you can use Unsupervised Machine Learning models such as Principal Components Analysis.

Common uses of clustering cases in the real world
1. Anomaly detection
Example: Fraudulent transactions.
Suspicious fraud patterns such as small clusters of credit card transactions with high volume of attempts, small amounts, for new merchants. This creates a new cluster and this is presented as an anomaly so perhaps there’s fraudulent transactions happening. 
2. Customer segmentation
You could segment the customers by recency, frequency, and average amount of visits in the last 3 months. Another common type of segmentation is by demographic and the level of engagement, for example, single costumers, new parents, empty nesters, etc. And the combinations of each with the preferred marketing channel, so you can use these insights for future marketing campaigns. 
3. Improve supervised learning
You can perform a Logistic regression for each cluster. This means training one model for each segment of your data to try to improve the classification.

Common uses of Dimension Reduction in the real world
1. Turn high-resolution images into compressed images
This means to come to a reduced, more compact version of those images, so they can still contain most of the data that can tell us what the image is about.  
2. Image tracking
Reduce the noise to the primary factors that are relevant in a video capture. The benefits of reducing the data set can greatly speed up the computational efficiency of the detection algorithms.   
