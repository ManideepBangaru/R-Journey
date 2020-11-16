rm(list=ls(all=T))

library(dplyr)

# Summarise cases
df <- mtcars

summarise(df,std = sd(mpg),diff_cyls = n_distinct(cyl))
