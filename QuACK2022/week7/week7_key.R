# For loops
# Willa & Elena
# 10/11/21

################### Warm up #########################

#1.a. Create a vector called guest_list that contains the names "Willa", "Elena", "Roya
guest_list = c("Willa", "Elena", "Roya")

#1.b. Access the second element in the vector guest_list

guest_list[2]

# 2a. Create a vector called phone_no that contains three phone numbers: (3459430876, 2067389942, 5482240381)
phone_no = c("3459430876", "2067389942", "5482240381")

# 2b. Access the second phone number in the list. 

phone_no[2]

# 3a. The function paste0() allows you to concatenate elements into one string. Try the following code to test it out: 
week_days <- c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday")

paste0("Today is ",  week_days[2], ".")

# paste default is " "
paste("Today is",  week_days[2], ".", sep = "-")

# 3b. Now use the paste0 function along with your answers to 1b and 2b to print the following message: 
# "Elena's phone number is 2067389942." 

paste0(guest_list[2], "'s phone number is ", phone_no[2])

################### For Loops #######################

# For loops use an index or iterator variable. Often called "i"
# i exists within the scope of the loop
# "i" will take on each value in a range. 

# print the numbers 1 through 10 on separate lines
for (i in 1:10){
  print(i)
}

## Remember we have used indexing to get elements of a vector. 

guest_list = c("Willa", "Elena", "Roya")

guest_list[1]
guest_list[2]
guest_list[3]

## We can use for loops build on this idea but allow us to iterate over the elements. 

for (i in 1:3){
  print(guest_list[i])

}

# What if we add another guest to the list though? 

guest_list = c(guest_list, "Emily")

# If we keep the same for loop from above, we won't get to the last person now!
for(i in 1:3) {
  print(guest_list[i])
}

# Better to use 1:length(guest_list), which makes the length into a variable so
# that it is not "hard-coded" in (i.e., not pre-determined), but rather based on
# the number of guests in the current list.
length(guest_list)
1:length(guest_list)

for(i in 1:length(guest_list)) {
  print(guest_list[i])
}
# ^^ Much better!

## Let's use the power of the loop to personalize our message. 
# Change the for loop to print " Hi <guest name> I’m having a Halloween Party on 10/31! The party starts at 9pm. I hope to see you there!

message <- "I’m having a Halloween Party on 10/31! The party starts at 9pm. I hope to see you there!"
  
for (i in 1:length(guest_list)){
  
  print(paste0('hi ', guest_list[i], " ! ", message))
  
  
}
  

## Indexing allows us to access information from multiple vectors in the same loop. 

# lets include phone number at the top of our message

for (i in 1:3){
  
  print(paste0('To:', phone_no[i], 
                
                'hi ', guest_list[i], message) )
  
}

## Lets save our custom messages in a new vector "sent"
sent <- c()

for (i in 1:3){
  
  sent[i] = paste0('To:', phone_no[i], 
               
               'hi ', guest_list[i], message)
  
}
  
  
##### Practice questions ####


# Instructions: Use for loops to answer the following puzzle questions.

# Note that these are designed to help you learn how for loops work, and they
# are not necessarily things you will be using for loops for with data -- we
# will see some real-life uses of for loops next week!

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


# Another way to do it
n <- c()
for(i in 1:5) {
  n <- append(n, i, after = length(n))
  print(n)
}


## Question 2 ##

# Make a vector that has all the multiples of a given number (e.g., 2) and the
# numbers 1 through 10. For example, if your number is 2, then your output
# should be c(2, 4, 6, 8, 10, 12, 14, 16, 18, 20)

# Save it into a vector named mult_tbl

# Let the given number be 2

# Create a vector to act as our bucket, collecting all of the multiples
mult_tbl <- c()

for(i in 1:10) {
  mult_tbl[i] <- 2*i
}

mult_tbl

### Bonus (for after completing the other questions) ###
# How could you "parameterize" this for loop so that you could easily set any
# number to generate a table for (mult) and any max multiplier (max) instead of
# just 10?

# Set given number
mult <- 5

# And any max value for our multiplication table
max <- 10

mult_tbl <- c()
for(i in 1:max) {
  mult_tbl[i] <- mult*i
}

mult_tbl



## Question 3 ##
## For a given number, calculate the sum of all the numbers between 1 and the
# given number. Print out the running total each time after you add the next
# number.
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





## Question 4: Introduction to "nested" for loops ##
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



body_parts <- c("left foot", "right foot", "head", "left hand", "right hand", "tongue")

for(i in 1:length(body_parts)) {
  cat(paste("Put your", body_parts[i], "in"), "\n",
      paste("Take your", body_parts[i], "out"), "\n",
      paste("You put your", body_parts[i], "in"), "\n",
      "And you shake it all about \nYou do the hokey pokey \nAnd turn yourself around \nThat's what it's all about! \n\n")
}

# cat is a new function I am trying out! You can also just do this with print
# statements for each line!
