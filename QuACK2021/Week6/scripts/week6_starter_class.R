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
penguins_noNAs <- penguins %>% 
  drop_na() %>% 
  mutate(sex = factor(sex),
         year = factor(year))

penguins_noNAs_2 <- penguins %>% 
  drop_na() %>% 
  mutate(across(c(sex, year), factor))


## 3. We said before that the year column tells you the year that the data were collected. But we haven't mentioned whether these data are cross-sectional or longitudinal. Which is it?
## * Hint: one way you could do this is to use the tidyverse function arrange() (you can do ?arrange or Google it!). You could also do this using group_by!

penguins_check <- penguins_noNAs %>% 
  arrange(penguin)

penguins_count <- penguins_noNAs %>% 
  group_by(penguin) %>% 
  count() %>% 
  ungroup()

table(penguins_count$n)



## 4. Plot the relation between sex and body mass across year and species

ggplot(penguins_noNAs, aes(x = sex, y = body_mass_g, fill = year)) +
  facet_wrap(~species) +
  geom_violin(trim = FALSE) +
  theme_bw()


## 5. Suppose we wanted to plot the relation between body mass in 2007 and 2008
## for each individual penguin, for each species. How would we do that?

# How predictive is body mass in 2007 on body mass in 2008?

# ggplot(penguins_noNAs, aes(x = body_mass_2007, y = body_mass_2008))



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
  pivot_wider(names_from = "year",
              values_from = c("bill_length_mm", "bill_depth_mm", 
                              "flipper_length_mm", "body_mass_g"),
              names_sep = ".")



### Wide to long ###
penguins_longer <- penguins_wide_class %>% 
  pivot_longer(cols = contains(c("2007", "2008")),
               names_to = c(".value", "year"),
               names_sep = "[.]")



# penguins_longer <- penguins_wide_class %>% 
#   pivot_longer(cols = contains("bill_length"),
#                names_to = "year",
#                values_to = c("bill_length"))






#### stat_summary ####

# Sometimes you want to plot something that is aggregated over data with a function
# For example, maybe you want to plot the mean of data


ggplot(penguins_noNAs, aes(x = sex, y = body_mass_g, fill = species)) +
  facet_wrap(~species) +
  geom_violin(trim = FALSE) +
  geom_boxplot(width = .1) +
  stat_summary(fun = "mean", geom = "point", shape = 5, size = 3) +
  theme_bw()


ggplot(penguins_noNAs, aes(x = sex, y = body_mass_g, fill = sex)) +
  facet_wrap(~species) +
  geom_jitter(width = .1) +
  stat_summary(fun = mean, geom = "point", shape = 5, color = "red") +
  stat_summary(fun.data = mean_se, geom = "errorbar", width = .1, color = "blue")

