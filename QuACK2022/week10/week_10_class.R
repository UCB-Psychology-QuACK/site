# Random sampling Part 2
# Elena & Willa
# 11/1/22

#### Load libraries  ####
library(tidyverse)

################### Warm up #########################

# 0) Load the baby data and remind Willa to start recording class!!!! 

baby <- read.csv("../data/brainwavebabydata.csv")

# 1) Randomly sample 20 babies from the baby brain wave data

sample <- baby %>% 
  slice_sample( n = 20)

# 2) Calculate the mean  of the r2 region for your sample and save it as a new variable.

mean_sample <- mean(sample$r2)


# 3) Repeat steps 1-2 10000 times, keeping all of the means that you calculate.


baby_means_r2 <- c()

for (i in 1:10000){
  
  sample_baby <- baby %>% 
    slice_sample(n = 20)
  
  # save mean
  baby_means_r2[i] <- mean(sample_baby$r2)
  
}

# 4) Use the function hist() to plot a histogram of the means.  What do you notice about the histogram?

hist(baby_means_r2)


# 5) Find the mean of the r2 region sample means. What is the
# mean telling you? (i.e., what does it represent?). And how does the mean
# compare to the population r2 mean?

mean(baby_means_r2)
abline(v = mean(baby_means_r2), col = "red")
abline(v = mean(baby$r2), col = "blue")

# 6) BONUS: Find the standard deviation of the r2 region means. What is the
# SD telling you? (i.e., what does it represent?)
sd(baby_means_r2)


###############################################################################X


######################## Picking up where we left off ########################

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

# This is what we are illustrating above. 

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


# Let's use resampling to estimate how much the mean body mass varies between samples

# Goal: Resample 1000 times *from our data* and take the mean every time.

# What do we need to do? (Pseudocode)
# 1) create a place to put our means in
# 2) sample with replacement and take the mean of that sample
# 3) repeat step 2 1000 times

# Code
# 1) create a place to put our means in
sample_means <- c()

for (i in 1:1000 ){
# sample penguins with replacement

p.sampled <- penguins %>% 
  slice_sample( n = nrow(penguins), replace = T)

# take mean
sample_means[i]<- mean(p.sampled$body_mass_g)

}

# Plot our means
hist(sample_means)

# What is the mean and sd of our means?

abline(v = mean(sample_means), col = "red")

sd(sample_means)

# What does the standard deviation tell you?


# This resampling technique is called "Bootstrapping"!!! Sampling with
# replacement from our collected data to find the amount of sampling error for
# some statistic of interest.



# Lets compare our SD to the traditional SEM 
#formula: se = sd / sqrt(n)

se_body_mass <- sd(penguins$body_mass_g)/sqrt(nrow(penguins))

# When we report any statistic, we need to always report error!
# For example, our mean body mass is  +/-  grams. 
# Or better yet, report the 95% confidence interval:
# Lower bound:

lb <- mean(penguins$body_mass_g) - 1.96 * sd(sample_means)

# Upper bound: 

up <- mean(penguins$body_mass_g) + 1.96 * sd(sample_means)

# Even better use your boostrapped standard deviation: 

lb <- mean(penguins$body_mass_g) - 1.96 * se_body_mass

# Upper bound: 

up <- mean(penguins$body_mass_g) + 1.96 * se_body_mass

print(paste("Based on our sample, we estimate that the mean body mass of the population of penguins is between", round(lb, 3), "and", round(up, 3), "grams."))

# 95% CI means that we estimate that 95% of random samples we draw from our
# population will have mean body masses between the lower bound and upper bound
# values.



############### Is the difference between two groups meaningful? ###############
# Use group_by() to find the body mass means for each sex

p.mean_body_mass <- penguins %>% 
  group_by(sex) %>% 
  summarize(mean_body_mass = mean(body_mass_g)) %>% 
  ungroup()


# Can you think of another way to get the mean values using base R? 
f.mean_body_mass <- mean(penguins$body_mass_g[penguins$sex == 'female'])
m.mean_body_mass <- mean(penguins$body_mass_g[penguins$sex == 'male'])

