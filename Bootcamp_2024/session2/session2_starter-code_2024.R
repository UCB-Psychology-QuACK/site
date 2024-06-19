# Week 2 - R Bootcamp Starter Code
# 6/20/2024
# Emily Rosenthal & Sierra Semko Krouse

### Make sure you sign in for session 2: https://tinyurl.com/signin-bootcamp-2 ###

#--------------------------------------------------------------#
#   Please note that we intend to do this during class today!  #
#                This is NOT A WARMUP!                         #
#--------------------------------------------------------------#

# I have a ton of comments and headings here. All of these extra dashes etc. don't serve a function per se, but I like them because they help me visually parse the sections of my data. Feel free to get rid of the extra dashes etc. if you find them distracting!

####---------------  Setting our options  ------------------####
options(stringsAsFActors = FALSE) 
# older versions of R would automatically make columns with
# characters (words)into factors. This is not what we want. 
# So, we're telling R not to make this assumption when loading data!


####----------------- Loading packages --------------------#### 
# Load the here, dplyr, and haven packages


####---------- Loading in our COVID attitudes data --------#### 


####---------- Examining our Data -------------------------#### 
  # Note: if you add a question mark before a command, 
  # R can provide some information about what it does 
  # (look in the bottom right corner of your screen! 
      # For instance, what do these do?: 
          ?ncol
          ?nrow
          ?str
          ?summary
    
# Remember: if you want to call a specific vector (column)
# from your data frame, use the $ operator! 
      ## eg. covid_attitudes$Q74.education


#------------------------------------------------------------------#-
####--------------------- On your own ---------------------------####
#------------------------------------------------------------------#-

# 1) summary() & str() ----------------------------------------##### 

  ## Use the summary() function to learn about the
  ## covid_attitudes dataframe. 
      ### This should look like: summary(covid_attitudes).

  ## Now use the use the str() function in the same way. 

  ## What do these do? What do you see? 
  ## What types of data do we have in our data frame?

#2) ncol()  -----------------------------------------------------#####
 
 ## Use the ncol() function. How many columns in our data?


#3) nrow() ------------------------------------------------------#####
 
 ## Use the nrow() function. How many rows in our data? 


#4) factor() ----------------------------------------------------####
#4.1)
  
## Some of these columns should be factors! 
  ## Lets turn the education column into a factor. 
  ## Use the command factor(covid_attitudes$Q74.education).
    
#4.2)  
 
 ## Pick some other column you think should be a factor and 
  ## turn it into a factor. 


#5) summary()------------------------------------------------------####
#5.1)
  
  ## Now use the summary(covid_attitudes$Q74.education) command
  ## to run on summary on just the column with your new factor.

  ## Does the description change from how it was before? 
  ## What does it look like now? 

#5.2) 
 
  ## Which columns have the most NAs? 
  ## Use the summary() command to investigate!

#6) NAs -------------------------------------------------------#####

  ## What do you notice about how the NAs are represented 
  ## in different columns? In summary? When you View()it?

#7)-------------------------------------------------------------#####
 
 ## On average, how likely do people think they are to catch Covid-19?
          ### Hint: you first need to find the relevant column 

#8)--------------------------------------------------------------#####

  ## How many types of living communities are there?

    
#9)--------------------------------------------------------------#####

    ##If you have time: Think of another question you can ask with your
    ## group and answer it!




