# load library

library(babynames)
library(tidyverse)

# load the database

bb_names <- babynames 

# 10) Create a histogram of the name Marie in 1982.

Marie_1982 <- bb_names %>% 
  filter(year > 1982) %>% 
  filter(name == 'Marie') %>% 
  filter(sex == 'F')
  
  ggplot(data = Marie_1982, aes(x = year, y = n)) + geom_line() 
 
# 11) Create a line plot for proportion of the name Joe, colored by sex. Make the lines a bit thicker and more transparent.
 
  Joe <- bb_names %>% 
    filter(name == 'Joe') 
    
  ggplot(Joe, aes(x = year, y = prop, color = sex)) + geom_line(alpha = 0.5, size = 2)
  
# 12) Add new x and y axis labels, as well as a chart title.
  
  ggplot(Joe, aes(x = year, y = prop, color = sex)) + geom_line(alpha = 0.5, size = 2) + labs(x = 'year', y = 'proportion of name', title = "Joe")
  
# 13) Create a bar chart of the 10 most popular female names in 2002.
 
  ten_most_popular_female_names_2002 <- bb_names %>%
    filter(year == 2002) %>% 
    filter(sex == 'F') %>% 
    arrange(desc(n)) %>% 
    head(10)
  
ggplot(ten_most_popular_female_names_2002, aes(x = name)) + geom_bar()
  
# 14) Make the bars transparent and filled with the color blue.

ggplot(ten_most_popular_female_names_2002, aes(x = name)) + geom_bar(alpha = 0.5, fill = 'blue')


# 15) Create a new data set called the_nineties that only contains years from the 1990s.

the_nineties <- bb_names %>%
  
filter(year >= 1990, year <= 1999)

 
# 16) Save this dataset to your repository (use write.csv()).

write_csv(the_nineties, file = 'bbnames_nineties.csv')
 
# 17) Add, commit, and push your files to GitHub.

