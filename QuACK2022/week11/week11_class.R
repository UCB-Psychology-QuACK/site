# Week 10 - Functions
# Elena & Willa
# 11/8/22

#### Load libraries, set options, and load data ####
library(tidyverse)
options(stringsAsFactors = FALSE)
penguins <- read.csv("../data/penguins_clean.csv") # (Note: only 2008 sample)


#### Warm up ####

# 1. Are there any times that you have had to copy and paste code in this class?
# What are some possible issues you can think of with repeatedly copy and
# pasting?

# - always...
# - for 101 exam -> copying code from prior work or another script
# - a lot to type and don't want to type it again
# - trouble shooting an error, code from Google
# - copy for making similar graphs

# What can go wrong?
# - override existing variables
# - names might be inconsistent
# - forget to select a comma or a bracket, code doesn't work

# ^^ Easier to make mistakes when copying



# The next two questions are about the code you wrote last week:

## Let's use bootstrapping to estimate how much the mean body mass varies between
## samples of penguins (standard error of the mean - SEM)
## Sample our sample (101) 1000 times!

# Vector to keep track of the sample means
means <- c()
for(i in 1:1000) {
  # 1) Create a resampled data set, sample WITH REPLACEMENT
  p.resampled <- penguins %>%
    slice_sample(n = nrow(penguins), replace = TRUE)
    
  
  # 2) Calculate the mean of body mass and save it
  means[i] <- mean(p.resampled$body_mass_g)
  
}

# Plot our means
hist(means)
sd(means)

# 2. What are at least two things you could change about this code to make it
# more "flexible" (e.g., "less hard coded")? Make those changes to the code
# above. Is there anything else you could make more flexible?

n_samp <- 1000
samp_size <- nrow(penguins)

means <- c()
for(i in 1:n_samp) {
  # 1) Create a resampled data set, sample WITH REPLACEMENT
  p.resampled <- penguins %>%
    slice_sample(n = samp_size, replace = TRUE)
  
  
  # 2) Calculate the mean of body mass and save it
  means[i] <- mean(p.resampled$body_mass_g)
  
}

# 3. What are some things you might want to change to use this code with new data?

# Change the data frame
# Variable of interest



## End of warm up ##


#### Let's make some functions! ####

# Let's make our sample size and num_samples more flexible!






# Now, let's take this one step even further in making this flexible by making
# it into a function called bootstrap_bodyMass



bootstrap_bodyMass <- function(n_samp) {
  
  samp_size <- nrow(penguins)
  
  means <- c()
  for(i in 1:n_samp) {
    # 1) Create a resampled data set, sample WITH REPLACEMENT
    p.resampled <- penguins %>%
      slice_sample(n = samp_size, replace = TRUE)
    
    
    # 2) Calculate the mean of body mass and save it
    means[i] <- mean(p.resampled$body_mass_g)
    
  }
  
  hist(means)
  
  return(means)
}

mean_output <- bootstrap_bodyMass(1000)
hist(mean_output)


# Let's add some additional functionality to our function.
# Let's make it so we can set a seed that we want it to use so that we (and
# others) can replicate our results.

bootstrap_bodyMass <- function(n_samp, seed) {
  
  set.seed(seed)
  
  samp_size <- nrow(penguins)
  
  means <- c()
  for(i in 1:n_samp) {
    # 1) Create a resampled data set, sample WITH REPLACEMENT
    p.resampled <- penguins %>%
      slice_sample(n = samp_size, replace = TRUE)
    
    
    # 2) Calculate the mean of body mass and save it
    means[i] <- mean(p.resampled$body_mass_g)
    
  }
  
  # hist(means)
  
  return(means)
}

mean_output <- bootstrap_bodyMass(n_samp = 1000, seed = 1234)
hist(mean_output)



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



bootstrap_bodyMass <- function(n_samp, seed = NA) {
  
  
  if(!is.na(seed)) {
    set.seed(seed)
  }
  
  
  samp_size <- nrow(penguins)
  
  means <- c()
  for(i in 1:n_samp) {
    # 1) Create a resampled data set, sample WITH REPLACEMENT
    p.resampled <- penguins %>%
      slice_sample(n = samp_size, replace = TRUE)
    
    
    # 2) Calculate the mean of body mass and save it
    means[i] <- mean(p.resampled$body_mass_g)
    
  }
  
  hist(means)
  
  return(means)
}

mean_output <- bootstrap_bodyMass(n_samp = 1000)

mean_output <- bootstrap_bodyMass(n_samp = 1000, seed = 1234)

hist(mean_output)





# What other parts of this function would we want to make more flexible?










# Maybe I don't only want to find the bootstrapped error of body_mass_g. Perhaps
# I want the flexibility to find any of the variables I have!


bootstrap_bodyMass <- function(n_samp, var, seed = NA) {
  
  
  if(!is.na(seed)) {
    set.seed(seed)
  }
  
  
  samp_size <- nrow(penguins)
  
  means <- c()
  for(i in 1:n_samp) {
    # 1) Create a resampled data set, sample WITH REPLACEMENT
    p.resampled <- penguins %>%
      slice_sample(n = samp_size, replace = TRUE)
    
    
    # 2) Calculate the mean of our variable and save it
    means[i] <- mean(p.resampled[, var])
    
  }
  
  hist(means)
  
  return(means)
  
}

mean_output <- bootstrap_bodyMass(n_samp = 1000, var = "bill_depth_mm")

mean_output <- bootstrap_bodyMass(n_samp = 1000, var = "bill_depth_mm", seed = 1234)
mean_output <- bootstrap_bodyMass(n_samp = 1000, var = "body_mass_g", seed = 1234)


hist(mean_output)





# ^^ should give us the same as what we got before with the _bodyMass function!



# Let's try it with another variable, bill_length_mm





# What if we wanted to do it with a different data set?
# Load more data
baby <- read.csv("../data/brainwavebabydata.csv")
happiness <- read.csv("../data/world-happiness_2020.csv")



bootstrap_bodyMass <- function(n_samp, var, data, seed = NA) {
  # This function ....
  
  # Arguments:
  # n_samp - a number indicating the number of times to sample the data
  # var - a string with the name of the column 
  
  
  # Output:
  # vector of means... 
  
  if(!is.na(seed)) {
    set.seed(seed)
  }
  
  
  samp_size <- nrow(data)
  
  means <- c()
  for(i in 1:n_samp) {
    # 1) Create a resampled data set, sample WITH REPLACEMENT
    data.resampled <- data %>%
      slice_sample(n = samp_size, replace = TRUE)
    
    
    # 2) Calculate the mean of our variable and save it
    means[i] <- mean(data.resampled[, var])
    
  }
  
  hist(means)
  
  return(means)
  
}

mean_output <- bootstrap_bodyMass(n_samp = 1000, var = "bill_depth_mm")

mean_output <- bootstrap_bodyMass(n_samp = 1000, 
                                  var = "bill_depth_mm", 
                                  data = penguins, 
                                  seed = 1234)

mean_output <- bootstrap_bodyMass(n_samp = 1000, 
                                  var = "body_mass_g", 
                                  data = penguins, 
                                  seed = 1234)


mean_output <- bootstrap_bodyMass(n_samp = 1000, 
                                  var = "Ladder_score", 
                                  data = happiness, 
                                  seed = 1234)


hist(mean_output)






# ^^ should give us the same as what we got before with the _penguins function!


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


