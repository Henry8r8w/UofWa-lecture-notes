Recitation1: R (swirl)
================

Topics to Practice in this Document (numbered by section):

1.  Basic Building Blocks
2.  Sequences of Numbers
3.  Vectors  
4.  Subsetting Vectors
5.  Matrices and Data Frames
6.  Looking at Data
7.  Functions (the first half especially)

Note: the notes reduced the sections into more concised form and
provided more examples

## 1. Basic Building Blocks: Operators in R

``` r
# basic operators
5 + 7
```

    ## [1] 12

``` r
100 - 10
```

    ## [1] 90

``` r
100 * 10
```

    ## [1] 1000

``` r
100/ 10
```

    ## [1] 10

``` r
100**10 # or ^
```

    ## [1] 1e+20

``` r
100 %% 10
```

    ## [1] 0

``` r
100%/% 10 # integer division
```

    ## [1] 10

``` r
# logic operators
x <- 5
y <- 10
i <- x == y
j <- x < 10
k <- x != y
isTRUE(i)
```

    ## [1] FALSE

``` r
isTRUE(j)
```

    ## [1] TRUE

``` r
isTRUE(k)
```

    ## [1] TRUE

``` r
isTRUE(!x)
```

    ## [1] FALSE

``` r
# usage example: slicing
x <- c(1:5)
x[(x>2)| (x<4)]
```

    ## [1] 1 2 3 4 5

``` r
x
```

    ## [1] 1 2 3 4 5

``` r
# usage example: vector membership using $in$
 x<- (1:10)
 y <- 5 %in% x
 y
```

    ## [1] TRUE

## (3, 4). Vectors and Varaibles Assignment

Vector assignment can be done using a `c()` function

Variables assignment can be done usinng \<\<- (global) or \<- (local,
within function)

``` r
# ?c to check the info on the c() function

z <- c(1.1, 9, 3.14)
c(z, 555,  z)
```

    ## [1]   1.10   9.00   3.14 555.00   1.10   9.00   3.14

``` r
z * 2 + 100 # element-wise multiplication and addition on z vector
```

    ## [1] 102.20 118.00 106.28

``` r
z * c(2, 2, 2) + c(100, 100, 100) # a more clearer writing form of element-wise operation 
```

    ## [1] 102.20 118.00 106.28

``` r
my_sqrt <- sqrt(z - 1) #subtract 1 element-wise, take the square root of the subtracted vector
my_sqrt
```

    ## [1] 0.3162278 2.8284271 1.4628739

``` r
my_div <- z/my_sqrt
my_div
```

    ## [1] 3.478505 3.181981 2.146460

``` r
c(1, 2, 3, 4) + c(0, 10) # vector of different dimension can be added together elemnet-wise; the left out deimsnion will be operated with 0 
```

    ## [1]  1 12  3 14

``` r
c(1, 2, 3, 4) + c(0, 10, 100)
```

    ## Warning in c(1, 2, 3, 4) + c(0, 10, 100): longer object length is not a
    ## multiple of shorter object length

    ## [1]   1  12 103   4

Vectors can also be non-numericaland boolean instead

``` r
num_vect <- c( 0.5, 55, -10,  6)
tf <- num_vect<1
tf
```

    ## [1]  TRUE FALSE  TRUE FALSE

``` r
num_vect >= 6
```

    ## [1] FALSE  TRUE FALSE  TRUE

``` r
(3 > 5) & (4 == 4) 
```

    ## [1] FALSE

``` r
(TRUE == TRUE) | (TRUE == FALSE)
```

    ## [1] TRUE

``` r
((111 >= 111) | !(TRUE)) & ((4 + 1) == 5)
```

    ## [1] TRUE

Vector assingment can also be done on characters and it is often coupled
paste () function

``` r
c("My", "name", "is") -> my_char
my_char
```

    ## [1] "My"   "name" "is"

``` r
paste(my_char, collapse = " ")
```

    ## [1] "My name is"

``` r
paste(1:3, c("X", "Y", "Z"), sep = ".")
```

    ## [1] "1.X" "2.Y" "3.Z"

## 6. Subsetting

Subsetting is important when only some elements are relevant. In R,
subsetting occurs by using a logical vector inside square brackets:

``` r
x <- c( NA, NA, NA, NA, NA, NA,  0.1416469,  0.5835647,  0.6249801, -1.7168059, 0.2295065,  0.3164563, NA, NA, NA, -2.2153293, NA, -0.7850284, -1.6878285, -1.2218555,2.4912774, NA, NA,  0.6100512,  0.6105755, 0.6130577,  0.7736417, -1.2376653,  0.7309674,  1.0643645,  NA, NA, NA, NA,NA,NA, NA, -0.5042185, NA,  0.9779947)
x[1:10] #basic slicing [inclusive: inclusive]
```

    ##  [1]         NA         NA         NA         NA         NA         NA
    ##  [7]  0.1416469  0.5835647  0.6249801 -1.7168059

``` r
x[is.na(x)] # subset only na 
```

    ##  [1] NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA

