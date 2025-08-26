# QuACK Week 4 - Tidyverse Part 2
# September 19, 2023
# Elizabeth Cisneros & Evan Orticio

#### Load libraries and set options ####
options(stringsAsFactors = FALSE)

library(tidyverse)
library(tidylog)


#### Warm-up is in the starter code! ####

# 0. Organize your quack folder with the new data files!


# 1. Load and view the penguins_long.csv 
penguins <- read_csv("../data/penguins.csv")
summary(penguins)

# 2.  Do the following in one pipe and name it penguins_analyses:
# (And try to do as much as you can without looking back at last week's code!)

penguins_analyses <- penguins %>% 
  # i) remove the flipper_length_mm variable
  select(-flipper_length_mm) %>% 
  
  # ii) Keep only the data for penguins on the islands Biscoe and Dream
  filter(island %in% c("Biscoe", "Dream")) %>% 



  # iii) remove all NA values
  drop_na() %>% 


  # iv) add a new column bill_sum that is the sum of bill_length_mm and
  # bill_depth_mm
  mutate(bill_sum = bill_length_mm + bill_depth_mm,
         # v) make species into a factor
         species = factor(species))



#### Plan for today ####

# 0. Check in

# 1. Review warmup

# 2. Learn more functionality in mutate --> case_when

# 3. group_by + summarize

# 4. joining data frames together

# 5. practice, practice, practice!



#### mutate() continued: case_when() ####

# As a reminder, mutate() allows us to A) Add new columns and B) Change a current
# column. Whether a new column is added or an old column is edited depends on
# what we name the column. If we give it a name of a column that already exists,
# it will edit that column. If it's a new name, it will make a new column.

# Sometimes when we are creating or editing a column, we want the contents of
# that column to be *conditional* on another piece of information

# Can you think of any examples?

# - Bin your data: make categorical variable from continuous one
#   0-4 hours of sleep
#   5-7 hours
#   8-10 hours

# - Recoding variables


# Let's do an example for our penguins data set:
# Imagine we want to categorize our penguins by how heavy they are into "heavy"
# and "light". How would we do this?

# Use mean or median

# First in pseudocode:

# new column such that if penguin's weight > median then "heavy"
# in the case when penguin weight < median then "light"

# Ifelse allows us to do just one conditional at a time
# ifelse(condition, true, false)

penguins <- penguins %>% 
  mutate(heavyLight = ifelse(body_mass_g > median(body_mass_g, na.rm = TRUE), "heavy", "light"))

# Case_when is a more powerful alternative with unlimited conditionals
# Here is the syntax:
# mutate(newColName = case_when(condition1 ~ result1,
#                               condition2 ~ result2,
#                               ...
#                               TRUE ~ catchAll))

# Note that case_when assigns a value to each row just once in order
# So if condition1 is met for a row, that row is done and will not be overwritten later
# The TRUE at the end captures every row that failed to satisfy any of the other conditions

# The ~ means "then"!

# Here is a great illustration by Allison Horst! 
# https://twitter.com/allison_horst/status/1282785610273447936?lang=en


# Now in real code:
penguins_class <- penguins %>% 
  # drop_na(body_mass_g) %>% depending on situation, could drop NAs here or use na.rm later
  mutate(heavyLight = case_when(body_mass_g >= median(body_mass_g, na.rm = TRUE) ~ "heavy",
                                body_mass_g < median(body_mass_g, na.rm = TRUE) ~ "light",
                                TRUE ~ NA_character_))


# Now imagine that there was a scientific breakthrough, and the species that you
# found on Torgersen that you thought was Adelie is actually a new species!

# Pseudocode:

# in the case when the island is Torgersen and the species is Adelie, change the species name to XXX
# in all the other cases, keep the species name the same

# Real code:
penguins_class <- penguins %>% 
  mutate(heavyLight = case_when(body_mass_g >= median(body_mass_g, na.rm = TRUE) ~ "heavy",
                                body_mass_g < median(body_mass_g, na.rm = TRUE) ~ "light",
                                TRUE ~ NA_character_),
         species_updated = case_when(species == "Adelie" & island == "Torgersen" ~ "Dill",
                                     TRUE ~ species))

# Remember, you can use as many conditionals as you want!

# This kind of logic -- if/else (here renamed as case_when) is prominent
# throughout all coding languages! We did it last week with filter, and now with
# case_when. It will continue to come up!


#### group_by() + summarise() ####
# When we have categorical data, we often want to calculate summary stats for
# each group. For example, we might want to see the mean and sd of body_mass
# for each species of penguin. We can use the group_by() and summarise()
# functions to calculate stats on each group and save them as a new dataframe.

## Save the mean and sd and n for each species as a new dataframe called
## sum_stats_species
# We can customize our column names within the summarise() function.

sum_stats_species <- penguins %>% 
  group_by(species) %>% 
  summarise(mean_body_mass = mean(body_mass_g, na.rm = TRUE),
            sd_body_mass = sd(body_mass_g, na.rm = TRUE)) %>% 
  ungroup() # NOTE: You should ungroup() every time to prevent unintended consequences


## We can also group our data by mulitple categories. eg. by species AND island.
sum_stats_speciesIsland <- penguins %>% 
  group_by(island, species) %>% 
  summarise(mean_body_mass = mean(body_mass_g, na.rm = TRUE),
            sd_body_mass = sd(body_mass_g, na.rm = TRUE)) %>% 
  ungroup()

