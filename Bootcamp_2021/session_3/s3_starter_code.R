# R bootcamp Session 3 - Starter Code
# July 20, 2021
# Elena Leib & Willa Voorhies



#### Set options ####
options(stringsAsFactors = FALSE)


#### Warm-up ####

# 1) Load in the penguins data set



# 2) What is the mean body mass in grams of the penguins?




# Bonus: 3) How many penguins were measured in each year?




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
# 5) Rename the levels of the variable sex from "female" to "f" and "male" to "m"


# This is what we want our data to look like after we do these processing steps:
penguins_endResult <- read.csv("penguins_cleaned.csv")
View(penguins_endResult)


#### Select ####
# Select only our columns of interest: penguin, species, island, bill_length_mm,
# bill_depth_mm, sex, year
# We remove flipper_lengh_mm and body_mass_g



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


#### Making our new dataframe ####
# We can actually do these two steps in the same call using pipes (%>%)!
# And now we will add on to do the rest of the steps





#### Write out our cleaned data frame ####



