# QuACK Week 4 - Tidyverse Part 2
# September 21, 2021
# Elena Leib & Willa Voorhies

#### Load libraries and set options ####
options(stringsAsFactors = FALSE)

library(tidyverse)
library(tidylog)


#### Warm-up ####

# 1. Load and view the penguins.csv 



# 2.  Follow the steps we completed last week to create penguins_clean.csv. Do all of the steps in one pipe. 
# Try to do as much as you can without looking back at last week's code!
  # i) remove the flipper_length_mm variable



  # ii) Keep only the data from 2008


  # iii) remove all NA values


  # iv) add a new column bill_sum that is the sum of bill_length_mm and bill_depth_mm


  # v) make sex into a factor



#### Where we left off last week / Warm-up review ####


#### mutate() continued: case_when() ####

# As a reminder, mutate() allows us to A) Add new columns and B) Change a current
# column. Whether a new column is added or an old column is edited depends on
# what we name the column. If we give it a name of a column that already exists,
# it will edit that column. If it's a new name, it will make a new column.

# Sometimes when we are creating or editing a column, we want the contents of
# that column to be *conditional* on another piece of information

# Can you think of any examples?






# Let's do an example for our penguins data set:
# Imagine we want to categorize our penguins by how heavy they are into "heavy"
# and "light". How would we do this?

# First in pseudocode:




# Case_when allows us to do these conditionals
# Here is the syntax:
# mutate(newColName = case_when(condition1 ~ result1,
#                               condition2 ~ result2,
#                               ...
#                               TRUE ~ catchAll))

# Here is a great illustration by Allison Horst! 
# https://twitter.com/allison_horst/status/1282785610273447936?lang=en


# Now in real code:




# Now imagine that there was a scientific breakthrough, and the species that you found on Torgerson that you thought was Adelie is actually a new species!

# Pseudocode:



# Real code:


# This kind of logic -- if/else (here renamed as case_when) is prominent
# throughout all coding languages! We did it last week with filter, and now with
# case_when. It will continue to come up!


#### group_by() + summarise() ####
# When we have categorical data, we often want to calculate summary stats for each group. 
# For example, we might want to see the mean and sd of body_mass  for each species of penguin. 
# We can use the group_by() and summarise() functions to calculate stats on each group and save them as a new dataframe. 

## Save the mean and sd  as a new dataframe called sum_stats_species 





# We can customize our column names within the summarise() function.



## We can also group our data by mulitple categories. eg. by species AND island. 


# We can use the n() function within summarise() to get the number or frequency in each group.
# eg. Which island has the fewest Adelie penguins? 



## It looks like island may have an effect on penguin weight. Now that we know this, we might want to account for this in our data. 
#  For example, lets create a new column with z-scored body_mass
# To z-score our data : ( body_mass - mean(body_mass) ) / sd(body_mass)




# This isn't exactly what we want. We noted that weights seem to differ by island so lets normalize our data within island (ie we want to use the mean specific to the island the penguin is on). 

# This kind of idea is often useful in situations where you are creating standardized scores within age groups or populations of participants. 




#### Joining data frames ####

# Sometimes, we want to combine data from multiple csv files into one data
# frame. This is very common! For example, you may have one file of demographic
# data and one with the participant's experimental data.

# Here's another common problem: most of the time, the data frames DON'T have
# the same number of rows. What are some reasons for why that could be?





# Imagine you've cleaned all you experimental data, and needed to remove some
# participants (they just didn't pay attention to the task and their data were
# terrible!)
# You started off with 100 participants, so this is how many rows you have in
# your demographic data frame.
# In your clean data, you only have valid data for 75 participants!
# In this case, you only want the demo data for the 75 participants.


# Now, let's imagine another scenario.
# What if your demographic info included a survey and not all the participants filled it out! Now your demographic data includes only 82 participants.
# And your cleaned data has 75 still. 
# What would you do?


# There is a "join" for all occasions!
# - full_join - keeps all rows in both data frames
# - inner_join - keeps only rows that are in both data frames
# - left_join - keeps all rows from left data frame
# - right_join - keeps all rows from right data frame

# Here's a nice visualization of the 4 kinds of "joins"
# http://svmiller.com/images/sql-joins.jpeg

# Sort of a way of "filtering" in its own right!

# Check out the tidy cheatsheet for more:
# https://www.rstudio.com/wp-content/uploads/2015/02/data-wrangling-cheatsheet.pdf


# Let's try it with our penguins code!

penguins_researcher <- read.csv("../data/penguins_researcher-info.csv")

# How many observations are there in this data frame?

# How many observations in penguins?

# How many observations in penguins_clean?



## Full join - penguins + researcher ##



## Full join - penguins_clean + researcher ##



## Inner join - penguins_clean + researcher ##



## Left join - penguins_clean + researcher ##



## Right join - penguins_clean + researcher ##



# Now let's try inner join but with a researcher data set that is missing obsv
penguins_researcher_missing <- read.csv("../data/penguins_researcher-info_missingData.csv")


