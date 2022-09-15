# QuACK 2022 - Week 3: Intro to the tidyverse
# September 13, 2022
# Elena Leib & Willa Voorhies

#### Set options and load libraries ####
options(stringsAsFactors = FALSE)
library(tidyverse)
library(tidylog)


#### Warm-up ####

# 1) Download and unzip the materials for week 3 -- be sure to organize it in
# your quack folder!(e.g., there's a new data file!)


# 2) Create a new script named week3_warmup and save it
## Where did you save the script?


# 3) Load in the penguins_long data set
## Did you have to do anything before you could load in the data?
penguins <- read.csv("../data/penguins_long.csv")
# penguins_wide <- read.csv("../data/penguins.csv")

penguins <- read.csv(file = "../data/penguins_long.csv")


# 4) Answer the following questions:

  # a) What is the mean body mass in grams of the penguins?
summary(penguins$body_mass_g)
# mean mass = 4141g

# Another way to do this is by using the mean() function
# However, when we use just mean(penguins$body_mass_g), we get NA
mean(penguins$body_mass_g)
# Check out ?mean
?mean

# The default way of handling NAs is to include them in the calculation,
# resulting in NA. So we have to add an argument telling the function to "ignore"
# or "remove" NAs. The argument is called na.rm (na.remove) and we set it to true
# Now it works!
mean(penguins$body_mass_g, na.rm = TRUE)


  # b) How many penguins were measured in each year?
# One way to do this is to make year into a factor, then use summary
penguins$year <- factor(penguins$year)
summary(penguins$year)

# Here is another way to do this using a function called table()
# This way is nice because you don't have to make anything into a factor first!
table(penguins$year, exclude = NULL)




  # c) What is the value in the 4th column of the 10th row?
penguins[10,4]

penguins$bill_length_mm[10]


  # d) How much does the penguin in the 5th row weigh?

penguins$body_mass_g[5]

penguins[5, "body_mass_g"]

penguins[5, "penguin"]





#### Load your packages ####
# If you don't have tidyverse installed, first, we need to install it.
# You can do this by:
# A) Go to "Packages" in the bottom right pane of RStudio, then click "Install."
#    Type "tidyverse" into the box and click "Install"
#
# B) You can also type install.packages("tidyverse") into the console

# Load the package
library(tidyverse)


#### Our goal for our tidy data frame ####

# We want a data frame that:
# 1) Only has columns for the variables penguin, species, island, bill_length_mm, bill_depth_mm, sex, year
# 2) Only has the observations for the year 2008
# 3) Remove penguins from the data frame that have NAs for any cells
# 4) Make a new variable called "bill_sum" that is the sum of bill_length and bill_depth


# This is what we want our data to look like after we do these processing steps:
penguins_endResult <- read_csv("../data/penguins_clean.csv") # use tidyverse read_csv()
View(penguins_endResult)


#### Read in our data ####
# We will be using the penguins_long data set for class today.
penguins <- read_csv("../data/penguins_long.csv")


#### Hot keys for the pipe %>% operator ####
# PC: ctrl + shift + M
# Mac: cmd + shift + M


#### Select ####
# Select only our columns of interest: penguin, species, island, bill_length_mm,
# bill_depth_mm, body_mass_g, sex, year
# We remove flipper_lengh_mm 

# Note: typically, we would do all of these processing/cleaning steps in one
# pipe, as we will do below. For teaching purposes, doing this in separate
# pipes, but we will be putting them together later.


penguins_selected <- penguins %>% 
  select(penguin, species, island, bill_length_mm, bill_depth_mm, body_mass_g, 
         sex, year)


## Or, if you just want to remove columns, you can just do this:
penguins_selected2 <- penguins %>% 
  select(-c(flipper_length_mm, body_mass_g))


## ^^ These two ways will get you the same resulting data frame
## This is a change to the columns!


# Learn more functionality of select here: 
# https://dplyr.tidyverse.org/reference/select.html
# You can even use select to rename columns! Also reorder columns. Tons of
# flexibility in this one function!


#### Filter ####

## Can also think about this as "subsetting" the data to get just a part of it.
## This is a change to the rows! Only keeping rows that meet certain criteria,
## in this case, are part of the group that was measured in 2008

penguins_filter <- penguins %>% 
  filter(year == 2008)


# In addition to our tidylog output, we can also check that this worked by
# clicking the top of the year column in the View() data frame. That will sort
# the column and you can quickly see that there are no 2007s left. We can also
# use table() to check as well. In sum, check to make sure things worked the way
# you intended them to after running code! We never want to assume that it
# worked as expected without checking!


# Learn more functionality of filter here: 
# https://dplyr.tidyverse.org/reference/filter.html


