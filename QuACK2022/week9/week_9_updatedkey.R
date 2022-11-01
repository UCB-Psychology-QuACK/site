# Random sampling Part 2
# Elena & Willa
# 11/1/22

#### Load libraries  ####
library(tidyverse)

################### Warm up #########################

# 0) Load the baby data
baby <- read.csv("../data/brainwavebabydata.csv")

# 1) Randomly sample 20 babies from the baby brain wave data
n_sample = 20

baby_sample <- baby %>% 
  slice_sample(n = n_sample)


# 2) Calculate the mean gyrification of the r2 region for your sample and save it as a new variable.

mean(baby_sample$r2)


# 3) Repeat steps 1-2 10000 times, keeping all of the means that you calculate.
means_r2 <- c()

for (i in 1:10000){
  baby_sample <- baby %>% 
    slice_sample(n = n_sample)
  
  means_r2[i] <- mean(baby_sample$r2)
}



# 4) Use the function hist() to plot a histogram of the means.  What do you notice about the histogram?

hist(means_r2)


# 5) Find the mean of the r2 region sample means. What is the
# mean telling you? (i.e., what does it represent?). And how does the mean
# compare to the population r2 mean?

mean(means_r2)

# 6) BONUS: Find the standard deviation of the r2 region means. What is the
# SD telling you? (i.e., what does it represent?)

sd(means_r2)

# Its the sum of each measurements distance from the mean. Divided by the number of measurements. Square rooted to see one side. 

# In this case it tells us how much variation we see in sample means. 
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
for (sample in 1:num_samples){
  
  #   Draw the sample
  baby_sample <- baby %>% 
    slice_sample(n = sample_size)
  
  #   Take the mean of r1 and save it
  
  means[sample] <- mean(baby_sample$r1)

}

# Let's plot this

hist(means)

# Compare our estimated population mean to our true population mean with an abline

# print each mean
paste("our estimated population mean is", round(mean(means),4))
paste("our true population mean is", round(mean(baby$r1),4))

# add a line to the histogram
abline(v = mean(means), col = "red")
abline(v = mean(baby$r1), col = "blue")

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
# 1) create a resampled data set
# 2) calculate the mean and sd and save it
# 3) repeat 1000 times. 

# Code
means_resampled <- c()
for (i in 1:1000){
  
  resample <- penguins %>% 
    slice_sample(n = nrow(penguins), replace = T ) 
    
    # calculate our mean
    means_resampled[i] <-  mean(resample$body_mass_g)
}

# Plot our means
hist(means_resampled)

# What is the mean and sd of our means?
mean(means_resampled)

sd(means_resampled)



# What does the standard deviation tell you?



# Lets compare our SD to the traditional SEM 
#formula: se = sd / sqrt(n)

se_bodyMass = sd(penguins$body_mass_g)/sqrt(nrow(penguins))
sd((means_resampled))

# When we report any statistic, we need to always report error!
# For example, our mean body mass is  +/-  grams. 
# Or better yet, report the 95% confidence interval:
# Lower bound:

lb <- 

# Upper bound: 

up <- 

print(paste("Based on our sample, we estimate that the mean body mass of the population of penguins is between", round(lb, 3), "and", round(ub, 3), "grams."))



# 95% CI means that we estimate that 95% of random samples we draw from our
# population will have mean body masses between the lower bound and upper bound
# values.


# This resampling technique is called "Bootstrapping"!!! Sampling with
# replacement from our collected data to find the amount of sampling error for
# some statistic of interest.


############### Is the difference between two groups meaningful? ###############
# Use group_by() to find the body mass means for each sex

means_sex <- penguins %>% 
  group_by(sex) %>% 
  summarize(mean_body_mass =  mean(body_mass_g))

# Can you think of another way to get the mean values using base R? 

female <- mean(penguins$body_mass_g[penguins$sex=='female'])
male <- mean(penguins$body_mass_g[penguins$sex=='male'])
# plot the body mass as a violin plot with ggplot for each group to visualize this difference. 
# include the following layers to illustrate the difference in means. 
# stat_summary(fun = mean, geom = "point") 
# stat_summary(fun = mean, geom = "line", aes(group = 1))

ggplot(penguins, aes(x = sex, y = body_mass_g)) + 
  geom_violin() + 
  stat_summary(fun = mean, geom = "point", size = 4) +
  stat_summary(fun = mean, geom = "line", aes(group = 1))


# Let's quantify this difference in mean body mass between the group
sex_dif <- female - male



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

# 4. Create the same plot as above but using shuffled data


ggplot(p.shuffled, aes(x = sex, y = body_mass_g)) + 
  geom_violin() + 
  stat_summary(fun = mean, geom = "point", size = 4) +
  stat_summary(fun = mean, geom = "line", aes(group = 1))

# What do you notice? 



# Do this 1000 times and each time save the difference in means
# HINT: Write out your steps in pseduo code first!
mean_dif <- c()

for (i in 1:1000){
  
  # Make a new data set called p.shuffled (for penguins.shuffled)
  p.shuffled <- penguins
  
  # Randomly shuffle the sex column WITHOUT REPLACEMENT!
  p.shuffled$sex <- sample(penguins$sex)
  
  f.mean_shuffled <-  mean(p.shuffled$body_mass_g[p.shuffled$sex=='female'])
  m.mean_shuffled <-mean(p.shuffled$body_mass_g[p.shuffled$sex=='male'])
  dif <- f.mean_shuffled - m.mean_shuffled
  mean_dif[i] <- dif
}

mass.diffs <- c()
for(i in 1:1000) {
  # Make a new data set called p.shuffled (for penguins.shuffled)
  p.shuffled <- penguins
  
  # Randomly shuffle the sex column WITHOUT REPLACEMENT!
  p.shuffled$sex <- sample(penguins$sex)
  
  # Calculate the means for each group
  f.mean_shuffled <- with(p.shuffled, mean(p.shuffled[sex == "female",]$body_mass_g))
  m.mean_shuffled <- with(p.shuffled, mean(p.shuffled[sex == "male",]$body_mass_g))
  
  # Calcualte the difference in the means and save it
  mass.diffs[i] <- (f.mean_shuffled - m.mean_shuffled)
}

# Plot all the differences in means

hist(mean_dif)


# Add our sample mean to the plot
mean <- mean(mean_dif)
abline(v = mean(mean_dif), col = 'red')
abline(v = mean(sex_dif), col = 'blue')
# What do you notice? 


# What percent of our shuffled samples had differences in means more extreme than our experimental group difference?

sum(mean_dif < sex_dif) /length(mean_dif) * 100

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
