# QuACK Week 4 - Tidyverse Part 2
# September 21, 2021
# Elena Leib & Willa Voorhies

#### Load libraries and set options ####
options(stringsAsFactors = FALSE)

library(tidyverse)
library(tidylog)


#### Where we left off last week / Warm-up review ####

# 1. Load and view the penguins.csv 
penguins <- read.csv("../data/penguins.csv")
summary(penguins)


# 2.  Follow the steps we completed last week to create penguins_clean.csv. Do all of the steps in one pipe. 
# Try to do as much as you can without looking back at last week's code!

# i) remove the flipper_length_mm variable
# ii) Keep only the data from 2008
# iii) remove all NA values
# iv) add a new column bill_sum that is the sum of bill_length_mm and bill_depth_mm
# v) make sex into a factor

penguins_clean <- penguins %>% 
  select(-flipper_length_mm) %>% 
  filter(year == 2008) %>% 
  drop_na() %>% 
  mutate(bill_sum = bill_length_mm + bill_depth_mm,
         sex = factor(sex, levels = c("male", "female"))) 
  



#### mutate() continued: case_when() ####

# As a reminder, mutate() allows us to A) Add new columns and B) Change a current
# column. Whether a new column is added or an old column is edited depends on
# what we name the column. If we give it a name of a column that already exists,
# it will edit that column. If it's a new name, it will make a new column.

# Sometimes when we are creating or editing a column, we want the contents of
# that column to be *conditional* on another piece of information

# Can you think of any examples?
# - Scores of anxiety in a column, make a new column that categorizes a continuous variable!
# - More generally: Continuous variable --> categorical one!



# Let's do an example for our penguins data set:
# Imagine we want to categorize our penguins by how heavy they are into "heavy"
# and "light". How would we do this?

# First in pseudocode:

# If the penguin weight > mean(weight) --> "heavy"
# If the penguin weight < mean(weight) --> "light"



# Case_when allows us to do these conditionals
# Here is the syntax:
# mutate(newColName = case_when(condition1 ~ result1,
#                               condition2 ~ result2,
#                               ...
#                               TRUE ~ catchAll))

# Here is a great illustration by Allison Horst! 
# https://twitter.com/allison_horst/status/1282785610273447936?lang=en


# Now in real code:

penguins_clean <- penguins_clean %>% 
  mutate(weight_cat = case_when(body_mass_g >= mean(body_mass_g) ~ "heavy",
                                body_mass_g < mean(body_mass_g) ~ "light"))


# Now imagine that there was a scientific breakthrough, and the species that you found on Torgerson that you thought was Adelie is actually a new species!

# Pseudocode:

# If island == Torgerson & species == Adelie --> newSpecies!
# Else --> NOTHING (keep it the same)


# Real code:

penguins_updatedSpecies <- penguins_clean %>% 
  mutate(species_updated = case_when(island == "Torgersen" 
                                     & species == "Adelie" ~ "Happy Feet",
                                     TRUE ~ species))


# We could rename more than one of the species, too
penguins_updatedSpecies2 <- penguins_clean %>% 
  mutate(species_updated = case_when(island == "Torgersen" 
                                     & species == "Adelie" ~ "Happy Feet",
                                     island == "Biscoe" & species == "Adelie" ~ "Tuxedo Kings",
                                     # island == "Dream" & species == "Adelie" ~ NA_character_,
                                     TRUE ~ species))


# Suppose we wanted to change one of the species to NA (on purpose!).
# You cannot just write ~ NA. You have to use a special NA that has the same
# type (i.e., character, integer, etc.) as the column you are creating.
penguins_updatedSpecies3 <- penguins_clean %>% 
  mutate(species_updated = case_when(island == "Torgersen" 
                                     & species == "Adelie" ~ "Happy Feet",
                                     island == "Biscoe" & species == "Adelie" ~ "Tuxedo Kings",
                                     island == "Dream" & species == "Adelie" ~ NA_character_,
                                     TRUE ~ species))


# This kind of logic -- if/else (here renamed as case_when) is prominent
# throughout all coding languages! We did it last week with filter, and now with
# case_when. It will continue to come up!


#### group_by() + summarise() ####
# When we have categorical data, we often want to calculate summary stats for each group. 
# For example, we might want to see the mean and sd of body_mass  for each species of penguin. 
# We can use the group_by() and summarise() functions to calculate stats on each group and save them as a new dataframe. 

## Save the mean and sd and n for each species as a new dataframe called sum_stats_species

summary_stats <- penguins_clean %>% 
  group_by(species) %>% 
  summarise(mean(body_mass_g),
            sd(body_mass_g)) 



# We can customize our column names within the summarise() function.

