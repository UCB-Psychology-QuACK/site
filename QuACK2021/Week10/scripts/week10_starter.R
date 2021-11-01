# Week 10 - Functions
# Elena & Willa
# 11/2/21

#### Load libraries and set options ####
library(tidyverse)
# options(stringsAsFactors = FALSE)



#### Let's make some functions! ####

# Let's use bootstrapping to estimate how much the mean body mass varies between
# samples of penguins (standard error of the mean - SEM)

# Load data
penguins <- read.csv("../data/penguins_clean.csv") # (Note: only 2008 sample)


# Here is what we did before:

# Sample our sample size (101) 1000 times!

# Vector to keep track of the sample means
means <- c()
for(i in 1:1000) {
  # 1) Create a resampled data set, sample WITH REPLACEMENT
  p.resampled <- penguins %>%
    sample_n(nrow(penguins), replace = T)
  
  # 2) Calculate the mean of body mass and save it
  means[i] <- mean(p.resampled$body_mass_g)
  
}

# Plot our means
hist(means)
sd(means)



# How could we make these steps more "flexible"?













# Let's make our sample size and num_samples more flexible!






# Now, let's take this one step even further in making this flexible by making
# it into a function called bootstrap_bodyMass





# Let's add some additional functionality to our function.
# Let's make it so we can set a seed that we want it to use so that we (and
# others) can replicate our results.





# But what if I don't always want to pass it a seed? Right now, if I don't pass
# it a seed, the entire function doesn't work! We've added flexibility, but
# we've also removed some at the same time...

# To solve this problem, we can set a default value for an argument! This allows
# us to make an argument optional, and only if we pass something as an argument
# in the function will it override the default.

# Let's make the default value NA because if we don't specifically set a seed,
# we don't want there to be one, and we will just let R use the default seed. We
# will also need to make some changes to the body of our function to fully
# incorporate the change.









# What other parts of this function would we want to make more flexible?










# Maybe I don't only want to find the bootstrapped error of body_mass_g. Perhaps
# I want the flexibility to find any of the variables I have!






# ^^ should give us the same as what we got before with the _bodyMass function!
means <- bootstrap_bodyMass(100, 1000, 1234)
hist(means)

# It does!


# Let's try it with another variable, bill_length_mm



# Does this make sense? Let's check the original data:
mean(penguins$bill_length_mm)
mean(means)

sd(penguins$bill_length_mm) / sqrt(nrow(penguins))
sd(means)
# ^^ Looks good!



# What if we wanted to do it with a different data set?
# Load more data
baby <- read.csv("../data/brainwavebabydata.csv")
happiness <- read.csv("../data/world-happiness_2020.csv")









# ^^ should give us the same as what we got before with the _penguins function!
means <- bootstrap_penguins("body_mass_g", 100, 1000, 1234)
hist(means, main = "body_mass_g")

# It does!


# Now, try it with another data set and variable. Then we will do some together.









# If I were writing this function for my work, I would TEST TEST TEST! We would
# need to make sure that everything is working properly!






# Now that we have a working function, next thing is to DOCUMENT it so that we can easily share it with others!
# The most important things to document about a function are 3-fold:
# 1) What it does
# 2) What its arguments are (both the type and what it is/what purpose it serves)
# 3) What it returns

# Let's do this documentation for our bootstrap_SEM function














#### Good resources about functions ####
# Basic intro to functions:
# https://swcarpentry.github.io/r-novice-inflammation/02-func-R/

# Intro to roxygen2 for more formally documenting functions that you make:
# https://combine-australia.github.io/r-pkg-dev/documenting-functions.html


