#### Functions: Practice questions - Key ####

## load libraries and data we will need
library(tidyverse)
happiness <- read.csv('../data/world-happiness_2020.csv')

## 1. Write your own sum function

calc_sum <- function(list){
# Calculates the sum of a sequence of numbers
# ARGUMENTS: 
# list = a vector of type "num" to sum. 
# RETURNS: 
# the sum of the list
sum <- 0 
for (num in 1:length(list)){
  sum = sum + list[num]
}
return(sum)
}

# test our function 
# simple integers
list1 <- c(1, 4, 5) 
test_1 <- calc_sum(list1)

# negative integers
list2 <- c(-1, -4, 0)
test_2 <- calc_sum(list2)

# List of different link and decimals
list3<- c(1.5, 2.8, 3, 4.77, 5.66)
test_3<- calc_sum(list3)


## 2. Make the following violin plot from the happiness data

plot_data <- function(happiness_metric) {
# A function to generate a violin plot showing the relationship between ladder_score_cat and continuous happiness measures. 
# ARUGMENTS: 
# happiness metric: The name of a variable for the y-axis of type STRING. 
# RETURNS:
# plot showing the relationship between ladder score and measure of interest. 
p <- ggplot(happiness, aes(x = ladder_score_cat, y = get(happiness_metric), 
                           fill = ladder_score_cat )) + 
  geom_violin() + 
  geom_boxplot(width = 0.1) + 
  theme_classic()

return(p)
} 

# Generate plots
plot_data("Healthy_life_expectancy")
plot_data("Logged_GDP_per_capita")
plot_data("Freedom_to_make_life_choices")
plot_data("Generosity")

## 4. Plot continuous data (including additional customizations from Q5)
plot_data_cont <- function(data, x_axis, y_axis,
                           set_xlab = x_axis,
                           set_ylab = y_axis,
                           set_se = TRUE, 
                           set_color = "dark red") {
# Plot two continuous variables from a dataframe.
# ARGUMENTS: 
# data: Name of dataframe as a STRING
# x_axis: data to map to x_axis as a string
# y_axis: data to map to y_axis as a string
# OPTIONS:
# set x/ylab: Allows the user to set the x and y axis labels. default is column name. 
# set_se: Allows user to set standard error around regression line. Default is TRUE. 
# set_color: Allow user to specify color of scatter plot points as a string. Default is red.
# RETURNS: 
# Scatter plot of data with a regression line. 
  
  p <- ggplot(get(data), aes(x = get(x_axis), y = get(y_axis))) + 
    # create a scatter plot
    geom_point(color = set_color) + 
    geom_smooth(method = 'lm', se = set_se) + 
    
    # set axis labels
    xlab(set_xlab) + 
    ylab(set_ylab) + 
    
    # set theme
    theme_classic()
  
  return(p)
} 

# test using defaults
plot_data_cont("happiness", "Perceptions_of_corruption", "Generosity")

# test using my own customizations
plot_data_cont("happiness", "Perceptions_of_corruption", "Generosity", 
               set_se=FALSE, 
               set_color = "dark gray")
