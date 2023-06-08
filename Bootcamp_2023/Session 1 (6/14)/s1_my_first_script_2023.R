# Week 1 - Intro to R and Programming
# 6/14/2023
# Emily Rosenthal & Sierra Semko Krouse

##### Intro to the console #####
# The console is used to run all the code.
# The script is used to keep track of everything that you have done so that 
# you can do it again! 



# We use hashtags (#) to write comments! 
      # Comments are very important for 
            # Helping to lay out and remember what you did
            # Helping others read and understand what you did 
      # R does NOT run what is commented out!

# If you use four (or more) hashtags on either side of text, it will make that
# a heading that you can use. You can collapse information under it and also 
# navigate to it using the dropdown menu on the bottom right of your script

# You can indent notes to yourself (or not) -- whatever makes it easier to read!

#### My code ####
# lets try a number
5

# a word (string/character)
"hello"

# you can do math!
5+6

# To run this, use the "Run button" on the top right
# You can also use a keyboard shortcut (also known as "hot keys")

# As you can see, the results from what you run in your R Script (up here!)
# Show up in your console down below


#### Hot keys ####
    # To run a line of code in your script in your console, hit:
    # PC - ctrl + enter
    # Mac - cmd + enter
    # Or highlight a chunk of code and use a hot key
    # Or highlight a chunk of code and hit the "run" button 


#### Assigning Variables ####
# In order to be able to reuse information again later in our scripts, we need 
# to give it a name!

# So, we create VARIABLES to store the information
     # We do this by giving it a variable name, and then assigning it information
     # "<-" is called the "assignment operator"


# Hot key for making "<-"
    # PC: "alt" +  "-"
    # Mac: "opt" + "-"
    # or you can just type it out! 

# Variables can store numeric information
      # Number of participants in our study: 100
      sample_size <- 100

# What if I name it Sample_size (with a capital 'S')? What does this tell us about R? 
      Sample_size <-105
        # This creates a different variable! 
        # R cares about capitalization when naming variables! 
      
#What happens if I run it again, with a new value? 
      
      sample_size <- 50000
        # R replaced the value of this variable! This is because they have the same name. 
        # If you have two variables with the same name, R will assign the value to the 
        # one you ran most recently. It replaces what you did before! 
              # Be careful about this!! 

# Variables can also store words (strings, characters)
      name <- "Emily"
          # The quotes indicate to the program that the information inside
          # is a word (string/character)
          
          # Functionally, double and single quotes are the same
              name <- "Sierra"
              name2 <- 'Sierra'

# Variables can also store logical values (booleans)
bool_t <- TRUE
bool_f <- FALSE

      # Notice that characters and booleans change colors -- this is R telling you
      # that it recognizes that it is a character or boolean.

  # Note: it is important that TRUE and FALSE are capitalized!
      # Writing true or True will NOT do the same thing!
      # Using all caps is to logicals what using double quotes is to characters.
      # It is your way of telling R how a piece of info should be treated.

# Try it out! Type true or True and you will see that it doesn't change color if
# all the letters aren't capitalized.



#### Vectors ####

# Syntax for creating a vector is: c()
      # c means "concatenate" (some people also think of it as "combine")
      # it's telling R that we are giving it a list 
      # make sure you put a comma between items on your list! 

# you can make a vector of numbers
numbers<- c(1, 2, 3, 4, 5, 10000, 4000, 3)
      # after you run this, the variable 'numbers' should pop up in your global 
      # environment on the top right

      # Interpreting what your global environment is telling you: 
          # 'num' tells you that this is a numeric variable
          # [1:8] tells you that there are 8 items or members of this vector

# you can make a vector of characters 
names9<-c("Emily", "Sierra", "Becca", "Catherine", "Breanna", "Sam")
      # after you run this, the variable 'names' should pop up in your global 
      # environment on the top right

      # Interpreting what your global environment is telling you: 
          # 'chr' tells you that this is a character variable
          # [1:6] tells you that there are 6 items or members of this vector

# you can make a vector of booleans (or logic)
boolean_vector<-c(TRUE, TRUE, TRUE, FALSE, FALSE, TRUE, FALSE, TRUE, TRUE)

boolean_vector
print(boolean_Vector)

# Vectors can only contain one type of value! What happens when we try to give 
# a vector multiple types of input? 
      newvector<-c(TRUE, 10, "Emily", 15, FALSE)
      newvector
          # It turns everything into characters!


#### Factors ####
# Represent categorical information (where we have a limited number of discrete categories)
      # Levels are sub-categories or groups of categorical information! 
      # This distinction becomes super important later on, for instance, with graphing!
      
# How is a factor different from a character vector? How do they show up in our
# global environment? 
      #vector of character data
      groups_string<-c("Treatment1", "Treatment1", "Treatment1", "Treatment2", "Control")
      
      #making it a factor
      groups<-factor(c("Treatment1", "Treatment1", "Treatment1", "Treatment2", "Control"))
      
      
# You can also make numeric values into a factor
      # e.g., if you had a variable "TreatmentGroups" where each participant was 
      # assigned to one of four unique treatment conditions, 1, 2, 3, or 4, 

      #vector of numeric data
      TreatmentGroup<-c(1, 2, 3, 3, 4, 1, 2, 4, 3)
      
      #making it a factor
      TreatmentGroupFactor<-factor(c(1, 2, 3, 3, 4, 1, 2, 4, 3))
  
 