# plot the body mass as a violin plot with ggplot for each group to visualize this difference. 
# include the following layers to illustrate the difference in means. 
# stat_summary(fun = mean, geom = "point") 
# stat_summary(fun = mean, geom = "line", aes(group = 1))

ggplot(penguins, aes(x = sex, y = body_mass_g)) + 
  geom_violin() + 
  stat_summary(fun = mean, geom = "point") +
  stat_summary(fun = mean, geom = "line", aes(group = 1))

# Let's quantify this difference in mean body mass between the group

true_mean_dif <- f.mean_body_mass  - m.mean_body_mass
# We want to know: is this difference different than 0? In other words, is there
# really a group difference? Or is this difference that we found just due to
# chance?


# What are some ways that we could test whether this difference is reliable?
# 


# Here's another idea:
# We randomly shuffle the labels of sex and see if the two groups are different or not. If the label is MEANINGFUL then there will be a difference in the original data but there will not be a difference in the shuffled data!

# 1. Make a new copy of the dataset called p.shuffled 

p.shuffled <- penguins

# 2. Randomly shuffle the sex column without replacement.

p.shuffled$sex <- sample(penguins$sex)

# 3. Calculate the difference in means

f.mean_body_mass_shuffled <- mean(p.shuffled$body_mass_g[p.shuffled$sex == 'female'])
m.mean_body_mass_shuffled <- mean(p.shuffled$body_mass_g[p.shuffled$sex == 'male'])

shuffled_mean_dif <- f.mean_body_mass_shuffled - m.mean_body_mass_shuffled
# 4. Create the same plot as above but using shuffled data

ggplot(p.shuffled, aes(x = sex, y = body_mass_g)) + 
  geom_violin() + 
  stat_summary(fun = mean, geom = "point") +
  stat_summary(fun = mean, geom = "line", aes(group = 1))



# What do you notice? 



# Do this 1000 times and each time save the difference in means
# HINT: Write out your steps in pseduo code first!

#1. create and empty vector for means
saved_sampled_means <- c()

#2. have a for loop 

for (i in 1:1000){
  
  # create a shuffled dataframe
  p.shuffled <- penguins
  
  # Randomly shuffle the sex column without replacement.
  
  p.shuffled$sex <- sample(penguins$sex)
  
  
  # calculate the means for each sex
  
  f.mean_body_mass_shuffled <- mean(p.shuffled$body_mass_g[p.shuffled$sex == 'female'])
  m.mean_body_mass_shuffled <- mean(p.shuffled$body_mass_g[p.shuffled$sex == 'male'])
  # save the mean difference
  
  saved_sampled_means[i] <- f.mean_body_mass_shuffled - m.mean_body_mass_shuffled
  
}

# Plot all the differences in means

hist(saved_sampled_means, xlim = c(-800, 800))
# Add the mean of mean differences to the plot

abline(v = mean(saved_sampled_means), col = 'red')
abline(v = true_mean_dif, col = 'blue')

# Add the experimental mean difference from penguins to the plot 
# HINT (hist( X, xlim = c()) will change the axis)



# What do you notice? 


# What percent of our shuffled samples had differences in means more extreme than our experimental group difference?

sum(saved_sampled_means < true_mean_dif)/length(saved_sampled_means)

# This is called a permutation test!
# Shuffle our labels WITHOUT REPLACEMENT! Calculate our test statistic, and do
# it many times. Test whether the test statistic that we got is more extreme
# than the distribution of test statistics from data sets with randomly shuffled
# labels.


#### Practice ####

# Practice doing a permutation test with the happiness data.
happiness <- read.csv("../data/world-happiness_2020_clean.csv")

# The label we are interested in shuffling is ladder_score_cat. Pick one of the
# other variables to work with. We are interested in knowing whether being above
# or below average in your ladder score is meaningfully different for this other
# variable.



# First, just try it with plotting! Then after you get
# that code working, try it with calculating the difference in their means, like
# we did in the example above.


