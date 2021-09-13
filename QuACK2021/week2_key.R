# Week 2 - Accessing and Viewing data
# 7/13/2021
# Willa Voorhies (& Elena in spirit)

#### Warm-up ####
## 1. Create a  vector called "names" with three names
names <- c("Patricia", "Chris", "Marlen")

## 2. Create a vector called "even" that prints all of the even numbers between 1 and 10. 

even <-  seq(2,10, by = 2)

## 3. How many even numbers are there? Hint:Try using the function length() to check how many numbers are in the vector. 
length(even)

# C. Create a vector called "year" of type factor with three years of college (e.g., Freshman, Sophomore, etc.). Check that this works in the global environment

year <- c("freshman", "Sophomore", "Junior")

Yearsfactor <- factor(year)

# option 2
year = factor(c("Freshman", "Sophomore", "Junior"))

year_1 <- c("freshman", "sophmore", "junior")
year <- factor(year_1, levels = c("freshman", "sophomore", "junior", "senior"))

########################## Start of session 2 #####################################
# Working with dataframes. 
# Remember: Dataframes can be thought of as a collection of vectors but there are some important differences that we will explore! 
###################################################################################
##### Lets check our working directory ####

getwd()

# if you are in the wrong directory you can use setwd() to change your directory to the correct location:

setwd('/Users/willav/GoogleDrive/Teaching/QuACK2021/Week2/scripts')
getwd()

#### Read in the datafile ####

# Lets create a new variable "penguins" that will contain the data from the penguins.csv file. 
penguins <- read.csv('/Users/willav/GoogleDrive/Teaching/QuACK2021/Week2/data/penguins.csv')


# In programming we like to be as efficient as possible and eliminate redundancy. A lot of the path to the data is the same as the working directory. In fact, the only difference is that we are in the "data" folder. To get to the data folder from where we are, we go back one step which we can represent with two dots (..)

penguins <- read.csv('../data/penguins.csv')


### Check your understanding: If my working directory was set to my data folder. what would I type to load the data? 
### 




#### Explore the data ####

## Click on the dataset in the global environment. 
## What do you notice happened in the console?

## Lets try running that command directly .
View(penguins)

## This is just a check that our dataset loaded in correctly. But R can give us more info about the data that we might not pick up on at first glance. 


## Lets get a little more information on the structure of the dataset. We can use the str() command. - str stands for "structure". This function call gives you the structure which is similar to the info from the global environment.  It shows you all of the columns and what type they are. It also gives you a sample of the data in each column.
str(penguins)
str(penguins$bill_length_mm)

#### NOTE: if you have an old version of R you might have a bunch of factros instead of characters or strings. We can set some options in R to fix this and give you more control over your data. 
options(stringsAsFactors = FALSE) 
# If you have an older version of R I would suggest updating it. Otherwise just use the options command at the start of every script you write. 


## So far we have looked at the data and we have seen how R is representing our data.

## Lets get some other basic information 
# How many penguins do we have? (how many rows)
nrow(penguins)
length(penguins)


# How many variables did we collect ? (how many columns)
length(penguins)
ncol(penguins)



# We can also get some summary  statistics on the dataset for ourselves using the summary() funciton. 
summary(penguins)



# For numeric columns, gives you mean, median, and quartile information
# For character columns, does not give you much information, just the length and type
# For factors, gives much more information: shows all the levels (i.e.,
# sub-groups), and also how many observations are in each group.


#### Accessing information about specific variables ####

# We can access the information for one column using dollar-sign ($) notation



## Lets make the species column into a factor 

penguins$species <- factor(penguins$species)


# Check to see if it worked using str()

str(penguins)

# we can see a summary of each species now

summary(penguins$species)

#### Add a column ####
# Using the same notation you can add a completely new column
# For example, lets say you wanted to create a new column called "study" and label all of these subjects as study 1. (Perhaps because you are planning to collect more data for a second study). 


penguins$study<-rep(1, nrow(penguins))

# There is an even simpler way to do this in a dataframe. Because R is built for data analysis it assumes you want to do something to all of the rows in your data so we can use the simple code below. 

penguins$study2 <- 1

# NOTE: always check your dataframes to make sure it did what you wanted. 


#### We can also access specific rows. This is  called indexing. #### 
# If you view the dataframe each ach row has a number corresponding to its position in the vector or dataframe. You can actually represent every cell in the dataset by a row and column number. 

# We can ask R to give us the data from a specifc cell or set of cells using the [] notion. It follows the format penguins[row, column]

# first row, first column

penguins[1,1]
# First row, second column

penguins[1,2]

penguins$bill_length_mm[1]

# first row, all colums
penguins[1,1:ncol(penguins)]

penguins[1,]

## This concept will come back and we will do more with it but its important to think of each cell in the dataframe as having a position or an index that you can use to access it. 

##### ################################## Practice Activity answer key ################################ ####
## Q2. Check your working directory to make sure it is set to ../week2/scripts. If not, change your working directory to that location. 

getwd()

## Q3. Read in the covid_data.csv from the ../data directory. (Don’t forget to comment at the top and throughout to explain what you are doing ).

covid_attitudes <- read.csv('../data/covid_attitudes_clean.csv')


## Q4. Look at the data and make sure it loaded correctly

View()
str()
summary()

## Q5. How many columns are in the data?
ncol(covid_attitudes)

## Q6. How many rows?

nrow(covid_attitudes)

## Q7. Choose two columns you think should be factors and make them into factors.
covid_attitudes$Q13_trust_hospital_news <- as.factor(covid_attitudes$Q13_trust_hospital_news)

covid_attitudes$Q13_1_trust_doctor_news <- as.factor(covid_attitudes$Q13_1_trust_doctor_news)

# Check that they are now factors
str(covid_attitudes)

## Q8. How concerned is subject 15 about a covid outbreak (column 11)?

# Subject 15 is in row 5 and their fear of covid outbreak is reported in column 11
covid_attitudes[5,11]

# We can also avoid using the column index and just looking at the fifth row in our column interest
covid_attitudes$Q17_concerned_outbreak[5]

## Q9. Are there any NAs? 
summary(covid_attitudes)
# No missing data 

## Q10. On average, how likely do people think they are to catch covid-19?
summary(covid_attitudes) # this gives us all the cols and we have to search for the variable we want. 
# We can also just get the summary of our column of interest. 
summary(covid_attitudes$Q18_likely_to_catch_covid)

## Q11. How many types of living communities are there? And how many responses are there from each type of community?
# Currently community is a string or character value. This means the summary() function doesn't give us much useful information
summary(covid_attitudes$Q84_community)

# To see the types of communities and the number or responses in each type we need to make it into a factor
covid_attitudes$Q84_community <- as.factor(covid_attitudes$Q84_community)

# Now we can get this information using summary()
summary(covid_attitudes$Q84_community)