# There are a lot more ways you can use filter! For more information about all
# the logical operators you can use in filter, see:
# https://www.tutorialspoint.com/r/r_operators.htm, the Relational and Logical
# Operators sections
## == equals, != not equals,
## > greater than, >= greater than or equal to
## < less than, <= less than or equal to
## <=
## & AND
## | OR
## %in%


# Keep only penguins that are either Adelie or Chinstrap species
# Two ways to do it
# Using the or operator: |
penguins_filter2 <- penguins %>% 
  filter(species == "Adelie" | species == "Chinstrap")

# Using the %in% operator, which checks if a value is in a vector
penguins_filter3 <- penguins %>% 
  filter(species %in% c("Adelie", "Chinstrap"))



# For example, let's keep all the penguins that are females and are heavier than
# 3500g
penguins_filter4 <- penguins %>% 
  filter(sex == "female", body_mass_g > 3500)


# What about keeping all females that are heavier than the mean body mass for
# all penguins?
penguins_filter5 <- penguins %>% 
  filter(sex == "female", body_mass_g > mean(body_mass_g))

## Ack! My tidylog output says it removed 100% of the columns! What is going on?
## Let's troubleshoot.
mean(penguins$body_mass_g)

# Oh no, we are getting an NA result. We have to remember to use na.rm = TRUE
# so that it gives us back a value and not NA.
penguins_filter5 <- penguins %>% 
  filter(sex == "female", body_mass_g > mean(body_mass_g, na.rm = TRUE))
# ^^ much better!


# Now, let's keep only penguins that have a bill length greater than 40 OR a
# bill depth greater than 20
penguins_filter6 <- penguins %>% 
  filter(bill_length_mm > 40 | bill_depth_mm > 20)



#### Making our new dataframe ####
# We can actually do these two steps in the same call using pipes (%>%)!
# And now we will add on to do the rest of the steps





#### Write out our cleaned data frame ####

# We want a data frame that:
# 1) Only has columns for the variables penguin, species, island, bill_length_mm, bill_depth_mm, sex, year
# 2) Only has the observations for the year 2008
# 3) Remove penguins from the data frame that have NAs for any cells
# 4) Make a new variable called "bill_sum" that is the sum of bill_length and bill_depth


penguins_clean <- penguins %>% 
  # Remove flippter_length
  select(-flipper_length_mm) %>% 
  
  # Keep only observations from 2008
  filter(year == 2008) %>% 
  
  # Remove rows that have any NAs
  drop_na() %>% 
  
  # Make a new column called bill_sum by adding together the two bill columns
  mutate(bill_sum = bill_length_mm + bill_depth_mm,
         # We can also find the mean. You may be tempted to use mean(), which
         # you can do, but it gets sticky. We will do that next week. For now,
         # calculate mean "by hand"
         bill_mean = (bill_length_mm + bill_depth_mm) / 2,
         # We can also use mutate to make a column into a factor
         species = factor(species))


# Mutate "mutates" the data frame by adding a column or changing an already
# existing column. Select only addresses whether a column exists in the data set
# or not (or can rename it), and filter changes which rows are in the data
# frame. Mutate changes the actual data that appears in each row of a column!
# We can add or change multiple columns within one mutate call by adding commas.



## What happens if you drop NAs first and then do the rest of the cleaning?
## Do you end up with the same data frame? Try it out!

penguins_clean_NAfirst <- penguins %>% 
  # Remove penguins from the data frame that have NAs for any cells
  drop_na() %>% 
  
  # remove flipper_length_mm
  select(-flipper_length_mm) %>% 
  
  # keep data for 2008 only
  filter(year == 2008) %>% 
  
  # Add column
  mutate(bill_sum = bill_length_mm + bill_depth_mm)


# ORDER MATTERS!
# p90 only has NA for flipper_length_mm in 2008. If you drop_na first, removes
# this penguin. But if you drop NA after already removing the flipper column,
# the data for this penguin stays in there. Important to be careful and
# intentional with data cleaning!



#### Answers to practice activity ####

# Load the data
covid_attitudes <- read_csv("../data/covid_attitudes.csv")


# Questions 1, 3, 5, 7, and 8
covid_attitudes_clean <- covid_attitudes %>% 
  # 1) Remove the variable Q6.consent and Q13.trust_none_of_above
  select(-Q6.consent, -Q13.trust_none_of_above) %>% 
  
  # 3) Only keep observations from large cities or small cities
  # There are a few ways to do this!
  # filter(Q84.community == "large city" | Q84.community == "small city/town")
  filter(Q84.community %in% c("large city", "small city/town")) %>% 
  
  # 5) Drop NAs
  drop_na() %>% 
  
  # 7) Add a new variable called "apprehension_score" that is a composite score of Q18, Q20, and Q21
  # I decided my composite score would be an average of the three measures
  mutate(apprehension_score = (Q18.likely_to_catch_covid + 
                                 Q20.ability_to_protect_self + 
                                 Q21.expected_symptom_severity) / 3,
         
         
         # 8) Make one of the likert-scale columns into a factor
         Q8.covid.info = factor(Q8.covid_info, 
                                levels = c("A little", 
                                           "A moderate amount", 
                                           "A lot")))


