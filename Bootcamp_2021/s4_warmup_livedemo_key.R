# Session 4 - Data visualization with ggplot
# Willa & Elena
# July 27, 2021

#### Set up and load packages #### 
library(tidyverse)
options(stringsAsFactors=FALSE)

#### Warm-up  #### 

## 1. Load in penguins dataset and view your data. Anything diffefrent you notice about the observations this time? 
penguins <- read.csv('penguins.csv')

## 2 Use tidyverse commands to do the following data processing steps (use pipes to connect your commands). 
    # 2a. Remove three columns: "bill_length_mm", "bill_depth_mm", "flipper_length_mm".
    # 2b. Remove NAs from the dataset

penguins_clean <- penguins %>% 
  select(-bill_length_mm, -bill_depth_mm, -flipper_length_mm) %>% 
  drop_na()

#### End of Warm-up ####

#### Data Viz demo ####

### Plot 1 : Let's compare the body mass of each penguin species in 2007.

# 1a. Set up our ggplot
ggplot(data = penguins_clean, aes(x = species, y = body_mass_g_2007)) + 
  
 # add a column object
 geom_col() 
 #  notice that the species are ordered alphabetically. We could change this by creating an ordered factor
# eg. factor(species, levels = c("Chinstrap", "Adelie", "Gentoo"))


# 1b. Now lets separate the the plot by sex. 
# 
ggplot(data = penguins_clean, aes(x = species, y = body_mass_g_2007, fill = sex)) + 
  
  # add a column object
  geom_col(position = "dodge")


## Bar charts aren't the best way to look at data because it doesn't tell us much about individual data points or the distribution of data. 


# 1c. Let's use a box plot. 
ggplot(data = penguins_clean, aes(x = species, y = body_mass_g_2007, fill = sex)) + 
  
  # add a box object
  geom_boxplot()


## This gives us some more descriptive stats about the data but we still don't
## have a good feel for what the distribution of the data points look like.

# 1d. Lets use a violin plot to visualize the data. 
ggplot(data = penguins_clean, aes(x = species, y = body_mass_g_2007, fill = sex)) + 
  
  # add a box object
 geom_violin(trim = FALSE)
  
## A violin plot immediately gives us an idea of the shape of our data. We also
## see that while the mean mass of males and females may be similar the
## distributions can be quite different.

# 1e. Now that we are happy with our plot choice, lets customize it further.
ggplot(data = penguins_clean, aes(x = species, y = body_mass_g_2007, fill = sex)) + 
  
  # add a box object
  geom_violin(trim = FALSE) + 
  
  # change axis labels
labs(x = "Species", y = " Body mass in 2007 (g)") + 


  # change the y axis scale to start at 0 and end at 8000
 ylim(0, 8000) + 

  
  # change the color scheme. There are a few ways to do this (Only select one and comment out the others!)

  # i.Some color names are built in
 scale_fill_manual(values = c("gray", "yellow"))
  
  # ii.We can give it hex values
  scale_fill_manual(values=c("#999999", "#E69F00"))

  # iii, We can use color palettes
  scale_fill_brewer(palette = 1) + 
  
  # change the overall theme
  
  theme_classic()

#### Plot 2. Now lets look at the relationship between body mass in 2007 and 2008 
#### for each species

ggplot(penguins_clean, aes(x = body_mass_g_2007, y = body_mass_g_2008)) + 
  
  # add a scatter plot
  geom_point() + 
  
  # add a regression line
 geom_smooth(method = "lm") + 
  
  # split by species
  facet_wrap(~sex)

# This gives us an idea of the relationship between these two measures
# But what if we want to compare body mass between 2007 and 2008 for each species
# As we did for sex to see if there are differences in body mass between 2007 and 2008? 
# in this case we would need to rearrange our dataframe. 
# Elena will demo reshaping in a separate video. 







