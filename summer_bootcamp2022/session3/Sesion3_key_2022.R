# R Bootcamp Session 3 - Starter Code ** WARMUP KEY**
# July 20, 2022
# Emily Rosenthal, Elena Leib & Willa Voorhies

#### Set options ####
options(stringsAsFactors = FALSE)


#### Warm-up #### *************************************************************

# 1) Please sign in! Go to: https://tinyurl.com/r-boot-attend

#............................................................................

# 2) Make sure you have downloaded and saved the following three files: 
# (i) The *NEW* COVID attitudes data 
# (ii) the penguins data (titled "penguins.csv") *** we will use this for the warmup ***
# (iii) the cleaned penguins data (titled "penguins_cleaned.csv") 
# Note that we are not using the cleaned penguins data right now, 
# but we will be working with it later today

# *Make sure all files are saved in the appropriate location*

#..........................................................................
# 3) Load the penguins data set (the document is titled "penguins.csv"). Name it penguins. 
# Hint: if it's not working, check your working directory using the 
# getwd() command. Is it where you want it to be located?
# If not, set your working directory!
penguins <- read.csv("penguins.csv")

#..........................................................................
# 4) What is the mean body mass of the penguins (in grams)?
summary(penguins$body_mass_g)
  # the mean body mass (in grams) is 4202

#..........................................................................
# 5) In addition to the functions we've already learned, there's another function for summarizing data that I really like! It is the describe() function and is part of the psych package. Let's try it out!

#5b) Install and load the psych package
#install.packages("psych")
library(psych)

#5b) Run describe(penguins$body_mass_g). How is this different from the summary() function? How is it similar?
describe(penguins$body_mass_g)
    # the describe() function from the psych package reports the n
    # (number of people with data on this variable) in addition to
    # the standard deviation, median, minimum, maximum, etc. 
    # Some of this information is provided by the summary() command. 
    # The mean body mass is 4201.75 (describe() rounds slightly differently 
    # than the summary() command)

#..........................................................................
# 6) How many penguins were measured in each year?
penguins$year <- factor(penguins$year)
summary(penguins$year)
  # 110 measured in 2007
  # 114 measured in 2008
  # 120 measured in 2009

#..........................................................................
# 7) Load the tidyverse package to be prepared for class today!
library(tidyverse)



#### Introduction to Tidy Data #### *******************************************

#### Our goal for our tidy data frame #### 

# We want a data frame that:
# 1) Only has columns for the variables penguin, species, island, bill_length_mm, bill_depth_mm, sex, year
# 2) Only has the observations for the year 2008
# 3) Remove penguins from the data frame that have NAs for any cells
# 4) Make a new variable called "bill_sum" that is the sum of bill_length and bill_depth
# 5) Make species into a factor
# 6) Rename the levels of the variable sex from "female" to "f" and "male" to "m"

View(penguins) #this is how the data is currently 

# This is what we want our data to look like after we do these processing steps:
penguins_endResult <- read.csv("penguins_cleaned.csv")
View(penguins_endResult)
  # If your data file is saved one level up from your working directory
  # remember to add "../" before the name of your data file

# ...........................................................................

#### Select #### 

# Select only our columns of interest: penguin, species, island, bill_length_mm,
# bill_depth_mm, sex, year

# We remove flipper_length_mm and body_mass_g
penguins_selected<- penguins %>% 
  select(penguin, species, island, bill_length_mm, bill_depth_mm, sex, year)

## Or, if you just want to remove columns, you can just do this:
penguins_selected2 <- penguins %>% 
  select(-flipper_length_mm, -body_mass_g)

## ^^ These two ways will get you the same resulting data frame
## This is a change to the columns!


# Learn more functionality of select() here: 
# https://dplyr.tidyverse.org/reference/select.html
# You can even use select to rename columns!


# ...........................................................................

#### Filter #### 

penguins_filtered <- penguins %>% 
  filter(year == 2008) 
# Notice we use a double equals sign for logic 

## Can also think about this as "subsetting" the data to get just some of the observations.
## This is a change to the rows! Only keeping rows that meet a certain criteria,
## in this case, we are only keeping observations (rows) that are part of the group that was measured in 2008


# Learn more functionality of filter here: 
# https://dplyr.tidyverse.org/reference/filter.html


# There are a lot more ways you can use filter! For more information about all
# the logical operators you can use in filter, see:
# https://www.tutorialspoint.com/r/r_operators.htm, the Relational and Logical
# Operators sections
## == equals
## != not equals
## > greater than, >= greater than or equal to
## < less than, <= less than or equal to
## & AND
## | OR

# Below is another example of how logic could be used with the filter () function: 

## If you wanted to create a data frame with all penguins from 2007 and 2008 
## but NOT those from 2009, here are two ways this might be done using logic: 

  ### penguins_filtered_no2009 <- penguins %>% filter(year == 2007 | year==2008)
    
      # I am telling R that I want to keep all penguins where the year is 2007
      # or the year is 2008.  This means that all penguins who are not 
      # from either 2007 or 2008 are excluded. 
      # This means those from 2009 are excluded.

  ### penguins_filtered_no2009.2 <- penguins %>% filter(year!=2009)

      # I am telling R to put in my new data frame all penguins where the year
      # is NOT 2009. 
      # Given the levels of "year", this means those from 2007 or 2008 are
      # included and those from 2009 are excluded. 

  ### These two produce the identical resulting data frames with penguins 
  ### only from 2008 and 2007. 


