# Data visualization with ggplot
# Willa & Elena
# 9/28/21

############### #### Warm-up #### ##################

# From the practice questions last week:

# 0. Move the penguins_clean data from this weeks folder into the data folder.


# 1. Load in world-happiness_2020.csv (what we worked with last week) and the tidyverse library


# 2. Pick two variables and summarize them in a new data frame. Get the mean,
# median, and sd.



# 3. In another new data frame, get the mean, median, sd for your variables by
# region.




# 4. Do you feel like this information gives you a sense for how these variables are distributed? If not, what else do you want to know?


############### #### Data Viz demo #### ##################

#### Read in our data ####

penguins <- read.csv('../data/penguins_clean.csv')

#### Explore our data with some simple plots ####

## 1. how many observations of each species do we have? 

# Set up our ggplot and define our variables

  
# Map the data to a bar object
  

### Q. Is this a reasonable way to view this data? Why or Why not? 



## 2.  Use a bar chart to determine which species is heavier on average

# Set up our ggplot and define our variables



# Map the data to a bar object.


### Q: What does this give us? 



# Lets use "stat = summary" and "fun = mean" to plot the means



### Q: Are you happy with this plot? Why or Why not. 




## 3. Let's change the geometric representation of our data and use a boxplot. 

 

### Q. What other information might we want to see? 


## 4. Lets use a violin plot to visualize the data. Violin plots are a great way to visualize the distribution of your data. 

  # Create a ggplot object


  # Map the data to a  violin


  # stop the ends from being trimmed. 


  # Add a boxplot on top.


  # Make the violins blue


  # Instead let's color the plot by species


# Notice that the species are ordered alphabetically. Can you make species into a factor and order it Gentoo, Chinstrap, Adelie 


## 5. Now lets see if there are additional differences between sexes. 



## 6.Now that we are happy with our plot choice, lets customize it further.


  # change axis labels



  # change the y axis scale to start at 0 and end at 8000



  #  Lets change the overallcolor scheme by adding a new object to your plot     called scale_fill_manual(). There are a few ways to do this. CHOOSE ONE

      # i.Some color names are built in. Try running: scale_fill_manual(values =       c("blue", "red", "green"))
    

      # ii.We can give it hex values 
    
      # (scale_fill_manual(values=c ("#999999", "#E69F00"..)))


      # iii. We can use color palettes 
    
      #scale_fill_brewer(palette ="Dark2")


    # change the overall theme (We'll talk about customizing the teme more next   time. )


#### 7. What is the relationship between bill depth and body mass? ####

# set up the ggplot object 


# map the data to a geometric object (How should we represent this data?)


# Add a regression line


### Q.What is the directionality of the relationship? 

### Q. There are two groups. Try splitting it by sex. Does that explain the grouping? 

### Q. Create the same plot but split it by species. 


