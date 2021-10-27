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

baby_sample <- baby %>% 
  sample_n(20)

baby_sample <- baby[sample(x = 1:nrow(baby), size = 20),]
penguin_sample <- penguin[sample(x = 1:nrow(penguins), size = nrow(penguins), replace = TRUE),]
# df[rows,cols]

# 2) Calculate the mean gyrification of the r2 region for your sample and save it as a new variable.

mean_samp <- mean(baby_sample$r2)

# 3) Repeat steps 1-2 10000 times, keeping all of the means that you calculate.
means <- c()
for(sample in 1:num_samples) {
  #   Draw the sample
  baby_sample <- baby %>% 
    sample_n(sample_size)
  
  #   Take the mean of r1 and save it
  means[sample] <- mean(baby_sample$r2)
  
}

# 4) Plot a histogram of the means. What do you notice about the histogram?
hist(means)

# 5) Find the mean of the r2 region means. What is the
# mean telling you? (i.e., what does it represent?). And how does the mean
# compare to the population r2 mean?
mean(means)

# The mean of the sample means is close to the population mean!


# 6) BONUS: Find the standard deviation of the r2 region means. What is the
# SD telling you? (i.e., what does it represent?)
sd(means)

# The standard deviation of the sample means is telling you the variation in the
# sample means. In other words, it is approximating the *sampling error* (how
# much variation there is in your statistic due to random chance). This value is
# the **standard error**!



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



# Let's look at this for the baby brain data:
View(baby)

# Remember, we were pretending that the baby data magically included data for
# our entire population of babies!

# Set resampling parameters
sample_size <- 20
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
abline(v = mean(baby$r2), col = "red")


# If we were to do this again and draw samples of 100 10,000 times, then our
# estimate would be even closer!

# You can try that out by changing sample_size to 100 and running the code again.

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

mean_body_mass <- mean(penguins$body_mass_g)


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
# 1) Create a resampled data set, sampling WITH REPLACEMENT, sample size = nrow(penguins)
# 2) Calculate the mean of body_weight_g and save it
# 3) Repeat 1000 times


# Code
body_mass_means <- c()
for(i in 1:1000) {
  # 1) Create a resampled data set, sample WITH REPLACEMENT
  p.resampled <- penguins %>%
    sample_n(nrow(penguins), replace = T)
  
  # 2) Calculate the mean of body mass and save it
  body_mass_means[i] <- mean(p.resampled$body_mass_g)
  
}

# Could also do it this way to make our sample size and num_samples more flexible!
# sample_size <- nrow(penguins)
# num_samples <- 1000
# 
# means <- c()
# for(i in 1:num_samples) {
#   # 1) Take a sample WITH REPLACEMENT nrows(penguin) times
#   p.resampled <- penguins %>%
#     sample_n(sample_size, replace = TRUE)
#   
#   # 2) Calculate the mean body_weight_g of the sample (and save it!)
#   means[i] <- mean(p.resampled$body_mass_g)
# }


# Plot our means
hist(body_mass_means)

# What is the mean and sd of our means?
mean(body_mass_means)
mean(penguins$body_mass_g)

sd(body_mass_means)

# What does the standard deviation tell you?
# It tells you the expected variation in the mean due to sampling error! In
# other words, it tells you the variability in our means that is due to chance.
# standard deviation of our sample means = standard error of our sampled mean

# standard error is traditionally calculated from our own sample with this
# formula: se = sd / sqrt(n)

# Let's compare the standard error calculated this way with our bootstrapped
# standard error:
(se_formula <- sd(penguins$body_mass_g) / sqrt(nrow(penguins)))
(se_bootstrapped <- sd(means))
# The bootstrapped se is a more robust and rigorous statistic.


# When we report any statistic, we need to always report error!
# For example, our mean body mass is 4192.453 +/- 77.18 grams. 
# Or better yet, report the 95% confidence interval: 4192.453 +/- 1.96 * 77.18
# Lower bound:
(lb <- mean(penguins$body_mass_g) - 1.96 * sd(body_mass_means))
# Upper bound: 
(ub <- mean(penguins$body_mass_g) + 1.96 * sd(body_mass_means))
print(paste("Based on our sample, we estimate that the mean body mass of the population of penguins is between", round(lb, 3), "and", round(ub, 3), "grams."))

# OR we could say:
print(paste0("We found that penguin body mass is ", 
             round(mean(penguins$body_mass_g), 4), 
             " grams (95% CI: [", 
             round(lb, 3), ", ", round(ub, 3), "])."))

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

# You can do this with tidyverse, too!
penguins %>%
  group_by(sex) %>%
  summarise(mean_body_mass = mean(body_mass_g))

