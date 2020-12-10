# Learning from cheat sheet -----------------------*-------*-----------------------

# loading required library
library(data.table)

# Create a data table from scratch
df <- data.table(a = c(1,2), b = c("A","B"))

# Convert a dataframe to data table
mtcars <- data.frame(mtcars)
mtdt <- copy(as.data.table(mtcars))
mtdt <- setDT(mtcars)

# Subset rows using i
mtdt[2:5,]
mtdt[hp>150,]
mtdt[is.na(mpg)]
mtdt[hp==180 | hp==175,]
mtdt[hp==180 & cyl==8,]
mtdt[hp %in% c(180,175),]
mtdt[!(hp %in% c(180,175)),]
mtdt[hp %like% '110',]
mtdt[hp %between% c(100,120),]

# column names of a dataset
colnames(mtdt)

# subset the data with only one column
mtdt[,c(2)]
mtdt[,.(hp,cyl)]

# Summarize
mtdt[,.(Mean_hp=mean(hp))]

# Compute columns
mtdt[,gear_carb:=gear+carb]
mtdt[cyl==4,gear_carb:=0]
mtdt[,':='(six_cyl = gear*carb, eight_cyl = gear/carb)]

# Delete columns
# mtdt[,eight_cyl:=NULL]
mtdt[,six_cyl:=NULL]

# Convert the data type of a column
mtdt = mtdt[,eight_cyl:=as.integer(eight_cyl)]

# Group according to by
mtdtsum1 <- mtdt[,.(AvgMPG = mean(mpg),AvgHp = mean(hp)),by=cyl]
mtdtsum2 <- mtdt[,AvgMPG:=mean(mpg),by=cyl] # wont't work

# Chaining
mtdtsum3 <- mtdt[,.(AvgMPG = mean(mpg)), by = cyl][,BreakInHalf:=AvgMPG/2]

# reorder
setorder(mtdtsum3,cyl,-AvgMPG)
setorder(mtdt,cyl,-mpg)

# Unique values
unique(mtdt,by=c('cyl'))
unique(mtdt,by=c('hp','cyl'))

# Rename Columns
setnames(mtdt,c('mpg','cyl'),c('MilePerG','Cylinders'))
setnames(mtdt,c('MilePerG','Cylinders'),c('mpg','cyl'))
