#Function_1
# title: remove_missing()
# description: takes a vector, returns the input vector without missing values
# input parameters: a vector
# output: a vector without missing values
remove_missing <- function(the_vector){
  the_vector <- the_vector[!is.na(the_vector)]
  the_vector
}

#Function_2
#title: get_minimum
#description: takes a numeric vector, and an optional logical na.rm argument, to find the minimum values
#input: a numeric vector
#output:the smallest number in the vector

get_minimum <- function(the_vector, na.rm=FALSE){
  if (na.rm == TRUE){
    the_vector <- remove_missing(the_vector)
  } 
  for (x in the_vector){
    if (is.na(x)){
      stop("non-numeric argument")
    }
  }
  the_vector <- sort(the_vector)
  return (the_vector[1])
}




#Function_3
#title:get_maximum
#description: takes a numeric vector, and an optional logical na.rm argument, to find the maximum values
#input: a numeric vector
#output: the biggest number in the vector

get_maximum <- function(the_vector, na.rm=FALSE){
  if (na.rm == TRUE){
    the_vector <- remove_missing(the_vector)
  } 
  for (x in the_vector){
    if (is.na(x)){
      stop("non-numeric argument")
    }
  }
  the_vector <- sort(the_vector,decreasing = TRUE)
  return (the_vector[1])
}

#Function_4 
#title:get_range
#description:takes a numeric vector, and an optional logical na.rm argument, to compute the overall range of the input vector
#input: a numeric vector
#output: the range of all the numbers in the vector

get_range <- function(the_vector,na.rm=FALSE){
  if (na.rm == TRUE){
    the_vector <- remove_missing(the_vector)
  }
  for (x in the_vector){
    if (is.na(x)){
      stop("non-numeric argument")
    }
  }
  range <- get_maximum(the_vector) - get_minimum(the_vector)
  range
}

#Function_5
#title:get_percentile10
#description: A function that takes a numeric vector, and an optional na.rm argument, to compute the 10th percentile of the input vector
#input: a numeric vector
#output: the 10th percentile of the input vector

get_percentile10 <- function(the_vector,na.rm=FALSE){
  if (na.rm == TRUE){
    the_vector <- remove_missing(the_vector)
  }
  for (x in the_vector){
    if (is.na(x)){
      stop("non-numeric argument")
    }
  }
  return (quantile(the_vector,probs=0.1,names=FALSE))
}

#Function_6
#title:get_percentile90
#description: A function that takes a numeric vector, and an optional na.rm argument, to compute the 90th percentile of the input vector
#input: a numeric vector
#output: the 90th percentile of the input vector

get_percentile90 <- function(the_vector,na.rm=FALSE){
  if (na.rm == TRUE){
    the_vector <- remove_missing(the_vector)
  }
  for (x in the_vector){
    if (is.na(x)){
      stop("non-numeric argument")
    }
  }
  return (quantile(the_vector,probs=0.9,names=FALSE))
}



#Function_6
#title:get_median
#description: A function that takes a numeric vector, and an optional na.rm argument, to compute the median of the input vector
#input: a numeric vector
#output: the median of the input vector
check_remove <- function(the_vector,na.rm=FALSE){
  if (na.rm == TRUE){
    the_vector <- remove_missing(the_vector)
  }
}


get_median <- function(the_vector,na.rm=FALSE){
  the_vector <- check_remove(the_vector,na.rm)
  the_vector <- sort(the_vector)
  vec_len <- length(the_vector)
  if (vec_len %% 2 != 0){
    num <- (vec_len + 1)/2
    return (the_vector[num])
  } else {
    num_1 <- vec_len/2
    num_2 <- num_1 + 1
    result <- (the_vector[num_1] + the_vector[num_2])/2
    return (result)
  }
  }





#Function_7
#title:get_average
#description: A function that takes a numeric vector, and an optional na.rm argument, to compute the average of the input vector
#input: a numeric vector
#output: the average of the input vector
check_remove <- function(the_vector,na.rm=FALSE){
  if (na.rm == TRUE){
    the_vector <- remove_missing(the_vector)
  }
}


get_average <- function(the_vector,na.rm=FALSE){
  the_vector <- check_remove(the_vector,na.rm)
  for (x in the_vector){
    if (is.na(x)){
      stop("non-numeric argument")
    }
  }
  sum <- 0
  for (i in the_vector){
    sum <- sum + i
  }
  vec_len <- length(the_vector)
  result <- sum/vec_len
  return (result)
}



#Function_8
#title:get_stdev()
#description: A function that takes a numeric vector, and an optional na.rm argument, to compute the standard deviation of the input vector
#input: a numeric vector
#output: the standard deviation of the input vector

check_remove <- function(the_vector,na.rm=FALSE){
  if (na.rm == TRUE){
    the_vector <- remove_missing(the_vector)
  }
}
``


