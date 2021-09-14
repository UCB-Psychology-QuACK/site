# QuACK 2021 - Week 3: Intro to the tidyverse
# September 14, 2021
# Elena Leib & Willa Voorhies



#### Set options ####
options(stringsAsFactors = FALSE)


#### Warm-up ####

# 1) Load in the penguins data set
penguins <- read.csv("../data/penguins.csv")

## Data adapted from Allison Horst: https://allisonhorst.github.io/palmerpenguins/


# 2) What is the mean body mass in grams of the penguins?
summary(penguins$body_mass_g)



# Bonus: 3) How many penguins were measured in each year?
penguins$year <- factor(penguins$year)
summary(penguins$year)



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
penguins_endResult <- read.csv("../data/penguins_endResult.csv")
View(penguins_endResult)


#### Select ####
# Select only our columns of interest: penguin, species, island, bill_length_mm,
# bill_depth_mm, sex, year
# We remove flipper_lengh_mm and body_mass_g
penguins_select <- penguins %>% 
  select(penguin, species, island, bill_length_mm, bill_depth_mm, sex, year)

View(penguins_select)

## Or, if you just want to remove columns, you can just do this:
penguins_select2 <- penguins %>% 
  select(-flipper_length_mm, -body_mass_g)

## These two ways will get you the same resulting data frame
## This is a change to the columns!


# Learn more functionality of select here: 
# https://dplyr.tidyverse.org/reference/select.html
# You can even use select to rename columns!


#### Filter ####
penguins_filter <- penguins %>% 
  filter(year == 2008)

## Can also think about this as "subsetting" the data to get just a part of it
## This is a change to the rows! Only keeping rows that meet a certain criteria,
## in this case, are part of the group that was measured in 2008


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


# For example, let's keep all the penguins that are females and are heavier than
# 3500g
pf_more3500 <- penguins %>% 
  filter(sex == "female", body_mass_g > 3500)

# What about keeping all females that are heavier than the mean body mass for
# all penguins?
pf_heavy <- penguins %>% 
  filter(sex == "female", body_mass_g > mean(body_mass_g)) # might need na.rm!


# Now, let's keep only penguins that have a bill length greater than 40 OR a
# bill depth greater than 20
p_longBill <- penguins %>% 
  filter(bill_length > 40 | bill_depth > 20)

#### Making our new dataframe ####
# We can actually do these two steps in the same call using pipes (%>%)!
# And now we will add on to do the rest of the steps
penguins_cleaned <- penguins %>% 
  # Select the columns we want
  select(-flipper_length_mm, -body_mass_g) %>% 
  
  # Only keep observations from 2008
  filter(year == 2008) %>% 
  
  # Remove all rows with missing data
  drop_na() %>% 
         
         # Make a new column called bill_sum that adds the two bill columns
  mutate(bill_sum = bill_length_mm + bill_depth_mm,
         
         # Make the variable species into a factor
         species = factor(species))



#### Write out our cleaned data frame ####
write.csv(penguins_cleaned, file="penguins_cleaned.csv", row.names = FALSE)





###############################################################################X

#### Answers to group activity ####

# You may need to change the prefix on the file name to direct it to where your
# file is located in your folder system, if you'd like to run this code
covid_attitudes <- read.csv("../covid_attitudes.csv")

# If the csv file is in the same folder you are running the script from:
# covid_attitudes <- read.csv("covid_attitudes.csv")

covid_attitudes_cleaned <- covid_attitudes %>% 
  # 1) Remove the variable Q6.consent
  select(-Q6.consent) %>% 
  
  # 2) Only keep oversvations from large cities
  filter(Q84.community == "large city") %>% 
  
  # 5) Drop NAs
  drop_na() %>% 
  
  # 7) Add a new variable called "apprehension_score" that is a composite score of Q18, Q20, and Q21
  # I decided my composite score would be an average of the three measures
  mutate(apprehension_score = (Q18_likely_to_catch_covid + 
                              Q20_ability_to_protect_self + 
                              Q21.expected_symptom_severity) / 3,
  
  
  # 8) Make one of the likert-scale columns into a factor
          Q8.covid.info = factor(Q8.covid.info))
  

# Save your data frame:
write.csv(covid_attitudes_cleaned, "covid_attitudes_cleaned.csv", row.names = FALSE)



# Bonus
  
attitudes_summary <- covid_attitudes_cleaned %>%
  summarise(mean(attitudes_score))

  
attitudes_summary <- covid_attitudes_cleaned %>%
  # This is cleaning up all those wonky #N/As for us!
  mutate(across(where(is.character), ~ str_replace(., "#N/A", NA_character_))) %>% 
  # group by age
  group_by(Q40.age) %>%
  # get mean apprehension score for each age group
  summarise(apprehension_mean=mean(apprehension_score))%>%
  # it's important to ungroup!
  ungroup()


# Tidy cheat sheet for more tidyverse and data wrangling functionality
# https://www.rstudio.com/wp-content/uploads/2015/02/data-wrangling-cheatsheet.pdf