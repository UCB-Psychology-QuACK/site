# Week 6 - ggplot continued and data reshaping
# Elena Leib & Willa Voorhies
# October 5, 2021

#### Set up and load packages #### 
library(tidyverse)
library(tidylog)
options(stringsAsFactors=FALSE)

#### Warm-up  #### 

## 1. Load in penguins dataset and view your data. Notice that this isn't the "clean" data set anymore!
penguins <- read.csv("../data/penguins.csv")

## 2. Remove all rows that have NAs, and make year and sex into a factors

# You could do this for each column
penguins_noNA <- penguins %>% 
  drop_na() %>% 
  mutate(sex = factor(sex),
         year = factor(year))

# You could also use this nifty new helper function called across()!
penguins_noNA_2 <- penguins %>% 
  drop_na() %>% 
  mutate(across(c(sex, year), factor))


## 3. We said before that the year column tells you the year that the data were collected. But we haven't mentioned whether these data are cross-sectional or longitudinal. Which is it?
## * Hint: one way you could do this is to use the tidyverse function arrange() (you can do ?arrange or Google it!). You could also do this using group_by!

# Check with arrange, and inspect visually
penguins_check <- penguins_noNA %>% 
  drop_na() %>% 
  arrange(penguin)

# Check with group_by
penguins_count <- penguins_noNA %>% 
  group_by(penguin) %>% 
  count() %>% 
  ungroup()

# Check how many penguins have each count
table(penguins_count$n)



## 4. Plot the relation between sex and body mass across year and species

ggplot(penguins_noNA, aes(x = sex, y = body_mass_g, fill = year)) +
  facet_wrap(~species) +
  geom_violin(trim = FALSE) +
  theme_bw()


## 5. Suppose we wanted to plot the relation between body mass in 2007 and 2008
## for each species. How would we do that?

# We could plot year on the x-axis and body_mass_g on the y-axis. But what if we
# wanted to plot them against each other? What if we wanted to explore how
# predictive body mass in 2007 is of body mass in 2008?

# We'd want something like this set up:
# ggplot(penguins_noNA, aes(x = body_mass_g_2007, y = body_mass_g_2008)) +
#   geom_point() +
#   geom_smooth(method = "lm")

# However, as our data frame is now, we cannot make this plot!!! There is no
# column "body_mass_g_2007"!



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
#  - Half the number of rows
#  - 3 more columns than before!
#  - One row per penguins
#  - Identifier columns then 2 columns per measurement (one for each year)


# And now we can make our plot that we couldn't make in the warm-up!
ggplot(penguins_wide, aes(x = body_mass_g_2007, y = body_mass_g_2008)) +
  facet_wrap(~species) +
  geom_point() +
  geom_smooth(method = "lm")


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
penguins_wide_class <- penguins %>% 
  pivot_wider(names_from = year,
              values_from = c("bill_length_mm", "bill_depth_mm", 
                              "flipper_length_mm", "body_mass_g"),
              names_sep = ".")



### Wide to long ###

penguins_longer <- penguins_wide %>% 
  pivot_longer(cols = contains(c("2007", "2008")), 
               names_to = c(".value", "year"),
               names_sep = "[.]")



# How you use these functions depends a lot on how your columns are already
# named and what exactly you are trying to do. There are a lot of arguments to
# these functions, which gives you a lot of control and flexibility!!! But it
# also makes it confusing to begin learning how to use.


#### A simpler and more fleshed out example of using pivot_wider and pivot_longer ####

# Make a data set with only one of the variables of interest.

## Make wider ##
penguins_smaller <- penguins_noNA %>% 
  select(penguin, species, island, sex, year, body_mass_g)

penguins_smaller_w <- penguins_smaller %>% 
  pivot_wider(names_from = year, # Which column are the names (or "keys") that uniquely identified the rows coming from? Here, year uniquely identified each row.
              values_from = body_mass_g, # Which column do we want to make "wider"? Here, it is body_mass_g
              names_prefix = "body_mass_g.") # Since we are only giving it one values_from column, it will use whatever levels are in the names_from column. In this case, those values are numbers, so we need to provide a prefix for the column names!

# Looking back at our more complex example from above:
penguins_wide_class <- penguins %>% 
  pivot_wider(names_from = year,
              values_from = c("bill_length_mm", "bill_depth_mm", 
                              "flipper_length_mm", "body_mass_g"),
              names_sep = ".")
# Since we give it 4 different columns to make wider, it automatically uses
# those names as the prefixes for the columns. So all I need to specify is what
# separator to use between the original col name and the suffix from year that
# it is adding on.


## Make longer ##
penguins_smaller_l <- penguins_smaller_w %>% 
  pivot_longer(cols = contains(c("2007", "2008")), # we could have also said cols = starts_with("body_mass_g") or contains("body_mass_g") also, but I used this because it lines up with the more complex example!
               names_to = "year",
               values_to = "body_mass_g")

