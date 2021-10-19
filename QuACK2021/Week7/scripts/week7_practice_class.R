# Week 7 - For Loops
# Practice
# Elena Leib & Willa Voorhies
# 10/12/21



##### Instructions ####

# Use for loops to answer the following questions!



#### Question 1 ####
# Print the following pattern
# 1 
# 1 2 
# 1 2 3 
# 1 2 3 4 
# 1 2 3 4 5


n <- c()
for(i in 1:5) {
  n <- append(n, i, after = length(n))
  print(n)
}


for(i in 1:5){
  print(1:i)
}


#### Question 2 ####
# Make the multiplication table for a given number (table should be 1 through
# 10), and save it into a vector named mult_tbl
# For example, start with the multiplication table for the number 2
# (After running your code, mult_tbl should be c(2, 4, 6, 8, 10, 12, 14, 16, 18, 20))

mult <- 5
max <- 10

mult_tbl <- c()
for(i in 1:max) {
  mult_tbl[i] <- mult*i
}

mult_tbl





#### Question 3 ####
# For a given number, calculate the sum of all the numbers between 1 and the given number. Print out the running total after you add the next number.
# Hint: How will you store the running sum?

sum <- c()
for(i in 1:10) {
  sum[i] <- sum(1:i)
  print(sum[i])
}


sum2 <- 0
num <- 10
for(i in 1:num) {
  sum2 <- sum2 + i
  print(sum2)
}

# sum2 = 0  i = 1 --> sum2 <- 0 + 1 = 1
# sum2 = 1  i = 2 --> sum2 <- 1 + 2 = 3
# sum2 = 3  i = 3 --> sum2 <- 3 + 3 = 6

# 1
# 1+2
# 1+2+3
# 1+2+3+4
# ...


#### Question 4: Introduction to "nested" for loops ####
# Run the following code

for(outerLoop_index in 1:4) {
  for(innerLoop_index in 1:5) {
    print(paste0("Outter loop index = ", outerLoop_index, " and inner loop index = ", innerLoop_index))
  }
}

# Put in block and trial now
for(trial in 1:4) {
  for(block in 1:5) {
    print(paste0("block = ", block, " and trial = ", trial))
  }
}
# ... need to swap them!

for(block in 1:5) {
  for(trial in 1:4) {
    print(paste0("block = ", block, " and trial = ", trial))
  }
}



# What is happening in the code? Describe any patterns you see.



#### Bonus: Question 5 ####

# 1) Print the lyrics to the song "The Hokey Pokey"!
# Sample lyrics: 
# Put your left foot in
# You take your left foot out
# You put your left foot in
# And you shake it all about
# You do the hokey pokey
# And turn yourself around
# That's what it's all about!

# ... and right foot, and head, and left hand, and right hand, and tongue!




# Make a multiplication table for the numbers 1 to 5 with their multiples from 1 to 10
# Save the result in a data frame

# e.g.,

# multiplicand:   1       2       3      4
# mult by:
#           1     1       2       3      4
#           2     2       4       6      8
#           3     3       6       9      12
#         ...


paste0()

paste()

m <- c("Hello", "world", "how", "are", "you?")
paste("Hello", "world", "how", "are", "you", "?")
paste0("Hello", "world", "how", "are", "you", "?")

grade <- 6

paste("Distribution of grade", grade, "and EFs")

year <- 2020
paste(grade, year, sep = "")
paste0(grade, year)

paste(m, collapse = "_")

t <- 1:5
t + 5
