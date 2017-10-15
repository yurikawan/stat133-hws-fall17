# title: "make_teams_table"
# author: "Kexin Wan"
# description: a short description of what the script is about
# input(s): what are the inputs required by the script?
# output(s): what are the outputs created when running the script?

# Raw Data and Dictionaries

roster <- "https://raw.githubusercontent.com/ucb-stat133/stat133-fall-2017/master/data/nba2017-roster.csv"
destination <- "nba2017-roster.csv"
download.file(url=roster,destfile = destination)
roster <- read.csv("nba2017-roster.csv",stringsAsFactors=FALSE)

stats <- "https://raw.githubusercontent.com/ucb-stat133/stat133-fall-2017/master/data/nba2017-stats.csv"
download.file(url=stats,destfile = "nba2017-stats.csv")
stats <- read.csv("nba2017-stats.csv",stringsAsFactors = FALSE)

write.csv(stats, "/Users/user/Desktop/stat133/stat133-hws-fall17/hw03/data/nba2017-stats.csv", row.names=FALSE)
write.csv(roster, "/Users/user/Desktop/stat133/stat133-hws-fall17/hw03/data/nba2017-roster.csv", row.names=FALSE)

library(readr)
library(dplyr)
library(ggplot2)

# Adding new variables

stats1 <- mutate(stats, 
                 missed_fg=stats$field_goals_atts-field_goals_made,
                 missed_ft=stats$points1_atts-stats$points1_made,
                 points = 3*points3_made + 2*points2_made + points1_made,
                 rebounds=stats$def_rebounds+stats$off_rebounds
)
stats1

stats2 <- mutate(stats1,
                 efficiency = (points + rebounds + assists + steals + blocks - missed_fg - missed_ft -turnovers)/(games_played))
stats2

# Merging Tables
data <- merge(stats2,roster)
data


#Creating nba2017-teams.csv
teams <- data %>%
  group_by(team) %>%
  summarize(experience = sum(round(experience,2)),
            salary = sum(round(salary/1000000,2)),
            points3 = sum(points3_made),
            point2 = sum(points2_made),
            free_throws = sum(points1_made),
            points = sum(points),
            off_rebounds = sum(off_rebounds),
            def_rebounds = sum(def_rebounds),
            assists = sum(assists),
            steals = sum(steals),
            blocks = sum(blocks),
            turnovers = sum(turnovers),
            fouls = sum(fouls),
            efficiency = sum(efficiency)
            )

#Use sink() to send the R output
sink("/Users/user/Desktop/stat133/stat133-hws-fall17/hw03/data/teams-summary.txt")
summary(teams)
sink()

#Export the team tables to a csv file
write.csv(teams,"/Users/user/Desktop/stat133/stat133-hws-fall17/hw03/data/nba2017-teams.csv")

#Some graphics
pdf(file ="~/Desktop/stat133/stat133-hws-fall17/hw03/images/teams_star_plot.pdf")
stars(teams[,-1],labels = teams$team)
dev.off()

experience_salary <- ggplot(teams,aes(x=experience,y=salary)) + geom_point() + geom_label(aes(label = team))
ggsave("~/Desktop/stat133/stat133-hws-fall17/hw03/images/experience_salary.pdf",plot=experience_salary)