summary_stats <- penguins_clean %>% 
  group_by(species) %>% 
  summarise(mean_mass = mean(body_mass_g),
            sd_mass = sd(body_mass_g),
            n = n()) 

## We can also group our data by mulitple categories. eg. by species AND island. 

summary_stats <- penguins_clean %>% 
  group_by(species, island) %>% 
  summarise(mean_mass = mean(body_mass_g),
            sd_mass = sd(body_mass_g),
            n = n()) 

# We can use the n() function within summarise() to get the number or frequency in each group.
# eg. Which island has the fewest Adelie penguins? 

summary_stats <- penguins_clean %>% 
  group_by(species, island) %>% 
  summarise(mean = mean(body_mass_g), 
            sd = sd(body_mass_g), 
            freq = n()) %>% 
  ungroup() 


## It looks like island may have an effect on penguin weight. Now that we know this, we might want to account for this in our data. 
#  For example, lets create a new column with z-scored body_mass
# To z-score our data : ( body_mass - mean(body_mass) ) / sd(body_mass)

penguins_clean <- penguins_clean %>%
  mutate(mass_zscored_sex = (body_mass_g - mean(body_mass_g)) / sd(body_mass_g)) %>% 
  ungroup()


# This isn't exactly what we want. We noted that weights seem to differ by island so lets normalize our data within island (ie we want to use the mean specific to the island the penguin is on). 

penguins_clean <- penguins_clean %>%
  group_by(sex) %>% 
  mutate(mass_zscored_sex = (body_mass_g - mean(body_mass_g)) / sd(body_mass_g)) %>% 
  ungroup()

# This kind of idea is often useful in situations where you are creating standardized scores within age groups or populations of participants. 




#### Joining data frames ####

# Sometimes, we want to combine data from multiple csv files into one data
# frame. For example, you may have one file of demographic data and one with the
# participant's experimental data. This is very common, and we will use the
# "join" function to do this (as we'll see, it is a family of functions)!

# Here's another common problem: most of the time, the data frames DON'T have
# the same number of rows. What are some reasons for why that could be?
#   - One example: Not all participants filled out the demographic survey

# Imagine you've cleaned all you experimental data, and you needed to remove
# some participants (they just didn't pay attention to the task and their data
# were terrible!). You started off with 100 participants. In your clean data,
# you only have valid data for 75 participants! You have demographic data for
# all 100 participants, so this is how many rows you have in your demographic
# data frame. In this case, you probably only want the demo data for the 75
# participants that have clean experimental data.

# Now, let's imagine another scenario. What if your demographic info included a
# survey and not all the participants filled it out! Now your demographic data
# includes only 82 participants. And your cleaned data has 75 still. What would
# you do? Depending on your question, maybe you only want to keep participants
# that have demographic data AND clean experimental data.


# There is a "join" for all occasions!
# - full_join - keeps all rows in both data frames
# - inner_join - keeps only rows that are in both data frames
# - left_join - keeps all rows from left data frame
# - right_join - keeps all rows from right data frame

# Here's a nice visualization of the 4 kinds of "joins"
# http://svmiller.com/images/sql-joins.jpeg

# Sort of a way of "filtering" in its own right!

# Check out the tidy cheatsheet for more:
# https://www.rstudio.com/wp-content/uploads/2015/02/data-wrangling-cheatsheet.pdf


# Let's try it with our penguins code!

# "Demographic" data for all the penguins
penguins_researcher <- read.csv("../data/penguins_researcher-info.csv")

# "Demographic" data for the penguins, but some demo data is missing
penguins_researcher_missing <- read.csv("../data/penguins_researcher-info_missingData.csv")

# How many observations in penguins? 220

# How many observations in penguins_clean? 102

# How many observations are there penguins_researcher? 220

# How many observations are there penguins_researcher_missing? 213



## Left join - penguins_clean & researcher ##
# This will keep all the rows in the penguins_clean data set, and add in columns
# from the other data frame.

penguins_clean.demo <- penguins_clean %>% 
  left_join(penguins_researcher, by = c("penguin", "island", "year"))

# It is "left" because the penguins_clean data set is the left argument in
# left_join if we weren't using it in a pipe. Note that whichever dataframe is
# getting piped in is automatically the "left" data frame!!
head(left_join(penguins_clean, penguins_researcher, by = c("penguin", "island", "year")))


## Inner join - penguins_clean & researcher ##
# This will keep only rows that are in both data sets.
penguins_clean.demo_inner <- penguins_clean %>% 
  inner_join(penguins_researcher, by = c("penguin", "island", "year"))
# ^^ In this case, same as left join!


# Now let's try these two joins again but with a researcher data set that is missing
# observations
# How many rows do you think it will have for left_join?
# What about for inner_join?

# left join
penguins_clean.demo_missing <- penguins_clean %>% 
  left_join(penguins_researcher_missing, by = c("penguin", "island", "year"))

