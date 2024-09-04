# Week 2 - Working directories, accessing and viewing data
# 9/5/2023
# Maria Luciani & Sierra Semko Krouse


############################### Warm up ########################################
# 1. Make a new R script
#   a. Save it to your computer and name it "week2_warmup"
#   b. Add a comment with the title of the script, the date, and your name

# 2. Create three different vectors, each with 5 items
#   a. Vector called "pid" with 5 participant id numbers
pid <- c(305, 299, 155, 399, 275)

#   b.Vector called "ages" with 5 ages of participants
ages <- c(18, 29, 19, 20, 30)

#   c. Vector called "condition" with the condition of each participant, either cond1, cond2, or control. 
condition <- c("cond1", "control", "cond1", "cond2", "cond2")

# 3. Make the condition vector into a factor
condition_factor <- factor(condition)

# 4. Run length(pid). What does it tell you?
length(pid)


#### Introduction to data frames! ####
# Data frames are a collection of vectors, where each column is a vector, and
# rows align the positions of the vectors (e.g., row 1 is position 1 of each of
# the vectors)

# create a data frame from our three vectors
df <- data.frame(pid, ages, condition_factor)

# dollar sign notation
## allows us to access the columns of a data frame
df$pid

################################ Class #########################################

#### Set options and load packages ####
# We will talk about this more later, for now, run this:
options(stringsAsFactors = FALSE) 

#### Load data! ####

# We load in data using a function called read.csv()

# Let's create a new variable "penguins" that will contain the data from the
# penguins.csv file. 
# Thank you Allison Horst!
# Is this going to work? Why or why not?
# penguins <- read.csv("penguins.csv")


# It is not going to work because R doesn't know where to look for this file!
# And when it does look for it in the current directory, it isn't going to find
# it. 


# Where is R looking?
## To answer this, we need to check our working directory (wd)

# What is the current working directory?
getwd()
# "C:/Users/14122/OneDrive/Documents" <- On Maria's computer!



# So how do we get R to find the file? There are a few options


# Hard coding in the absolute path is an option... but we don't recommend
# doing this
# penguins <- read.csv("C:/Users/14122/Box/QuACK/quack2023/data/penguins.csv")
# This is the absolute path of the data on Maria's computer

# We don't recommend doing this. Why not?
# - Not good for if the quack2023 folder is moved somewhere else
# - Also not good for sharing code! That path will be different on someone else's
#   computer, so they will have to change the path to get the code to work, not
#   ideal.


# Instead of absolute paths, we recommend using relative paths.
# This is helpful because if we always use our script location as the working
# directory, then we can give paths to the data (or to other files) that are 
# relative to the script. So when we share our data and scripts, as long as we
# we share the whole folder (e.g., quack2023), it doesn't matter where the other
# person puts the folder, all the scripts will still work for them.

# Here is the structure of our files:
# quack2023
#  - data
#     - penguins.csv
#     - covid_attitudes.csv
#  - week1
#  - week2
#     - week2_starter.R

# So we want our working directory to be wherever quack2023 is located on your
# computer, here represented by ~ for short, and then in the week 2 folder, like
# this, "~/quack2023/week2"

# And then to access the data from the week2 folder, we will tell R to go one
# level up, find the data folder, and then go in there to find the penguins.csv
# file. To do this, we tell it, "../data/penguins.csv" where ".." means "go one
# level up in the file structure."


### 3 ways to set the working directory to week2 ###

# Option 1: Set the working directory "by hand" (e.g., copying it from the
# finder/browser window)
# setwd("C:/Users/14122/Box/QuACK/quack2023/week2")

# Option 2: Session > Set Working Directory > To Source File Location
# Does the setwd("C:/Users/14122/Box/QuACK/quack2023/week2") for you!

# Option 3: Open RStudio by clicking on the source file, and it will set the wd
# to the source file location for you!


# Now we are ready to read in our data!
penguins <- read.csv("../data/penguins.csv")




### Check your understanding: If my data were in my directory (i.e., the SAME
### folder as my script), what path would I give it?
# In this case, you would just say read.csv("penguins.csv"). If the folder R
# needs to look in is already the working directory, then there is no need to
# specify anywhere else! Only when it is in a *different* folder do we tell R
# where to look relative to the working directory (i.e., relative to it's
# current location.)



#### Explore the data ####

# Click on the dataset in the global environment. 
# What do you notice happened in the console?


# Lets try running that command directly.
View(penguins)


# This is just a check that our dataset loaded in correctly. But R can give us
# more info about the data that we might not pick up on at first glance.


# Lets get a little more information on the structure of the dataset. We can
# use the str() command. - str stands for "structure". This function call gives
# you the structure which is similar to the info from the global environment.
# It shows you all of the columns and what type they are. It also gives you a
# sample of the data in each column.

str(penguins)



#### NOTE: if you have an old version of R you might have a bunch of columns
#### that are factors instead of characters or strings. We can set some options
#### in R to fix this and give you more control over your data, which we did
#### above already

# options(stringsAsFactors = FALSE) 

# If you have an older version of R we suggest updating it. Otherwise just use
# the options command at the start of every script you write. (And even with the
# new version, we often keep this line of code to ensure this option is off)


