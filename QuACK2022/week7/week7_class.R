# For loops
# Willa & Elena
# 10/11/22

################### Warm up #########################

# 1.a. Create a vector called guest_list that contains the names "Willa",
# "Elena", "Roya"


# 1.b. Access the second element in the vector guest_list. 
#HINT use indexing (bracket notation) to get the second element. If you don't remember how to index see Q.3 for a hint.


# 2a. Create a vector called phone_no that contains three phone numbers:
# (3459430876, 2067389942, 5482240381)


# 2b. Access the second phone number in the list. 


# 3a. The function paste0() allows you to concatenate elements into one string.
# Try the following code to test it out:
week_days = c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday")

paste0("Today is ",  week_days[2])


# 3b. Now use the paste0 function along with your answers to 1b and 2b to print the following message: 
# "Elena's phone number is 2067389942." 



################### For Loops #######################

# For loops use an index or iterator variable. Often called "i"
# i exists within the scope of the loop
# "i" will take on each value in a range. 

# The : symbol let's us define a range

1:3

# print the numbers 1 through 3 on separate lines



## Remember we have used indexing to get elements of a vector. 

guest_list = c("Willa", "Elena", "Roya")

guest_list[1]
guest_list[2]
guest_list[3]

## We can use for loops build on this idea but allow us to iterate over the elements. 

for (i in 1:3) {
  print(guest_list[i])

}

# What if we add another guest to the list though? 

guest_list = c(guest_list, "Emily")

# If we keep the same for loop from above, we won't get to the last person now!


for (i in 1:3) {
  
  print(guest_list[i])
  
}

# Better to use 1:length(guest_list), which makes the length into a variable so
# that it is not "hard-coded" in (i.e., not pre-determined), but rather based on
# the number of guests in the current list.

length(guest_list)

1:3
1:length(guest_list)


for(i in 1:length(guest_list)) {
  
  print(guest_list[i])
}


for(guest in guest_list) {
  
  print(guest)
}

# ^^ Much better!

## Let's use the power of the loop to personalize our message. 
# Change the for loop to print " Hi <guest name> I’m having a Halloween Party on
# 10/31! The party starts at 9pm. I hope to see you there!"

message <- "I’m having a Halloween Party on 10/31! The party starts at 9pm. I hope to see you there!"
  
for () {
  

  
}
  

## Indexing allows us to access information from multiple vectors in the same loop. 

# lets include phone number at the top of our message

for (i in 1:length(guest_list)) {
  paste0("To: ", phone_no[i])
  paste0("hi ", guest_list[i], ", ", message)
 
  
}

## Lets save our custom messages in a new vector "sent"


sent <- c()

for (i in 1:length(guest_list)) {
  
  
  sent[i]<- paste0("To: ", phone_no[i], " hi ", guest_list[i], ", ", message)
  
  print(sent[i])
  
}
  

##### Practice questions ####


# Instructions: Use for loops to answer the following puzzle questions.

# Note that these are designed to help you learn how for loops work, and they
# are not necessarily things you will be using for loops for with data -- we
# will see some real-life uses of for loops next week!



## Question 1 ##
# Print the following pattern
# 1 
# 1 2 
# 1 2 3 
# 1 2 3 4 
# 1 2 3 4 5

for(i in 1:5) {
  print(1:i)
}

pattern <- c()
for(i in 1:5) {
  pattern <- c(pattern, i)
  # pattern[i] <- i
  
  print(pattern)
}


for(i in 1:5) {
  print(i)
}




## Question 2 ##
# Make a vector that has all the multiples of a given number (e.g., 2) and the
# numbers 1 through 10. For example, if your number is 2, then your output
# should be c(2, 4, 6, 8, 10, 12, 14, 16, 18, 20)

# Save it into a vector named mult_tbl

# Let the given number be 2

num <- 3
max <- 20
mult_tbl <- c()

for(i in 1:max) {
  mult_tbl[i] <- num * i
}
mult_tbl


### Bonus (for after completing the other questions) ###
# How could you "parameterize" this for loop so that you could easily set any
# number to generate a table for (mult) and any max multiplier (max) instead of
# just 10?




## Question 3 ##
# For a given number, calculate the sum of all the numbers from 1 to the
# given number. Print out the running total each time after you add the next
# number.
# Hint: How will you store the running sum?


# Given number is 3:
# 1
# 3
# 6


given <- 3

nums <- 0
for(i in 1:given) {
  nums <- sum(nums, i)
  print(nums)
}

sum <- 0
for(i in 1:given) {
  sum <- sum + i
  print(sum)
}


for(i in 1:given) {
  print(sum(1:i))
}

sum_bucket <- c()
for(i in 1:given) {
  sum_bucket[i] <- sum(1:i)
}

sum_bucket <- c(1)
for(i in 2:given) {
  sum_bucket[i] <- sum_bucket[i-1] + i
}



## Question 4: Introduction to "nested" for loops ##
# Run the following code

for(outerLoop_index in 1:4) {
  for(innerLoop_index in 1:5) {
    print(paste0("Outter loop index = ", outerLoop_index, " and inner loop index = ", innerLoop_index))
  }
}

# What is happening in the code? Describe any patterns you see.



## Bonus: Question 5 ##

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







