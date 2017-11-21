# Read in the CSV file with the raw scores
raw_scores <- read.csv(file="~/desktop/stat133/stat133-hws-fall17/hw04/data/rawdata/rawscores.csv")

# Sink the structure and summary statistics for each column
sink(file="~/desktop/stat133/stat133-hws-fall17/hw04/output/summary-rawscores.txt")
str(raw_scores)
nam <- colnames(raw_scores)
for (i in 1:16){
  print(nam[i])
  print(summary_stats(raw_scores[i]))
}
for(n in 1:16){
  print(nam[n])
  print_stats(summary_stats(raw_scores[n]))
}
sink()


# Write a for loop to replace all the NA to 0
for (num in 1:16){
  raw_scores[,num][is.na(raw_scores[,num])] <- 0
}

# Use rescale to rescale QZ1
raw_scores$QZ1 <- rescale100(raw_scores$QZ1,0,12)

# Use rescale to rescale QZ2
raw_scores$QZ2 <- rescale100(raw_scores$QZ2,0,18)

# Use rescale to rescale QZ3
raw_scores$QZ3 <- rescale100(raw_scores$QZ3,0,20)


# Use rescale to rescale QZ4
raw_scores$QZ4 <- rescale100(raw_scores$QZ4,0,20)

# Use rescale to add new variable EX1
raw_scores$Test1 <- rescale100(raw_scores$EX1,0,80)


# Use rescale to add new variable EX1
raw_scores$Test2 <- rescale100(raw_scores$EX2,0,90)

# Add a new variable Homework
raw_scores$Homework <- NA
one <- raw_scores$HW1
two <- raw_scores$HW2
three <- raw_scores$HW3

four <- raw_scores$HW4
five <- raw_scores$HW5

six <- raw_scores$HW6

seven <- raw_scores$HW7



eight <- raw_scores$HW8
nine <- raw_scores$HW9

for (i in 1:nrow(raw_scores)){
  raw_scores$Homework[i] <- score_homework(c(one[i],two[i],three[i],four[i],five[i],six[i],seven[i],eight[i],nine[i]))
}

# Add a new variable quiz
raw_scores$Quiz <- NA
quiz_1 <- raw_scores$QZ1

quiz_2 <- raw_scores$QZ2
quiz_3 <- raw_scores$QZ3
quiz_4 <- raw_scores$QZ4

 for (i in 1:nrow(raw_scores)){
  raw_scores$Quiz[i] <- score_quiz(c(quiz_1[i],quiz_2[i],quiz_3[i],quiz_4[i]))
}

# Add a new variable overall
raw_scores$lab <- NA
for (i in 1:nrow(raw_scores)){
  raw_scores$lab[i] <- score_lab(raw_scores$ATT[i])
}

raw_scores <- mutate(raw_scores,overall=0.1*lab + 0.3*Homework + 0.15 * Quiz + 0.2*Test1 + 0.25*Test2)

# Add a new variable grade
raw_scores$Grade <- NA
final_score <- function(x){
  if (x>=95){
    "A+"
  } else if(x>=90){
    "A"
  } else if(x>=88){
    "A-"
  } else if(x>=86){
    "B+"
  } else if(x>=82){
    "B"
  } else if(x>=79.5){
    "B-"
  } else if(x>=77.5){
    "C+"
  } else if(x>=70){
    "C"
  } else if(x>=60){
    "C-"
  } else if(x>=50){
    "D"
  } else if(x>=0){
    "F"
  }
}

for (i in 1:nrow(raw_scores)){
  raw_scores$Grade[i] <- final_score(raw_scores$overall[i])
}

as.factor(raw_scores$Grade)

#Sink separate scores using for loops
sink_scores <- c("lab","Homework","Quiz","Test1","Test2","overall")
for (i in sink_scores){
  sink(file = paste0("~/desktop/stat133/stat133-hws-fall17/hw04/output/", i, "_stats.txt"))
  column <- select(raw_scores,i)
  print(summary_stats(column))
  print(print_stats(summary_stats(column)))
  sink()
}

# Sink the structure of the cleaned data frame
sink(file="~/desktop/stat133/stat133-hws-fall17/hw04/output/summary-cleanscores.txt")


str(raw_scores)
sink()

# Export the clean data frame
write.csv(raw_scores,file="~/desktop/stat133/stat133-hws-fall17/hw04/data/cleandata/cleanscores.csv",sep=",")

