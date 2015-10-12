
#' Different approaches to knapsack problem
#'
#' Three differens approaches to solve the knapsack problem: Brute force, dynamic programming and greedy approaches.
#' @param x is object that contains two vectors with weights and values. Must be a data frame with two colums w and v.
#' @param W is maximum weight and must be a Numeric number.
#' @examples brute_force_knapsack(x = knapsack_objects[1:8,], W = 3500)
#' @return A list with two elements; the maximum value and the elements that are packed.
"brute_force_knapsack"


#' Different approaches to knapsack problem
#'
#' Three differens approaches to solve the knapsack problem: Brute force, dynamic programming and greedy approaches.
#' @param x is object that contains two vectors with weights and values. Must be a data frame with two colums w and v.
#' @param W is maximum weight and must be a Numeric number.
#' @examples knapsack_dynamic(x = knapsack_objects[1:8,], W = 3500)
#' @return A list with two elements; the maximum value and the elements that are packed.
"knapsack_dynamic"



#' Different approaches to knapsack problem
#'
#' Three differens approaches to solve the knapsack problem: Brute force, dynamic programming and greedy approaches.
#' @param x is object that contains two vectors with weights and values. Must be a data frame with two colums w and v.
#' @param W is maximum weight and must be a Numeric number.
#' @examples greedy_knapsack(x = knapsack_objects[1:8,], W = 3500)
#' @return A list with two elements; the maximum value and the elements that are packed.
"greedy_knapsack"



#' C++ implementation of the brute force algorithm
#'
#' An improved function of \link{brute_force_knapsack}. The function is an R function wrapped around a C++ function.
#' @param x Same as for \link{brute_force_knapsack}, but must be a matrix.
#' @param W Same as for \link{brute_force_knapsack}.
#' @examples brute_force_knapsack_C(x = knapsack_objects[1:8,], W = 3500)
#' @return A list with two elements; the maximum value and the elements that are packed.
"brute_force_knapsack_C"



#' Knapsack algorithms
#'
#' Contains three algorithms for solving the knapsack problem; the brute force, dynamic programming and greedy approaches. The brute force algorithm is implemented as both R and C++ functions.
#' @examples brute_force_knapsack(x = knapsack_objects[1:8,], W = 3500)
#' @name Lab6
#' @docType package
#' @seealso The functions: \link{brute_force_knapsack}.
#' @references Information about the knapsack problem and the three approaches: \url{https://en.wikipedia.org/wiki/Knapsack_problem}.
NULL





#' An example set of objects.
#'
#' A sampled set of 2,000 objects with weights and values. The weights are discrete values.
#'
#' @format A data frame with 2,000 rows and 2 variables \code{w} and \code{v}:
#' \describe{
#'   \item{w}{containing a vector of weights}
#'   \item{v}{containing a vector of values}
#' }
"knapsack_objects"


