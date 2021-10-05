# Week 6 - ggplot continued and data reshaping
# Elena Leib & Willa Voorhies
# October 5, 2021

#### Set up and load packages #### 
library(tidyverse)
options(stringsAsFactors=FALSE)

#### Warm-up  #### 

## 1. Load in penguins dataset and view your data. Anything diffefrent you notice about the observations this time? 



## 2 Use tidyverse commands to do the following data processing steps (use pipes to connect your commands). 
# 2a. Remove two columns: "bill_length_mm", "bill_depth_mm".
# 2b. Remove NAs from the dataset




#### End of Warm-up ####



#### Data reshaping ####

# The way our data is now, we can't make a violin plot that compares body mass
# in 2007 to body mass in 2008!

# Why's that? It's because we have the data for each of those years in separate
# columns. However, we want to GROUP by year, like we did for sex. And right
# now, we don't have a variable (i.e., a column) that is good for grouping by year.

# The columns we have now, are good for an axis (e.g., y-axis in the previous
# plot, or for making a scatter plot comparing 2007 to 2008)

# So, in order to group by year in our violin plot, we need to 'reshape' the data
# This means that we need to change the way the rows and columns are so that we
# have a column that is good for grouping by year.
# In other words, we want to have a data frame that has a column that indicates
# year, and a column that is for body mass. So there will now be two rows per
# penguin: one row for 2007 and one row for 2008.


# This is what we want our data to look like



# How do we get there?
# We need to use a function called pivot_longer(), to pivot (i.e., reshape, rearrange) our data to be longer (i.e., have more rows)



# We can "undo" what we just did, too! Using the sister function pivot_wider

