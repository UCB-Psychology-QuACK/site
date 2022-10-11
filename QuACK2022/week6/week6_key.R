# Week 6 - ggplot continued and data reshaping
# Elena Leib & Willa Voorhies
# October 4, 2021

#### Set up and load packages #### 
library(tidyverse)
library(tidylog)
options(stringsAsFactors=FALSE)

#### Warm-up  #### 

## 1. Load in penguins_long dataset as "penguins" and view your data.
penguins <- read.csv("../data/penguins_long.csv")

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


## 3. We said before that the year column tells you the year that the data were
## collected. But we haven't mentioned whether these data are cross-sectional or
## longitudinal. Which is it?
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
  theme_classic()


## 5. Run the following code:

ggplot(penguins_noNA, aes(x = sex, y = body_mass_g)) +
  geom_violin(trim = FALSE) +
  stat_summary(fun.data = mean_se, geom = "errorbar", width = .1, size = .5) +
  stat_summary(fun = mean, geom = "point", size = 2) +
  theme_classic()

## What does stat_summary do?
### Applies and plots a summary function, e.g., mean
### You can set how mean is plotted by changing the geom, and within that you
### can change the size, color, etc.


## Play around with the size and width arguments and see what changes in the plot


## Here's another example:

ggplot(penguins_noNA, aes(x = sex, y = body_mass_g, fill = species)) +
  facet_wrap(~species) +
  geom_violin(trim = FALSE) +
  geom_boxplot(width = .1) +
  stat_summary(fun.data = mean_se, geom = "errorbar", width = .1, size = 2) +
  stat_summary(fun = "mean", geom = "point", size = 3) +
  theme_classic()


## 6. Suppose we wanted to plot the relation between body mass in 2007 and 2008
## for each species. How would we do that?

# We could plot year on the x-axis and body_mass_g on the y-axis. But what if we
# wanted to plot them against each other? What if we wanted to explore how
# predictive body mass in 2007 is of body mass in 2008?

# We'd want something like this set up:
# ggplot(penguins_noNA, aes(x = body_mass_g.2007, y = body_mass_g.2008)) +
#   geom_point() +
#   geom_smooth(method = "lm")

# However, as our data frame is now, we cannot make this plot!!! There is no
# column "body_mass_g.2007"!



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
#  - Half the number of rows
#  - 3 more columns than before!
#  - One row per penguins
#  - Identifier columns then 2 columns per measurement (one for each year)


# And now we can make our plot that we couldn't make in the warm-up!
ggplot(penguins_wide, aes(x = body_mass_g.2007, y = body_mass_g.2008)) +
  facet_wrap(~species) +
  geom_point() +
  theme_classic()


# Sometimes our data may come in this shape. And this isn't always useful,
# because we may want to GROUP (or facet) by year, like we've done for other
# categorical variables. And right now, we don't have a variable (i.e., a
# column) that is good for grouping by year.


# "Wider" format  --> increases # of columns and decreases # of rows
# "Longer" format --> increases # of rows and decreases # of columns
#   - Note: the truest "long" format would be only 2 columns! One for
#   information type, and one for the value! But this wouldn't be very useful at
#   all!


# So how to we change the shape of our data? Pivoting!


# Let's use the built-in data set mtcars to explore pivoting in it's simplest form.
View(mtcars)
mtcars <- mtcars %>% 
  mutate(car = rownames(mtcars))

## Longer
mtcars_long <- mtcars %>% 
  pivot_longer(cols = !car)

## Wider
mtcars_long2wide <- mtcars_long %>% 
  pivot_wider()


# This is helpful to learn about the different arguments. However, in practice,
# it is rare that we want to pivot a whole data frame like this. Often, we want
# to use some kind of categorical variable to pivot on, such as year in our
# penguins data set.


## Wider
penguins_wider_toPlot <- penguins_long %>% 
  select(penguin, body_mass_g, year) %>% 
  pivot_wider(id_cols = penguin,
              names_from = year,
              values_from = body_mass_g)

