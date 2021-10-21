# Random sampling
# Willa & Elena
# 10/19/21

################### Warm up #########################

# 1. Write a for loop that makes a string indicating the output file paths for
# each of the following participants and saves it them in a vector called filepaths:
subj <- c("subj01", "subj02", "subj03", "subj04", "subj05", "subj06", "subj07", "subj08")

# The file path for a participants should also include the condition that they were in:
cond1 <- c("subj01", "subj04", "subj07", "subj08")
cond2 <- c("subj02", "subj03", "subj05", "subj06")

# For example, the output for participant 1 would be: "../data/cond1/data_subj01"
# and for participant 2 it would be: "../data/cond2/data_subj02"



# 2. Look at the function rnorm() in the Help window (you can use ?rnorm()) or google it. What does rnorm do?




#####################################################

#### Load libraries and set options ####
library(tidyverse)
# options(stringsAsFactors = FALSE)



#### We can simulate the data collection process in R ####

# Define our random variable with a function



# Plot our observations


# The exact values change but the definition of heights is consistent. 

# In practice we don't want the values to change each time. To keep our results consistent, we want to simulate random data collection ONCE.

set.seed(342)


# This lets us reproduce the same sequence of random numbers every time we run the analysis. 
# Try changing the seed and see what happens.




#### Estimating means of a population ####

# Imagine that you live on a planet called Quackland and are baby researchers
# studying gyrification of different regions of the brain. We want to know the
# average gyrification of a certain region of interest (r1) in 1-year-old
# children.

# How would we go about estimating the average gyrification of r1 in
# 1-year-olds?








# Now imagine that Willa and Elena are magical wizards who happen to know the
# actual gyrification of r1 in all 40,000 1-year-olds who live on Quackland.
# Lucky for you, we posted it on OSF just for us to use in this class!

# Load in our #openscience data!
# We are interested in r1
# Data adapted by Elena from a CSV file used by Daniel Catterson in Psych 101
baby <- read.csv("../data/brainwavebabydata.csv")



# Let's randomly sample from our population (as we described above) and estimate
# our mean.




# What if we sample just 10 babies? Plot a histogram. What is the mean
# gyrification? The sd?



# As all knowing wizards, Elena and Willa have granted you the power to check
# the TRUE MEAN gyrification of the population. Check that value. How does it
# compare to the estimated mean from the 10-baby sample?



# Now, what if we took a bunch of samples (5) of 10 babies and took the mean of
# the means (e.g., 5 follow-up studies). How does this value compare to the TRUE
# population mean? Plot a histogram of the means. What is the mean gyrification
# of the means? The sd of the means?




# What if we could take 100 samples of 10 babies? How does this value compare to
# the TRUE population mean? Plot a histogram of the means. What is the mean
# gyrification of the means? The sd of the means?




## Practice: Now try this all again, but now drawing samples of 100 babies. ##

# Draw one sample of 100 babies. How does this compare to the mean r1 depth from the 1 sample of 10 babies? To the true population mean?


# Draw 100 babies 5 times and compare the means


# Draw 100 babies 100 times and compare the means




#### The Central Limit Theorem! ####



#### How reliable is our measure? ####

# More realistically, we can only collect one sample, or maybe up to a few.
# Take our penguins for example.
penguins <- read.csv("../data/penguins_clean.csv") # Only 2008 sample!


# Suppose we want to know how reliable is our measure of interest (e.g., mean
# body weight, relation between body weight and bill length, etc.). What is the range of values the mean can take on?

#     What is the *ideal* way to test this?


#     What is a possible work-around?









# We could take OUR SAMPLE and pretend it is the POPULATION and then sample *from
# it*!!!


# How reliable is the mean body mass?
mean(penguins$body_mass_g)
sd(penguins$body_mass_g)

# In other words, how much would it vary across samples?

# Ideally we would collect many many samples of penguins to do this. But... We can't. So the next best thing is to use our own data as if they were the whole population, and *sample from it*!!!

# Key here is: SAMPLE WITH REPLACEMENT!


# Let's sample 1000 times from our data and take the mean.




# Plot our means



# What is the mean and sd of our means?




# This is called "Bootstrapping"!!! Sampling with replacement + computing some
# metric of interest.


# Bootstrapping is most commonly used to estimate error of a model. But there
# are plenty of other uses for it!



#### Is the difference between two groups meaningful and reliable? ####

mean(penguins[penguins$sex == "female",]$body_mass_g)
mean(penguins[penguins$sex == "male",]$body_mass_g)


# What are some ways that we could test whether this difference is reliable?
