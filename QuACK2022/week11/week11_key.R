# Week 10 - Functions
# Elena & Willa
# 11/8/22

#### Load libraries and set options ####
library(tidyverse)
options(stringsAsFactors = FALSE)
penguins <- read.csv("../data/penguins_clean.csv") # (Note: only 2008 sample)

#### Warm up ####

# 1. Are there any times that you have had to copy and paste code in this class?
# What are some possible issues you can think of with repeatedly copy and
# pasting?

# The next two questions are about the code you wrote last week:

## Let's use bootstrapping to estimate how much the mean body mass varies between
## samples of penguins (standard error of the mean - SEM)
## Sample our sample (101) 1000 times!

# Vector to keep track of the sample means
means <- c()
set.seed(1234)
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
# more "flexible" (e.g., less hard coded")? Make those changes to the code
# above. Is there anything else you could make more flexible?

# Some examples
# - Set parameters for sample size and for # of samples
# - Set if we want to sample with replacement or not!

# Let's make our sample size and num_samples more flexible!
sample_size <- nrow(penguins)
num_samples <- 1000

# Vector to keep track of the sample means
means <- c()
for(i in 1:num_samples) {
  # 1) Take a sample WITH REPLACEMENT nrows(penguin) times
  p.resampled <- penguins %>%
    slice_sample(n = sample_size, replace = TRUE)
  
  # 2) Calculate the mean body_weight_g of the sample (and save it!)
  means[i] <- mean(p.resampled$body_mass_g)
}



# 3. What are some things you might want to change to use this code with new data?


## Change the data frame
## Variable of interest


## End of warm up ##


#### Let's make some functions! ####


# Let's make our sample size and num_samples more flexible!
sample_size <- nrow(penguins)
num_samples <- 1000

# Vector to keep track of the sample means
means <- c()
for(i in 1:num_samples) {
  # 1) Take a sample WITH REPLACEMENT nrows(penguin) times
  p.resampled <- penguins %>%
    slice_sample(n = sample_size, replace = TRUE)

  # 2) Calculate the mean body_weight_g of the sample (and save it!)
  means[i] <- mean(p.resampled$body_mass_g)
}



# Now, let's take this one step even further in making this flexible by making
# it into a function!

bootstrap_bodyMass <- function(num_samples) {
  
  sample_size = nrow(penguins)
  
  # Vector to keep track of the sample means
  means <- c()
  for(i in 1:num_samples) {
    # 1) Take a sample WITH REPLACEMENT nrows(penguin) times
    p.resampled <- penguins %>%
      slice_sample(n = sample_size, replace = TRUE)
    
    # 2) Calculate the mean body_weight_g of the sample (and save it!)
    means[i] <- mean(p.resampled$body_mass_g)
  }
  
  return(means)
}

means_bodyMass <- bootstrap_bodyMass(num_samples = 1000)
hist(means_bodyMass)



# Let's add some additional functionality to our function.
# Let's make it so we can set a seed that we want it to use so that we (and
# others) can replicate our results.
bootstrap_bodyMass <- function(num_samples, seed) {
  
  sample_size = nrow(penguins)
  
  set.seed(seed)
  # Vector to keep track of the sample means
  means <- c()
  for(i in 1:num_samples) {
    # 1) Take a sample WITH REPLACEMENT nrows(penguin) times
    p.resampled <- penguins %>%
      slice_sample(n = sample_size, replace = TRUE)
    
    # 2) Calculate the mean body_weight_g of the sample (and save it!)
    means[i] <- mean(p.resampled$body_mass_g)
  }
  
  return(means)
}

means_bodyMass <- bootstrap_bodyMass(num_samples = 1000,
                                     seed = 1234)
hist(means_bodyMass)

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

bootstrap_bodyMass <- function(num_samples, seed = NA) {
  
  sample_size = nrow(penguins)
  
  # If a value is given for seed, set a seed
  # Otherwise, don't set a seed
  if(!is.na(seed)) {
    set.seed(seed)
  }
  
  # Vector to keep track of the sample means
  means <- c()
  for(i in 1:num_samples) {
    # 1) Take a sample WITH REPLACEMENT nrows(penguin) times
    p.resampled <- penguins %>%
      slice_sample(n = sample_size, replace = TRUE)
    
    # 2) Calculate the mean body_weight_g of the sample (and save it!)
    means[i] <- mean(p.resampled$body_mass_g)
  }
  
  return(means)
}

# Check that it still works when I pass it a seed
means_bodyMass <- bootstrap_bodyMass(num_samples = 1000,
                                     seed = 1234)
