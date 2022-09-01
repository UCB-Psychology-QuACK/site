#### Quack demo - using the console ####
## hot keys 
## cntl enter (PC)
## cmd enter (mac)

# write a number
5

# some math
5 + 4

# a string
 "hello"
 
##### Quack demo creating a chunk #####

#### Variables! ####
 
# sample size
n <- 100

# elena's favorite number
faveNum <- 5

faveNum + 4 

# Elena's name variable
name <- "Elena" 
name2 <- 'Willa'


# booleans
bool_t <- TRUE
bool_f <- FALSE



#### Vectors! ####
# "Collections" of data

names <- c("Elena", "Willa", "Roya", "Monica", "Lena")
numbers <- c(5, 6, 7, 8+7)

years <- c("freshman", "sophomore", "junior", "freshman", "senior")

years_factor <- factor(years)
levels(years_factor)

years_factor_fixed <- factor(years, levels = c("freshman", "sophomore", "junior", "senior"))
levels(years_factor_fixed)

df <- data.frame(names, years_factor_fixed)

# ctrl/cmd + shift + c to comment out!
# q1.type
# q1Type
# q1_type