## So far we have looked at the data and we have seen how R is representing our
## data.



## Lets get some other basic information 
# How many penguins do we have? (how many rows)
nrow(penguins)


# How many variables did we collect ? (how many collections)
ncol(penguins)



# We can also get some summary statistics on the dataset for ourselves using the
# summary() function.

summary(penguins)


# For numeric columns, gives you mean, median, and quartile information
# For character columns, does not give you much information, just the length and
# type
# For factors, gives much more information: shows all the levels (i.e.,
# sub-groups), and also how many observations are in each group.
### ^^ Very useful!!! For categorical data, factors >>> characters


#### Accessing specific variables (columns) ####

# We can access the information for one column using dollar-sign ($) notation
penguins$penguin



# Lets make the species column into a factor 
penguins$species <- factor(penguins$species)

# Check to see if it worked using str() (or looking in the global environment)
str()

# Now, make sex into a factor
penguins$sex <- factor(penguins$sex)
str()


# Now let's see how summary(penguins) is different now that those are factors
summary(penguins)
# Now summary gives us counts for each level of the category!


# You can also run summary and str for individual columns
summary(penguins$sex)



#### Add a column #### 
# Using the same notation you can add a completely new column.
# For example, lets say you wanted to create a new column called "study" and
# label all of these subjects as study 1. (Perhaps because you are planning to
# collect more data for a second study).

penguins$study <- "study1"



################### Time check: If we have time at the end.... #################


#### We can also access specific rows: Indexing #### 
# If you view the data frame each row has a number corresponding to its position
# in the vector or data frame. You can actually represent every cell in the data
# set by a row and column number.

# We can ask R to give us the data from a specific cell or set of cells using
# the [] notion. It follows the format penguins[row, column]

# first row, first column
penguins[1,1]

# can also do:
penguins$penguin[1]

# First row, second column
penguins[1,2]
penguins$species[1]

# first row, all columns
penguins[1,]

# first row, first 3 columns
penguins[1, 1:3]


## This concept will come back and we will do more with it but its important to
## think of each cell in the dataframe as having a position or an index that you
## can use to access it.


############################# Practice Activity Key ############################

# Q2. Check your working directory to make sure it is set to ../week2/ If not,
# change your working directory to that location.

getwd()

# Q3. Read in the covid_data.csv from the ../data directory. (Don't forget to comment at the top and throughout to explain what you are doing ).

covid_attitudes <- read.csv('../data/covid_attitudes.csv')


## Q4. Look at the data and make sure it loaded correctly

View()
str()
summary()

## Q5. How many columns are in the data?
ncol(covid_attitudes)

## Q6. How many rows?
nrow(covid_attitudes)

## Q7. What do you think length(covid_attitudes) will tell you? Try it out: what
## does it tell you? Why do you think it tells you this?
length(covid_attitudes)
# It tells you the number of columns! Many people (including me), would expect
# it to give the number of rows, that *feels* like the length of the data frame.
# But what it is actually telling you is the number of elements in the object
# (remember back to with vectors, length(pid) when pid <- c(5, 46, 99, 3, 28)
# was 5.) And the number of elements in a data frame is the number of columns it
# has! We can see that when we "expand" a data frame in the global environment.
# For that reason, length of a data frame gives you the number of columns it
# has. Typically, we use ncol and nrow for data frames instead of length for the
# reason that what length gives you is a little confusing!

## Q8. Choose two columns you think should be factors and make them into factors.
covid_attitudes$Q13.trust_hospital_news <- factor(covid_attitudes$Q13.trust_hospital_news)

covid_attitudes$Q13.trust_doctor_news <- factor(covid_attitudes$Q13.trust_doctor_news)

# Check that they are now factors
str(covid_attitudes)


## Q9. Which columns have the most NAs? 
# You can use summary() to see this, though for character columns, would need to
# make them factors first to see NA count.
summary(covid_attitudes)


## Q10. On average, how likely do people think they are to catch covid-19?
summary(covid_attitudes) # this gives us all the cols and we have to search for the variable we want. 
# We can also just get the summary of our column of interest. 
summary(covid_attitudes$Q18.likely_to_catch_covid)

## Q11. How many types of living communities are there? And how many responses are there from each type of community?
# Currently community is a string or character value. This means the summary() function doesn't give us much useful information
summary(covid_attitudes$Q84.community)

# To see the types of communities and the number or responses in each type we need to make it into a factor
covid_attitudes$Q84.community <- factor(covid_attitudes$Q84.community)

# Now we can get this information using summary()
summary(covid_attitudes$Q84.community)

### Bonus practice: Accessing rows, columns, and cells ###


## 1. Look at participant 15's row of data
covid_attitudes[15,]

## 2. Look at covid outbreak column of data (column 14)
covid_attitudes$Q17.concerned_outbreak
covid_attitudes[,13]

## Q3. How concerned is subject 15 about a covid outbreak?

# Subject 15 is in row 15 and their fear of covid outbreak is reported in column 13
covid_attitudes[15, 13]

# We can also avoid using the column index and just looking at the fifth row in our column interest
covid_attitudes$Q17.concerned_outbreak[15]