hist(means_bodyMass)


# Now check that it works when I don't pass a seed
means_bodyMass2 <- bootstrap_bodyMass(num_samples = 1000)
hist(means_bodyMass2)




# What other parts of this function would we want to make more flexible?

# Some answers from class:
# - Change what function it is calculating --> Not mean anymore!
# - Calculate SEM for a different variable
# - Use on a different data set, too!

# We will do the second and third idea!


# Maybe I don't only want to find the bootstrapped error of body_mass_g. Perhaps
# I want the flexibility to find the bootstrapped SEM for any of the variables I
# have!

bootstrap_penguins <- function(variable, num_samples, seed = NA) {
  
  sample_size = nrow(penguins)
  
  # If a value is given for seed, set a seed
  # Otherwise, don't set a seed
  if(!is.na(seed)) {
    set.seed(seed)
  }
  
  # Vector to keep track of the sample means
  means <- c()
  for(i in 1:num_samples) {
    # 1) Take a sample WITH REPLACEMENT nrows(penguin) times
    p.resampled <- penguins %>%
      slice_sample(n = sample_size, replace = TRUE)
    
    # 2) Calculate the mean body_weight_g of the sample (and save it!)
    means[i] <- mean(p.resampled[, variable])
  }
  
  return(means)
}

means_bodyMass <- bootstrap_penguins(variable = "body_mass_g",
                                     num_samples = 1000,
                                     seed = 1234)

# ^^ should give us the same as what we got before with the _bodyMass function!

means_bodyMass_old <- bootstrap_bodyMass(num_samples = 1000,
                                         seed = 1234)

hist(means_bodyMass)
hist(means_bodyMass_old)

# It does!


# Let's try it with another variable
means <- bootstrap_penguins("bill_length_mm", 100, 1000, 1234)
hist(means, main = "bill_length_mm")

# Does this make sense? Let's check the original data:
mean(penguins$bill_length_mm)
mean(means)

sd(penguins$bill_length_mm) / sqrt(nrow(penguins)) # (formula for SEM)
sd(means)
# ^^ Looks good!



# What if we wanted to calculate SEM with a different data set?
# Load more data
baby <- read.csv("../data/brainwavebabydata.csv")
happiness <- read.csv("../data/world-happiness_2020.csv")



bootstrap_SEM <- function(data, variable, num_samples, seed = NA) {
  
  sample_size = nrow(data)
  
  # If a value is given for seed, set a seed
  # Otherwise, don't set a seed
  if(!is.na(seed)) {
    set.seed(seed)
  }
  
  # Vector to keep track of the sample means
  means <- c()
  for(i in 1:num_samples) {
    # 1) Take a sample WITH REPLACEMENT nrows(penguin) times
    df.resampled <- data %>%
      slice_sample(n = sample_size, replace = TRUE)
    
    # 2) Calculate the mean body_weight_g of the sample (and save it!)
    means[i] <- mean(df.resampled[, variable])
  }
  
  return(means)
}

means_bodyMass <- bootstrap_SEM(penguins, variable = "body_mass_g",
                                num_samples = 1000,
                                seed = 1234)

# ^^ should give us the same as what we got before with the _penguins function!

means_bodyMass_old <- bootstrap_penguins(variable = "body_mass_g",
                                         num_samples = 1000,
                                         seed = 1234)

hist(means_bodyMass)
hist(means_bodyMass_old)
# It does!


# Now, try it with another data set and variable. Then we will do some together.



# Examples of what someone could have done:

means_r2 <- bootstrap_SEM(baby, "r2", 20, 1000, 456)
hist(means_r2)

means_ladder <- bootstrap_SEM(happiness, "Ladder_score", nrow(happiness), 10000, 1234)
hist(means_ladder)

# If I were writing this function for my work, I would TEST TEST TEST! We would
# need to make sure that everything is working properly!


# Now that we have a working function, next thing is to DOCUMENT it so that we can easily share it with others!
# The most important things to document about a function are 3-fold:
# 1) What it does
# 2) What its arguments are (both the type and what it is/what purpose it serves)
# 3) What it returns

# Let's do this documentation for our bootstrap_SEM function


