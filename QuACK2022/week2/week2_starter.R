# Week 2 - Working directories, accessing and viewing data
# 9/6/2022
# Elena Leib & Willa Voorhies




#### Set options and load packages ####
# We will talk about this more later, for now, run this:
options(stringsAsFactors = FALSE) 



#### Load data! ####

# We load in data using a function called read.csv()

# Let's create a new variable "penguins" that will contain the data from the
# penguins.csv file. 
# Is this going to work? Why or why not?










# In programming we like to be as efficient as possible and eliminate
# redundancy. A lot of the path to the data is the same as the working
# directory. In fact, the only difference is that we are in the "data" folder.
# To get to the data folder from where we are, we go back one step which we can
# represent with two dots (..)




### Check your understanding: If my data were in my directory (i.e., the SAME
### folder as my script), what path would I give it?




#### Explore the data ####

# Click on the dataset in the global environment. 
# What do you notice happened in the console?


# Lets try running that command directly.



# This is just a check that our dataset loaded in correctly. But R can give us
# more info about the data that we might not pick up on at first glance.


# Lets get a little more information on the structure of the dataset. We can
# use the str() command. - str stands for "structure". This function call gives
# you the structure which is similar to the info from the global environment.
# It shows you all of the columns and what type they are. It also gives you a
# sample of the data in each column.





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



# How many variables did we collect ? (how many collections)




# We can also get some summary statistics on the dataset for ourselves using the
# summary() function.




# For numeric columns, gives you mean, median, and quartile information
# For character columns, does not give you much information, just the length and
# type
# For factors, gives much more information: shows all the levels (i.e.,
# sub-groups), and also how many observations are in each group.
### ^^ Very useful!!! For categorical data, factors >>> characters


#### Accessing information about specific variables ####

# We can access the information for one column using dollar-sign ($) notation




# Lets make the species column into a factor 




# Check to see if it worked using str()






#### Add a column #### 
# Using the same notation you can add a completely new column.
# For example, lets say you wanted to create a new column called "study" and
# label all of these subjects as study 1. (Perhaps because you are planning to
# collect more data for a second study).




################### Time check: If we have time at the end.... #################


#### We can also access specific rows: Indexing #### If you view the data frame
#each row has a number corresponding to its position in the vector or data
#frame. You can actually represent every cell in the data set by a row and
#column number.

# We can ask R to give us the data from a specific cell or set of cells using
# the [] notion. It follows the format penguins[row, column]

# first row, first column


# First row, second column


# first row, all colums



## This concept will come back and we will do more with it but its important to
## think of each cell in the dataframe as having a position or an index that you
## can use to access it.


