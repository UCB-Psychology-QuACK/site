# Data visualization with ggplot
# Willa & Elena
# 9/28/21

############### #### Warm-up #### ##################
library(tidyverse)

# From the practice questions last week:

# 0. Move the penguins_clean data from this weeks folder into the data folder.


# 1. Load in world-happiness_2020.csv (what we worked with last week) and the tidyverse library

happiness <- read.csv("../data/world-happiness_2020.csv")

# 2. Pick two variables and summarize them in a new data frame. Get the mean,
# median, and sd.



summary1 <- happiness %>% 
  summarize(ladder.mean = mean(Ladder_score, na.rm = TRUE),
            ladder.med = median(Ladder_score, na.rm = TRUE),
            ladder.sd = sd(Ladder_score, na.rm = TRUE),
            gen.mean = mean(Generosity, na.rm = TRUE),
            gen.med = median(Generosity, na.rm = TRUE),
            gen.sd = sd(Generosity, na.rm = TRUE))


# 3. In another new data frame, get the mean, median, sd for your variables by
# region.

summary2 <- happiness %>% 
  group_by(Regional_indicator, ) %>% 
  summarize(ladder.mean = mean(Ladder_score, na.rm = TRUE),
            ladder.med = median(Ladder_score, na.rm = TRUE),
            ladder.sd = sd(Ladder_score, na.rm = TRUE),
            gen.mean = mean(Generosity, na.rm = TRUE),
            gen.med = median(Generosity, na.rm = TRUE),
            gen.sd = sd(Generosity, na.rm = TRUE)) %>% 
  ungroup()



# 4. Do you feel like this information gives you a sense for how these variables are distributed? If not, what else do you want to know?


############### #### Data Viz demo #### ##################

#### Read in our data ####

penguins <- read.csv('../data/penguins_clean.csv')

#### Explore our data with some simple plots ####

## 1. how many observations of each species do we have? 

# Set up our ggplot and define our variables
ggplot(penguins, aes(x = species)) + 
  
# Map the data to a bar object
  geom_bar(stat = "count")

### Q. Is this a reasonable way to view this data? Why or Why not? 
# Viewing frequency or proportion data as a bar is informative. You should be cautious using bar charts for other types of data representations. 

## 2.  Use a bar chart to determine which species is heavier on average

# Set up our ggplot and define our variables
ggplot(penguins, aes(x = species, y = body_mass_g)) + 
  
  # Map the data to a bar object
  geom_bar(stat = "identity") 
  
### Q: What does this give us? 

#A. by default geom_bar shows the "count" or sum of one variable. By using   "identity" as the stat we can override the default and see the sum of two variables. note this is a specific change to the geom_bar representation so we set this option within the geom_bar object. 


# Lets use "stat = summary" and "fun = mean" to plot the means

ggplot(penguins, aes(x = species, y = body_mass_g)) + 
  
  # Map the data to a bar object
  geom_bar(stat = "summary", 
           fun = "mean")
  # instead of representing the sum. We are asking it to give us a summary statistic. The function we would like it to use to summarize the data is the mean. 

### Q: Are you happy with this plot? Why or Why not. 

# A. his plot doesn't give us much more information than a summary table. We still don't know anything about the distribution of the data.

## 3. Let's change the geometric representation of our data and use a boxplot. 

ggplot(penguins, aes(x = species, y = body_mass_g)) + 
  
  # Map the data to a bar object
  geom_boxplot()


### Q. What other information might we want to see? 
# This gives us summary information about the shape of the data but its still useful to see the overall shape of the distribution.

## 4. Lets use a violin plot to visualize the data. Violin plots are a great way to visualize the distribution of your data. 

  # Create a ggplot object
ggplot(penguins, aes(x = species, y = body_mass_g, fill = species)) + 
 

  # Map the data to a  violin
  geom_violin( trim = FALSE) + 

  # stop the ends from being trimmed with the "trim" option. This is purely asthetic. 

  # Add a boxplot on top.
  geom_boxplot(width = 0.1)
  # set the width 

  # Make the violins blue
  ggplot(penguins, aes(x = species, y = body_mass_g, fill = species))+
  geom_violin( trim = FALSE, fill = "blue") + 
  geom_boxplot(width = 0.1)

  # Instead let's color the plot by species

ggplot(penguins, aes(x = species, y = body_mass_g, fill = species)) + 
  
  # Map the data to a  violin
  geom_violin( trim = FALSE) + 
  
  # Add a boxplot on top.
  geom_boxplot(width = 0.1)

# Notice that the species are ordered alphabetically. Can you make species into a factor and order it Gentoo, Chinstrap, Adelie 

penguins <- penguins %>% 
  mutate(species = factor(species, levels = c("Gentoo", "Chinstrap", "Adelie")))

  ## 5. Now lets see if there are additional differences between sexes. 
ggplot(penguins, aes(x = species, y = body_mass_g, fill = species)) + 
  
  # Map the data to a  violin
  geom_violin( trim = FALSE) + 
  
  # Add a boxplot on top.
  geom_boxplot(width = 0.1)+ 
  
  # separate plots by sex
  facet_wrap(~ sex)


