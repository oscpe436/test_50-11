#include <bitset>
#include <Rcpp.h>
using namespace Rcpp;

// [[Rcpp::export]]
std::vector< int > get_bits( unsigned long x ) {
    std::string chars( std::bitset< sizeof(long) * CHAR_BIT >( x )
        .to_string( char(0), char(1) ) );
    return std::vector< int >( chars.begin(), chars.end() );
}


// [[Rcpp::export]]
List bf_cpp(NumericMatrix x, int W){

  int no_of_objects = x.nrow();
  int no_of_sets = pow(2, no_of_objects);
  NumericVector weights(no_of_sets);
  NumericVector values(no_of_sets);
  NumericVector index_OK(no_of_sets);
  List selected_objects(no_of_sets);
  int max_value = 0;
  int index_of_best= 0;
  NumericVector best_objects(no_of_objects);
  NumericVector almost_return_object(no_of_objects);
  int i, j;

  std::vector< int > binary, include_obj(no_of_objects);

  for(i=0 ; i<(no_of_sets - 1) ; i++){

    binary = get_bits(i+1);
    weights[i] = 0;
    values[i] = 0;

    for(j=0 ; j<no_of_objects ; j++){

      include_obj[j] = binary[31-j];

      if(include_obj[j] == 1){
        weights[i] += x(j,0);
        values[i] += x(j,1);
      }
    }

    if(weights[i]<=W){
      index_OK[i]=1;

      if(values[i] > max_value){
        index_of_best = i;
        max_value = values[i];
      }

    }else{
      index_OK[i]=0;
    }

    selected_objects[i] = include_obj;
  }

  best_objects = selected_objects[index_of_best];
  j=0;

  for(i=0 ; i < no_of_objects ; i++){
    if(best_objects[i] == 1){
      almost_return_object[j] = i+1;
      j = j+1;
    }

  }

  NumericVector return_object(j);
  for(i=0;i<j;i++){
    return_object[i] = almost_return_object[i];
  }

  return List::create(values[index_of_best], return_object);
}