bootstrap_SEM <- function(data, variable, sample_size, num_samples, seed = NA) {
  # Estimates the standard error of the mean of a variable through bootstrapping
  # by iteratively sampling the given data frame with replacement.
  
  # Arguments:
  # data - a data frame that will be resampled
  
  # variable - a string with the name of the variable (i.e., column) for which
  # we want to estimate the standard error of the mean
  
  # sample_size - a number indicating the number of rows we want to resample
  # from our original data in each iteration. For bootstrapping, this number is
  # usually the number of rows in the original data (i.e., nrow(data))
  
  # num_samples - a number indicating the number of times that the original data
  # will be resampled (i.e., the number of iterations of the for loop)
  
  # seed - an optional argument indicating the number to be used as the seed for
  # resampling. If not specified, defaults to NA and R will set a seed according
  # to its default procedure
  
  # Returns a vector of the sample means
  
  
  # If a value is given for seed, set a seed
  # Otherwise, don't set a seed
  if(!is.na(seed)) {
    set.seed(seed)
  }
  
  # Vector to keep track of the sample means
  means <- c()
  for(i in 1:num_samples) {
    # 1) Take a sample WITH REPLACEMENT nrows(penguin) times
    df.resampled <- data %>%
      slice_sample(n = sample_size, replace = TRUE)
    
    # 2) Calculate the mean body_weight_g of the sample (and save it!)
    means[i] <- mean(df.resampled[, variable])
  }
  
  return(means)
}


#### Good resources about functions ####
# Basic intro to functions:
# https://swcarpentry.github.io/r-novice-inflammation/02-func-R/

# Intro to roxygen2 for more formally documenting functions that you make:
# https://combine-australia.github.io/r-pkg-dev/documenting-functions.html


#### Functions: Practice questions - Key ####

## load data we will need
happiness <- read.csv('../data/world-happiness_2020_clean.csv')

## 1. Write your own sum function

calc_sum <- function(list){
  # Calculates the sum of a sequence of numbers
  # ARGUMENTS: 
  # list = a vector of type "num" to sum. 
  # RETURNS: 
  # the sum of the list
  sum <- 0 
  for (num in 1:length(list)){
    sum = sum + list[num]
  }
  return(sum)
}

# test our function 
# simple integers
list1 <- c(1, 4, 5) 
test_1 <- calc_sum(list1)

# negative integers
list2 <- c(-1, -4, 0)
test_2 <- calc_sum(list2)

# List of different link and decimals
list3 <- c(1.5, 2.8, 3, 4.77, 5.66)
test_3 <- calc_sum(list3)


## 2&3. Make the following violin plot from the happiness data and again with
## other y variables

plot_data <- function(happiness_metric) {
  # A function to generate a violin plot showing the relationship between ladder_score_cat and continuous happiness measures. 
  # ARUGMENTS: 
  # happiness metric: The name of a variable for the y-axis of type STRING. 
  # RETURNS:
  # plot showing the relationship between ladder score and measure of interest. 
  p <- ggplot(happiness, aes(x = ladder_score_cat, y = get(happiness_metric), 
                             fill = ladder_score_cat )) + 
    geom_violin() + 
    geom_boxplot(width = 0.1) + 
    theme_classic()
  
  return(p)
} 

# Generate plots
# Q2
plot_data("Social_support")

# Q3
plot_data("Healthy_life_expectancy")
plot_data("Logged_GDP_per_capita")
plot_data("Freedom_to_make_life_choices")
plot_data("Generosity")

## 4. Plot continuous data (including additional customizations from Q5)
plot_data_cont <- function(data, x_axis, y_axis,
                           set_xlab = x_axis,
                           set_ylab = y_axis,
                           set_se = TRUE, 
                           set_color = "dark red") {
  # Plot two continuous variables from a dataframe.
  # ARGUMENTS: 
  # data: Name of dataframe as a STRING
  # x_axis: data to map to x_axis as a string
  # y_axis: data to map to y_axis as a string
  # OPTIONS:
  # set x/ylab: Allows the user to set the x and y axis labels. default is column name. 
  # set_se: Allows user to set standard error around regression line. Default is TRUE. 
  # set_color: Allow user to specify color of scatter plot points as a string. Default is red.
  # RETURNS: 
  # Scatter plot of data with a regression line. 
  
  p <- ggplot(get(data), aes(x = get(x_axis), y = get(y_axis))) + 
    # create a scatter plot
    geom_point(color = set_color) + 
    geom_smooth(method = 'lm', se = set_se) + 
    
    # set axis labels
    xlab(set_xlab) + 
    ylab(set_ylab) + 
    
    # set theme
    theme_classic()
  
  return(p)
} 

# test using defaults
plot_data_cont("happiness", "Perceptions_of_corruption", "Generosity")

# test using my own customizations
plot_data_cont("happiness", "Perceptions_of_corruption", "Generosity", 
               set_se=FALSE, 
               set_color = "dark gray")

