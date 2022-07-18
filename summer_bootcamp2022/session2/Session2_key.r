# R Bootcamp 2022 - Warm up Answers - Session 2
# 7/13/2022 
# Emily, Willa, and Elena


#### Warm-Up  --------------------------------------------------------------------
  ##Create three different vectors: 
    ## i. A  vector called "names" with three names
    
      names <- c("Sarah", "Robert", "Sally")
    
    ## ii. A vector named "ages" with three ages of college students
      ages <- c(18, 20, 21)
    
    
    ## iii. A vector called "year" with three years of college (e.g., Freshman, Sophomore, etc.)
      year <- c("freshman", "junior", "senior")
      year <- factor(year, levels = c("freshman", "sophomore", 
                                      "junior", "senior"))
    
          # Could do this in one step if you wanted to:
          # year <- factor(c("freshman", "junior", "senior"), levels = c("freshman", "sophomore", "junior", "senior"))
      
  ## Run the code and check that everything looks correct in the global environment.
      



#### Creating a data frame -----------------------------------------------------
      
students <- data.frame(names, ages, year)
      
View(students) # use this to see the full data frame in a new tab! 

      # Can also look at our data frame in the global environment
      # We see that each of our vectors became columns
      # And R is smart enough to make our column names the names of the vectors!
      

# We can examine each column using the '$'
# data frame name + $ + column name
# If we run these lines of code, we see that each column is a vector! 
      students$names
      students$ages
      students$year
      
## Normally, we don't create our own data frames by hand though because we have
## collected data that we have stored in a file that we want to read in to work
## with! So let's go ahead and do that now.
      
## But first, before we read in any data, we need to understand the structure of
## our file directory and understand where our R script "lives" (i.e., which
## folder it is in), where our data file lives, and where our R script is
## pointing to.
      

#### Packages in R -------------------------------------------------------------
      # We want to install the package tidyverse!
      # To install this package: 
      # A) Go to "Packages" in the bottom right pane of RStudio, then click "Install."
      #    Type "tidyverse" into the box and click "Install"
      # B) You can also type install.packages("tidyverse") into the console
      #You only need to install the package once!
      
      # Load the package
      library(tidyverse)  #You need to have this in your script if you want to use the package! 

      
#### Setting our working directory ----------------------------------------------------
      ## The working directory is the file folder that R is currently working from
      ## You can also think of it as the folder that R is pointing to
      ## R assumes that whatever the working directory is, that is where you want to
      ## read files from and write new files to
      
      # Command to check the working directory
           getwd() #this tells you where your working directory is currently set 
      # You can also see what the working directory is by looking at the bar below the
      # tabs that say "Console," "Terminal," and "Jobs" and above the console panel
      

      # If your data file is in your current working directory (which often means it
      # is in the same folder as the R script you are working with), you can just
      # write read.csv("name-of-file.csv"). You don't need to give R any other
      # "address" information from the file because R is already in the right place to
      # look for it!
      
      #Some ways to set your working directory: 
      
      # 1) [When R is closed] - Open your script from the file/library on your computer
      # 2) Point and click -- At the top of your screen, go to 
          #Session >> Set working directory >> Choose directory >> select a folder
      # 3) Use the setwd() function
          # You would put the absolute file path here. 
                  # For me, this would look like *EITHER*: 
                  #setwd("C:\\Users\\Emily\\Documents\\R_Bootcamp\\2022_Summer\\Session2")
                      # setwd("C:/Users/Emily/Documents/R_Bootcamp/2022_Summer/Session2")
                          # *** Note that if you have a PC, you either need 
                          # two dashes like \\ or one dash in the other direction / 
         # This will differ for each person - your file paths will be different than mine!
         # Using this absolute path is tricky if you ever change the names of your files. 
      
# ** Regardless of how you do it, just be careful and make sure you always know 
# where your R script is located, where your data file is located, and where the working directory is.** 
            
           
           
#### Loading covid_attitudes data ---------------------------------------------------------
   

      # In the file structure that I was using as an example in class, my data file
      # "lives" one level *above* my R script and current working directory. In other
      # words, I have a folder called 2022_Summer, which has sub-folders for each
      # session of this workshop. I keep my data files in the main folder since I will
      # be using them every session, and I keep my session-specific scripts in their
      # respective session folders.
      
      # My working directory was the session2 folder, where my R script lives
      # (whenever you open up a script **from it's location in your file folder**, 
      # RStudio will automatically set the script's folder location as the working 
      # directory! This is very handy!). 
      
      # I need to indicate to R to look at the folder one level higher 
      # in order to find my data file! (To extend the analogy we used in class, your 
      # script (where R looks automatically) is in a classroom, but your data file is
      # in the hallway). 
      
      
      # I indicate this to R by adding something to the beginning of the
      # name of my data file. I add "../", which says, "look one folder higher."
      # We recommend always using *RELATIVE* paths, so it is always
      # in reference to the folder in which your script is in! And when you share your
      # script, share all your files and folders, so that structure is maintained!
      # e.g., the 2022_Summer folder with all the files and sub-folders inside
      
      
#To read in my data: 
covid_attitudes <- read.csv("../covid_attitudes.csv")
          # I have now read in my csv file, and created a data frame called covid_attitudes
      
          # This should appear in my global environment! 
      
