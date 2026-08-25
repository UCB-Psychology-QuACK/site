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

# Option that needs tidyverse!! case_when is in tidyverse!
filepaths <- c()
for(i in 1:length(subj)) {
  
  cond <- case_when(subj[i] %in% cond1 ~ "cond1",
                    subj[i] %in% cond2 ~ "cond2")
  
  filepaths[i] <- paste0("../data/", cond, "/data_", subj[i])
  
  
}

# Case when condition is true then do y
#       a == b do c,
# ....
#   TRUE ~ z

# If condition is true then do y
# Ifelse
# else (so in all other conditions), do z

# Option 2: General, foundational programming
for(i in 1:length(subj)) {
  
  if(subj[i] %in% cond1) {
    filepaths[i] <- paste0("../data/cond1/data_", subj[i])
  } else {
    filepaths[i] <- paste0("../data/cond2/data_", subj[i]) 
  } 

}


# 2. Look at the function rnorm() in the Help window (you can use ?rnorm()) or google it. What does rnorm do?
?rnorm



#####################################################

#### Load libraries and set options ####
# options(stringsAsFactors = FALSE)
library(tidyverse)




#### We can simulate the data collection process in R ####

# Define our random variable with a function

height <- rnorm(100, mean = 5.5, sd = 0.75)

# Plot our observations
hist(height)

# The exact values change but the definition of heights is consistent. 

# In practice we don't want the values to change each time. To keep our results consistent, we want to simulate random data collection ONCE.

set.seed(342)


# This lets us reproduce the same sequence of random numbers every time we run the analysis. 
# Try changing the seed and see what happens.

height <- rnorm(100, mean = 5.5, sd = 0.75)

# Plot our observations
hist(height)


#### Estimating means of a population ####

# Imagine that you live on a planet called Quackland and are baby researchers
# studying gyrification of different regions of the brain. We want to know the
# average gyrification of a certain region of interest (r1) in 1-year-old
# children.

# How would we go about estimating the average gyrification of r1 in
# 1-year-olds?

# Sample a bunch of babies and measure their r1 gyrification

# 1) How many in each sample? 
# 2) How many samples can you collect?


# Often, our samples are limited in size and we can only collect one sample...
# maybe 2 or 3 if we are lucky! (in the real world)


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
set.seed(1234)
baby_s10 <- baby %>% 
  sample_n(10)

hist(baby_s10$r1)
mean(baby_s10$r1)
sd(baby_s10$r1)



# As all knowing wizards, Elena and Willa have granted you the power to check
# the TRUE MEAN gyrification of the population. Check that value. How does it
# compare to the estimated mean from the 10-baby sample?

# Compare to the population!
mean(baby$r1)
sd(baby$r1)

# Now, what if we took a bunch of samples (5) of 10 babies and took the mean of
# the means (e.g., 5 follow-up studies). How does this value compare to the TRUE
# population mean? Plot a histogram of the means. What is the mean gyrification
# of the means? The sd of the means?


# Goal: Collect 5 samples of 10 babies and find the mean of r1 each time

num_samples <- 5
sample_size <- 10

# For each sample:
means <- c()
for(sample in 1:5) {
  #   Draw the sample
  baby_sample <- baby %>% 
    sample_n(10)
  
  #   Take the mean of r1 and save it
  means[sample] <- mean(baby_sample$r1)

}

means
hist(means)
abline(v = mean(means), col = "blue")
abline(v = mean(baby$r1), col = "red")

mean(means)

mean(baby$r1)

# Do it in one line!
# for(sample in 1:5) {
#   #   Draw the sample
#   #   Take the mean of r1 and save it
#   means[i] <- mean(sample_n(baby, 10)$r1)
#   
# }
  


# What if we could take 100 samples of 10 babies? How does this value compare to
# the TRUE population mean? Plot a histogram of the means. What is the mean
# gyrification of the means? The sd of the means?


sample_size <- 100
num_samples <- 5

# For each sample:
means <- c()
for(sample in 1:num_samples) {
  #   Draw the sample
  baby_sample <- baby %>% 
    sample_n(sample_size)
  
  #   Take the mean of r1 and save it
  means[sample] <- mean(baby_sample$r1)
  
}

means
hist(means)
abline(v = mean(means), col = "blue")
abline(v = mean(baby$r1), col = "red")




## Practice: Now try this all again, but now drawing samples of 100 babies. ##

# Draw one sample of 100 babies. How does this compare to the mean r1 depth from the 1 sample of 10 babies? To the true population mean?


# Draw 100 babies 5 times and compare the means


# Draw 100 babies 100 times and compare the means
sample_size <- 100
num_samples <- 1000

# For each sample:
means <- c()
for(sample in 1:num_samples) {
  #   Draw the sample
  baby_sample <- baby %>% 
    sample_n(sample_size)
  
  #   Take the mean of r1 and save it
  means[sample] <- mean(baby_sample$r1)
  
}

hist(means)
abline(v = mean(means), col = "blue")
abline(v = mean(baby$r1), col = "red")



sample_size <- 10
num_samples <- 1000

# For each sample:
means <- c()
for(sample in 1:num_samples) {
  #   Draw the sample
  baby_sample <- baby %>% 
    sample_n(sample_size)
  
  #   Take the mean of r1 and save it
  means[sample] <- mean(baby_sample$r1)
  
}

hist(means)
abline(v = mean(means), col = "blue")
abline(v = mean(baby$r1), col = "red")


#### The Central Limit Theorem! ####
# This was an intuitive proof of the central limit theorem! If you randomly
# sample from your population enough times and calculate some statistic on your
# measure (e.g., mean height), then the distribution of the sample statistic
# will approach a normal distribution and the MEAN of your sample statistic
# (e.g., sample means) will approach the true statistic of the population! The
# bigger your sample (sample_size) and the more times you sample (num_samples)
# then the better your approximation is!


# Random sampling Part 2

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