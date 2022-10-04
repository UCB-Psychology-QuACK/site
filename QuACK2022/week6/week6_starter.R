# Week 6 - ggplot continued and data reshaping
# Elena Leib & Willa Voorhies
# October 4, 2021

#### Set up and load packages #### 
library(tidyverse)
library(tidylog)
options(stringsAsFactors=FALSE)

#### Warm-up  #### 

## 1. Load in penguins_long dataset as "penguins" and view your data.


## 2. Remove all rows that have NAs, and make year and sex into a factors. Name
## the new data frame "penguins_noNA"



## 3. We said before that the year column tells you the year that the data were
## collected. But we haven't mentioned whether these data are cross-sectional or
## longitudinal. Which is it?
## * Hint: one way you could do this is to use the tidyverse function arrange()
## (you can do ?arrange or Google it!). You could also do this using group_by!




## 4. Plot the relation between sex and body mass across year and species


## 5. Run the following code:

ggplot(penguins_noNA, aes(x = sex, y = body_mass_g)) +
  geom_violin(trim = FALSE) +
  stat_summary(fun.data = mean_se, geom = "errorbar", width = .1, size = .5) +
  stat_summary(fun = mean, geom = "point", size = 2) +
  theme_bw()

## What does stat_summary do?


## Play around with the size and width arguments and see what changes in the plot


## Here's another example:

ggplot(penguins_noNA, aes(x = sex, y = body_mass_g, fill = species)) +
  facet_wrap(~species) +
  geom_violin(trim = FALSE) +
  geom_boxplot(width = .1) +
  stat_summary(fun.data = mean_se, geom = "errorbar", width = .1, size = 2) +
  stat_summary(fun = "mean", geom = "point", size = 3) +
  theme_bw()



## 6. Suppose we wanted to plot the relation between body mass in 2007 and 2008
## for each species. How would we do that?



### End of Warm-up ###



#### Data reshaping ####

penguins_long <- read_csv("../data/penguins_long.csv")

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

# What do you notice about this data frame compared to our original long penguins
# data frame?




# And now we can make our plot that we couldn't make in the warm-up!




# Sometimes our data may come in this shape. And this isn't always useful,
# either because we may want to GROUP (or facet) by year, like we've done for
# other categorical variables. And right now, we don't have a variable (i.e., a
# column) that is good for grouping by year.


# "Wider" format  --> increases # of columns and decreases # of rows
# "Longer" format --> increases # of rows and decreases # of columns
#   - Note: the truest "long" format would be only 2 columns! One for
#   information type, and one for the value! But this wouldn't be very useful at
#   all!

# To pivot longer or wider, you don't need a categorical variable (e.g., could
# make your whole data frame 2 columns, as just described). However, it is in
# the context of categorical variables that you often want to do some kind of
# reshaping, so that is something to keep in mind that can be helpful.


# So how to we change the shape of our data? Pivoting!


# Let's use the built-in data set mtcars to explore pivoting in it's simplest form.
View(mtcars)

# Make a quick change to the mtcars data set to make it more user friendly
mtcars <- mtcars %>% 
  mutate(car = rownames(mtcars))

## Longer


## Wider



# This is helpful to learn about the different arguments. However, in practice,
# it is rare that we want to pivot a whole data frame like this. Often, we want
# to use some kind of categorical variable to pivot on, such as year in our
# penguins data set.


## Wider


# But having the names as 2007 and 2008 is useless because we don't know what
# the measurement is, so we can add a prefix with that information




## Longer


# That's not what we want!




## Here is code to pivot wider and longer for the whole data set
# Long to wide #
penguins_wide_class <- penguins %>% 
  pivot_wider(names_from = year,
              values_from = c("bill_length_mm", "bill_depth_mm", 
                              "flipper_length_mm", "body_mass_g"),
              names_sep = ".")



# Wide to long #
penguins_long_class <- penguins_wide %>% 
  pivot_longer(cols = contains(c("2007", "2008")), 
               names_to = c(".value", "year"),
               names_sep = "[.]")