# inner join
penguins_clean.demo_inner_missing <- penguins_clean %>% 
  inner_join(penguins_researcher_missing, by = c("penguin", "island", "year"))

# Missing demo data doesn't affect the left join (still 102 rows), but does
# affect the inner join (now only 99 rows that are matched)



# Other joins you could try for practice. Try and guess how many rows the data
# frame will have before you run the code

## Full join
#   - penguins & researcher
#   - penguins_clean & researcher
#   - penguins & researcher_missing
#   - penguins_clean & researcher_missing

# Again for right join

# Complete the set for left join and inner join!





#### Key to practice questions! ####

# 1) Load in world-happiness_2020.csv, which has the measures information about
# each country. Look at the data frame, in particular the column names (use
# colnames())
happiness <- read.csv("../data/world-happiness_2020.csv")
colnames(happiness)

# 2) Load in population.csv, which holds general information about each country
# (e.g., population). Look at the data frame.
population <- read.csv("../data/population.csv")

# **NOTE: population.csv is updated on the website now. If you are having issues
# with it (there were some wonky things in the old version), redownload it and
# try again!

# Do the next steps in one pipe:
#   3) After looking at the data frame, we see a bunch of columns that we won't
#   need, and they all start with "Explained." Remove all these columns
#   4) Add the population information for all the countries in the happiness
#   dataframe.
#   5) Add a column that categorizes countries by size. Large countries have
#   over 100 million citizens, small countries have fewer than 1 million
#   citizens, and medium countries have populations in between.
#   6) Create a new variable that categorizes countries as below average or
#   above average for ladder score.
#   7) Now create another new variable that categorizes countries as below
#   average or above average compared to the other countries in their region.


happiness_clean <- happiness %>% 
  select(-starts_with("Explained")) %>% #3
  inner_join(population) %>% #4 - Following the question wording, you'd use left join. For the key, I'm using inner join to keep only countries that have population data (it seems like the countries that we don't have population data for are disputed/controversial areas, so maybe they are named something differently in the population data!)
  mutate(size_cat = factor(case_when(population >= 100000000 ~ "large",
                              population <= 1000000 ~ "small",
                              TRUE ~ "medium")), #5 --> added making it a factor as a bonus!
         size_avg_cat = factor(case_when(population >= mean(population, na.rm = TRUE) ~ "above_avg",
                                     population < mean(population, na.rm = TRUE) ~ "below_avg"))) %>% #6
  group_by(Regional_indicator) %>% #7
          # Can use the same code as above, but now mean(population) is referring to the mean within a region!
  mutate(size_avg_cat_byRegion = factor(case_when(population >= mean(population, na.rm = TRUE) ~ "above_avg",
                                                  population < mean(population, na.rm = TRUE) ~ "below_avg"))) %>% 
  ungroup()



# Summarizing data
# 8) Pick two variables and summarize them in a new data frame. Get the mean, median, and sd.

summarize_ladder.generosity <- happiness_clean %>% 
  summarize(ladder.mean = mean(Ladder_score, na.rm = TRUE),
            ladder.median = median(Ladder_score, na.rm = TRUE),
            ladder.sd = sd(Ladder_score, na.rm = TRUE),
            generosity.mean = mean(Generosity, na.rm = TRUE),
            generosity.median = median(Generosity, na.rm = TRUE),
            generosity.sd = sd(Generosity, na.rm = TRUE))


# 9) In another new data frame, get the mean, median, sd for these variables by region.
summarize_ladder.generosity_byRegion <- happiness_clean %>% 
  group_by(Regional_indicator) %>% 
  summarize(ladder.mean = mean(Ladder_score, na.rm = TRUE),
            ladder.median = median(Ladder_score, na.rm = TRUE),
            ladder.sd = sd(Ladder_score, na.rm = TRUE),
            generosity.mean = mean(Generosity, na.rm = TRUE),
            generosity.median = median(Generosity, na.rm = TRUE),
            generosity.sd = sd(Generosity, na.rm = TRUE)) %>% 
  ungroup()

# 10) In a third new data frame, get the mean, median, sd for these variables by region and population category.
summarize_ladder.generosity_byRegionSize <- happiness_clean %>% 
  group_by(Regional_indicator, size_avg_cat) %>% 
  summarize(ladder.mean = mean(Ladder_score, na.rm = TRUE),
            ladder.median = median(Ladder_score, na.rm = TRUE),
            ladder.sd = sd(Ladder_score, na.rm = TRUE),
            generosity.mean = mean(Generosity, na.rm = TRUE),
            generosity.median = median(Generosity, na.rm = TRUE),
            generosity.sd = sd(Generosity, na.rm = TRUE)) %>% 
  ungroup()



