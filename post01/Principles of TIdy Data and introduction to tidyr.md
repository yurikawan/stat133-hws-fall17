---
title: "The principles of tidy data and introduction to tidyr"
author: "Kexin Wan"
date: "2017/10/29"
output: html_document
---

```{r eval=FALSE}
install.packages("tidyr")
```


##Introduction:

> For data scientists, almost 80% of the data analysis is spent on cleaning and     preparing data. 

  I am sure most of you have heard this quote, which sheds light to the importance of tidy data for later data analysis. However, though so far in this course we have learned how to organize a clean data set in spreadsheet, we haven't touched on the principles of tidy data in R and the usage of data tidying tools in R to clean messy data. Therefore, this post will focus on teaching how to tidy a raw, messy dataset in R. I divide this post into 2 parts. In the first part I would introduce the **principles of tidy data** (and also list examples of messy datas to show common symptons of messy datas) to establish the rules for cleaning messy data. In the second part I would introduce four **basic funtions in tidyr**, which is a package designed specifcally for data tidying, so that we can learn how to use data tidying tools to "clean up" the dataset. 
  
![](https://public.tableau.com/s/sites/default/files/media/data-cleaning-thumb2_20.jpg)
  


##Motivation

  Getting data organized is usually the first step towards efficient data analysis. In order to be able to handle real-world datasets, it's important for us to have a framework understanding of what defines tidy data and also how to obtain a tidy data. So far, most of the data used in our homework and lab are already processed and therefore tidy enough to analyze. However, when I try to do some individual data analysis project using real life datasets, I am soon daunted by its disorganization and messiness. After reading some papers, self-studying and practicing I am now able to prepare tidy data by myself. I think this is a really practical skill to possess if we are interested in data analyzing and hope to work in data-related fields in the future.
  
![](https://media-exp1.licdn.com/mpr/mpr/AAEAAQAAAAAAAAj3AAAAJGI1N2NmYzBjLWM0NmEtNDZkNi1hY2Y4LTA5NjJkMDMyOWE1MA.jpg)



##Background

  Tidy data is the data obtained as a result of a process called data tidying. It is one of the important cleaning processes during big data processing and is a recognized step in the practice of data science. The tidy data sets have structure and working with them are easy, they are easy to manipulate, model and visualize. Tidy data sets main concept is to arrange data in a way that each variable is a column and each observation is a row. [source](https://en.wikipedia.org/wiki/Tidy_data)
  
  Tidyr is new package designed by Hadley Wickham that makes it easy to tidy your data. Tidy data is data that is easy to work with: it is easy to munge (with dplyr), visualise (with ggplot2 or ggvis) and model (with hundreds of modelling packages in R). [source](https://blog.rstudio.com/2014/07/22/introducing-tidyr/) 

![Tidyr Cheatsheet](https://image.slidesharecdn.com/data-wrangling-cheatsheet-160705210122/95/data-wrangling-with-dplyr-and-tidyr-cheat-sheet-1-638.jpg?cb=1467752577)




##Content
* The principles of tidy data (and exmaples of messy dataset)
* Four important functions in tidyr helpful for obtaining a tidy data



##Part One -- Principles of Tidy Data and Messy Dataset Example

> Tidy dataset are all alike; every messy dataset is messy in its own way. 
  -- Hadley Wickham

   In this section I am first going to explain the principles that define tidy dataset, then I will present some examples of messy dataset and explains what principles do they violate.
   
###Principles of Tidy Data

  Before I introduce the three key principles of tidy data, there are three definitions for dataset we should understand.
  
  * Variable: A quantity, quality, or property that you can measure.
  * Observation: A set of values that display the relationship between variables. To be an observation, values need to be measured under similar conditions, usually measured on the same observational unit at the same time.
  * Value: The state of a variable you observe when you measure it.
  
  ![](http://garrettgman.github.io/images/tidy-4.png)
 
  A dataset is said to be tidy if it satisfies the following three principles.

  * Each observation in its own row
  * Each variable in its own column
  * Each value is in its own set
  
  To be more clear, here is an example that illustrates the three rules of tidy dataset.
  
  ![](http://garrettgman.github.io/images/tidy-1.png)
   
   It might seem like a tidy data is too obvious. However, in practice, raw data is rarely tidy and is much harder to work with. To illustrate this, let's consider some bad examples of messy datasets.
   
####Examples of Messy Datasets

#####Example One
    
Considering the following Tuberculosis incidence dataset, why it could not be considered as a tidy data?
 
```{r echo=FALSE}
tb <- read.csv(
  file = "http://stat405.had.co.nz/data/tb.csv",
  header = TRUE, 
  stringsAsFactors = FALSE
)
head(tb)
```

**Answer**: Except for iso2 and year, the rest of the columns headers are actually values of a lurking variable, in fact combination of two lurking variavles, gender and age.

#####Example Two

Considering the following Whether dataset, why it could not be considered as a tidy data?

```{r echo=FALSE}
weather <- read.delim(
 file = "http://stat405.had.co.nz/data/weather.txt",
 stringsAsFactors = FALSE
)
head(weather)
```

**Answer**: This dataset seems to have two problems. First, it has variables in the rows in the column element. Second, it has a variable d in the column header spread across multiple columns.

#####Example Three

Considering the following Whether dataset, why it could not be considered as a tidy data?
```{r echo=FALSE}
pew <- read.delim(
  file = "http://stat405.had.co.nz/data/pew.txt",
  header = TRUE,
  stringsAsFactors = FALSE,
  check.names = F
)
head(pew)
```

**Answer**: This dataset has column headers as values but not variable names.

#####Features of Messy Dataset

There are various features of messy data that one can observe in practice. Here I generalize some of the more commonly observed patterns to idenfify. 

* Column headers are values, not variable names
* Multiple variables are stored in one column
* Variables are stored in both rows and columns

Now we have finished talking about the principles of tidy dataset and some general patterns to identify messy datasets using examples. In the second part I am going to introduce specific funtions in tidyr that can help us deal with each corresponding problems in messy dataset.

###Part Two -- Introduction to tidyr
    
In this section I going to introduce 4 functions in tidyr, a package designed by Hadley Wickham that makes it easier to tidy the data following the three principles. These functions can help us deal with specific problems listed above to make our data set tidy.

    
####Function One -- Gather

* When to use: When column headers are values, not variable names.

* Description: Gather should be used when you have columns that are not variables and you want to collapse them into key-value pairs. The easiest way to visualize the effect of gather() is that it makes wide datasets long.

* Format: gather(data, key = "key", value = "value", ..., na.rm = FALSE,
  convert = FALSE, factor_key = FALSE)

* Example: I will use the third example in part one to show how to take multiple column and collapse them into key-value pairs. Notice that in this example the various column headers should be stored as values in the dataset.
  

```{r echo=FALSE}
library(tidyr)
```
```{r}
# Turning the pew dataset into a tidy dataset by using the gather function in tidyr
tidy_pew <- gather(pew, salary, number, -religion)
head(tidy_pew)
```


* Comment: Notice that salary becomes the name of the second column, which takes in all of the previous column name (except religion) as the new column values, acting as keys. While number becomes the name of the third column, which takes in all of the previous values corresponding to each column name, acting as values. After the key-value are paired up together, a new tidy data set is formed. Also notice that I add "-religion" in the end so that the religion column is not turned into value under the salary columns.

####Function Two -- Spread

* When to use: When Variables are stored in both rows and columns

* Description: Gather should be used when variables are stored in both rows and columns. The opposite of gather() is spread(), which takes key-values pairs and spreads them across multiple columns. This is useful when values in a column should actually be column names (i.e. variables). It can also make data more compact and easier to read. The easiest way to visualize the effect of spread() is that it makes long datasets wide. 

* Format: spread(data, key, value, fill = NA, convert = FALSE, drop = TRUE,
  sep = NULL)
  
* Example: To show how spread works, Let's use a data frame called animals. Notice that in this case variables (the type of pet) are also stored in the row as values. However, the values in the pet column should be variables rather than values. Therefore, we use the spread function to spread them across multiple columns.

```{r echo=FALSE}
animals <- data.frame(name=rep(c("Jake","Alice"),each=3),pet=rep(c("n_dogs","n_cats","n_birds"),2),value=c(1,0,1,1,2,0))
animals
```

  
```{r}
## Turning the animals dataset into a tidy dataset by using the spread function in tidyr
tidy_animals <- spread(animals,pet,value)
tidy_animals
```

* Comment: By using the spread function in tidyr, we succeed in turning all of pet variable to columns. Now there is no variable in row and is a tidy dataset.
  
####Function Three -- Separate
* When to use: When multiple variables are stored in one column

* Description:  Separate should be used when you have multiple variables stored in one column. The separate() function allows you to separate one column into multiple columns. Unless you tell it otherwise, it will attempt to separate on any character that is not a letter or number. You can also specify a specific separator using the sep argument.


* Format: separate(data, col, into, sep = "[^[:alnum:]]+", remove = TRUE,
  convert = FALSE, extra = "warn", fill = "warn", ...)
  
* Example: To show how to use it, let's use a data frame called treatments, which record the number and type of treatment given to each patient during a specific month.Notice that in the year_mo column, there are actually two variables stored in one column: the year and the month of the treatment, which makes it a messy dataset.
  
```{r echo=FALSE}
treatments <- data.frame(patient = rep(c("X","Y"),3), treatment = rep(c("A","B","C"),each=2),year_mo = rep(c(2010.1,2010.7,2014.12),each=2),times=c(1,4,2,5,3,6),stringsAsFactors = FALSE)
treatments
```

 
```{r}
# Turning the treatment dataset into a tidy dataset by using the separate function in tidyr
tidy_treatments <- separate(treatments,col=year_mo,into=c("Year", "Month"))
tidy_treatments
```

* Comment: By using the separate function in tidyr, we succeed in separating the column into two columns Year and Month, therefore only one variable is stored in each column. It's now a tidy dataset.

####Function Four -- Unite
* When to use: When multiple columns actually store the same variable.

* Description: The opposite of separate() is unite(), which takes multiple columns and pastes them together. By default, the contents of the columns will be separated by underscores in the new column, but this behavior can be altered via the sep argument.

* Format: unite(data, col, ..., sep = "_", remove = TRUE)
  
* Example: To show how to use it, let's use a dataframe called lipsticks, which record the color,col_type and brand of the lipstick for Jane and Audrey. Notice that in this example both color and col_type are describing the same variable -- color. Therefore, we can use unite to merge this columns together.

```{r echo=FALSE}
lipsticks <- data.frame(name=rep(c("Coco","Vivien"),each=3), color=rep(c("red","plum","pink"),2),col_type=c("deep","light","medium","medium","light","deep"), brand=c("Dior","Stila","Smashbox","Armani","YSL","CT"))
lipsticks
```

  
```{r}
# # Turning the lipstick dataset into a tidy dataset by using the unite function in tidyr
tidy_lipsticks <- unite(lipsticks,color,color,col_type,sep="_")
tidy_lipsticks
```

* Comment: By using the unite function in tidyr, we succeed in uniting two columns color and col_type and turn them into one column, representing only one variable. It's now a tidy dataset.


###Conclusion
Now we have finished talking about the principles of tidy data and the four most important functions in tidyr that can help us turn messy dataset into a tidy dataset.  There are actually more functions in tidyr that can be employed for cleaning our data. If you are interested in learning more about tidyr and tidy data, here are some useful resources for you.

[Comprehensive introduction of tidyr package](https://cran.r-project.org/web/packages/tidyr/tidyr.pdf)

[Principles of tidy data and tidyr PPT](https://lsru.github.io/tv_course/lecture05_tidyr.html)

[Johns Hopkins Tidy Data Course on Coursea](https://www.coursera.org/learn/data-cleaning/lecture/FfV6P/components-of-tidy-data)


###Take Home Message

![ ](https://static1.squarespace.com/static/52a751fce4b033709a8acae1/t/55a51e3ce4b0a77a7c05f80e/1436884542182/Take+Home+Message+logo.png)

After reading this post we should now learn:

A tidy data, which is a data that obeys the three principles, is really important for the convenience of later data analysis. Therefore, before we start to analyze the data, we should always check if a data is tidy first, if not, we can then use the four most common functions (or more) in tidyr to clean it up.

  
###References:

* [Data Tidying by Garrett Grolemund](http://garrettgman.github.io/tidying/)
* [RPubs Tidyr](https://rpubs.com/m_dev/tidyr-intro-and-demos)
* [Cran R Tidy Data](https://cran.r-project.org/web/packages/tidyr/vignettes/tidy-data.html)
* [Tidy Data by Hadley Wickham](http://vita.had.co.nz/papers/tidy-data.html)
* [Tidy Data Wikipedia](https://en.wikipedia.org/wiki/Tidy_data)
* [Principles of tidy data and tidyr PPT](https://lsru.github.io/tv_course/lecture05_tidyr.html)
* [Comprehensive introduction of tidyr package](https://cran.r-project.org/web/packages/tidyr/tidyr.pdf)
  