# When you run this though, notice that what used to be the column name (e.g., body_mass_g_2007) is now the value in the column year! And all the values went to the column that we named "body_mass_g". This is annoying, but we can fix it in a few ways.

# First, we could add the names_prefix argument to get rid of it:
penguins_smaller_l <- penguins_smaller_w %>% 
  pivot_longer(cols = contains(c("2007", "2008")),
               names_to = "year",
               names_prefix = "body_mass_g.",
               values_to = "body_mass_g")

# Ahhhh, the looks much better :)
# Buuuuuuut, our code is pretty redundant now! Because we write "body_mass_g"
# twice. (And urg, I just wrote it again!)

# Here's another, more refined way to do it! Notice that our "values_to" column
# name is *already* part of our current column name!

# Our column names are currently: body_mass_g.2007 and body_mass_g.2008
# These have the form: colname.year
# Therefore, in the names_to argument, instead of saying "push the names of
# these columns directly into the new column year" (and have a separate
# values_to argument) like we were before, we can say, "hey, part of the column
# name is the values_to information, and part is what we want in our new column
# year!". We do this by saying names_to = c(".value", "year") and giving an
# argument that indicates what is separating these two pieces of information,
# which in our case is a "."
  
penguins_smaller_l2 <- penguins_smaller_w %>% 
  pivot_longer(cols = contains(c("2007", "2008")),
               names_to = c(".value", "year"),
               names_sep = "[.]")

# Whooohooo! That is so much cleaner! And even better, is that it generalizes,
# too! We can use this same code for any number of columns that are in this
# format, such as our more complex example from above!

penguins_longer <- penguins_wide %>% 
  pivot_longer(cols = contains(c("2007", "2008")), 
               names_to = c(".value", "year"),
               names_sep = "[.]")

# Isn't it great that we don't have to change any of the code to make 8 columns
# (4 variables) longer instead of just our body_mass_g columns?!



#### stat_summary ####

# Sometimes you want to plot something that is aggregated over data with a function
# For example, maybe you want to plot the mean of data

ggplot(penguins_noNA, aes(x = sex, y = body_mass_g, fill = species)) +
  facet_wrap(~species) +
  geom_violin(trim = FALSE) +
  geom_boxplot(width = .1) +
  stat_summary(fun = "mean", geom = "point", shape = 23, size = 3, fill = "black") +
  theme_bw()


ggplot(penguins_noNA, aes(x = sex, y = body_mass_g, fill = sex)) +
  facet_wrap(~species) +
  geom_jitter(width = .1) +
  stat_summary(fun.data = mean_se, geom = "errorbar", width = .1, color = "blue", size = 2) +
  stat_summary(fun = mean, geom = "point", shape = 23, color = "red", fill = "red", size = 2)





#### Practice questions key ####

# 1. Load in data
happiness <- read.csv("../data/world-happiness_2007-2020.csv")

# 2. Keep data for countries that have at least 5 years of data
happiness_clean <- happiness %>% 
  group_by(Country_name) %>% 
  filter(n() >= 5) %>% 
  ungroup()


# You can compare the range of # of years of participation before and after
# cleaning
country_count <- happiness %>% 
  group_by(Country_name) %>% 
  count() %>% 
  ungroup() %>% 
  arrange(n)

country_count_clean <- happiness_clean %>% 
  group_by(Country_name) %>% 
  count(name = "n.years") %>% 
  ungroup() %>% 
  arrange(n.years)

table(country_count$n)
table(country_count_clean$n)

# Could also do this with tidyverse:
country_count_clean_tbl <- country_count_clean %>% 
  group_by(n.years) %>% 
  count(name = "n.countries") %>% 
  ungroup()


# 3. Make a plot that compares happiness in 2019 and 2020
# First, I want to keep only a few columns, filter for years, and reshape it:
happiness_scatter <- happiness_clean %>% 
  select(Country_name, Regional_indicator, Year, Ladder_score) %>% 
  filter(Year %in% c(2019, 2020)) %>% # This %in% operator is very nifty! Good for checking more than one condition on a variable
  pivot_wider(names_from = "Year",
              values_from = "Ladder_score",
              names_glue = "{.value}.{Year}") # Could have also used names_prefix= "Ladder_score.", but this is a much nicer (and more generalizable) way to do it!


# Make plot
ggplot(happiness_scatter, aes(x = Ladder_score.2019, y = Ladder_score.2020, color = Regional_indicator)) +
  facet_wrap(~Regional_indicator) +
  geom_point() +
  geom_smooth(method = "lm")



# Jamboard:
# https://tinyurl.com/quack-plots