# Plot the body mass for each group to visualize this difference
ggplot(penguins, aes(x = sex, y = body_mass_g)) +
  geom_violin(trim = FALSE) +
  stat_summary(fun = mean, geom = "point", size = 4) +
  stat_summary(fun = mean, geom = "line", aes(group = 1))

# Let's quantify this difference in mean body mass between the group
(mass.diff_samp <- f.mean - m.mean)

# We want to know: is this difference different than 0? In other words, is there
# really a group difference? Or is this difference that we found just due to
# chance?


# What are some ways that we could test whether this difference is reliable?
#     - Sample from the population many times and test! <-- But that is not
#     realistic

# Other ways:
#   - Could compare the error bars on the two categories? People definitely do
#   that!


# Here's another idea:
# What if we randomly shuffle the labels of sex and check the difference between
# the means of two groups over and over again?

# If the label is MEANINGFUL, then there will be a difference in the means in
# the original data but there will NOT be a difference in the shuffled data! In
# other words, if the label is MEANINGFUL, then the difference in body mass
# between the two groups in our original data should be really different
# than(i.e., far away from) the distribution of differences that we get from
# data sets with the sex labels shuffled.


# Make a new data set called p.shuffled (for penguins.shuffled)
p.shuffled <- penguins

# Randomly shuffle the sex column WITHOUT REPLACEMENT!
p.shuffled$sex <- sample(penguins$sex)
# (Don't want replacement because we want the same number of male and female
# labels as in our original data set.)

# Plot the difference
ggplot(p.shuffled, aes(x = sex, y = body_mass_g)) +
  geom_violin(trim = FALSE) +
  stat_summary(fun = mean, geom = "point", size = 4) +
  stat_summary(fun = mean, geom = "line", aes(group = 1))

# Calculate the means for each group
f.mean_shuffled <- with(p.shuffled, mean(p.shuffled[sex == "female",]$body_mass_g))
m.mean_shuffled <- with(p.shuffled, mean(p.shuffled[sex == "male",]$body_mass_g))

# Calcualte the difference in the means and save it
(mass.diff_shuffled <- (f.mean_shuffled - m.mean_shuffled)) 

# Do this many times and see what happens! (Highlight the code and run it a
# handful of times.)


# Now let's make a for loop to do this more formally and to be able to plot a
# distribution of the differences in the means.
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
hist(mass.diffs)

# Add our sample mean to the plot
abline(v = mass.diff_samp, col = "red", lwd = 3)

# Notice that we get a distribution centered around 0 and that there is *error*
# (i.e., sampling error) around 0!

# What percent of our shuffled samples had differences in means more extreme
# than our difference in means?
sum(mass.diffs < mass.diff_samp) / length(mass.diffs) * 100
# This is our "p-value": the probability of getting a value at least as extreme
# as the one we got in our data. But unlike p-values that we often see, we got
# this one using a distribution that we generated from our own data! COOL!


# This process is called a permutation test! It is used to test whether groups
# are reliably different by generating a null distribution from our own data!
# Review of this process:
# 1) Shuffle our labels WITHOUT REPLACEMENT! (This is the "null hypothesis",
# that the labels don't matter/don't have an effect on our outcome measure!)
# 2) Calculate some test statistic based on this shuffled data
# 3) Do this many times to generate many test statistics
# 4) Plot the distribution of these test statistics and see where the test
# statistic from our sample falls compared with this "null distribution".
# Specifically, we want to find the probability in this generated null
# distribution of getting a test statistic at least as extreme as the one we
# found in our sample

#### Thought experiment: Control and treatment  ####
# Here is a more psychology-ey example:
# Does our treatment condition help people be less depressed than our control
# condition?

# DV: reported depression
# IV: condition (control or treatment)

# What would our process be?
# 1) Randomly shuffle the condition labels for your sample
# 2) Do that 10,000 times to get a distribution of differences between the groups
# 3) Compare the difference between the two groups that we found in our
# experiment with the distribution of differences that we found from randomly
# shuffling the labels.
# 4) If what we found in our sample is sufficiently far away from our generated
# distribution (i.e., there are very few of our randomly shuffled samples that
# generated differences at least as extreme as the one that we found), then we
# can conclude that the treatment had an effect on depression levels!



#### Extra practice ####

# Practice doing a permutation test with the happiness data.
happiness <- read.csv("../data/world-happiness_2020.csv")

# The label we are interested in shuffling is ladder_score_cat. Pick one of the
# other variables to work with. We are interested in knowing whether being above
# or below average in your ladder score is meaningfully different for this other
# variable.

# First, just try it with plotting (and with ~15 samples)! Then after you get
# that code working, try it with calculating the difference in their means, like
# we did in the example above.