# But having the names as 2007 and 2008 is useless because we don't know what
# the measurement is, so we can add a prefix with that information
penguins_wider_toPlot <- penguins_long %>% 
  select(penguin, body_mass_g, year) %>% 
  pivot_wider(id_cols = penguin,
              names_from = year,
              names_prefix = "body_mass_g.",
              values_from = body_mass_g)




## Longer
penguins_wider2longer_toPlot <- penguins_wider_toPlot %>% 
  pivot_longer(!penguin)

# That's not what we want!
penguins_wider2longer_toPlot <- penguins_wider_toPlot %>% 
  pivot_longer(!penguin,
               names_to = "year",
               names_prefix = "body_mass_g.",
               values_to = "body_mass_g")


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


# How you use these functions depends a lot on how your columns are already
# named and what exactly you are trying to do. There are a lot of arguments to
# these functions, which gives you a lot of control and flexibility!!! But it
# also makes it confusing to begin learning how to use.


#### Simpler penguin example from above with more explanations ####



## Make wider ##
penguins_wider_ex2 <- penguins_long %>% 
  # Keep only one of the longitudinal variables of interest - body_mass_g
  select(penguin, species, island, sex, year, body_mass_g) %>% 
  
              # names_from: Which column are the names (or "keys") that uniquely identify
              # the rows coming from? Here, year uniquely identifies each row
              # because the data come from either 2007 or 2008.
  pivot_wider(names_from = year, 
              
              # values_from: Which column do we want to make "wider"? In other
              # words, where are we getting our values from for the new columns?
              # Here, it is body_mass_g
              values_from = body_mass_g, 
              
              # names_prefix: Since we are only giving it one values_from
              # column, it will use whatever levels are in the names_from column
              # as the names for the columns. In this case, those values are
              # numbers and so we we would lose the information that says what
              # those values refer to (body mass!). Therefore, we need to
              # provide a prefix for the column names!
              names_prefix = "body_mass_g.") 

# Looking back at our more complex example from above:
penguins_wide_class2 <- penguins %>% 
  pivot_wider(names_from = year,
              values_from = c("bill_length_mm", "bill_depth_mm", 
                              "flipper_length_mm", "body_mass_g"),
              names_sep = ".")
# Since we give it 4 different columns to make wider, it automatically uses
# those names as the prefixes for the columns. So all I need to specify is what
# separator to use between the original col name and the suffix from year that
# it is adding on.


## Make longer ##
penguins_longer_ex2 <- penguins_wider_ex2 %>% 
  
              # cols: We don't want sex, species, or island to pivot longer,
              # only the body_mass_g columns, so need to select those. We could
              # have also said cols = starts_with("body_mass_g") or
              # contains("body_mass_g") also, but I used this because it lines
              # up with the more complex example!
  pivot_longer(cols = contains(c("2007", "2008")), 
               
               # names_to: what will the name of the new column be that will
               # hold the names of the columns that are pivoting longer? In
               # other words, what will the column be called that uniquely
               # identifies the rows with the year 2007 or 2008?
               names_to = "year",
               
               # values_to: what will the name of the column be that has the
               # values from the column that is pivoting longer?
               values_to = "body_mass_g")

# When you run this though, notice that what used to be the column name (e.g.,
# body_mass_g_2007) is now the value in the column year! And all the values went
# to the column that we named "body_mass_g". This is annoying, but we can fix it
# in a few ways.

# First, we could add the names_prefix argument to get rid of it:
penguins_longer_ex2 <- penguins_wider_ex2 %>% 
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
  
penguins_longer_ex3 <- penguins_wider_ex2 %>% 
  pivot_longer(cols = contains(c("2007", "2008")),
               names_to = c(".value", "year"),
               names_sep = "[.]")

# Whooohooo! That is so much cleaner! And even better, is that it generalizes,
# too! We can use this same code for any number of columns that are in this
# format, such as our more complex example from above!

penguins_longer_class2 <- penguins_wide %>% 
  pivot_longer(cols = contains(c("2007", "2008")), 
               names_to = c(".value", "year"),
               names_sep = "[.]")

# Isn't it great that we don't have to change any of the code to make 8 columns
# (4 variables) longer instead of just our body_mass_g columns?! :)



