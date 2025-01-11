---
title: "Recitation1: R (swirl)"
output: github_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```
Topics to Practice in this Document (numbered by section):

1. Basic Building Blocks
3. Sequences of Numbers
4. Vectors                
6. Subsetting Vectors
7. Matrices and Data Frames 
12. Looking at Data
9. Functions (the first half especially)

Note: the notes reduced the sections into more concised form and provided more examples

## 1. Basic Building Blocks: Operators in R
```{r}
# basic operators
5 + 7
100 - 10
100 * 10
100/ 10
100**10 # or ^
100 %% 10
100%/% 10 # integer division

# logic operators
x <- 5
y <- 10
i <- x == y
j <- x < 10
k <- x != y
isTRUE(i)
isTRUE(j)
isTRUE(k)
isTRUE(!x)

# usage example: slicing
x <- c(1:5)
x[(x>2)| (x<4)]
x

# usage example: vector membership using $in$
 x<- (1:10)
 y <- 5 %in% x
 y
 
```
## (3, 4). Vectors and Varaibles Assignment 
Vector assignment can be done using a `c()` function

Variables assignment can be done usinng <<- (global) or <- (local, within function) 
```{r}
# ?c to check the info on the c() function

z <- c(1.1, 9, 3.14)
c(z, 555,  z)

z * 2 + 100 # element-wise multiplication and addition on z vector
z * c(2, 2, 2) + c(100, 100, 100) # a more clearer writing form of element-wise operation 

my_sqrt <- sqrt(z - 1) #subtract 1 element-wise, take the square root of the subtracted vector
my_sqrt

my_div <- z/my_sqrt
my_div

c(1, 2, 3, 4) + c(0, 10) # vector of different dimension can be added together elemnet-wise; the left out deimsnion will be operated with 0 
c(1, 2, 3, 4) + c(0, 10, 100)
```
 Vectors can also be non-numericaland boolean instead
```{r}
num_vect <- c( 0.5, 55, -10,  6)
tf <- num_vect<1
tf
num_vect >= 6

(3 > 5) & (4 == 4) 
(TRUE == TRUE) | (TRUE == FALSE)
((111 >= 111) | !(TRUE)) & ((4 + 1) == 5)
```

Vector assingment can also be done on characters and it is often coupled paste () function 
```{r}
c("My", "name", "is") -> my_char
my_char

paste(my_char, collapse = " ")
paste(1:3, c("X", "Y", "Z"), sep = ".")
```

## 6. Subsetting

Subsetting is important when only some elements are relevant. In R, subsetting occurs by using a logical vector inside square brackets:

```{r}
x <- c( NA, NA, NA, NA, NA, NA,  0.1416469,  0.5835647,  0.6249801, -1.7168059, 0.2295065,  0.3164563, NA, NA, NA, -2.2153293, NA, -0.7850284, -1.6878285, -1.2218555,2.4912774, NA, NA,  0.6100512,  0.6105755, 0.6130577,  0.7736417, -1.2376653,  0.7309674,  1.0643645,  NA, NA, NA, NA,NA,NA, NA, -0.5042185, NA,  0.9779947)
x[1:10] #basic slicing [inclusive: inclusive]
x[is.na(x)] # subset only na 
y <- x[!is.na(x)] # susect the section where na does not exist (! boolean condition)
y


y[y > 0] # only the positive values are subsetted
x[x>0] # only the positive values are subsetted


# note: R will not tell you that x has less than 3k elements; your result will be na
x[c(3, 5, 7)]
x[3000]

# you want to subset the neagtivev numbers from -10 to -2, in two way
x[c(-2, -10)]
x[-c(2, 10)]
```
If you want a funcitonality of hashing, you can also use c()

import library(hash) if you want, but c() should be enough
```{r}
vect <- c(foo = 11, bar = 2, norf = NA) # c(var_i = name_i, ...., var_n = name_n)
vect  # access the variables
names(vect) # access the names

vect2 <- c(11, 2, NA)
names(vect2) <- c("foo", "bar", "norf") # assing the names to the variables
identical(vect,vect2) # check condition

vect["bar"] # accessing the name using your variable
vect[c("foo", "bar")]
```




## 7. Matrices and data frames

Matrices and data frames are rectangles. These are unlike vectors, which have no "dimensions" but still have length:
```{r}
my_vector <- 1:20
dim(my_vector) # becuase you don't a dimension assinge,d you shoule expct a null outpput
length(my_vector)


# We can turn a vector into a matrix by assigning it dimensions:

dim(my_vector) <- c(4, 5)
my_vector
class(my_vector) # identify object class


# the standard way to create matrix
my_matrix2 <- matrix(1:20, nrow=4, ncol=5)
identical(my_vector, my_matrix2) # check equivalnce
```


Imagine that the numbers in our table represent some measurements from a clinical experiment, where each row represents one patient and each column represents one variable for which measurements were taken. In that case, we may want to name the rows, so we know who belongs to which data:
```{r}
patients <- c("Bill", "Gina", "Kelly", "Sean") 
cbind(patients, my_matrix2) # cbind() by default set the row names

meassurement1 <-c('m1', 'm2', 'm3', 'm4', 'm5')

colnames(my_matrix2) <- meassurement1 # your colnames exist as the attribute only, not the data itself



# A better way to define your col and row as your df  is using the data.frame() function
my_data <- data.frame(patients, my_matrix2)
my_data


cnames <- c("patient", "age", "weight", "bp", "rating", "test") #cname is used for the datafram column naming
colnames(my_data) <- cnames
my_data
```
This is bad since it converted the numbers to words ('strings'). This is because matrices can only contain ONE class of data. Instead, we should use a data farme:

## 12. Looking at data

This lesson introduces some useful functions like the following:
```{r}
my_data -> df

ncol(df)
nrow(df)

names(df)

head(df)
head(df, 10)
summary(df)
```


```{r}
table(df$variable)
```

```{r}
str(df)
```

## 9. Functions
Some basic function calls
```{r}
Sys.Date() #today's date
mean(c(2, 4, 5)) # mean of 2,4,5
```

Writing your function
```{r}
x <- 6
y <- 10
boring_function <- function(x) {
  y<-x**2
  cat('y as a local variable evaluated by the function:', y, '\n')
}

boring_function(x)

cat('y as a global variable not evaluated by the function:', y)

# Some other code examples
my_mean <- function(my_vector) {
  sum(my_vector)/length(my_vector)
}
my_mean(c(4, 5, 10))
remainder <- function(num, divisor = 2) {
  num %% divisor
}
remainder(5)
remainder(11, 5)
remainder(divisor = 11, num = 5)
remainder(4, div = 2)
```

You can  a higher-order function if you would like to create more complicated usage
```{r}
evaluate <- function(func, dat){
  func(dat)
}
evaluate(sd, c(1.4, 3.6, 7.9, 8.8))
evaluate(function(x){x+1}, 6)
evaluate(function(x){x[1]}, c(8, 4, 0))
```