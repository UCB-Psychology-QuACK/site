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


# For each of the numbers between 1 and 5,
#   print 1 up to that number

for(i in 1:5){
  print(1:i)
}


# Another way to do it from someone in class!
n <- c()
for(i in 1:5) {
  n <- append(n, i, after = length(n))
  print(n)
}


#### Question 2 ####

# Make a vector of the multiples between a given number and the numbers 1
# through 10 (e.g., like a multiplication table!). Name the vector mult_tbl.

# For example, start with the multiplication table for the number 2
# After running your code, mult_tbl should be c(2, 4, 6, 8, 10, 12, 14, 16, 18, 20)

# Original wording that people said was confusing!:
# Make the multiplication table for a given number (table should be 1 through
# 10), and save it into a vector named mult_tbl)


# Let the given number be 2

# Create a vector to act as our bucket, collecting all of the multiples
mult_tbl <- c()

for(i in 1:10) {
  mult_tbl[i] <- 2*i
}

mult_tbl

# We could also "paramterize" our for loop so that we could give any number to
# find the multiples for:
mult <- 5

# And any max value for our multiplication table
max <- 10

mult_tbl <- c()
for(i in 1:max) {
  mult_tbl[i] <- mult*i
}

mult_tbl





#### Question 3 ####
# For a given number, calculate the sum of all the numbers between 1 and the given number. Print out the running total after you add the next number.
# Hint: How will you store the running sum?

# Solution 1:
sum <- 0
num <- 10
for(i in 1:num) {
  sum <- sum  + i
  print(sum)
}

# Let's step through what the code is doing:
# sum = 0  i = 1 --> sum <- 0 + 1 = 1
# sum = 1  i = 2 --> sum <- 1 + 2 = 3
# sum = 3  i = 3 --> sum <- 3 + 3 = 6

# 1
# 1+2
# 1+2+3
# 1+2+3+4
# ...


# Solution 2: 
# In this solution, we save each intermediate sum, whereas before we did not
sum_bucket <- c()

for(i in 1:10) {
  sum_bucket[i] <- sum(1:i)
  print(sum_bucket[i])
}





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

# The outer loop iterates one, then the inner loop runs all of its iterations,
# then the outerloop iterates one again, and the inner loop runs all of its
# iterations, and so on.



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



body_parts <- c("left foot", "right foot", "head", "left hand", "right hand", "tongue")

for(i in 1:length(body_parts)) {
  cat(paste("Put your", body_parts[i], "in"), "\n",
      paste("Take your", body_parts[i], "out"), "\n",
      paste("You put your", body_parts[i], "in"), "\n",
      "And you shake it all about \nYou do the hokey pokey \nAnd turn yourself around \nThat's what it's all about! \n\n")
}

# cat is a new function I am trying out! You can also just do this with print
# statements for each line!
