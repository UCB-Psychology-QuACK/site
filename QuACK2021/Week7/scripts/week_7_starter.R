# For loops
# Willa & Elena
# 10/11/21

################### Warm up #########################

#1.a. Create a vector called guest_list that contains the names "Willa", "Elena", "Roya
guest_list = c("Willa", "Elena", "Roya")

#1.b. Access the second element in the vector guest_list


# 2a. Create a vector called phone_no that contains three phone numbers: (3459430876, 2067389942, 5482240381)
phone_no = c(3459430876, 2067389942, 5482240381)

# 2b. Access the second phone number in the list. 


# 3a. The function paste0() allows you to concatenate elements into one string. Try the following code to test it out: 
week_days = c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday")

paste0("Today is ",  week_days[2])

# 3b. Now use the paste0 function along with your answers to 1b and 2b to print the following message: 
# "Elena's phone number is 2067389942." 



################### For Loops #######################

# For loops use an index or iterator variable. Often called "i"
# i exists within the scope of the loop
# "i" will take on each value in a range. 

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
  

}

## Let's use the power of the loop to personalize our message. 
# Change the for loop to print " Hi <guest name> I’m having a Halloween Party on 10/31! The party starts at 9pm. I hope to see you there!

message <- "I’m having a Halloween Party on 10/31! The party starts at 9pm. I hope to see you there!"
  
for (i in 1:length(guest_list)){
  
  
}
  

## Indexing allows us to access information from multiple vectors in the same loop. 

# lets include phone number at the top of our message

for (i in 1:3){
  
  
}

## Lets save our custom messages in a new vector "sent"
sent <- c()

for (i in 1:3){

  }
  
  
