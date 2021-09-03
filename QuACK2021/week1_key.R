# Week 1 - Intro to R and Programming
# 8/31/2021
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
N <- 100

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



#### Vectors ####

# Syntax for creating a vector is: c()
# c means "concatenate" (some people also think of it as "combine") 
names <- c("Elena", "Willa", "Gold", "Monica", "Roya")

years <- c("senior", "senior", "freshman", "sophomore", "freshman")

dev_area <- c(TRUE, FALSE, FALSE, TRUE, TRUE)

dev_area2 <- c(1, 0, 0, 1, 1)



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

years_factor2 <- factor(years, levels = c("freshman", "sophomore", "junior", "senior"))

levels(years_factor2)

# Another, more traditional example
condition <- factor(c("Treatment1", "Treatment2", "Control"))

#### Data Frames ####
# We can take the vectors that we have made and make them into a data frame!

# Ignore this next line for now, we will come back to this:
options(stringsAsFactors = FALSE)

# Make our data frame
students <- data.frame(names, years_factor2)

# Dollar sign notation: Get a column out
students$names 

# All columns are vectors!

 