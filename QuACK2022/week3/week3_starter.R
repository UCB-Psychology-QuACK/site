# QuACK 2022 - Week 3: Intro to the tidyverse
# September 13, 2022
# Elena Leib & Willa Voorhies

#### Set options ####
options(stringsAsFactors = FALSE)


#### Warm-up ####

# 1) Download and unzip the materials for week 3 -- be sure to organize it in
# your quack folder!(e.g., there's a new data file!)


# 2) Create a new script named week3_warmup and save it
## Where did you save the script?


# 3) Load in the penguins data set
## Did you have to do anything before you could load in the data?



# 4) Answer the following questions:

  # a) What is the mean body mass in grams of the penguins?



  # b) How many penguins were measured in each year?



  # c) What is the value in the 4th column of the 10th row?



  # d) How much does the penguin in the 5th row weigh?




#### Load your packages ####
# If you don't have tidyverse installed, first, we need to install it.
# You can do this by:
# A) Go to "Packages" in the bottom right pane of RStudio, then click "Install."
#    Type "tidyverse" into the box and click "Install"
#
# B) You can also type install.packages("tidyverse") into the console

# Load the package



#### Our goal for our tidy data frame ####

# We want a data frame that:
# 1) Only has columns for the variables penguin, species, island, bill_length_mm, bill_depth_mm, sex, year
# 2) Only has the observations for the year 2008
# 3) Remove penguins from the data frame that have NAs for any cells
# 4) Make a new variable called "bill_sum" that is the sum of bill_length and bill_depth


# This is what we want our data to look like after we do these processing steps:
penguins_endResult <- read_csv("../data/penguins_clean.csv") # use tidyverse read_csv()
View(penguins_endResult)


#### Select ####
# Select only our columns of interest: penguin, species, island, bill_length_mm,
# bill_depth_mm, body_mass_g, sex, year
# We remove flipper_lengh_mm 



## Or, if you just want to remove columns, you can just do this:



## ^^ These two ways will get you the same resulting data frame
## This is a change to the columns!


# Learn more functionality of select here: 
# https://dplyr.tidyverse.org/reference/select.html
# You can even use select to rename columns!


#### Filter ####

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



# What about keeping all females that are heavier than the mean body mass for
# all penguins?



# Now, let's keep only penguins that have a bill length greater than 40 OR a
# bill depth greater than 20




# Sorting data frames in View() mode

# Making quick tables to examine columns 


#### Making our new dataframe ####
# We can actually do these two steps in the same call using pipes (%>%)!
# And now we will add on to do the rest of the steps





#### Write out our cleaned data frame ####

# We want a data frame that:
# 1) Only has columns for the variables penguin, species, island, bill_length_mm, bill_depth_mm, sex, year
# 2) Only has the observations for the year 2008
# 3) Remove penguins from the data frame that have NAs for any cells
# 4) Make a new variable called "bill_sum" that is the sum of bill_length and bill_depth









## What happens if you drop NAs first and then do the rest of the cleaning?
## Do you end up with the same data frame? Try it out!