# load libraries

library(tidyverse)
library(ggplot2)
library(dplyr)
library(gsheet)
library(tidytext)
library(wordcloud2)
library(sentimentr)
library(lubridate)

# 3. Read in your survey data by running the following:

survey <- gsheet::gsheet2tbl('https://docs.google.com/spreadsheets/d/1W9eGIihIHppys3LZe5FNbUuaIi_tfdscIq521lidRBU/edit?usp=sharing')

# 4. Take a look at the first few rows of the data. What is the unit of observation?

head(survey)

# 5. Create a variable named date_time in your survey data. This should be based on the Timestamp variable. Use the mdy_hms variable to created a “date-time” object.

survey<-survey%>%
  mutate(date_time = mdy_hms(Timestamp))

# 6. Create a visualization of the date_time variable.

ggplot(survey, aes(x=date_time)) + geom_histogram()

# 7. Create an object called sentiments by running the following:

sentiments <- get_sentiments('bing')

# 8. Explore the sentiments object. How many rows? How many columns? What is the unit of observation.

number_of_columns_in_sentiments = ncol(sentiments)

number_of_rows_in_sentiments = nrow(sentiments)

# 9. Create an object named words by running the following:

words <- survey %>%
  dplyr::select(first_name,
                feeling_num,
                feeling) %>%
  unnest_tokens(word, feeling)

# 11. Look up the help documentation for the function wordcloud2. What does it expect as the first argument of the function? 

# The 1st argument is data.

# 12. Create a dataframe named word_freq. This should be a dataframe which is conformant with the expectation of wordcloud2, showing how frequently each word appeared in our feelings.

 word_freq <- words %>%  group_by(word) %>%  tally()
 
 # 13. Make a word cloud.
 
 wordcloud2(word_freq, shape = 'star')
 
 # 14. Run the below to create an object named sw.
 
 sw <- read_csv('https://raw.githubusercontent.com/databrew/intro-to-data-science/main/data/stopwords.csv')
 
 # 15. What is the sw object all about? Explore it a bit.
 
 # It's all about small words. 
 
 # 16. Remove from word_freq any rows in which the word appears in sw.
 
 #removing words from word_freq that appears in sw.
 no_repeat <- word_freq %>% 
   filter(!word %in% sw$word)
 
 # 17. Make a new word cloud.
 
 wordcloud2(no_repeat, shape = 'star')
 
 # 18. Make an object with the top 10 words used only. Name this object top10.
 
 top10 <- head(words, 10)
 
 #19. Create a bar chart showing the number of times the top10 words were used.
 
 ggplot(top10, aes(x = word)) + geom_bar()
 
 # 20. Run the below to join word_freq with sentiments.
 
 fusion <- left_join(word_freq, sentiments)
 
 # 21. Now explore the data. What is going on?
 
 # Sentiments and word frequency are attributes of each word within the dataset.
 
 # 22. For the whole survey, were there more negative or positive sentiment words used?
 
 negative_sentiment <- fusion %>% 
 filter(sentiment == 'negative') %>% 
 summarise(count = n(), .groups = 'drop')
   
 positive_sentiment <- fusion %>% 
 filter(sentiment == 'positive') %>% 
 summarise(count = n(), .groups = 'drop')
 
 # 23. Create an object with the number of negative and positive words used for each person.
 
 # 24. In that object, create a new variabled named sentimentality, which is the number of positive words minus the number of negative words.
  
 # 25. Make a histogram of senitmentality
  
 # 26. Make a barplot of sentimentality.
  
 # 27. Create a wordcloud for the dream variable.
 
 