# 9) Save your data frame to the data folder, label it covid_attitudes_clean_w3.csv:
write_csv(covid_attitudes_clean, "../data/covid_attitudes_w3_clean.csv")

# If you don't have row.names = FALSE then it adds an extra column to your data
# frame with row names. Since our rows aren't named, it ends up being a column
# of the row indexes, 1 to length(df), which we don't want!


# 2) Make a different data frame that has people who either live in a large city or a small city
covid_attitudes_city <- covid_attitudes %>% 
  # 1) Remove the variable Q6.consent and Q13.trust_none_of_above
  select(-Q6.consent, -Q13.trust_none_of_above) %>%
  
  # 2) Keep observations from large cities only
  filter(Q84.community == "large city")


# 4) Make a third data frame that only has people below the age of 50 that have
# earned a 4 year degree
covid_attitudes_degree <- covid_attitudes %>% 
  # 1) Remove the variable Q6.consent and Q13.trust_none_of_above
  select(-Q6.consent, -Q13.trust_none_of_above) %>%
  
  # 4) < 50 and 4 year degree
  # If age was a continuous variable we could write it as Q40.age < 50
  # filter(Q40.age < 50, Q74.education == "4 year degree")
  # That was the answer for the intended question
  # However, in the data set we have here, age is actually a categorical variable
  # with the levels being age bins, so we need to do something a little differently
  # to get it to work. We can use the %in% operator again!
  filter(Q40.age %in% c("18-19", "20-24", "25-29", "30-34", "35-39", "40-44",
                        "45-49")) 
  



# Someone in class noted that filter(Q40.age < 50) does "work"
# But after playing around with this more, we found it only sort of works, and 
# I'd say never to trust something that you don't really understand why it is 
# working, which we didn't here.

# Some examples of us messing around and it sort of working

covid_attitudes_filtered1 <- covid_attitudes %>% 
  filter(Q40.age %in% c("18-19", "20-24", "25-29", "30-34", "35-39", "40-44",
                        "45-49")) 

# Correct: Removes 297 rows

covid_attitudes_filtered2 <- covid_attitudes %>% 
  filter(Q40.age < 50)
# Also removes 297 rows, so seems like it works

covid_attitudes_filtered3 <- covid_attitudes %>% 
  filter(Q40.age < 5)
# This also removes 297 rows though! And that shouldn't "work"
# Clearly it is doing something with the first character of the string and the
# first number here

covid_attitudes_filtered4 <- covid_attitudes %>% 
  filter(Q40.age < 500)
# Removes 269 rows. So not working, but close. This is too weird!



# 6a) Take the data frame from step #2 and only remove participants that have NA
# in the age column

covid_attitudes_noAgeNA <- covid_attitudes %>% 
  # 1) Remove the variable Q6.consent and Q13.trust_none_of_above
  select(-Q6.consent, -Q13.trust_none_of_above) %>%
  
  # 3) Only keep observations from large cities or small cities
  filter(Q84.community %in% c("large city", "small city/town")) %>% 
  
  # 6) Remove participants with NAs in age column
  drop_na(Q40.age) 


# 6b) Using drop_na carelessly can lead do losing a lot of data. It will remove
# any row that has an NA in it. For example, 205 rows remain after drop_na(),
# but 407 remain after drop_na(age). Looking more closely, we see columns like 
# Q23.risk_exaggerated have a ton of NAs:

table(covid_attitudes_noAgeNA$Q23.risk_exaggerated, exclude = NULL)

# 142 to be exact! So we would lose 142 participants' data from this column
# alone by using drop_na(). For this reason, I typically only use drop_na()
# *after* I only have the columns left in my data frame that I am including in
# analyses OR I run drop_na(outcome_variable) on whichever column is my outcome
# variable specifically if I need to keep only participants with data for that
# variable.


#### Bonus questions ####

apprehension_summary <- covid_attitudes_clean %>%
  summarise(apprehension_mean = mean(apprehension_score),
            apprehension_sd = sd(apprehension_score))




apprehension_summary <- covid_attitudes_clean %>%
  # group by community
  group_by(Q84.community) %>%
  # get mean apprehension score for each community group
  summarise(apprehension_mean=mean(apprehension_score))%>%
  # it's important to ungroup!
  ungroup()


# You could also try grouping by age bin, see what happens!


# Tidy cheat sheet for more tidyverse and data wrangling functionality
# https://www.rstudio.com/wp-content/uploads/2015/02/data-wrangling-cheatsheet.pdf