# We can use the n() function within summarise() to get the number or frequency
# in each group. eg. Which island has the fewest Adelie penguins?
sum_stats_speciesIsland <- penguins %>% 
  group_by(island, species) %>% 
  summarise(mean_body_mass = mean(body_mass_g, na.rm = TRUE),
            sd_body_mass = sd(body_mass_g, na.rm = TRUE),
            n = n()) %>% 
  ungroup()

# Biscoe has the fewest.


## It looks like island may have an effect on penguin weight. Now that we know
## this, we might want to account for this in our data.
#  For example, lets create a new column with z-scored body_mass
# To z-score our data : ( body_mass - mean(body_mass) ) / sd(body_mass)

penguins_zscore <- penguins_clean %>%
  mutate(mass_zscored_sex = (body_mass_g - mean(body_mass_g, na.rm = TRUE)) / sd(body_mass_g, na.rm = TRUE)) %>% 
  ungroup()


# This isn't exactly what we want. We noted that weights seem to differ by
# island so lets normalize our data within island (ie we want to use the mean
# specific to the island the penguin is on).


penguins_zscore.island <- penguins_clean %>%
  group_by(island)
  mutate(mass_zscored_sex = (body_mass_g - mean(body_mass_g, na.rm = TRUE)) / sd(body_mass_g, na.rm = TRUE)) %>% 
  ungroup()


# This kind of idea is often useful in situations where you are creating
# standardized scores within age groups or populations of participants.


# Summarise works very similarly to mutate, in fact we can replace summarise
# with mutate. See how this df using mutate is different than the one using
# summarise.
penguins_exampleWithMutate <- penguins %>% 
  group_by(island, species) %>% 
  mutate(mean_body_mass = mean(body_mass_g, na.rm = TRUE),
         sd_body = sd(body_mass_g, na.rm = TRUE)) %>% 
  ungroup()

# Summarise makes a new data frame, mutate makes those same columns but in the
# old data frame, so the summary stat for each island, species pair is the same
# for all the penguins each group.


#### Joining data frames ####

# Sometimes, we want to combine data from multiple csv files into one data
# frame. This is very common! For example, you may have one file of demographic
# data and one with the participant's experimental data.

# Here's another common problem: most of the time, the data frames DON'T have
# the same number of rows. What are some reasons for why that could be?


# Imagine you've cleaned all you experimental data, and needed to remove some
# participants (they just didn't pay attention to the task and their data were
# terrible!)
# You started off with 100 participants, so this is how many rows you have in
# your demographic data frame.
# In your clean data, you only have valid data for 75 participants!
# In this case, you only want the demo data for the 75 participants.


# Now, let's imagine another scenario.
# What if your demographic info included a survey and not all the participants
# filled it out! Now your demographic data includes only 82 participants.
# And your cleaned data has 75 still. 
# What would you do?


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

## Use our penguins_clean data set as the example
penguins_clean <- read_csv("../data/penguins_clean.csv")

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

# It is "left" because the penguins_clean data set is the left (x) argument in
# left_join if we weren't using it in a pipe. Note that whichever dataframe is
# getting piped in is automatically the "left" data frame!!
head(left_join(penguins_clean, penguins_researcher, by = c("penguin", "island", "year")))

# Check out ?join for more info about this. And note that ?select, ?filter, all
# of these functions have a first argument (i.e., left-most argument) that is
# called data


## Inner join - penguins_clean & researcher ##
# This will keep only rows that are in both data sets.
penguins_clean.demo_inner <- penguins_clean %>% 
  inner_join(penguins_researcher, by = c("penguin", "island", "year"))
# ^^ In this case, same as left join since there are no penguins that have demo
# data that we don't have experimental data for.


## Right join
# This will keep all the rows in the researcher demo data set, and add in
# columns from the left data set.
penguins_clean.demo_inner <- penguins_clean %>% 
  right_join(penguins_researcher, by = c("penguin", "island", "year"))


## Full join
# This will keep all rows from both data sets.
penguins_clean.demo_inner <- penguins_clean %>% 
  full_join(penguins_researcher, by = c("penguin", "island", "year"))

# Now let's try these two joins again but with a researcher data set that is
# missing observations
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
happiness <- read_csv("../data/world-happiness_2020.csv")
colnames(happiness)

# 2) Load in population.csv, which holds general information about each country
# (e.g., population). Look at the data frame.
population <- read_csv("../data/population.csv")


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
  # 3) Remove all "explain columns"
  select(-starts_with("Explained")) %>% #3
  
  # 4) Join population information
  # Following the question wording, you'd use left join. For the key, I'm using
  # inner join to keep only countries that have population data (it seems like
  # the countries that we don't have population data for are
  # disputed/controversial areas, so maybe they are named something differently
  # in the population data!)
  inner_join(population) %>%
  
         # 5) Add a column that categorizes countries by size
  mutate(size_cat = factor(case_when(population >= 100000000 ~ "large",
                                     population <= 1000000 ~ "small",
                                     TRUE ~ "medium")), #5 --> added making it a factor as a bonus!
         
         # 6) Create a new variable that categorizes countries as below average
         # or above average for ladder score.
         avg.ladder_cat = factor(case_when(Ladder_score >= mean(Ladder_score, na.rm = TRUE) ~ "above_avg",
                                            Ladder_score < mean(Ladder_score, na.rm = TRUE) ~ "below_avg"))) %>%
  group_by(Regional_indicator) %>% #7
  # Can use the same code as above, but now mean(Ladder_score) is referring to the mean within a region!
  mutate(avg.ladder_cat_byRegion = factor(case_when(Ladder_score >= mean(Ladder_score, na.rm = TRUE) ~ "above_avg",
                                                    Ladder_score < mean(Ladder_score, na.rm = TRUE) ~ "below_avg"))) %>%  
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