``` r
y <- x[!is.na(x)] # susect the section where na does not exist (! boolean condition)
y
```

    ##  [1]  0.1416469  0.5835647  0.6249801 -1.7168059  0.2295065  0.3164563
    ##  [7] -2.2153293 -0.7850284 -1.6878285 -1.2218555  2.4912774  0.6100512
    ## [13]  0.6105755  0.6130577  0.7736417 -1.2376653  0.7309674  1.0643645
    ## [19] -0.5042185  0.9779947

``` r
y[y > 0] # only the positive values are subsetted
```

    ##  [1] 0.1416469 0.5835647 0.6249801 0.2295065 0.3164563 2.4912774 0.6100512
    ##  [8] 0.6105755 0.6130577 0.7736417 0.7309674 1.0643645 0.9779947

``` r
x[x>0] # only the positive values are subsetted
```

    ##  [1]        NA        NA        NA        NA        NA        NA 0.1416469
    ##  [8] 0.5835647 0.6249801 0.2295065 0.3164563        NA        NA        NA
    ## [15]        NA 2.4912774        NA        NA 0.6100512 0.6105755 0.6130577
    ## [22] 0.7736417 0.7309674 1.0643645        NA        NA        NA        NA
    ## [29]        NA        NA        NA        NA 0.9779947

``` r
# note: R will not tell you that x has less than 3k elements; your result will be na
x[c(3, 5, 7)]
```

    ## [1]        NA        NA 0.1416469

``` r
x[3000]
```

    ## [1] NA

``` r
# you want to subset the neagtivev numbers from -10 to -2, in two way
x[c(-2, -10)]
```

    ##  [1]         NA         NA         NA         NA         NA  0.1416469
    ##  [7]  0.5835647  0.6249801  0.2295065  0.3164563         NA         NA
    ## [13]         NA -2.2153293         NA -0.7850284 -1.6878285 -1.2218555
    ## [19]  2.4912774         NA         NA  0.6100512  0.6105755  0.6130577
    ## [25]  0.7736417 -1.2376653  0.7309674  1.0643645         NA         NA
    ## [31]         NA         NA         NA         NA         NA -0.5042185
    ## [37]         NA  0.9779947

``` r
x[-c(2, 10)]
```

    ##  [1]         NA         NA         NA         NA         NA  0.1416469
    ##  [7]  0.5835647  0.6249801  0.2295065  0.3164563         NA         NA
    ## [13]         NA -2.2153293         NA -0.7850284 -1.6878285 -1.2218555
    ## [19]  2.4912774         NA         NA  0.6100512  0.6105755  0.6130577
    ## [25]  0.7736417 -1.2376653  0.7309674  1.0643645         NA         NA
    ## [31]         NA         NA         NA         NA         NA -0.5042185
    ## [37]         NA  0.9779947

If you want a funcitonality of hashing, you can also use c()

import library(hash) if you want, but c() should be enough

``` r
vect <- c(foo = 11, bar = 2, norf = NA) # c(var_i = name_i, ...., var_n = name_n)
vect  # access the variables
```

    ##  foo  bar norf 
    ##   11    2   NA

``` r
names(vect) # access the names
```

    ## [1] "foo"  "bar"  "norf"

``` r
vect2 <- c(11, 2, NA)
names(vect2) <- c("foo", "bar", "norf") # assing the names to the variables
identical(vect,vect2) # check condition
```

    ## [1] TRUE

``` r
vect["bar"] # accessing the name using your variable
```

    ## bar 
    ##   2

``` r
vect[c("foo", "bar")]
```

    ## foo bar 
    ##  11   2

## 7. Matrices and data frames

Matrices and data frames are rectangles. These are unlike vectors, which
have no “dimensions” but still have length:

``` r
my_vector <- 1:20
dim(my_vector) # becuase you don't a dimension assinge,d you shoule expct a null outpput
```

    ## NULL

``` r
length(my_vector)
```

    ## [1] 20

``` r
# We can turn a vector into a matrix by assigning it dimensions:

dim(my_vector) <- c(4, 5)
my_vector
```

    ##      [,1] [,2] [,3] [,4] [,5]
    ## [1,]    1    5    9   13   17
    ## [2,]    2    6   10   14   18
    ## [3,]    3    7   11   15   19
    ## [4,]    4    8   12   16   20

``` r
class(my_vector) # identify object class
```

    ## [1] "matrix" "array"

``` r
# the standard way to create matrix
my_matrix2 <- matrix(1:20, nrow=4, ncol=5)
identical(my_vector, my_matrix2) # check equivalnce
```

    ## [1] TRUE

Imagine that the numbers in our table represent some measurements from a
clinical experiment, where each row represents one patient and each
column represents one variable for which measurements were taken. In
that case, we may want to name the rows, so we know who belongs to which
data:

``` r
patients <- c("Bill", "Gina", "Kelly", "Sean") 
cbind(patients, my_matrix2) # cbind() by default set the row names
```

    ##      patients                       
    ## [1,] "Bill"   "1" "5" "9"  "13" "17"
    ## [2,] "Gina"   "2" "6" "10" "14" "18"
    ## [3,] "Kelly"  "3" "7" "11" "15" "19"
    ## [4,] "Sean"   "4" "8" "12" "16" "20"

