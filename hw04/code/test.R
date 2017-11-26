## Title: test
## Descriptions: This script test the correctness of all the functions
## Inputs: test
## Output: correctness



install.packages("testthat")
library(testthat)

# Test for function One
context("remove_missing")


test_that("remove_missing removes all NA values and return a vector",{
  expect_identical(remove_missing(c(NA,NA,2,3,4)),c(2,3,4))
  expect_identical(remove_missing(c(NA,NA)),logical(0))
  expect_is(remove_missing(c(NA,NA,2,3,4)),"numeric")
})

test_that("remove_missing only takes one argument",{
  expect_error(remove_missing(NA,NA),"unused argument")
  expect_error(remove_missing(c(1,2,3,4),list(5)),"unused argument")
})

# Test for function Two
context("get_minimum")

test_that("get the minimum values of a vector",{
  expect_equal(get_minimum(c(2,3,4,5),na.rm=TRUE), 2)
  expect_equal(get_minimum(c(-1,-5,-10,3),na.rm=TRUE),-10)
  expect_equal(length(get_minimum(c(2,3,4,5),na.rm=TRUE)),1)
  expect_equal(length(get_minimum(c(-1,-5,-10,3),na.rm=TRUE)),1)
})

test_that("error if na.rm is FALSE and contains NA",{
  expect_error(get_minimum(c(2,3,4,NA)),"non-numeric argument")
})

# Test for function Three
context("get_maximum")

test_that("get the maximum values of a vector",{
  expect_equal(get_minimum(c(2,3,4,5)), 2)
  expect_equal(get_minimum(c(-1,-5,-10,3)),-10)
  expect_equal(length(get_minimum(c(2,3,4,5))),1)
  expect_equal(length(get_minimum(c(-1,-5,-10,3))),1)
})

test_that("error if na.rm is FALSE and contains NA",{
  expect_error(get_maximum(c(2,3,4,NA)),"non-numeric argument")
})


# Test for function four
context("get_range")

test_that("get the overall range of the input vector",{
  expect_equal(get_range(c(1,2,3,4,5)),4)
  expect_equal(get_range(c(-1,-2,-3,-4,-5)),4)
  expect_equal(length(get_range(c(1,2,3,4,5))),1)
})

test_that("error if na.rm if FALSE and contains NA",{
  expect_error(get_range(c(2,3,4,NA)),"non-numeric argument")
})

# Test for function Five
context("get_percentile10")

test_that("get the 10th percentile of the input vector",{expect_equal(get_percentile10(c(1,1,2,3,7)),1)
          expect_equal(get_percentile10(c(1,2,3,4,5,6,7,8,9,10)),1.9)
          })

test_that("error if na.rm is FALSE and contains NA",{
  expect_error(get_percentile10(c(1,1,2,3,7,NA)),"non-numeric argument")
  expect_error(get_percentile10(c(1,2,3,4,5,6,7,8,9,10,NA)),"non-numeric argument")
})

# Test for function Six
context("get_percentile90")

test_that("get the 90th percentile of the input vector",
          {expect_equal(get_percentile90(c(1,1,2,3,7)),5.4)
          expect_equal(get_percentile90(c(1,2,3,4,5,6,7,8,9,10)),9.1)
          })


test_that("error if na.rm is FALSE and contains NA",{
  expect_error(get_percentile90(c(1,1,2,3,7,NA)),"non-numeric argument")
  expect_error(get_percentile90(c(1,2,3,4,5,6,7,8,9,10,NA)),"non-numeric argument")
})

# Test for function Seven
context("get_median")

test_that("get the middle number if there is odd number",{
  expect_equal(get_median(c(1,2,3,4,5),na.rm=TRUE),3)
  expect_equal(get_median(c(1,2,8,99,100),na.rm=TRUE),8)
})

test_that("get the mean of two central number if there is even number",{
  expect_equal(get_median(c(1,2,3,4,5,6),na.rm=TRUE),3.5)
  expect_equal(get_median(c(1,2,8,9,99,100),na.rm=TRUE),8.5)
})

test_that("remove NA if na.rm is TRUE",{
  expect_equal(get_median(c(1,2,3,4,5,NA),na.rm=TRUE),3)
})

# Test for function Eight
context("get_average")

test_that("get the average of a vector",{
  expect_equal(get_average(c(1,2,3,4,5),na.rm=TRUE),3)
  expect_equal(get_average(c(100,1000,10000,100000),na.rm=TRUE),27775)
  expect_equal(get_average(c(10,15,20,25,30),na.rm=TRUE),20)
})

test_that("remove NA if na.rm is TRUE",{
  expect_equal(get_average(c(1,2,3,4,5,NA),na.rm=TRUE),3)
})


# Test for function Nine
context("get_stdev")

