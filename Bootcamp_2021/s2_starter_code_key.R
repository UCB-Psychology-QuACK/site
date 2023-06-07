# Week 2 - Accessing and Viewing data
# 7/13/2021
# Elena Leib (& Willa in spirit)


#### Warm Up ####

# 1. Create three different vectors: 
## i. A  vector called "names" with three names

names <- c("Sarah", "Jamal", "Nico")

## ii. A vector named "ages" with three ages of college students
ages <- c(18, 20, 21)


## iii. A vector called "year" with three years of college (e.g., Freshman, Sophomore, etc.)
year <- c("freshman", "junior", "senior")
year <- factor(year, levels = c("freshman", "sophomore", "junior", "senior"))

# Could do this in one step:
# year <- factor(c("freshman", "junior", "senior"), levels = c("freshman", "sophomore", "junior", "senior"))

# 2. Run the code and check that everything looks correct in the global environment.


#### Set options ####
# This is good practice to run at the beginning of all you scripts so that when
# you create or read in data frames, it keeps the string columns as strings and
# does not automatically make them into factors! (More on this below)
options(stringsAsFactors = FALSE)


#### Data frames ####

students <- data.frame(names, ages, year)
View(students)
# Can also look at it in the global environment
# We see that each of our vectors became columns
# And R is smart enough to make our column names the names of the vectors!

# We can examine each column using the '$'
# data frame name + $ + column name
# If we run these lines of code, we see that each column is a vector! 
students$names
students$ages
students$year

## Normally, we don't create our own data frames by hand though because we have
## collected data that we have stored in a file that we want to read in to work
## with! So let's go ahead and do that now.

## But first, before we read in any data, we need to understand the structure of
## our file directory and understand where our R script "lives" (i.e., which
## folder it is in), where our data file lives, and where our R script is
## pointing to.

#### Check working directory ####
## The working directory is the file folder that R is currently working from
## You can also think of it as the folder that R is pointing to
## R assumes that whatever the working directory is, that is where you want to
## read files from and write new files to

# Command to check the working directory
getwd()
# You can also see what the working directory is by looking at the bar below the
# tabs that say "Console," "Terminal," and "Jobs" and above the console panel


#### Read in data ####
# Use help function to look up read.csv
?read.csv

# If your data file is in your current working directory (which often means it
# is in the same folder as the R script you are working with), you can just
# write read.csv("name-of-file.csv"). You don't need to give R any other
# "address" information from the file because R is already in the right place to
# look for it!
# For example:
# penguins <- read.csv("penguins.csv")

# In the file structure that I was using as an example in class, my data file
# "lives" one level *above* my R script and current working directory. In other
# words, I have a folder called 2021_Summer, which has sub-folders for each
# session of this workshop. I keep my data files in the main folder since I will
# be using them every session, and I keep my session-specific scripts in their
# respective session folders.

# My working directory was the session2 folder, where my R script lives
# (whenever you open up a script, RStudio will automatically set the script's
# folder location as the working directory! This is very handy!). Therefore, I
# need to indicate to R to look at the folder one level higher in order to find
# my data file! I indicate this to R by adding something to the beginning of the
# name of my data file. I add "../", which says, "look one folder higher."

# Tell it to look one level higher to look for the file
penguins <- read.csv("../penguins.csv")

# What the full name of your file looks like will depend on YOUR file structure!
# If your script and csv file are in the same folder, no need to add prefix, if
# they are in different places (i.e., the data file is NOT in the current
# working directory), then you MUST tell R where to look for it!

# Note: You could also give it the *absolute* file path, which is the full file
# path (think address) of where R can find the file. In my file structure, it
# would look like this:
# penguins <- read.csv("C:/Users/14122/Box/QuACK/2021_Summer/penguins.csv")
# It works! BUT we do not recommend using absolute file paths for a variety of reasons:
#   - One of the names of the folders could change, then you'd have to fix the path
#   - If you are sharing your code, someone else's file path might be different,
#     so they would have to go through and change all the paths (e.g., the
#     "C:/Users/14122/Box/QuACK/" part could be different between people)

# For these reasons, we recommend always using *RELATIVE* paths, so it is always
# in reference to the folder in which your script is in! And when you share your
# script, share all your files and folders, so that structure is maintained!
# e.g., the 2021_Summer folder with all the files and sub-folders inside

# Regardless of how you do it, just be careful and make sure you always know where your R script is located, where your data file is located, and where the working directory is.



