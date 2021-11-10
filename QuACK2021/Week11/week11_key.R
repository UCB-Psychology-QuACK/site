# Week 11 Key - Putting it together
# Elena Leib & Willa Voorhies


#### Load libraries and set options ####
library(tidyverse)
library(tidylog)

options(stringsAsFactors = FALSE)


#### Load data ####
wisc_raw <- read.csv("wisc_raw.csv")
wisc_key <- read.csv("wisc_key.csv")


#### PART 1 ####

# View data
str(wisc_raw)
# Everything is a character because the first two rows are trash! Ack that's
# annoying!


wisc_rowRM <- wisc_raw %>% 
  slice(-c(1, 2))
# Could also use indexing!
# wisc_rowRM <- wisc_raw[-c(1,2),]

str(wisc_rowRM)

# The trash rows are removed, by the types of all the columns are messed up,
# unfortunately. We are going to need to fix the types in order to use our data.

# (Honestly, the easiest thing to do may  be to delete the first two rows before
# you read the data into R! That's a possibility. BUT it makes it harder to keep
# track of what you've done, and you should never change your raw data file by
# hand! You could make a new data file with the rows removed to make it easier,
# and then make a note of this when your read your data in that you are reading
# in this changed file and not the raw data.)


# Now for the rest of part 1
# And going to include removing the first two rows in this same pipe
wisc_processed <- wisc_raw %>% 
  # Remove the first two "trash" rows
  slice(-c(1, 2)) %>% 
  
  # Keep only participants who finished 100% of the task
  # Note, I need to use "100" not 100 because all the column types are messed up!
  # * I checked Q_BallotBoxStuffing separately and there are none, but keeping
  # it in here to show that I checked. Might want to do this in two separate
  # steps if, for example, you need to report how many participants did not
  # finish the task.
  filter(Progress == "100", Q_BallotBoxStuffing != "1") %>% # Could have also used Finished == "TRUE"
  
  # Select only our columns of interest and rename them
  select(pid, grade, "condition" = cond, 
         "totalDuration" = Q_TotalDuration, "Q.score" = SC0,
         "item7" = Q12,
         "item8" = Q14,
         "item9" = Q16,
         "item10" = Q18,
         "item11" = Q20,
         "item12" = Q22,
         "item13" = Q24,
         "item14" = Q26,
         "item15" = Q28,
         "item16" = Q30,
         "item17" = Q32,
         "item18" = Q34,
         "item19" = Q36,
         "item20" = Q38,
         "item21" = Q40,
         "item22" = Q42,
         "item23" = Q44,
         "item24" = Q46,
         "item25" = Q48,
         "item26" = Q50,
         "item27" = Q52,
         "item28" = Q54,
         "item29" = Q56,
         "item30" = Q58,
         "item31" = Q60,
         "item32" = Q62,
         "item33" = Q64,
         "item34" = Q66,
         "item35" = Q68) %>% 
  
  # Make levels of condition meaningful! And fix the column types!!!!
  mutate(condition = case_when(condition == "0" ~ "control",
                               condition == "1" ~ "exp"),
    across(.cols = c(contains("item"), pid, totalDuration, Q.score), as.numeric),
    across(.cols = c(grade, condition), as.factor))




# Check your work! (You should be doing along the way as you build your pipe!
# After each additional step, run and check your work)
str(wisc_processed)


# How many students do we have in each grade? 
table(wisc_processed$grade)


# How many students are in each condition? 
table(wisc_processed$condition)

# How many students in each grade x condition pair?
with(wisc_processed, table(grade, condition))

write.csv(wisc_processed, file = "wisc_part1.csv", row.names = FALSE)

#### Part 2 ####
wisc_long <- wisc_processed %>% 
  
  # Pivot our data longer so we have one row per trial per participant
  pivot_longer(cols = contains("item"),
               names_to = "item",
               values_to = "response") %>% 
  
  # Remove the trials where response is NA (participants never saw those trials)
  drop_na(response) %>% 
  
  # Join in the response key
  left_join(wisc_key, by = "item") %>% 
  
  # Score the responses
  mutate(accuracy = case_when(response == answer ~ 1,
                              response != answer ~ 0))

write.csv(wisc_long, file = "wisc_part2-1.csv", row.names = FALSE)

# New data frame that has one row per participant and calculates their matrix score
wisc_score <- wisc_long %>% 
  # Only really need to group by pid, but grouping by the other columns will
  # keep them in the data frame for use!
  group_by(pid, grade, condition, totalDuration, Q.score) %>% 
  summarise(score = sum(accuracy),
            totalTrials = n()) %>% 
  ungroup()

write.csv(wisc_score, file = "wisc_part2-2.csv", row.names = FALSE)