get_stdev <- function(the_vector,na.rm=FALSE){
  the_vector <- check_remove(the_vector,na.rm)
  ave <- get_average(the_vector,na.rm)
  counter <- 0
  for (i in the_vector){
    counter = counter + (i-ave)^2 
  }
  result <- sqrt(counter/(length(the_vector) - 1))
  result
}



#Function_9
#title:get_quartile1
#description: A function that takes a numeric vector, and an optional na.rm argument, to compute the first quartile of the input vector
#input: a numeric vector
#output: the first quartile of the input vector


get_quartile1 <- function(the_vector,na.rm=FALSE){
  if (na.rm == TRUE){
    the_vector <- remove_missing(the_vector)
  }
  for (x in the_vector){
    if (is.na(x)){
      stop("non-numeric argument")
    }
  }
  return (quantile(the_vector,probs=0.25,names=FALSE))
}



#Function_10
#title:get_quartile3
#description: A function that takes a numeric vector, and an optional na.rm argument, to compute the third quartile of the input vector
#input: a numeric vector
#output: the third quartile of the input vector

get_quartile3 <- function(the_vector,na.rm=FALSE){
  if (na.rm == TRUE){
    the_vector <- remove_missing(the_vector)
  }
  for (x in the_vector){
    if (is.na(x)){
      stop("non-numeric argument")
    }
  }
  return (quantile(the_vector,probs=0.75,names=FALSE))
}


#Function_11
#title:count_missing
#description: A function that takes a numeric vector, and calculates the number of missing values NA
#input: a numeric vector
#output: the number of missing values in the input vector

count_missing <- function(the_vector){
  counter <- 0
  for (i in the_vector){
    if (is.na(i)){
      counter = counter + 1
    }
  }
  counter
}


#Function_12
#title:summary_stats
#description: A function that takes a numeric vector, and returns a list of summary statistics
#input: a numeric vector
#output: a list of summary statistics

summary_stats <- function(the_vector,is.na=TRUE){
  helper <- list(get_minimum(the_vector,is.na),get_percentile10(the_vector,is.na),get_quartile1(the_vector,is.na),
                 get_median(the_vector,is.na),get_average(the_vector,is.na),get_quartile3(the_vector,is.na),
                 get_percentile90(the_vector,is.na),get_maximum(the_vector,is.na),get_range(the_vector,is.na),
                 get_stdev(the_vector,is.na),count_missing(the_vector))
  names(helper) <- c("minimum","percent10","quartile1","median","mean","quartile3","percent90",
                    "maximum","range","stdev","missing" )
  helper
}


#Function_13
#title:print_stats
#description: A function that takes a list of summary statistics and prints the value in nice format
#input: a list of summary statistics
#output: nice format summary

print_stats <- function(lst_stats){
  lst_names <- names(lst_stats)
  for (i in 1:length(lst_stats)){
    helper <- paste0(format(lst_names[i],width=9,justify="left"),": ", sprintf("%.4f",lst_stats[[i]]))
    print(helper,quote=FALSE)
  }
}

#Function_14
#title:rescale100
#description: A function that takes three arguments to compute a rescaled vector
#input: a numeric vector
#output: a rescaled vector

rescale100 <- function(the_vector,xmin,xmax){
  rescale_vector <- c()
  counter <- 1
  for (i in the_vector){
    z <- 100*((i-xmin)/(xmax-xmin))
    rescale_vector[counter] <- z
    counter = counter+1
  }
  rescale_vector
}

#Function_15
#title:drop_lowest
#description: A function that takes a numeric vector and return a new vector droping the lowest value
#input: a numeric vector
#output: a new vector dropping the lowest vakue

drop_lowest <- function(the_vector){
  the_vector <- sort(the_vector)
  the_vector <- the_vector[-1]
  the_vector
}

#Function_16
#title:score_homework
#description: A function that takes a numeric vectorof homework scores and an on optional logical argument drop to compute a single homework score
#input:a numeric vector
#output:a single homeowork score

score_homework <- function(the_vector,drop=FALSE){
  if (drop==TRUE){
    the_vector <- drop_lowest(the_vector)
  }
  get_average(the_vector,na.rm=TRUE)
}

#Function_17
#title:score_quiz
#description: A function that takes a numeric vectorof quiz scores and an on optional logical argument drop to compute a single quiz score
#input:a numeric vector
#output:a single quiz score

score_quiz <- function(the_vector,drop=FALSE){
  if (drop==TRUE){
    the_vector <- drop_lowest(the_vector)
  }
  get_average(the_vector,na.rm=TRUE)
}

#Function_18
#title:score_lab
#description: A function that takes a lab attendance score and return the lab score
#input:a numeric score for attendance
#output:a single lab score

score_lab <- function(lab_attendance){
  if (lab_attendance >= 11){
    return (100)
  } else if (lab_attendance==10){
    return (80)
  } else if (lab_attendance==9){
    return (60)
  } else if (lab_attendance == 8){
    return (40)
  } else if (lab_attendance == 7){
    return (20)
  } else {
    return (0)
  }
}




