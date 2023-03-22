# Load necessary libraries ----
# Hint: use library()
library(readr)
library(dplyr)
library(ggplot2)

# Exercise ----

# The file shopping_data.csv contains purchases of several consumers,
# identified by the variable id.

# Your task is to complete the steps below with the data from the file.

# In short the tasks are
#
# 1. Load the data
# 2. Check the data
# 3. Preprocess and re-code the data
#   - Remove, add, change variables, if needed
#   - Make sure data are the right type (numerical, character, factor, etc.)
# 4. Answer questions about the data
#   - What are the most popular products (in terms of items sold)?
#   - What are the highest rated products?
#   - What product categories sell the most (in terms of revenue)?
#   - What is the mean and standard deviation of the total amount spent by
#     a shopper?
#   - What does the distribution of total amount spent look like?
#   - What does the distribution of item price look like for each category?
#   - Is there gender variation in the sales of some categories?



# Load the data ----
# Hint: look at either read.csv() or read_csv() (from readr package)

# file_url <- "http://tildeweb.au.dk/~au78495/shopping_data.csv"

file_url <- "shopping_data.csv"
shopping <- read_csv(file_url)

# Take a look at how the data is organised
# Hint: Use, e.g., head(), str(), dim(), nrow(), ncol() or use the viewer
head(shopping)


# How many shoppers are there?
# Hint: look at the function unique()

max(shopping$id) # Bad solution
# Better solution that does not assume numerical and contiguous id
length(unique(shopping$id))

# Check for problems and missing values ----
# Hint: see section 4.1.5 in the book
colSums(is.na(shopping))


# Re-code variables and add any new variables ----
# Make sure data are the right type
# Hint: see the type with str()
str(shopping$sex)

shopping$sex <- factor(shopping$sex)
shopping$category <- factor(shopping$category)
shopping$sub_category <- factor(shopping$sub_category)

levels(shopping$sex)

# The most popular products (in terms of items sold) ----
# Hint: look at the functions group_by() and summarise() in dplyr
popular_products <- shopping %>% 
  group_by(product) %>% 
  summarise(items_sold = n()) %>% 
  arrange(desc(items_sold)) %>% 
  head(n = 10)

# Could also be tail without desc() in arrange()

# the highest rated products ----
# Hint: very similar to above, but rating is always the same for a
# particular product

top_10_rated <- shopping %>% 
  group_by(product) %>% 
  summarise(rating = unique(rating)) %>% 
  arrange(desc(rating)) %>% 
  head(n = 10)

# Problem: because of ties, there may be more products with the same score.

# Better to make the cut-off at a specific value:
top_rated <- shopping %>% 
  group_by(product) %>% 
  summarise(rating = unique(rating)) %>% 
  arrange(desc(rating)) %>% 
  filter(rating >= 4.6)

# Product categories that sell the most (in terms of revenue) ----
# Hint: again very similar. Compute the sum of price within each category.


# Mean and std of spending ----
# Hint: Start by computing the spending for each individual shopper
# Hint: Then look at the functions mean() and std()


# distribution of total amount spent ----
# Hint: Use the ggplot2 function geom_density() or geom_histogram()
# Hint: The plot may become easier to read if you remove outliers
# Hint: You can remove outliers using filter() from dplyr
# Hint: Or you can limit the plot range using xlim() from ggplot2


# distribution of item price by category ----
# Hint: use geom_density()
# Hint: to plot more categories, use aes(..., fill = category)
# Hint: alternatively add facet_wrap(~category) at the end


#  Gender variation in the sales by categories ----
# Hint: Use number of products sold in each category
# Hint: look at the function table()
# Hint: Or make a plot like above, with sex instead of category

