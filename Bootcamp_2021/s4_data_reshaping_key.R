
# Session 4 - BONUS:Data reshaping 
# Elena & Willa
# July 27, 2021

#### Data reshaping ####

# The way our data is now, we can't make a violin plot that compares body mass
# in 2007 to body mass in 2008!

# Why's that? It's because we have the data for each of those years in separate
# columns. However, we want to GROUP by year, like we did for sex. And right
# now, we don't have a variable (i.e., a column) that is good for grouping by year.

# The columns we have now, are good for an axis (e.g., y-axis in the previous
# plot, or for making a scatter plot comparing 2007 to 2008)

# So, in order to group by year in our violin plot, we need to 'reshape' the data
# This means that we need to change the way the rows and columns are so that we
# have a column that is good for grouping by year.
# In other words, we want to have a data frame that has a column that indicates
# year, and a column that is for body mass. So there will now be two rows per
# penguin: one row for 2007 and one row for 2008.


# This is what we want our data to look like
penguins_endResult <- read.csv("penguins_long.csv")

# How do we get there?
# We need to use a function called pivot_longer(), to pivot (i.e., reshape, rearrange) our data to be longer (i.e., have more rows)

penguins_long <- penguins_clean %>% 
  pivot_longer(cols = c(body_mass_g_2007, body_mass_g_2008),
               names_to = "year",
               names_prefix = "body_mass_g_",
               values_to = "body_mass_g")

## The function formerly known as "gather"


# We can "undo" what we just did, too! Using the sister function pivot_wider
penguins_wide <- penguins_long %>% 
  pivot_wider(names_from = year,
              values_from = body_mass_g,
              names_prefix = "body_mass_g_")

## The function formerly known as "spread"


#### Data vis cont. #### 
### Now lets make the plot comparing body mass between years. 

ggplot(penguins_long, aes(x = species, y = body_mass_g, fill = year)) + 
  geom_violin() + 
  
  # change axis labels
  labs(title = 'body mass by species across years', 
       x = "Species", 
       y = " Body mass (g)") + 
  
  # change the y axis scale to start at 0 
  ylim(0, 8000) +
  
  # change the color scheme
  scale_fill_brewer(palette="RdBu") + # use a color palette
  
  # change the overall theme
  theme_bw() 


ggplot(penguins_long, aes(x = species, y = body_mass_g, fill = sex)) + 
  geom_violin() + 
  
  # change axis labels
  labs(title = 'body mass by species across years', 
       x = "Species", 
       y = " Body mass (g)") + 
  
  # change the y axis scale to start at 0 
  ylim(0, 8000) +
  
  # change the color scheme
  scale_fill_brewer(palette="RdBu") + # use a color palette
  
  # change the overall theme
  theme_bw() +
  
  facet_wrap(~year)


ggplot(penguins_long, aes(x = species, y = body_mass_g, fill = year)) + 
  geom_violin() + 
  
  # change axis labels
  labs(title = 'body mass by species across years', 
       x = "Species", 
       y = " Body mass (g)") + 
  
  # change the y axis scale to start at 0 
  ylim(0, 8000) +
  
  # change the color scheme
  scale_fill_brewer(palette="RdBu") + # use a color palette
  
  # change the overall theme
  theme_bw() +
  
  facet_wrap(~sex)
