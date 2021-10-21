# Data visualization with ggplot
# Willa & Elena
# 9/28/21
library(tidyverse)
library(tidylog)
############### #### Warm-up #### ##################

# From the practice questions last week:

# 1. Load in world-happiness_2020.csv (what we worked with last week)


# 2. Pick two variables and summarize them in a new data frame. Get the mean,
# median, and sd.


# 3. In another new data frame, get the mean, median, sd for these variables by
# region.



# 4. In a third new data frame, get the mean, median, sd for these variables by
# region and population category.


############### #### Data Viz demo #### ##################

#### Read in our data ####

penguins <- read.csv('../data/penguins_clean.csv')

#### Explore our data with some simple plots ####

## 1. Look at body mass by species

# Set up our ggplot and define our variables. 
# aes = asthetic mapping. This tells ggplot how to map your variables to the plot. 

 
  
# represent the data to a column object.
# geom = geometric object. It tells ggplot the geometric 
# representation to use for your data. 


# In this case, bar charts aren't the best way to look at data 
# because it doesn't tell us much about individual data points
#  or the distribution of data. 

## Let's change the geometric representation of our data and use a boxplot. 

 
  
  # represent the data to a boxplot object.


# This gives us some more descriptive stats about the data 
# but we still don't have a good feel for what the distribution 
# of the data points look like.


## Lets use a violin plot to visualize the data. 
## Violin plots are a great way to visualize the distribution of your data. 


  # Map the data to a violin plot. Options stop the ends from being trimmed. 
 
# Add a boxplot on top. Options make the boxplot small. 


# Notice that the species are ordered alphabetically. 
# We could change this by creating a factor. 
# (eg. factor(species, levels = c("Chinstrap", "Adelie", "Gentoo"))


## Now lets see if there are differences between species. 
# We can use "fill" as an additional aesthetic mapping. 
# Fill = filled in color
# Color = colored outline. 
# For some shapes (eg. lines, points) they only have a color attribute.
#  For other shapes (eg. boxes) they have both color and fill. 


  
  # We can further split the plot by sex

  
# Now that we are happy with our plot choice, lets customize it further
  
  ## change axis labels


  ## change the y axis scale to start at 2000 and end at 7000


  ## Change the color scheme. 
  # Color scales and palettes allow you to change the color scheme 
  # for  mapping variable, in this case, species. 
  # There are a few ways to do this. Choose ONE

  # i.Some color names are built in


  # or if you were using "color" instead of fill
 # scale_color_manual(values = c("dark gray", "dark orange", " dark     green"))


  ##ii.We can give it hex values 
  # scale_fill_manual(values=c ("#999999", "#E69F00"))
    

  ## iii. We can use color palettes 
  # scale_fill_brewer(palette ="Dark2") 


## change the overall theme
# Theme = overall look of the plot. Including, grid lines, font, font size, legend etc. 


  # Some themes are built in and you can apply them in one command




# You can also create your own custom theme and change any features of the plot using theme()



# NOTE. Above we used color to represent variables. We can also just change the color of individual objects for aesthetic reasons. To do this you can modify the color of a specific geom.  
  # eg.



## 6. Exploring continuous variables with scatter plots.  We can explore the relationships between two continuous values with scatter plots. 

# create a ggplot object with body mass and bill depth

# Set up our ggplot


  
  # Represent the data as points


  
  # Add a  line. Option method = 'lm' gives you a linear regression line. 





# There are two clear groups here. Given what we saw already about sex differences let's see if they group by sex?
# Note: we will use "color" instead of "fill" here 
# because geom_point() only has a "color" attribute. 




# There are sex differences but these don't explain the grouping. 
# Lets try grouping by species instead.




# We see that this split in the data is due to species and 


# by accounting for species the relationship between bill depth 
# and body mass becomes postive whereas before it was negative. 
# This shows the value of looking at your data before running analyses. 

