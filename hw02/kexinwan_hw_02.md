---
title: hw02-kexin-wan
author: "kexin wan"
date: "2017/9/29"
output: github_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

## R Markdown

This is an R Markdown document. Markdown is a simple formatting syntax for authoring HTML, PDF, and MS Word documents. For more details on using R Markdown see <http://rmarkdown.rstudio.com>.

When you click the **Knit** button a document will be generated that includes both content as well as the output of any embedded R code chunks within the document. You can embed an R code chunk like this:

```{r cars}
summary(cars)
```

## Including Plots

You can also embed plots, for example:

```{r pressure, echo=FALSE}
plot(pressure)
```

Note that the `echo = FALSE` parameter was added to the code chunk to prevent printing of the R code that generated the plot.
```{r eval=FALSE}
install.packages("readr")
install.packages("dplyr")
install.packages("ggplot2")
```

## 2. Import the data in R
```{r}
# Recall the read.csv() using the argument colClasses
dat1 <- read.csv("https://raw.githubusercontent.com/ucb-stat133/stat133-fall-2017/master/data/nba2017-player-statistics.csv",colClasses=c('Player'="character",'Team'="character","Experience"="character","Position"=factor(c("C","PF","PG","SF","SG")),"Salary"="double","Rank"="integer","Age"="integer","GP"="integer","GS"="integer","MIN"="integer","FGM"="integer","FGA"="integer","Points3"="integer","Points3_atts"="integer","Points2"="integer","Points2_atts"="integer","FTM"="integer","FTA"="integer","OREB"="integer","DREB"="integer","AST"="integer","STL"="integer"))

#Using str() to display its structure
str(dat1)

#Recall the read_csv() using the argument col_types
library(readr)
dat2 <- read_csv("https://raw.githubusercontent.com/ucb-stat133/stat133-fall-2017/master/data/nba2017-player-statistics.csv", col_types = list(Player = col_character(), Team=col_character(), Position = col_factor(c("C", "PF", "PG", "SF", "SG")),Experience=col_character(), Salary = col_double(),Rank=col_integer(),
Age=col_integer(),GP=col_integer(),GS=col_integer(),MIN=col_integer(),FGM=col_integer(),FGA=col_integer(),Points3=col_integer(),Points3_atts=col_integer(),Points2=col_integer(),Points2_atts=col_integer(),FTM=col_integer(),FTA=col_integer(),OREB=col_integer(),DREB=col_integer(),AST=col_integer(),STL=col_integer(),BLK=col_integer(),TO=col_integer()))

#Using str() to display its structure
str(dat2)
```

## 3.Right after importing the data
```{r}

#Processing on the column Experience and Converting the entire column to integers
library(dplyr)
Newexperience <- as.integer(replace(dat1$Experience,dat1$Experience == "R",0))
new_dat1 <- mutate(dat1,Experience=Newexperience)
new_dat1
```

## 4. Performance of Players
```{r}

# Add relevant variables to data frame
new_dat2 <- mutate(new_dat1, Missed_FG = FGA - FGM, Missed_FT = FTA - FTM, PTS = Points3*3 + Points2*2 +FTM, REB = OREB +DREB, MPG = MIN/GS)
new_dat2

# Add EFF to data frame 
new_dat3 <- mutate(new_dat2,EFF = (PTS + REB + AST +STL+BLK-Missed_FG-Missed_FT-TO)/GP)
new_dat3

#Compute Summary Statistics for EFF
summary <- summarise(new_dat3,Min=min(EFF),first_Qu=quantile(EFF,0.25),Median=median(EFF),Mean=mean(EFF),third_Qu=quantile(EFF,0.75),Max=max(EFF))
summary

#Histogram of Efficiency
hist_efficiency <- hist(new_dat3$EFF,main="Histogram of Efficiency",xlim=c(0,30),ylim=c(0,150),xlab="EFF",ylab="Frequency",col="grey")

#Display several values of top-10 players by EFF in decreasing order
arrange_dat <- slice(arrange(select(new_dat3,Player,Team,Salary,EFF),desc(EFF)),1:10)

#Provide the names of the players that have a negative EFF
negative_EFF <- select(filter(new_dat3,EFF < 0),Player)
negative_EFF

#Use the function cor() to compute the correlation coefficients between EFF and all the variables used in the EFF formula
correlation <- c(cor(new_dat3$PTS,new_dat3$EFF),cor(new_dat3$REB,new_dat3$EFF),cor(new_dat3$AST,new_dat3$EFF),cor(new_dat3$STL,new_dat3$EFF),cor(new_dat3$BLK,new_dat3$EFF),-cor(new_dat3$Missed_FG,new_dat3$EFF),-cor(new_dat3$Missed_FT,new_dat3$EFF),-cor(new_dat3$TO,new_dat3$EFF))
correlation

#Display the computed correlations in descending order
correlation_order <- sort(correlation,decreasing = TRUE)
correlation_order

#Create a barchart with the correlations in decreasing order
{barplot(correlation_order,space=0.5,main="Correlations between Player Stats and EFF",col=c("grey","grey","grey","grey","grey","coral","coral","coral"),names.arg = c("PTS","REB","STL","AST","BLK","Missed_FT","Missed_FG","TO"),cex.names=0.65)
abline(h=0)}
```

## 5. Efficiency and Salary
```{r}
# A scatterplot between Efficiency and Salary
library(ggplot2)
ggplot(data=new_dat3,aes(x=EFF,y=Salary)) + geom_point() +geom_smooth(method=loess)

# Linear correlation coefficient between EFF and Salary
cor(new_dat3$EFF,new_dat3$Salary)

# Select those players that have an MPG value of 20 or more minutes per game

new_MPG <- replace(new_dat3$MPG,new_dat3$MPG==Inf,0)
players2 <- mutate(new_dat3,MPG=new_MPG)
players2 <- filter(players2,MPG>=20)

# Create a scatterplot between Efficiency and Salary
ggplot(data=players2,aes(x=EFF,y=Salary)) + geom_point() + geom_smooth(method=loess)


# Compute the linear correlation coefficient between these variables
cor(players2$EFF,players2$Salary)
```

##6. Comments and Reflections

  * The use of various plotting function and how to import data from website
  * The markdown syntax is really easy
  * Yes. I need help in some syntaxes that are not covered in class through GSI      help during office hour
  * It took me for about 4 hours
  * The most time consuming part was trying to debug when you met an error           message and tried to make the plot look exactly the same as the one in the       homework by adding in other parameters.
  * How to use the read_csv function and how to turn a vector into a dataframe.
  * When you met a lot of syntax error but you don't know how to solve it
  * It is really exciting when you get the data visualization and use this 
    visualization to help you better understand the data.
