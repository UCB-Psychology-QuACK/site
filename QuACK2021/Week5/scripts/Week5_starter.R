#  Data visualization with ggplot
# Willa & Elena
# 9/28/21

############### #### Warm-up #### ##################





############### #### Data Viz demo #### ##################

## Read in our data ##

penguins <- ('../data/penguins_clean.csv')

## Explore body mass in our dataset ##

## 1. Plot body mass for exach species 

# Set up our ggplot and define our variables


# Map the data to a column object.


# notice that the species are ordered alphabetically. We could change this by creating an ordered factor. (eg. factor(species, levels = c("Chinstrap", "Adelie", "Gentoo"))


## 2. Now lets see if there are differences between sexes 




# Bar charts aren't the best way to look at data because it doesn't tell us much about individual data points or the distribution of data. 


## Let's change the geometric representation of our data and use a boxplot. 



# This gives us some more descriptive stats about the data but we still don't have a good feel for what the distribution of the data points look like.

## Lets use a violin plot to visualize the data. 

# stop the ends from being trimmed. 

# Add a boxplot on top.


# A violin plot immediately gives us an idea of the shape of our data. We also see that while the mean mass of males and females may be similar the distributions can be quite different.

## Now that we are happy with our plot choice, lets customize it further.


# change axis labels


# change the y axis scale to start at 0 and end at 8000


# change the color scheme. There are a few ways to do this:

# i.Some color names are built in

# ii.We can give it hex values (scale_fill_manual(values=c("#999999", "#E69F00")))

# iii. We can use color palettes scale_fill_brewer(palette      ="Dark2")


# change the overall theme



#### Explore the relationship between body mass and bill depth  #### 

# create a ggplot object with our variables of interest


# Map the data to a geometric object


# Add a regression line


# There are two clear groups here. Given what we saw already about sex differences let's see if they group by sex?




# There are two clear groups here. Given what we saw already about sex differences let's see if they group by sex?


# Lets split the plot by sex using facet_wrap()

