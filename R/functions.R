
set.seed(42)
n <- 2000
knapsack_objects <- data.frame(
  w=sample(1:4000, size = n, replace = TRUE),
  v=runif(n = n, 0, 10000)
)
rm(n)


StopOurFunction<-function(x,W){

  stopifnot(is.data.frame(x))
  stopifnot(colnames(x)==c("w","v"))
  stopifnot(is.numeric(x$w) & is.numeric(x$v))
  stopifnot(x$w>0 & x$v>0 & W>0)

}



brute_force_knapsack<-function(x,W){

  StopOurFunction(x,W)

  no_of_objects <- nrow(x)
  no_of_sets <- 2^nrow(x)
  weights <- rep(NA, no_of_sets)
  values <- rep(NA, no_of_sets)
  selected_objects <- as.list(numeric(no_of_sets))

  for(i in 1:no_of_sets){
    selected_objects[[i]] <- as.numeric(intToBits(i)[1:(no_of_objects)])
    sample <- x[selected_objects[[i]] == 1,]
    weights[i] <- sum(sample[,1])
    values[i] <- sum(sample[,2])
  }
  index_OK <- which(weights<W)
  weightsOK <- weights[index_OK]
  valuesOK <- values[index_OK]
  index_best <- which.max(valuesOK)

  best_elements <- (1:no_of_objects)[selected_objects[index_OK[index_best]][[1]]==1]
  best_elements <- best_elements[order(best_elements, decreasing = FALSE)]
  return(list(value=values[index_OK[index_best]], elements=best_elements))

}



knapsack_dynamic<-function(x, W){

  StopOurFunction(x,W)
  stopifnot( x$w %% 1 == 0)

  best_elements <- numeric(0)
  n<-nrow(x)
  m<-matrix(nrow=n+1,ncol=W+1)
  for (i in 1:(W+1)){
    m[1,i]<-0
  }

  for(i in 1:n){
    for(j in 1:(W+1)){
      if(x$w[i]<=j){
        m[i+1,j] <- max( m[i,j] , m[i,j-x$w[i] ]+x$v[i])
      }else{
        m[i+1,j] <- m[i,j]
      }
    }
  }

  i <- i + 1

  while(i > 1 ){

    if( m[i-1,j] < m[i,j] ){

      best_elements <- c(best_elements, i-1)

      i <- i - 1
      j <- j - x$w[i]
    }else{
      i <- i - 1
    }

  }

  best_elements <- best_elements[order(best_elements, decreasing = FALSE)]

  return(list(value=m[nrow(m), ncol(m)],elements=best_elements))

}



greedy_knapsack <- function(x, W){

  StopOurFunction(x,W)
  value_per_weight <- x$v/x$w
  index <- order(value_per_weight, decreasing = TRUE)

  elements <- numeric(0)
  total_weight <- 0
  total_value <- 0

  for(i in index){

    if( (x$w[i] + total_weight) <= W){
      elements <- c(elements, i)
      total_weight <- x$w[i] + total_weight
      total_value <- x$v[i] + total_value
    }
  }

  return(list(value = total_value, elements = elements))
}



brute_force_knapsack_C <- function(x, W){

  StopOurFunction(x, W)
  out <- bf_cpp(as.matrix(x), W)
  names(out) <- c("value", "elements")
  return(out)

}