``` r
meassurement1 <-c('m1', 'm2', 'm3', 'm4', 'm5')

colnames(my_matrix2) <- meassurement1 # your colnames exist as the attribute only, not the data itself



# A better way to define your col and row as your df  is using the data.frame() function
my_data <- data.frame(patients, my_matrix2)
my_data
```

    ##   patients m1 m2 m3 m4 m5
    ## 1     Bill  1  5  9 13 17
    ## 2     Gina  2  6 10 14 18
    ## 3    Kelly  3  7 11 15 19
    ## 4     Sean  4  8 12 16 20

``` r
cnames <- c("patient", "age", "weight", "bp", "rating", "test") #cname is used for the datafram column naming
colnames(my_data) <- cnames
my_data
```

    ##   patient age weight bp rating test
    ## 1    Bill   1      5  9     13   17
    ## 2    Gina   2      6 10     14   18
    ## 3   Kelly   3      7 11     15   19
    ## 4    Sean   4      8 12     16   20

This is bad since it converted the numbers to words (‘strings’). This is
because matrices can only contain ONE class of data. Instead, we should
use a data farme:

## 12. Looking at data

This lesson introduces some useful functions like the following:

``` r
my_data -> df

ncol(df)
```

    ## [1] 6

``` r
nrow(df)
```

    ## [1] 4

``` r
names(df)
```

    ## [1] "patient" "age"     "weight"  "bp"      "rating"  "test"

``` r
head(df)
```

    ##   patient age weight bp rating test
    ## 1    Bill   1      5  9     13   17
    ## 2    Gina   2      6 10     14   18
    ## 3   Kelly   3      7 11     15   19
    ## 4    Sean   4      8 12     16   20

``` r
head(df, 10)
```

    ##   patient age weight bp rating test
    ## 1    Bill   1      5  9     13   17
    ## 2    Gina   2      6 10     14   18
    ## 3   Kelly   3      7 11     15   19
    ## 4    Sean   4      8 12     16   20

``` r
summary(df)
```

    ##    patient               age           weight           bp       
    ##  Length:4           Min.   :1.00   Min.   :5.00   Min.   : 9.00  
    ##  Class :character   1st Qu.:1.75   1st Qu.:5.75   1st Qu.: 9.75  
    ##  Mode  :character   Median :2.50   Median :6.50   Median :10.50  
    ##                     Mean   :2.50   Mean   :6.50   Mean   :10.50  
    ##                     3rd Qu.:3.25   3rd Qu.:7.25   3rd Qu.:11.25  
    ##                     Max.   :4.00   Max.   :8.00   Max.   :12.00  
    ##      rating           test      
    ##  Min.   :13.00   Min.   :17.00  
    ##  1st Qu.:13.75   1st Qu.:17.75  
    ##  Median :14.50   Median :18.50  
    ##  Mean   :14.50   Mean   :18.50  
    ##  3rd Qu.:15.25   3rd Qu.:19.25  
    ##  Max.   :16.00   Max.   :20.00

``` r
table(df$variable)
```

    ## < table of extent 0 >

``` r
str(df)
```

    ## 'data.frame':    4 obs. of  6 variables:
    ##  $ patient: chr  "Bill" "Gina" "Kelly" "Sean"
    ##  $ age    : int  1 2 3 4
    ##  $ weight : int  5 6 7 8
    ##  $ bp     : int  9 10 11 12
    ##  $ rating : int  13 14 15 16
    ##  $ test   : int  17 18 19 20

## 9. Functions

Some basic function calls

``` r
Sys.Date() #today's date
```

    ## [1] "2025-01-10"

``` r
mean(c(2, 4, 5)) # mean of 2,4,5
```

    ## [1] 3.666667

Writing your function

``` r
x <- 6
y <- 10
boring_function <- function(x) {
  y<-x**2
  cat('y as a local variable evaluated by the function:', y, '\n')
}

boring_function(x)
```

    ## y as a local variable evaluated by the function: 36

``` r
cat('y as a global variable not evaluated by the function:', y)
```

    ## y as a global variable not evaluated by the function: 10

``` r
# Some other code examples
my_mean <- function(my_vector) {
  sum(my_vector)/length(my_vector)
}
my_mean(c(4, 5, 10))
```

    ## [1] 6.333333

``` r
remainder <- function(num, divisor = 2) {
  num %% divisor
}
remainder(5)
```

    ## [1] 1

``` r
remainder(11, 5)
```

    ## [1] 1

``` r
remainder(divisor = 11, num = 5)
```

    ## [1] 5

``` r
remainder(4, div = 2)
```

    ## [1] 0

You can a higher-order function if you would like to create more
complicated usage

``` r
evaluate <- function(func, dat){
  func(dat)
}
evaluate(sd, c(1.4, 3.6, 7.9, 8.8))
```

    ## [1] 3.514138

``` r
evaluate(function(x){x+1}, 6)
```

    ## [1] 7

``` r
evaluate(function(x){x[1]}, c(8, 4, 0))
```

    ## [1] 8
