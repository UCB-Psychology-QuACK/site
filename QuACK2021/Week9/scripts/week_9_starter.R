# Random sampling Part 2
# Elena & Willa
# 10/26/21

#### Load libraries and set options ####
library(tidyverse)
# options(stringsAsFactors = FALSE)

################### Warm up #########################

# 0) Load the baby data
baby <- read.csv("../data/brainwavebabydata.csv")

# 1) Randomly sample 20 babies from the baby brain wave data



# 2) Calculate the mean gyrification of the r2 region for your sample and save it as a new variable.



# 3) Repeat steps 1-2 10000 times, keeping all of the means that you calculate.


# 4) Plot a histogram of the means. What do you notice about the histogram?



# 5) Find the mean of the r2 region means. What is the
# mean telling you? (i.e., what does it represent?). And how does the mean
# compare to the population r2 mean?



# 6) BONUS: Find the standard deviation of the r2 region means. What is the
# SD telling you? (i.e., what does it represent?)



###############################################################################X


######################## Where we left off last week... ########################

# One big goal of science is to learn something about the world around us, in
# our case, a population. But we can't measure everyone in a population! What
# can we do instead?

# Central tenet of science: Take random samples of a population and then use
# those samples to make inferences about the population as a whole!

# For example, we want to find the average height of people in the US

# If you randomly sample from your population enough times and take the mean
# height every time, then the distribution of your sample means will approach a
# normal distribution and the MEAN of your sample means will approach the true
# mean of the population! The bigger your sample (sample_size) and the more
# times you sample (num_samples) then the better your approximation is!

# ^^ This is the Central Limit Theorem!


# Bonus: What would the standard deviation of the sample means represent?


# Let's look at this for the baby brain data:
View(baby)

# Remember, we were pretending that the baby data magically included data for
# our entire population of babies!

# Set resampling parameters
sample_size <- 100
num_samples <- 10000

# For each sample:
means <- c()
for(sample in 1:num_samples) {
  #   Draw the sample
  baby_sample <- baby %>% 
    sample_n(sample_size)
  
  #   Take the mean of r1 and save it
  means[sample] <- mean(baby_sample$r2)
  
}


# Let's plot this
hist(means)

# Compare our estimated population mean to our true population mean
print(paste("Estimated population mean for r2:", round(mean(means), 4)))
print(paste("Our true population mean for r2:", round(mean(baby$r2), 4)))

abline(v = mean(means), col = "blue")
abline(v = mean(baby$r1), col = "red")


# If we were to do this again and draw samples of 100 10,000 times, then our
# estimate would be even closer!

###############################################################################X

######################### How accurate is our measure? #########################

# In the real world, we can't know the true population mean (or any statistic).
# We also can't draw an infinite number of samples from the population in order
# to estimate the population mean!

# The best we can do is take one sample, may a few.

# Take our penguins data for example. It was very costly to collect data on so
# many penguins!

# What is the mean body mass of all the penguins?
penguins <- read.csv("../data/penguins_clean.csv") # (Note: only 2008 sample)




# Suppose we want to know how accurate our measure of interest is (e.g., mean
# body weight, relation between body weight and bill length, etc.). What is the
# range of values the mean can take on?

# What is the *ideal* way to test this since we can't measure the whole
# population?
#     The ideal way to test this would be to draw many samples from the
#     population, get the mean body_mass, and estimate the population mean from
#     the mean of the sample means!


# What is a possible work-around?
#     Since it is not realistic to draw so many real samples from the
#     population, we can use our current sample, pretend that it is the
#     population, and sample from it! The key here is that we resample from our
#     sample WITH REPLACEMENT! We assume that if we sampled radomly from the
#     population then our sample is representative of the population! Including
#     the frequencies with which different values of body mass come up. This
#     allows us to let our sample act as an approximation of our population in
#     order to estimate how much variation there is in our measure of interest
#     from sample to sample.



# Key insight: We can take OUR SAMPLE and pretend it is the POPULATION and then
# sample *from it*!!!


# How accurate is the mean body mass? In other words, how much would it vary across samples?
mean(penguins$body_mass_g)
sd(penguins$body_mass_g)

# Let's use resampling to estimate how much the mean body mass varies between samples

# Goal: Resample 1000 times *from our data* and take the mean every time.

# What do we need to do? (Pseudocode)
# 1) 
# 2) 
# 3)

# Code




# Plot our means


# What is the mean and sd of our means?




# What does the standard deviation tell you?




# When we report any statistic, we need to always report error!
# For example, our mean body mass is  +/-  grams. 
# Or better yet, report the 95% confidence interval:
# Lower bound:


# Upper bound: 


print(paste("Based on our sample, we estimate that the mean body mass of the population of penguins is between", round(lb, 3), "and", round(ub, 3), "grams."))

# OR
print(paste0("We found that penguin body mass is ", round(mean(penguins$body_mass_g), 4), " grams (95% CI: [", round(lb, 3), ", ", round(ub, 3), "])."))

# 95% CI means that we estimate that 95% of random samples we draw from our
# population will have mean body masses between the lower bound and upper bound
# values.



# This resampling technique is called "Bootstrapping"!!! Sampling with
# replacement from our collected data to find the amount of sampling error for
# some statistic of interest.



############### Is the difference between two groups meaningful? ###############
# Find the body mass means for each group
(f.mean <- with(penguins, mean(penguins[sex == "female",]$body_mass_g)))
(m.mean <- with(penguins, mean(penguins[sex == "male",]$body_mass_g)))

# Do it with tidyverse, too!



# Plot the body mass for each group to visualize this difference



# Let's quantify this difference in mean body mass between the group

# We want to know: is this difference different than 0? In other words, is there
# really a group difference? Or is this difference that we found just due to
# chance?


# What are some ways that we could test whether this difference is reliable?
# 






# Here's another idea:
# We randomly shuffle the labels of sex and see if the two groups are different or not. If the label is MEANINGFUL then there will be a difference in the original data but there will not be a difference in the shuffled data!





# Do this many times and see what happens!




# Plot all the differences in means



# What percent of our shuffled samples had differences in means more extreme than our difference in means?





# This is called a permutation test!
# Shuffle our labels WITHOUT REPLACEMENT! Calculate our test statistic, and do
# it many times. Test whether the test statistic that we got is more extreme
# than the distribution of test statistics from data sets with randomly shuffled
# labels.


#### Practice ####

# Practice doing a permutation test with the happiness data.
happiness <- read.csv("../data/world-happiness_2020.csv")

# The label we are interested in shuffling is ladder_score_cat. Pick one of the
# other variables to work with. We are interested in knowing whether being above
# or below average in your ladder score is meaningfully different for this other
# variable.

# First, just try it with plotting (and with ~15 samples)! Then after you get
# that code working, try it with calculating the difference in their means, like
# we did in the example above.