# NOTE: If my CSV file was saved in the same folder as my working directory, I would
#read it in with this code: covid_attitudes <- read.csv("covid_attitudes.csv")
      
    
#### Bonus/Extra -- Reading in SPSS (.sav) Data Files ----------------------------------
      
# Some labs have data files saved in SPSS, and they will appear in your folder as .sav files. 
# We didn't cover this during the recording, but this might be helpful for you if this applies to your lab! 
    # 1) install the haven package
    # 2) load the package!
              library(haven)
    # 3) make a data frame with your data!
              #data_frame_name<-read_sav("data_file_name.sav") 

      
#### Setting our options #### 
options(stringsAsFActors = FALSE) 
#older versions of R would automatically make columns with characters into factors, which is not what we want. 
#So, we're telling R not to make this assumption when it loads in data! 
      

#### Examining our Data  ----------------------------------------------------------
      
# Note: if you add a question mark before a command, R can provide some information about what it does 
#(look in the bottom right corner of your screen! 
# For instance, what do these do?: 
      ?ncol 
      ?nrow
      ?str
      ?summary
      
# Remember: if you want to call a specific vector (column) from your data frame, use the $ operator! 
      
# eg. covid_attitudes$Q74.education -- this calls the Q74.education column from our covid_attitudes data frame
      
  

### On your own: 
      
# *******************************************************************************

# (1) Use the summary() function to learn about the covid_attitudes dataframe. This should look like: summary(covid_attitudes). Now use the use the str() function in the same way. What do these do? What do you see? What types of data do we have in our data frame? 

str(covid_attitudes) ## str stands for "structure". This function gives you the structure of the data frame, which is similar to the information that the global environment gives you. It shows you all of the columns and what type they are. It also gives you a sample of the data in each column.

summary(covid_attitudes) ## When called on a data frame, gives you summary information for each column. 
  # For numeric columns, gives you mean, median, and quartile information
  # For character columns, does not give you much information, just the length and type
  # For factors, gives much more information: shows all the levels (i.e.,
  # sub-groups), and also how many observations are in each group 

# This data frame has variables that are integers, characters, numeric, and logical 


# ************************************************************************************
## (2) Use the ncol() function. How many columns in our data? 

ncol(covid_attitudes) # this function gives us the number of columns in the data frame
# 29 

#Note: if you check the output of your str() function or in the global environment, this is equal to the number of variables 


# ***********************************************************************************
## (3) Use the nrow() function. How many rows in our data? 
nrow(covid_attitudes) #number of rows in our data frame
# 1020


#Note: if you check the output of your str() function or in the global environment, this is equal to the number of obs. (which stands for observations)

# Note: This does not count the row with the col names, it knows that those are the names for the variables/columns
      

# ***********************************************************************************
## 4.1) Some of these columns should be factors! Lets turn the education column into a factor. Use the command factor(covid_attitudes$Q74.education).
covid_attitudes$Q74.education <- factor(covid_attitudes$Q74.education)
   
## 4.2) Pick some other column you think should be a factor and turn it into a factor.
covid_attitudes$Q8.covid.info <- factor(covid_attitudes$Q8.covid.info)


# ***********************************************************************************
## 5) Now use the summary(covid_attitudes$Q74.education) command  to run on summary on just the column with your new factor. 
## Does the description change from how it was before? What does it look like now? 
summary(covid_attitudes$Q74.education) 

# Before we made it a factor, the summary() function just told us that it was a character vector and had a length of 1020 (which is the number of observations)
      #Q74.education
      #Length:1020
      #Class :character
      #Mode :character

# Now that it is a factor, we can see more information! 
# We now see the levels and the number of observations (people) who reported each level of education (and NA)    
      #4 year degree        2 year degree        doctorate      highschool graduate 
      #   159                   76                  112                   91 
      #less than highschool   professional degree some college          NA's 
      #     7                   86                  301                  188 
     
 
# ************************************************************************************
## 6) Which columns have the most NAs? Use the summary() command to investigate!

# This depends on which you made into factors!       
# e.g., Q43 has 190 NAs! (it is a numeric variable, so will show NAs)
# Q84 has 188 NAs (but we only know this if we turned it into a factor!


# *************************************************************************************
## 7) What do you notice about how the NAs are represented in different columns? 
## In summary? When you View() it?
# I notice that for the numeric columns, the NAs are italicized and they come up as "NA's" in the summary.

# For the string columns, NA is represented as #N/A and show up as a level when
# made a factor, instead of ignored (like they are supposed to be)... this has
# to do with the formatting of the original data, and is not the best form for
# R. We will learn how to take care of this next week.


# *************************************************************************************
## 8) On average, how likely do people think they are to catch Covid-19?
## Hint: you first need to find the relevant column 
# To answer this question, we first have to find the relevant column: Q_18
# Then, use summary to find mean:
summary(covid_attitudes$Q18_likely_to_catch_covid)
# The mean is 42.16, so on average, people think they have a 42.16% chance of
# catching covid


# **************************************************************************************
## 9) How many types of living communities are there?
# To answer this question, we first have to find the relevant column: Q_84
# If you haven't already, need to turn it into a factor:
covid_attitudes$Q84.community <- factor(covid_attitudes$Q84.community)

# Then, use summary to find mean:
summary(covid_attitudes$Q84.community)

# 4 types of communities and NA:
#N/A      large city      rural area small city/town          suburb 
#188             150              66             260             356


# *************************************************************************************
## 10) If you have time: Think of another question you can ask and answer it!

# This differed for different people!
      
      

      
