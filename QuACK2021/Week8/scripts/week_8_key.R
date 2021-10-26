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