#### View data ####
# Check it out in the global environment
## How many columns?
# 9 variables = 9 columns
# Can also do ncol()
ncol()

## How many rows?
# 344 observations (obs.) = 344 rows
# ^^ Note! Does not count the row with the col names, it knows that those are
# the names for the variables/columns

# Can also do nrow()
nrow()


# View()
View(penguins)

# summary() - When called on a data frame, gives you summary information for
# each column.
# For numeric columns, gives you mean, median, and quartile information
# For character columns, does not give you much information, just the length and type
# For factors, gives much more information: shows all the levels (i.e.,
# sub-groups), and also how many observations are in each group
summary(penguins)

# str() - str stands for "structure". This function call gives you the structure
# of the data frame, which is similar to the information that the global
# environment gives you. It shows you all of the columns and what type they are.
# It also gives you a sample of the data in each column.
str(penguins)


#### Make factors ####
# Let's make some columns into factors
summary(penguins$species)
penguins$species <- factor(penguins$species)

## Check what this column look like now in summary() and str() to see the
## results of what you did!
str(penguins$species)
summary(penguins$species)

# Make more columns into factors
penguins$island <- factor(penguins$island)
penguins$sex <- factor(penguins$sex)
penguins$year <- factor(penguins$year)

## Check results again
summary(penguins)
str(penguins)


#### stringsAsFactors = FALSE versus stringsAsFactors = TRUE ####

# R used to default to making all string columns in a data frame into factors!
# This was bad, because not all strings *should* be factors!
# You want to control this yourself.

# So, always needed to set stringsAsFactors = FALSE, so that when it loaded in
# a csv file, it would keep string columns and strings.

# NOW, default is FALSE! So technically, don't need to do this anymore, but I
# still do it, because I like that it is explicit, so there is no confusion
# Plus, people have different versions of R, for example, I don't have the most
# recent version, so mine doesn't default to FALSE (but yours probably does),
# so it is safer to always include that in the script

options(stringsAsFactors = TRUE)
penguins2 <- read.csv("../penguins.csv")
summary(penguins2)
str(penguins2)

# ^^ see what happened?!

# Ok, let me switch it back now to be safe!
options(stringsAsFactors = FALSE)


###############################################################################X

#### Answers to group activity ####

# 2. Check working directory
getwd()

# 3. Read in data
covid_attitudes <- read.csv("../covid_attitudes.csv")

# 4. Look at the data and make sure it loaded correctly
View(covid_attitudes)
str(covid_attitudes)
summary(covid_attitudes)

# 5. How many columns are in the data?
# 29

# 6. How many rows?
# 1020

# 7. Make 2 columns into factors
covid_attitudes$Q8.covid.info <- factor(covid_attitudes$Q8.covid.info)
summary(covid_attitudes$Q8.covid.info)

covid_attitudes$Q84.community <- factor(covid_attitudes$Q84.community)
summary(covid_attitudes$Q84.community)

# 8. Which columns have the most NAs?
summary(covid_attitudes)
# Sort of depends on which you made into factors...
# e.g., Q43 has 190 NAs! (number, so will show NAs)
# Q84 has 188 NAs

## What do you notice about how the NAs are represented in different columns? In
## summary? When you View() it?

# I notice that for the numeric columns, the NAs are italicized and they come up
# as "NA's" in the summary.

# For the string columns, NA is represented as #N/A and show up as a level when
# made a factor, instead of ignored (like they are supposed to be)... this has
# to do with the formatting of the original data, and is not the best form for
# R. We will learn how to take care of this next week.

# 9. On average, how likely do people think they are to catch covid-19?
# To answer this question, we first have to find the relevant column: Q_18
# Then, use summary to find mean:
summary(covid_attitudes$Q18_likely_to_catch_covid)
# Mean is 42.16, so on average, people think they have a 42.16% chance of
# catching covid

# 10. How many types of living communities are there?
# To answer this question, we first have to find the relevant column: Q_84
# If you haven't already, need to turn it into a factor:
covid_attitudes$Q84.community <- factor(covid_attitudes$Q84.community)

# Then, use summary to find mean:
summary(covid_attitudes$Q84.community)
# 4 types of communities and NA:
#N/A      large city      rural area small city/town          suburb 
#188             150              66             260             356


# 11. Think of another question you can ask with your group and answer it. 
# This was up to each group!