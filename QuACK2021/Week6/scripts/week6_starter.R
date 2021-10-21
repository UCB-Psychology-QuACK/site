# Week 6 - ggplot continued and data reshaping
# Elena Leib & Willa Voorhies
# October 5, 2021

#### Set up and load packages #### 
library(tidyverse)
library(tidylog)
options(stringsAsFactors=FALSE)

#### Warm-up  #### 

## 1. Load in penguins dataset and view your data. Notice that this isn't the "clean" data set anymore!


## 2. Remove all rows that have NAs, and make year and sex into a factors



## 3. We said before that the year column tells you the year that the data were collected. But we haven't mentioned whether these data are cross-sectional or longitudinal. Which is it?
## * Hint: one way you could do this is to use the tidyverse function arrange() (you can do ?arrange or Google it!). You could also do this using group_by!







## 4. Plot the relation between sex and body mass across year and species



## 5. Suppose we wanted to plot the relation between body mass in 2007 and 2008
## for each species. How would we do that?



### End of Warm-up ###



#### Data reshaping ####

# It is handy that we can use year as a grouping variable!
# However, A) This might not always be the way we want to organize our data, and
# B) This isn't always how we *get* our data!

# Let's explore this more.

# Suppose we want to use body mass in 2007 as a predictor of the penguins body
# mass in 2008. We aren't doing any statistics in this course, but you can get a
# proxy for this by trying to plot the relation between body mass in 2007 and
# 2008. You want body mass in 2007 on the x-axis, and body mass in 2008 on the
# y-axis. However, as the data are now, this just isn't possible!

# One **shape** of our data may not fit all the things we want to do with it!

# This is where data "reshaping" comes in! When we reshape our data, we aren't
# changing the values of it in any way. But we are changing how the data are
# organized. In other words, we are changing the *dimensions* of our dataframe
# (the number of rows and columns).

# Let's check out another "shape" for our data:
penguins_wide <- read.csv("../data/penguins_wide.csv")

# What do you notice about this data frame compared to our original penguins
# data frame?







# Sometimes our data may come in this shape. And this isn't always useful,
# because we may want to GROUP (or facet) by year, like we've done for other
# categorical variables. And right now, we don't have a variable (i.e., a
# column) that is good for grouping by year.


# "Wider" format  --> increases # of columns and decreases # of rows
# "Longer" format --> increases # of rows and decreases # of columns
#   - Note: the truest "long" format would be only 2 columns! One for
#   information type, and one for the value! But this wouldn't be very useful at
#   all!


# So how to we change the shape of our data?

### Long to wide ###




### Wide to long ###





#### stat_summary ####

# Sometimes you want to plot something that is aggregated over data with a function
# For example, maybe you want to plot the mean of data