## 6.Now that we are happy with our plot choice, lets customize it further.

ggplot(penguins, aes(x = species, y = body_mass_g, fill = species)) + 
  
  # Map the data to a  violin
  geom_violin( trim = FALSE) + 
  
  facet_wrap(~ sex) + 

  # change axis labels
  xlab("Species") + 
  ylab("Body mass (g)") + 
  
  # change the y axis scale to start at 0 and end at 8000
  ylim(0, 8000) + 
  
  
  #  Lets change the overallcolor scheme by adding a new object to your plot     called scale_fill_manual(). There are a few ways to do this. CHOOSE ONE

      # i.Some color names are built in. Try running: 
      # scale_fill_manual(values =       c("blue", "red", "green"))

      # ii.We can give it hex values 
    
      # (scale_fill_manual(values=c ("#999999", "#E69F00"..)))

      # iii. We can use color palettes 
    
      scale_fill_brewer(palette ="Dark2") + 


    # change the overall theme (We'll talk about customizing the teme more next time. )

    theme_classic()
  # You can look up other built in themes and try them out! 
  # eg. theme_bw()

#### 7. What is the relationship between bill depth and body mass? ####

# set up the ggplot object 
ggplot(penguins, aes(body_mass_g, bill_depth_mm)) + 

# map the data to a geometric object (How should we represent this data?)

geom_point() + 
  
# Add a regression line
geom_smooth(method = 'lm')

### Q.What is the directionality of the relationship? 

### Q. There are two groups. Try splitting it by sex. Does that explain the grouping? 

ggplot(penguins, aes(body_mass_g, bill_depth_mm, color = sex)) + 
  geom_point() + 
  geom_smooth(method = 'lm')  
  

### Q. Create the same plot but split it by species. 
  ggplot(penguins, aes(body_mass_g, bill_depth_mm, color = species)) + 
  geom_point() + 
  geom_smooth(method = 'lm')  
  
# This is called the simpsons paradox. Although the correlation was negative initially we could see it didn't really fit the data well. Based on this we were able to see that there were distinct groups and that they separated by species. When we separate by species we see that the correlation is actually positive! This is why it is so important to visualize your data before running analyses!
  
##################### Practice ####################################
  ## 1. Load in the Happiness data
  
  happiness <- read.csv('../data/world-happiness_2020.csv')
  
  ## 2. Create a violin plot relating happiness levels to social support. Use ladder_score_cat as the x-value and Social_support as the y-value.
  
  # create ggplot object and map variables
  ggplot(happiness, aes(ladder_score_cat, Social_support)) + 
    # violin plot
    geom_violin(trim = FALSE)
  
  ## 3. Is this relationship between social support and happiness the same for all country sizes? (hint: Remember the categorical country_size variable you created last time).
  
  ggplot(happiness, aes(ladder_score_cat, Social_support, fill = country_size)) + 
    # violin plot
    geom_violin(trim = FALSE)
  
  # Another option is to split by country size. 
  ggplot(happiness, aes(ladder_score_cat, Social_support)) + 
    # violin plot
    geom_violin(trim = FALSE) + 
    
    # split plot by country size
    facet_wrap(~ country_size)
  
  ## 4. Recreate a violin plot of happiness by country size.
  # make country size a factor and re-order the levels. 
  happiness <- happiness %>% 
    mutate(country_size = factor(country_size, 
                                 levels = c("small", "medium", "large")))
  
  # set up variables to plot
  plot = ggplot(happiness, aes(country_size, Ladder_score, 
                               fill = country_size )) + 
    
    # add a violin
    geom_violin(trim = FALSE) + 
    
    # add a boxplot
    geom_boxplot(width = 0.1) +
    
    # Change axis labels
    
    xlab("Country Size") + 
    ylab("Ladder Score") + 
    
    # Change background color
    
    theme_classic() 
  
  ## 5. customize the plot
  plot + 
    # change y-axis limits
    ylim(0 , 10) + 
    
    # Change the color scheme to a color of your choosing
    scale_fill_brewer(palette ="Dark2") +
    
    # remove the legend
    theme(legend.position = 'none')
  
  ## 6. Recreate the scatter plot
  ggplot(happiness, aes(Freedom_to_make_life_choices, Social_support )) + 
    
    # scatter plot
    geom_point(color = "dark green", shape = "diamond") + 
    geom_smooth(method = 'lm', color = 'dark green') + 
    
    # change axis labels
    
    xlab("Freedom to make life choices") + 
    ylab("Social Support") + 
    
    # set theme
    theme_classic()
  
  ## 6 ii) try se = FALSE
  ggplot(happiness, aes(Freedom_to_make_life_choices, Social_support )) + 
    
    # scatter plot
    geom_point(color = "dark green", shape = "diamond") + 
    geom_smooth(method = 'lm', color = 'dark green', se = FALSE) 
  # se = FALSE removes the standard error from the regression line. 
  
  

