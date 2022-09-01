# Week 1 - Intro to R and Programming
# 8/30/2022
# Willa Voorhies & Elena Leib

# The console is used to run all the code.
# The script is used to keep track of everything that you have done so that 
# you can do it again! 

# We use hashtags (#) to write comments! Comments are very important for helping
# you lay out and remember what you did, and for helping others read and
# understand what you did.

# If you use four (or more) hashtags on either side of text, it will make that a
# heading that you can use. You can collapse information under it and also
# navigate to it using the thing dropdown menu of headers near the bar above the
# console

#### My code ####
# lets try a number
5

# a word (string/character)
"hello"

# you can do math!
5+4

# To run this, use the "Run button"
# You can also use a keyboard shortcut (also known as "hot keys")


#### Hot keys ####
# To run a line of code in your script in your console, hit:
# PC - ctrl + enter
# Mac - cmd + enter
# Or highlight a chunk of code and use a hot key


#### Assigning Variables ####
# In order to be able to reuse information again later in our scripts, we need 
# to name our information!

# In other words, we create variables to store the information
# We do this by giving a variable name, and then assigning it information
# "<-" is called the "assignment operator"
# Hot key for making "<-"
# PC: "alt" +  "-"
# Mac: "opt" + "-"

# Variables can store numeric information
# Number of participants in our study: 100
n <- 100

# They can also store words (strings, characters)
name1 <- "Elena"

# Functionally, double and single quotes are the same
# The quotes indicate to the program that the information inside
# is a word (string/character)
name2 <- "Willa" # double quotes is preferred stylistically
name2 <- 'Willa'
# ^ notice that when I make this variable, the name doesn't print out in the
# console anymore.

name2
# ^^ This will print to the console. And so will this:
print(name2)

# They can also store logical values (booleans)
bool_t <- TRUE
bool_f <- FALSE

# Notice that characters and booleans change colors -- this is R indicating that
# it recognizes that it is a character or boolean.

# Note: it is important that TRUE and FALSE are capitalized!
# Writing true or True will NOT do the same thing!
# Using all capitals is to logicals what using double quotes is to characters.
# It is the programmer's way of indicating how a piece of information should be
# treated.


# Try it out! Type true or True and you will see that it doesn't change color if
# all the letters aren't capitalized.


# You can also use just T and just F instead of writing out the whole words
T
F



#### Vectors ####

# Syntax for creating a vector is: c()
# c means "concatenate" (some people also think of it as "combine") 
names <- c("Elena", "Willa", "Roya", "Monica", "Lena")

years <- c("freshman", "sophomore", "junior", "freshman", "senior")




#### Factors ####
# Represent categorical information

years_factor <- factor(years)

# Levels: sub-categories or groups of categorical information

# R will automatically make the levels for us, which we can check:
levels(years_factor)

# This is very helpful, but sometimes, we want to specify the levels ourselves.
# This could be because not all the groups are represented in our data (e.g., we
# don't have any juniors in ours). Another reason is because R will put the
# levels in order alphabetically, but that not make sense for what the levels
# represent in the world.

years_factor_leveled <- factor(years, levels = c("freshman", "sophomore", "junior", "senior"))

levels(years_factor_leveled)

# Another, more traditional example
condition <- factor(c("Treatment1", "Treatment2", "Control", "Treatment1", 
                      "Control"))

#### Hot keys to comment out a highlighted segment of code ####
# ctrl/cmd + shift + c to comment out!

#### Valid variable names:
# q1.type
# q1Type
# q1_type
# can use camel case, ., and _. But not -!


#### Practice Answer Key ####

# 3. Create a vector named nums1 that contains the numbers 1 through 10
nums1 <- c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)

# 4. Now create a vector named nums2 using this code:
#   nums2 <- 1:10
# Compare nums1 and nums2. What do you think the : does?

nums2 <- 1:10
# The : tells R to make a vector from 1 to 10. Nice "syntactic sugar" shorthand
# for making a vector