# It looks like the score that Qualtrics calculated for us (Q.score) is off by
# one! Good thing that we recomputed it ourselves! We might want to look into
# why it is doing that. But for now, we can move onto plotting.

## First lets look at the general distributin of our measure of interest. 

# We can check this by looking at the score first
ggplot(wisc_score, aes(score, label = pid)) + 
  geom_histogram(bins = 15)

# in general our data has a good spread. But we see at least one participant has a score of zero. They may not be performing the task. 

# Let's look at the duration of the task to see if anything happened during the administration of the task 
ggplot(wisc_score, aes(totalDuration, label = pid)) + 
  geom_histogram() 

# Again we see that there is an notable outlier in task duration. This seems odd and we will probably want to remove this participant.  

# Before I remove them I want to see who the outliers are and where they fall relative to their group. 
ggplot(wisc_score, aes(grade, score , label = pid)) + 
  # plot by group. Boxplot will show outliers who fall outside 1.5 times the IQR.
  geom_boxplot() + 
  # Include text to identify the subjects.
  geom_text()
# We see there are two subjects with a score of zero. We may want to remove these participants  they are not doing the task

# Note: one of these participants is the one who has the very long duration so we will definitely remove them.  

ggplot(wisc_score, aes(grade, totalDuration , label = pid)) + 
  geom_boxplot() + 
  geom_text()

# Remove the two subjects with a score of 0. 
wisc_score <- wisc_score %>% 
  filter(pid != 61108  & 
           pid !=72613 )

# Check it worked. 
ggplot(wisc_score, aes(score, label = pid)) + 
  geom_histogram(bins = 15)
  

## Now we can move on to looking for group effects. We can make this a function so that we can use it again for other data. 

violin_plot <- function(df, x, y, z) {
  # A function to create violin plots. 
  # INPUTS: 
  # df <- a dataframe containing data for the plot.
  # x <- a string corresponding to column name of a grouping variable for x-axis
  # y <- a string corresponding to column name of a continuous variable for the y-axis. 
  # z <- a string corresponding to the column name of a second grouping variable. 
  # xaxis <- name of the xaxis as type string
  # yaxis <- name of the yaxis as type string
  #
  # RETURNS:
  # A vionlin plot. 
  
  p <- ggplot(df, aes(get(x), get(y), fill = get(z) )) + 
    # set violin plot
    geom_violin(trim = FALSE) + 
    
    # Add mean 
    
    stat_summary(fun = mean, geom = "point", size = 1, position = position_dodge(1)) +

  
    # set color scale
    scale_fill_manual(name = z, values = c("#FD7F00", "#0141CF")) + 

  
    # set  axis labels
    xlab(x) + 
    ylab(y) + 
    
    # Set theme
    theme_classic() 
  
      
  
  return (p)
  
}

# Plot 
violin_plot(wisc_score, 'grade', 'score', 'condition')


## Now lets see if this difference between conditions is a true difference or random variation. To do this, we can use the idea behind permutation testing where we shuffle our condition labels so that they are randomly assigned. 

# First, lets look at the mean difference in scores between control and experimental groups. We will collapse across grades here but feel free to try calculating this by group on your own! 

# get the mean score for each group
E.mean <- with(wisc_score, mean(wisc_score[condition == "exp",]$score))
C.mean <- with(wisc_score, mean(wisc_score[condition == "control",]$score))

# calculate the true mean difference. 
true_mean_diff <- E.mean - C.mean
  
# Now lets determine whether this mean difference is a true group difference.
# Let's create a new column randomly shuffled condition labels
wisc_score$condition_shuffled <- sample(wisc_score$condition)

# we can visualize the difference with our plot function. 
violin_plot(wisc_score, 'condition_shuffled', 'score', 'grade')

# Now this very different from our data,but lets shuffle the data many times to get a distribution of possible mean differences. 

# create an empty vector to store mean differences
reasoning.diffs <- c()

# peform this 1000 times
for(i in 1:1000) {

  # Randomly shuffle the sex column WITHOUT REPLACEMENT!
  wisc_score$condition_shuffled <- sample(wisc_score$condition)
  
  # Calculate the means for each group
  C.mean_shuffled <- with(wisc_score, 
                          mean(wisc_score[condition_shuffled=='exp', ]$score)) 
  E.mean_shuffled <- with(wisc_score, 
                          mean(wisc_score[condition_shuffled=='control', ]$score)) 
  # Calcualte the difference in the means and save it
  reasoning.diffs[i] <- (E.mean_shuffled - C.mean_shuffled)
}

# Lets plot our means and compare to the actual true mean difference. 
hist(reasoning.diffs, 
     xlim=c(-8, 8)) 
# inclue a line showing our true group difference. 
abline(v = true_mean_diff, col = "red", lwd = 3)

# Even without running any statistics it is already pretty clear that our difference is significant! 

