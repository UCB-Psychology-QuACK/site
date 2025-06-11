# Session 4 - Data visualization with ggplot
# Emily Rosenthal & Sierra Semko Krouse
# July 11, 2024

# **************************************************************
#### SET UP #### 
options(stringsAsFactors=FALSE)

#### WARM UP #### 

## 1. Sign in! Go to: https://tinyurl.com/bootcamp-session4-signin 


## 2. Load the tidyverse and the psych packages


## 3. Load in penguins dataset and View your data


## 4. Use tidyverse commands to do the following data processing steps (use pipes to connect your commands).
    ### 4a. Remove two columns: "body_mass_g" and "flipper_length_mm".
    
    ### 4b. Remove NAs from the dataset
    
    ### 4c. Let's say the researchers made a mistake! Those are actually Great penguins, not Gentoo penguins (oh no!). Make a new variable called species2, where those who have a species of Gentoo are fixed and are "Great", and the other types of species stay the same (Adelie is still Adelie and Chinstrap is still Chinstrap).


## 5. Using the describe() function, look at the variable bill_length_mm. 


# **************************************************************

#### DATA VISUALIZATION DEMO ####

# This website has some helpful info about plotting with ggplot: https://datacarpentry.org/R-ecology-lesson/04-visualization-ggplot2.html  

# ggplot cheat sheet: https://www.maths.usyd.edu.au/u/UG/SM/STAT3022/r/current/Misc/data-visualization-2.1.pdf  

# R-graph gallery: Help choosing and creating types of plots (NOTE: only use the ggplot section on each page) https://www.r-graph-gallery.com/index.html  


#-----------------------------------------------------------------------#
##### Plot 1: Let's look at the distribution of bill_length_mm with a histogram #####


# 1a. Set up our ggplot


# 1b. Add our histogram object 


#-----------------------------------------------------------------------#
##### Plot 2: Let's compare the bill length of each penguin species using a barplot #####


# 2a. Set up our ggplot

  
# 2b. Add a column object


# Notice that the species are ordered alphabetically. We could change this by creating an ordered factor:
# e.g., factor(species, levels = c("Chinstrap", "Adelie", "Gentoo"))

 
## Bar charts aren't the best way to look at data because it doesn't tell us much about individual data points or the distribution of data. 
 

#-----------------------------------------------------------------------#
##### Plot 3: Let's compare the bill length of each penguin species using some other kinds of plots #####


# 3a. Let's try a box plot. .................................................

  # i. Set up our ggplot

  
  # ii. add a box object 

  
## This gives us some more descriptive stats about the data but we still don't have a good feel for what the distribution of the data points look like.

 
# 3b. Lets use a violin plot to visualize the data. ...........................

  # i. Set up our ggplot


        ## Note that "fill" changes the color of the fill
        ## "color" changes the color of the *outline*
      
  # ii. Add a violin object

      
  # iii. Let's say we want separate plots for each sex...

      
  # iv. Maybe we want a boxplot on top... 

      
## A violin plot immediately gives us an idea of the shape of our data. We also see that while the bill length of males and females may be similar though the distributions can be quite different.

# 3c. Now that we are happy with our plot choice, lets customize it further.... (copy and paste 3b parts i-iv)

  
  # v. Change axis labels

  
  # vi. Set title 

  
  # vii. Change the y axis scale to start at 25 and end at 65

  
  # viii. Change the color scheme. There are a few ways to do this 
    # (Only select one and leave the others as comments!)
  
    ## Some color names are built in
        # scale_fill_manual(values = c("gray", "midnightblue", "dodgerblue1")) +
      
    ## We can give it hex values
        # scale_fill_manual(values = c("#999999", "#E69F00", "#26A2C6")) +
  
    ## We can use color palettes
         # scale_fill_brewer(palette = "Dark2") +
  
  # ix. change the overall theme


# In case of interest, this website lists a TON of the color names that R has built in: http://www.stat.columbia.edu/~tzheng/files/Rcolor.pdf  
  

#-----------------------------------------------------------------------#
##### Plot 4. Now lets look at the relationship between bill length and bill depth for each species #####
    
    
# 4a.

  # i. Set up our ggplot

 
  # ii. Add a scatter plot

    
  # iii. Add a regression line
    

# 4b. Overall, there appears to be a negative relationship between bill length and bill depth, and this is true for males and females. BUT, could there be something we aren't looking at or capturing? What if we break it up by species?   

  # i. Set up our ggplot


  # ii. Add a scatter plot

    
  # iii. Add a regression line

    
  # iv. Split by species

    
## This gives us an idea of the relationship between these two variables for each species

  
# **************************************************************  
#### ACTIVITY ####
## See PDF for details! 