# ...........................................................................

#### Making our new dataframe #### 

# We can actually do these two steps in the same call using pipes (%>%)! 
# Now we will add on to do the rest of the steps

penguins_cleaned<- penguins %>% 
  
  # Select the columns we want
  select(species, island, bill_length_mm, bill_depth_mm, sex, year) %>% 
  
  # Only keep observations from 2008
  filter(year == 2008) %>%
  
  # Remove all rows with missing data
  drop_na() %>%
  
  # Make a new column called bill_sum that adds the two bill columns
    mutate(bill_sum=bill_length_mm+bill_depth_mm,
           
           # Make the variable species into a factor
           species=factor(species),
           
           # Change the values of the cells in the sex column
           sex_recoded=case_when(sex == "female" ~ "f",
                                 sex == "male" ~ "m"))


  ## BONUS: recoding NA's
      ### Sometimes you will load data sets, and NA's will be coded in different
      ### ways, such as -99 or "." 
      ### You can use mutate() and the na_if() command to recode these values into
      ### NAs to make sure R can recognize them. 

      ### THIS IS NOT THE CASE, but if the column body_mass_g had -99 for its 
      ### NA values, you could write your code something like this: 

      ### penguins.new2 <- penguins %>%
          ### mutate(body_mass_g.NA= na_if(body_mass_g, -99)) 
                ## body_mass_g is the variable we are looking at
                ## -99 is the values of this vector that will be replaced with NA in the new vector body_mass_g.NA

#...........................................................................

#### Save a separate CSV file with our cleaned data frame ####
write.csv(penguins_cleaned, file="penguins_cleaned.csv", row.names = FALSE)



#### Independent Practice #### ************************************************

# ...........................................................................

## 1) Load the NEW covid attitudes data. Name this data frame covid_attitudes.

# You may need to change the prefix on the file name to direct it to where your
# file is located in your folder system, if you'd like to run this code

covid_attitudes<-read.csv("../covid_attitudes.csv")


## If you can, try to do all the ones below as a single call (e.g., only creating one new data frame)

covid_attitudes_clean <- covid_attitudes %>% 
  
# 2) Remove the variable Q6.consent
select(-Q6.consent) %>% 
  
# 3) Only keep observations from large cities
filter(Q84.community == "large city") %>%
  
# 4) Drop NAs
drop_na() %>%
  
# 5) Add a new variable called "apprehension_score" that is a composite score of Q18, Q20, and Q21 (e.g., is an average of these three values)
  mutate(apprehension_score = rowMeans(across(c(Q18.likely_to_catch_covid,
                                                Q20.ability_to_protect_self,
                                                Q21.expected_symptom_severity
                                                ))),

        # the function rowMeans() finds the mean across multiple columns and            
        # within one row. You also need the across() function within that
        # and then c() (concatenate) to give it multiple columns to go across.

        # Alternatively, you could add together values from the three columns and divide
        # by three: 
        # apprehension_score = (Q18.likely_to_catch_covid + Q20.ability_to_protect_self + Q21.expected_symptom_severity)/ 3

# ...........................................................................

# 6) Recode the levels of a variable that has TRUE and FALSE to 1 for TRUE and
# 0 for FALSE, and make this variable into a factor

# Since the values of this column are TRUE and FALSE, you can use them
# directly in the case_when!
Q13_1.trust_doctor_news  = case_when(Q13.trust_doctor_news ~ 1,
                                           !Q13.trust_doctor_news  ~ 0),

    #You could also do this as we've done previously and write it out -- 
       ##      case_when(Q13.trust_doctor_news ==TRUE ~ 1, 
       ##             Q13.trust_doctor_news == FALSE  ~ 0) 
    # Notice that there are no quotes around TRUE or FALSE 
    # It is because these columns are logical, NOT characters!

# ...........................................................................

# 7) We want to recode data from one of the likert scales! We want to convert Q9.covid_knowledge into numeric responses "Nothing at all" should be 1, "A little" should be 2, "A moderate amount" should be 3, and "A lot" should be 4. Save this as a new column titled Q9.covid_knowledge_num 

# This one was a bit tricky. First, let's take a look at the levels of this variable. Run summary(factor(covid_attitudes$Q9.covid_knowledge)) in your console. 

# Notice that the spacing and capitalization is odd -- the responses are "A little" "A lot" "A moderateAmount" and "NothingAtAll". Be careful with this! How we write out these levels needs to be the same exact spacing/capitalization for R to recognize it!!

Q9.covid_knowledge_num = case_when(Q9.covid_knowledge == "NothingAtAll" ~ 1, 
                                       Q9.covid_knowledge == "A little" ~ 2, 
                                       Q9.covid_knowledge == "A moderateAmount" ~ 3, 
                                       Q9.covid_knowledge == "A lot" ~ 4))

                                     



# ...........................................................................

## 8) Save your data frame:

# Hint: Your code should look something like this: write.csv(your_df, file ="add-your-file-name-here.csv", row.names=FALSE)

write.csv(covid_attitudes_clean, "covid_attitudes_cleaned.csv", row.names = FALSE)




#### Challenge questions -- if you have extra time  #### *******************

covid_attitudes_challenge <- covid_attitudes %>% 
  # 1) Remove the variable Q6.consent
  select(-Q6.consent) %>% 
  
  # 2) Only keep obsersvations from large cities or suburbs
  filter(Q84.community == "large city" | Q84.community == "suburb")



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





