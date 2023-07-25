---
title: "Grocery Association Rules"

output: html_document
---
The Groceries data set contains 1 month (30 days) of real-world point-of-sale transaction data from
a typical local grocery outlet. The data set contains 9835 transactions with items that are aggregated
to 169 categories, stored in sparse format. The dataset is part of the "arules" package and can be
loaded by calling data(Groceries).

##Tasks
In this assignment, you will gain practical experience with mining frequent itemsets and association
rules. Solve the tasks using R (package "arules") and answer the questions.

```{r imports}
library(arules)
data(Groceries)
```

##Task 1 
Plot a histogram of the number of items (number of categories) per transaction. What do you
observe? How can you explain this observation?

```{r Task1}
hist(size(Groceries), main = "Number of Transactions by Size", xlab = "# Groceries in Transaction")
```

Most people only buy a small amount of items from a grocery store. Usually they only the few items they need at that moment, rather than buying all their groceries at once.

##Task 2 
How many frequent itemsets, closed frequent itemsets, and maximal frequent itemsets do you
obtain with minimum support = 0.001? How many with minimum support = 0.01?

```{r Frequent, Closed and Maximal itemsets with support of 0.001}
freq_items1 = eclat(Groceries, parameter = list(supp = 0.001))
length(freq_items1)
closed1 = is.closed(freq_items1)
length(closed1[closed1 == TRUE])
max1 = is.maximal(freq_items1)
length(max1[max1 == TRUE])
```

```{r Frequent, Closed and Maximal itemsets with support of 0.01}
freq_items2 = eclat(Groceries, parameter = list(supp = 0.01))
length(freq_items2)
closed2 = is.closed(freq_items2)
length(closed2[closed2 == TRUE])
max2 = is.maximal(freq_items2)
length(max2[max2 == TRUE])
```

For support of 0.001, there are a total of 13492 frequent itemsets, 13464 closed itemsets, and 7794 maximal itemsets. For support of 0.01, there are a total of 333 frequent itemsets, 333 closed itemsets, and 243 maximal itemsets.

##Task 3
What are the 10 itemsets with the highest support, and what is their support?

```{r Support of top 10 itemsets}
itemFrequencyPlot(Groceries, topN = 10, main="Top 10 Itemsets by Support")
head(sort(itemFrequency(Groceries), decreasing = TRUE), n = 10)
```


##Task 4
How do you explain the relatively small number of frequent itemsets for the already low
minimum support of 0.01? How do you explain the observation that the numbers of frequent
itemsets, closed frequent itemsets, and maximal frequent itemsets are so similar?

The majority of itemsets have a very small minimum support value because they don't occur very frequently. Most people don't tend to purchase the same types of products if they plan to buy items like candy, international goods, etc. That is why setting minimum support to 0.01 removes many of the itemsets. The most frequently occuring itemsets most likely are essential items that almost all shoppers buy at the grocery store. This includes staples like milk, bread, vegetables, etc. This would explain why the frequent itemsets, closed itemsets, and maximal itemsets are similar in size. While people can buy many different combinations of groceries, if they are only going to buy staple items then they are most likely to purchase the same kind of items.

##Task 5
At minimum support = 0.01, how many association rules do you obtain with minimum
confidence = 0.9? How far do you need to lower the minimum confidence to obtain more than 10
rules?

```{r}
rules = apriori(Groceries, parameter = list(supp = 0.01, conf = 0.9))
summary(rules)
```

With minimum support of 0.01 and confidence of 0.9, no rules are generated.

```{r}
rules = apriori(Groceries, parameter = list(supp = 0.01, conf = 0.51))
summary(rules)
```

In order to generate at least 10 rules, the confidence must be lowered to at most 0.52.

##Task 6
For minimum support = 0.01 and minimum confidence = 0.5, print only the rules that have
"whole milk" in their right hand side.

```{r}
rules = apriori(Groceries, parameter = list(supp = 0.01, conf = 0.5))
milk_rules = subset(rules, subset = rhs %pin% "whole milk")
inspect(milk_rules)
```

##Task 7
Among the rules produced in task 6, which ones have the highest lift? How interesting are they?

The rules with the highest lift are curd, yogurt => milk with lift of 2.28, other vegetables, butter => milk with lift 2.24, and tropical fruit, root vegetables => milk with lift of 2.23. These results are interesting because a lift that is much greater than 1 indicates a strong association in the rule.