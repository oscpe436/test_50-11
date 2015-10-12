---
title: "Knapsack report"
author: "Oscar Pettersson and Vuong Tran"
date: "2015-10-12"
output: rmarkdown::html_vignette
vignette: >
  %\VignetteIndexEntry{Vignette Title}
  %\VignetteEngine{knitr::rmarkdown}
  \usepackage[utf8]{inputenc}
---

In this package we try three different algorithms for solving the knapsack problem. Our experimental data contains sampled values of weights and values for 2,000 objects, contained in a data.frame. The values are between 0 and 10,000 and the weights are between 1 and 4,000.


```r
library(Lab6)
set.seed(42)
n <- 2000
knapsack_objects <-
  data.frame(
    w=sample(1:4000, size = n, replace = TRUE),
    v=runif(n = n, 0, 10000)
  )
```

## Brute force algorithm

The first algorithm is the brute force algorithm. The approach of this algorithm is to test all possible existing combinations of objects. If we have n objects we have two to the power of n number of possible combinations. So the algorithm is very slow for large n:s. Below is an example:


```r
brute_force_knapsack(x = knapsack_objects[1:8,], W = 3500)
```

```
## $value
## [1] 16770.38
## 
## $elements
## [1] 5 8
```

So, the highest value that can be obtained from the first eight objects without exceding the maximum weigth of 3,500 weight-units is about 16 770 value-units, if objects 5 and 8 are used.

We use system.time() to measure the time it takes for the algorithm to solve the knapsack problem for 16 objects;



```r
system.time({
  brute_force_knapsack(x = knapsack_objects[1:16,], W = 2000)
})
```

```
##    user  system elapsed 
##  10.780   0.012  10.815
```

## Dynamic programming algorithm

Then, we proceed with the second algorithm for solving the knapsack problem. The dynamic programming algorithm only includes objects if their additional weight does not make the total weight exceed the maximum weight. Below is an example of this algorithm:


```r
knapsack_dynamic(x = knapsack_objects[1:8,], W = 3500)
```

```
## $value
## [1] 16770.38
## 
## $elements
## [1] 5 8
```

Here, the solution is obviously the same as for the brute force algorithm and this is always true. However, the differene between the algorithms can be seen when we use system.time() for a bigger number of objects:



```r
system.time({
  knapsack_dynamic(x = knapsack_objects[1:16,], W = 2000)
})
```

```
##    user  system elapsed 
##   0.988   0.004   0.997
```

When writing this, the dynamic programming algorithm is about 10 times faster than the brute force algorithm.


```r
system.time({
  knapsack_dynamic(x = knapsack_objects[1:500,], W = 2000)
})
```

```
##    user  system elapsed 
##  37.543   0.012  37.623
```

Another simulation, with 500 objects took around 15 seconds to perform.

## Greedy algorithm

Lastly, we try a greedy algorithm, that includes the objects with the highest value per weight, as long as the weight limit is not exceeded. This algorithm does not always give the optimal solution, but the total value is at least 50 % of the optimal total value.
Below, we see that the result differ for the eight first objects:


```r
greedy_knapsack(x = knapsack_objects[1:8,], W = 3500)
```

```
## $value
## [1] 15427.81
## 
## $elements
## [1] 8 3
```

However, the greediness make the algorithm super fast!


```r
system.time({
  greedy_knapsack(x = knapsack_objects[1:500,], W = 2000)
})
```

```
##    user  system elapsed 
##   0.012   0.000   0.012
```

So, we test if the algorithm can handle very large numbers of objects: 


```r
set.seed(42)
n <- 1E6
knapsack_objects <-
  data.frame(
    w=sample(1:4000, size = n, replace = TRUE),
    v=runif(n = n, 0, 10000)
  )
system.time({
  greedy_knapsack(x = knapsack_objects, W = 2000)
})
```

```
##    user  system elapsed 
##  22.789   0.016  22.864
```
As the output shows, it takes less than two times for greedy approach to run the code for one million objects compared to the brute force approach to run 16 objects.   

## Speed improvement

We want to improve the speed of the brute force algorithm and try to profile the function using both lineprof() from the lineprof package and Rprof() from the utils package. lineprof() does not give us any clue except that working with the data frame is what uses most resources. Rprof(), on the other hand, claims that the line where we create dummy variables using intToBits() is using more than half of the CPU-time. All of the lines in the for loop are, not surprisingly, the lines that use most resources in total. But using a data frame was part of the assignment and we have to create the dummy variables somehow and see no faster alternative than intToBits, so instead we create a C++ implementation of the algorithm.

## Brute force algorithm with C++ code


```r
 system.time({
  brute_force_knapsack_C(x = knapsack_objects[1:16,], W = 2000)
 })
```

```
##    user  system elapsed 
##   0.056   0.004   0.061
```

The output shows that the C++ implementation of the brute force algorithm is about ten times faster than the R implementation of the dynamic programming algorithm, and approximately 100 times faster than the R implementation of the brute force algorithm.

> "Jag har rätt, du har fel!"
([via](https://twitter.com/hadleywickham/status/504368538874703872))

