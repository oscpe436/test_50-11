## ------------------------------------------------------------------------
library(Lab6)
set.seed(42)
n <- 2000
knapsack_objects <-
  data.frame(
    w=sample(1:4000, size = n, replace = TRUE),
    v=runif(n = n, 0, 10000)
  )

## ------------------------------------------------------------------------
brute_force_knapsack(x = knapsack_objects[1:8,], W = 3500)

## ------------------------------------------------------------------------
system.time({
  brute_force_knapsack(x = knapsack_objects[1:16,], W = 2000)
})

## ------------------------------------------------------------------------
knapsack_dynamic(x = knapsack_objects[1:8,], W = 3500)

## ------------------------------------------------------------------------
system.time({
  knapsack_dynamic(x = knapsack_objects[1:16,], W = 2000)
})

## ------------------------------------------------------------------------
system.time({
  knapsack_dynamic(x = knapsack_objects[1:500,], W = 2000)
})

## ------------------------------------------------------------------------
greedy_knapsack(x = knapsack_objects[1:8,], W = 3500)

## ------------------------------------------------------------------------
system.time({
  greedy_knapsack(x = knapsack_objects[1:500,], W = 2000)
})

## ------------------------------------------------------------------------
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

## ------------------------------------------------------------------------
 system.time({
  brute_force_knapsack_C(x = knapsack_objects[1:16,], W = 2000)
 })