#   5. Now create a third vector named nums3 using this code:
#   nums3 <- seq(1, 10)
# What do you think the function seq() does?

nums3 <- seq(1, 10)

# seq also makes a vector from the starting number to the end number inclusive, 
# i.e., including both numbers
# See ?seq for more information
?seq

#   6. Create a vector called nums_by2 using this code:
#   nums_by2 <- seq(1, 10, by = 2)

nums_by2 <- seq(1, 10, by = 2)


# 7. Change the code for nums_by2 so that you get only the even numbers instead of the
# odd numbers.
nums_by2_odd <- seq(2, 10, by = 2)


# 8. Create a vector called all_fives using this code:
#   all_fives <- rep(5, 10)
# What do you think the function rep() does?

all_fives <- rep(5, 10)

# Repeats the first argument the number of times given by the second argument
# See ?rep for more information

?rep

# Same as saying:
all_fives <- rep(x = 5, times = 10)


# 9. Now compare these two vectors:
fives_sixes1 <- rep(c(5, 6), 10)
fives_sixes2 <- rep(c(5, 6), each = 5)

# What is similar between them? What is different? What caused this difference?
# Having times = 10 repeats 5 and 6 together 10 times, whereas saying each = 5
# has them first repeat 5 five times and then 6 five times.


# 10. Run the code: nums1 + 5. What happens?
nums1 + 5

# 5 is added to each of the numbers in the vector! R knows that when we add to 
# a vector, we want that operation to be done to each of the numbers

# 11. Run the code: nums1 + nums2. What happens?

nums1 + nums2

# The vectors are added in a pairwise way: position 1 in nums1 is added to
# position 1 in nums2, and so on.


# 12. Run the code: sum(nums1). What happens?
sum(nums1)

# sum() is a function that takes a numeric vector and returns the sum of those
# numbers!


# 13. Run the code: mean(nums1). What happens?
mean(nums1)
# mean() is a function that takes a numeric vector and returns the mean of the
# numbers.

# 14. Run the code: sd(nums1). What happens?
sd(nums1)

# Returns the sd of the vector of numbers


# 15. Make the following 2 vectors and name each of them uniquely:
#   a. A vector that has all the numbers from 1 to 24
nums_1to24 <- 1:24
nums_1to24_2 <- seq(1, 24)

#   b. A vector that has the all numbers between 1 and 48 that are multiples of 2
nums_1to48.by2 <- seq(2, 48, by = 2)

  

# Bonus:
# 1. What happens when you add these two vectors together?
#   a. nums1 + c(1, 2)
nums1
nums1 + c(1, 2)

# R adds 1 to position 1, 2 to position 2, 1 to position 3, 2 to position 4, and
# so on.


#   b. num1 + c(1, 2, 3)
nums1 + c(1, 2, 3)
# It doesn't work!

#   c. Why do you think one command gives an error and the other does not?
# The second one doesn't work because the length of nums1 (10) is not divisible
# by 3, so R doesn't know what you want to do with this. On the other hand, 10
# is divisible by 2 in (a), and therefore R can apply this operation to the
# vector in a pattern. This example goes to show that R doesn't always throw an
# error when you might expect it. For example, what we did in (a) might be on
# purpose, but it also might be by accident, and R didn't throw an error. It is
# always good to check your work and make sure that R is doing what you expect
# it to do!


# 2. Make a vector with 5 logicals (TRUE and FALSE). Use the sum function on this vector.
# What is the result? Why do you think this is?
logis <- c(TRUE, TRUE, FALSE, TRUE, FALSE)
sum(logis)

# R treats TRUE as a value of 1, and FALSE as a value of 0, so taking the sum of
# a vector of logicals will give you the total number of TRUE values in the
# vector.


# 3. Make a new vector that is the same as in (2), but replace all the TRUEs with 1 and all
# the FALSEs with 0. If you run sum on this new vector will you get the same result as in
# (2)? Test your hypothesis.
logis_num <- c(1, 1, 0, 1, 0)
sum(logis_num)

# Yes! Got the same number!

 