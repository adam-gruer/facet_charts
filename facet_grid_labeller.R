
library(tidyverse)
library(lubridate)
dates <- seq.Date(ymd('20161001'),ymd('20161031'), by = "day")
rnorm(length(dates))
a <- tibble(date=dates,
       day_of_week = wday(date, label = TRUE),
       week_number = week(date),
       week_start = floor_date(date,"week"),
       theatre_week = week_number %% 40,
       y = rnorm(length(dates)),
       x = rnorm(length(dates),1))

lookup <-  a %>% 
  group_by( week_start) %>%
  summarise( week_start_n = n()) %>%
  mutate(theatre_wk = paste("Theatre Week",
                            rep(1:4,
                                len = length(week_start)
                            )
  )) %>%
  select(1,3) 

theatre_week <- as.character(lookup$theatre_wk)
names(theatre_week) <- (lookup$week_start)


# 
# theatre_week <- c(
#   `2016-09-25` = "Theatre Week 1",
#   `2016-10-02` = "Theatre Week 2",
#   `2016-10-09` = "Theatre Week 3",
#   `2016-10-16` = "Theatre Week 4",
#   `2016-10-23` = "Theatre Week 1",
#   `2016-10-30` = "Theatre week 2"
# )

ggplot(a) +
  geom_point(aes(x,y)) +
  facet_grid(week_start~day_of_week,
            # labeller = labeller(week_start = function(x){
            #  substring(x,1,4)
            # })
            labeller = labeller(
                            week_start = theatre_week
                              ) 
             ) 


 