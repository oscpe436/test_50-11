
set.seed(42)
n <- 2000
knapsack_objects <- data.frame(
  w=sample(1:4000, size = n, replace = TRUE),
  v=runif(n = n, 0, 10000)
)



context("functions rejects errounous input")

test_that("functions rejects errounous input.", {
  expect_error(brute_force_knapsack("hej",3500))
  expect_error(knapsack_dynamic("hej",3500))
  expect_error(greedy_knapsack("hej",3500))


  expect_error(brute_force_knapsack(x = knapsack_objects[1:8,], W = -3500))
  expect_error(knapsack_dynamic(x = knapsack_objects[1:8,], W = -3500))
  expect_error(greedy_knapsack(x = knapsack_objects[1:8,], W = -3500))

})



context("functions return the same results")
test_that("functions return the same results.", {

  expect_equal(brute_force_knapsack(x = knapsack_objects[1:8,], W = 3500), knapsack_dynamic(x = knapsack_objects[1:8,], W = 3500))
  expect_equal(brute_force_knapsack(x = knapsack_objects[1:12,], W = 3500), knapsack_dynamic(x = knapsack_objects[1:12,], W = 3500))
  expect_equal(brute_force_knapsack(x = knapsack_objects[1:8,], W = 2000), knapsack_dynamic(x = knapsack_objects[1:8,], W = 2000))
  expect_equal(brute_force_knapsack(x = knapsack_objects[1:12,], W = 2000), knapsack_dynamic(x = knapsack_objects[1:12,], W = 2000))

  expect_equal(knapsack_dynamic(x = knapsack_objects[1:8,], W = 3500) , brute_force_knapsack_C(x = knapsack_objects[1:8,], W = 3500))
  expect_equal(knapsack_dynamic(x = knapsack_objects[1:12,], W = 3500) , brute_force_knapsack_C(x = knapsack_objects[1:12,], W = 3500))
  expect_equal(knapsack_dynamic(x = knapsack_objects[1:8,], W = 2000) , brute_force_knapsack_C(x = knapsack_objects[1:8,], W = 2000))
  expect_equal(knapsack_dynamic(x = knapsack_objects[1:12,], W = 2000) , brute_force_knapsack_C(x = knapsack_objects[1:12,], W = 2000))

})



context("functions return correct specific results")
test_that("functions return correct specific results.", {

  expect_equal(knapsack_dynamic(x = knapsack_objects[1:8,], W = 3500), list(value=16770.38, elements=c(5,8)), tolerance = 1E-3)
  expect_equal(knapsack_dynamic(x = knapsack_objects[1:12,], W = 3500), list(value=16770.38, elements=c(5,8)), tolerance = 1E-3)
  expect_equal(knapsack_dynamic(x = knapsack_objects[1:8,], W = 2000), list(value=15427.81, elements=c(3,8)), tolerance = 1E-3)
  expect_equal(knapsack_dynamic(x = knapsack_objects[1:12,], W = 2000), list(value=15427.81, elements=c(3,8)), tolerance = 1E-3)

})





