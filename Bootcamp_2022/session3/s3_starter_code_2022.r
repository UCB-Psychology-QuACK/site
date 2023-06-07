# R Bootcamp Session 3 - Starter Code
# July 20, 2022
# Emily Rosenthal, Elena Leib & Willa Voorhies



#### Set options ####
options(stringsAsFactors = FALSE)


#### Warm-up #### *************************************************************

# 1) Please sign in! Go to: https://tinyurl.com/r-boot-attend

#
# 2) Make sure you have downloaded and saved the following three files: 
     # (i) The *NEW* COVID attitudes data 
     # (ii) the penguins data (titled "penguins.csv") *** we will use this for the warmup ***
     # (iii) the cleaned penguins data (titled "penguins_cleaned.csv") 
             # Note that we are not using the cleaned penguins data right now, 
             # but we will be working with it later today
 
   # *Make sure all files are saved in the appropriate location*


# 3) Load the penguins data set (the document is titled "penguins.csv"). Name it penguins. 
      # Hint: if it's not working, check your working directory using the 
      # getwd() command. Is it where you want it to be located?
      # If not, set your working directory!


# 4) What is the mean body mass of the penguins (in grams)?



# 5) In addition to the functions we've already learned, there's another function for summarizing data that I really like! It is the describe() function and is part of the psych package. Let's try it out!
  
  #5b) Install and load the psych package
  
  #5b) Run describe(penguins$body_mass_g). How is this different from the summary() function? How is it similar?



# 6) How many penguins were measured in each year?


# 7) Load the tidyverse package to be prepared for class today!



#### Introduction to Tidy Data #### *******************************************

#### Our goal for our tidy data frame ####

# We want a data frame that:
# 1) Only has columns for the variables penguin, species, island, bill_length_mm, bill_depth_mm, sex, year
# 2) Only has the observations for the year 2008
# 3) Remove penguins from the data frame that have NAs for any cells
# 4) Make a new variable called "bill_sum" that is the sum of bill_length and bill_depth
# 5) Make species into a factor
# 6) Rename the levels of the variable sex from "female" to "f" and "male" to "m"


# This is what we want our data to look like after we do these processing steps:
penguins_endResult <- read.csv("penguins_cleaned.csv")
View(penguins_endResult)


#### Select ####
# Select only our columns of interest: penguin, species, island, bill_length_mm,
# bill_depth_mm, sex, year
# We remove flipper_length_mm and body_mass_g



## Or, if you just want to remove columns, you can just do this:



## ^^ These two ways will get you the same resulting data frame
## This is a change to the columns!


# Learn more functionality of select() here: 
# https://dplyr.tidyverse.org/reference/select.html
# You can even use select to rename columns!


#### Filter ####


## Can also think about this as "subsetting" the data to get just some of the observations.
## This is a change to the rows! Only keeping rows that meet a certain criteria,
## in this case, we are only keeping observations (rows) that are part of the group that was measured in 2008


# Learn more functionality of filter here: 
# https://dplyr.tidyverse.org/reference/filter.html


# There are a lot more ways you can use filter! For more information about all
# the logical operators you can use in filter, see:
# https://www.tutorialspoint.com/r/r_operators.htm, the Relational and Logical
# Operators sections
## == equals, != not equals
## > greater than, >= greater than or equal to
## < less than, <= less than or equal to
## <=
## & AND
## | OR



#### Making our new dataframe ####
# We can actually do these two steps in the same call using pipes (%>%)! 
# We can actually do all five steps in the same call! 
# Now we will add on to do the rest of the steps





#### Save a separate CSV file with our cleaned data frame ####



#### Independent Practice #### ************************************************

## 1) Load the NEW covid attitudes data. Name this data frame covid_attitudes


## If you can, try to do all the ones below as a single call (e.g., only creating one new data frame)

  # 2) Remove the variable Q6.consent
  
  # 3) Only keep observations from large cities
  
  # 4) Drop NAs

  # 5) Add a new variable called "apprehension_score" that is a composite score of Q18, Q20, and Q21 (e.g., is an average of these three values)

  # 6) Recode the levels of a variable that has TRUE and FALSE to 1 for TRUE and
      # 0 for FALSE, and make this variable into a factor
      # Since the values of this column are TRUE and FALSE, you can use them
      # directly in the case_when!


  # 7) We want to recode data from one of the likert scales! We want to convert Q9.covid_knowledge into numeric responses "Nothing at all" should be 1, "A little" should be 2, "A moderate amount" should be 3, and "A lot" should be 4. Save this as a new column titled Q9.covid_knowledge_num 


         


## 8) Save your data frame:

# Hint: Your code should look something like this: write.csv(your_df, file ="add-your-file-name-here.csv", row.names=FALSE)






#### Challenge questions -- if you have extra time  #### *******************

  # 1) Remove the variable Q6.consent
  
  # 2) Keep observations from large cities OR suburbs (Hint: think back to the logical operators we learned earlier today....)


#### Bonus -- Summary Statistics  #### ****************************************

#We can use summarise() to get summary statistics for our variables. 

# Run the following code to see how it works: 
  
  attitudes_summary <- covid_attitudes_cleaned %>%
  summarise(mean(attitudes_score))

#Try this yourself but now get the standard deviation instead of the mean 
#(hint: you can use ?summarise if you're stuck, and/or look up how to do standard deviation in R). 
  


#Now let's look at the average apprehension score for each age group using another powerful tidyverse command: group_by(). Run the following code: 
  
    attitudes_summary <- covid_attitudes_cleaned %>%
    # group by age
    group_by(Q40.age) %>%
    # get mean apprehension score for each age group
    summarise(apprehension_mean=mean(apprehension_score))%>%
    # it's important to ungroup!
    ungroup()

#i) View the new attitudes_summary variable. What did it give you? 

    
#ii) Try grouping by another variable of interest (or more than one). 
     # Don't forget to ungroup() after you're done ! 
  

# Note: Grouping doesn't alter your data frame, it just changes how it's listed and how it interacts with the other commands. 

# Check out the tidy cheat sheet for more tidyverse and data wrangling functionality! https://www.rstudio.com/wp-content/uploads/2015/02/data-wrangling-cheatsheet.pdf





