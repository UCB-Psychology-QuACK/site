# Week 11 Key - Putting it together
# Elena Leib & Willa Voorhies


#### Load libraries and set options ####
library(tidyverse)
library(tidylog)

options(stringsAsFactors = FALSE)


#### Load data ####
wisc_raw <- read.csv("ARM_WISC-matrices_quack.csv")
wisc_key <- read.csv("WISC_Matrices_key.csv")


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
  filter(Progress == "100", Q_BallotBoxStuffing != 1) %>% # Could have also used Finished == "TRUE"
  
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
  mutate(condition = case_when(condition == "1" ~ "control",
                               condition == "2" ~ "exp"),
    across(.cols = c(contains("item"), pid, totalDuration), as.numeric),
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
  group_by(pid, grade, condition, totalDuration, Q.score) %>% 
  summarise(score = sum(accuracy),
            totalTrials = n()) %>% 
  ungroup()

write.csv(wisc_score, file = "wisc_part2-2.csv", row.names = FALSE)

# It looks like the score that Qualtrics calculated for us (Q.score) is off by
# one! Good thing that we recomputed it ourselves! We might want to look into
# why it is doing that. But for now, we can move onto plotting.