test_that("get the standard deviation of a vector",{
  expect_equal(get_stdev(c(1,100),na.rm=TRUE),sd(c(1,100)))
  expect_equal(get_stdev(c(1,5,10,15),na.rm=TRUE),sd(c(1,5,10,15)))
})

test_that("remove NA if na.rm is TRUE",{
  expect_equal(get_stdev(c(100,1000,10000,100000,NA),na.rm=TRUE),sd(c(100,1000,10000,100000)))
  expect_equal(get_stdev(c(5,10,15,20,NA),na.rm=TRUE),sd(c(5,10,15,20)))
})



# Test for function Ten
context("get_quartile1")

test_that("get the first quartile of the input vector",{
  expect_equal(get_quartile1(c(1,2,3,4,5)),2)
  expect_equal(get_quartile1(c(1,3,5,7,9)),3)
})

test_that("remove NA if na.rm is TRUE",{
  expect_equal(get_quartile1(c(1,2,3,4,5,NA),na.rm=TRUE),2)
})

test_that("Error if na.rm is FALSE and contains NA",{
  expect_error(get_quartile1(c(1,2,3,4,5,NA)),"non-numeric argument")
})

# Test for function Eleven
context("get_quartile3")

test_that("get the third quartile of the input vector",{
  expect_equal(get_quartile3(c(1,2,3,4,5)),4)
  expect_equal(get_quartile3(c(1,3,5,7,9)),7)
})

test_that("remove NA if na.rm is TRUE",{
  expect_equal(get_quartile3(c(1,2,3,4,5,NA),na.rm=TRUE),4)
})

test_that("Error if na.rm is FALSE and contains NA",{
  expect_error(get_quartile3(c(1,2,3,4,5,NA)),"non-numeric argument")
})

# Test for function Twelve
context("count_missing")

test_that("count the number of missing values in a vector",{
  expect_equal(count_missing(c(1,4,10,NA,8)),1)
  expect_equal(count_missing(c(1,4,10,NaN,8)),1)
  expect_equal(count_missing(c(1,3)),0)
  expect_equal(count_missing(c(1,3,NULL)),0)
})

# Test for function Thirteen
context("summary_stats")

test_that("return a list of summary statistics",{
  expect_is(summary_stats(c(1,3,5,7,9)),"list")
  expect_equal(length(summary_stats(c(1,3,5,7,9))),11)
  expect_identical(names(summary_stats(c(1,3,5,7,9))),c("minimum","percent10","quartile1","median","mean","quartile3","percent90",
                                                        "maximum","range","stdev","missing" ))
})

test_that("removes NA if NA is contained inside the vector",{
  expect_equal(summary_stats(c(1,2,3,4,NA))[[5]],2.5)
})

# Test for function Fourteen
context("rescale100")

test_that("computing a rescaled vector following the rules",{
  expect_equal(rescale100(c(1,2,3,4,5),0,20),c(5,10,15,20,25))
  expect_equal(rescale100(c(5,10,15,20,25,30),0,100),c(5,10,15,20,25,30))
  expect_equal(rescale100(c(18,15,16,4,17,9),0,20),c(90,75,80,20,85,45))
  expect_equal(length(c(5,10,15,20,25,30)),length(rescale100(c(5,10,15,20,25,30),10,100)))
})

# Test for function Fifteen
context("drop_lowest")

test_that("drop the lowest value in a vector",{
  expect_identical(drop_lowest(c(10,10,8.5,4,7,9)),c(7,8.5,9,10,10))
  expect_equal(length(c(1,2,3,4,5,6)),length(drop_lowest(c(1,2,3,4,5,6)))+1)
  expect_identical(drop_lowest(c(5,5,5,5,5)),c(5,5,5,5))
  expect_equal(drop_lowest(c(5,5,5,10)),c(5,5,10))
})

# Test for function Sixteen
context("score_homework")

test_that("drop the lowest score if drop is TRUE",{
  expect_equal(score_homework(c(100,80,30,70,75,85),drop=TRUE),82)
  expect_equal(score_homework(c(100,80,30,70,75,85),drop=FALSE),73.3333333)
  expect_is(score_homework(c(100,2,30,40)),"numeric")
  expect_equal(score_homework(c(100,80,30,70,75,85)),73.3333333)
})

# Test for function Seventeen
context("score_homework")

test_that("drop the lowest score if drop is TRUE",{
  expect_equal(score_homework(c(100,80,30,70,75,85),drop=TRUE),82)
  expect_equal(score_homework(c(100,80,30,70,75,85),drop=FALSE),73.3333333)
  expect_is(score_homework(c(100,2,30,40)),"numeric")
  expect_equal(score_homework(c(100,80,30,70,75,85)),73.3333333)
})

# Test for function Eighteen
context("score_lab")

test_that("return the score corresponding to each lab attendance",{
  expect_equal(score_lab(11),100)
  expect_equal(score_lab(8),40)
  expect_equal(score_lab(7),20)
  expect_equal(score_lab(6),0)
})

