rm(list=ls())
library(tidyverse)
library(estimatr)
setwd("C:/Users/b3j3g/Desktop/Data Science/nba")


games = read_csv('games.csv') ##for stats
details = read_csv('games_details.csv')
players = read_csv('players.csv')
teams = read_csv('teams.csv')
full_records = read_csv("Team_Records.csv") ###for records

####hornets win plot, paul arrives in 05 season

hornets_games = games %>% 
  filter(HOME_TEAM_ID == "1610612740" | VISITOR_TEAM_ID == "1610612740")

hornets_games = hornets_games %>% 
  mutate(
    hornets_w = ifelse((HOME_TEAM_ID == "1610612740" & HOME_TEAM_WINS == 1)|(VISITOR_TEAM_ID == "1610612740" & HOME_TEAM_WINS == 0), 1, 0)
  )
##creating new variables
hornets_games = hornets_games %>% 
  select(GAME_DATE_EST, GAME_ID, HOME_TEAM_ID, VISITOR_TEAM_ID, SEASON, PTS_home, PTS_away, hornets_w) %>% 
  mutate(target_pts = ifelse(HOME_TEAM_ID == 1610612740, PTS_home, PTS_away)) %>% 
  filter(SEASON == 2005 | SEASON == 2006 | SEASON == 2007)


hornets_win_table = hornets_games %>% 
  filter(SEASON >= 2004 & SEASON <= 2007) %>% 
  group_by(SEASON) %>% 
  summarize(
    wins = sum(hornets_w)
  )

####need to stylize plot
hornets_win_plot = hornets_win_table %>% 
  ggplot(
    aes(x = SEASON, y = wins)
  )+
  geom_line()+
  geom_point(col = ifelse(hornets_win_table$SEASON == 2005|hornets_win_table$SEASON == 2006|hornets_win_table$SEASON == 2007|hornets_win_table$SEASON == 2008|hornets_win_table$SEASON == 2009|hornets_win_table$SEASON == 2010, 'turquoise3', 'black'),
                          size = ifelse(hornets_win_table$SEASON == 2005, 6, 3))+
  theme_bw()+
  labs(x = "Season", y = "Wins", title = "Hornets Outcomes (Regular and Post Season Wins)", subtitle = "Plot begins one season prior to Paul's arrival, his first season is enlarged")


####clips win plot, 2011, 2017
clips_games = games %>% 
  filter(HOME_TEAM_ID == "1610612746" | VISITOR_TEAM_ID == "1610612746")

clips_games = clips_games %>% 
  mutate(
    clips_w = ifelse((HOME_TEAM_ID == "1610612746" & HOME_TEAM_WINS == 1)|(VISITOR_TEAM_ID == "1610612746" & HOME_TEAM_WINS == 0), 1, 0)
  )
####creating new variables
clips_games = clips_games %>% 
  select(GAME_DATE_EST, GAME_ID, HOME_TEAM_ID, VISITOR_TEAM_ID, SEASON, PTS_home, PTS_away, clips_w) %>% 
  mutate(target_pts = ifelse(HOME_TEAM_ID == 1610612746, PTS_home, PTS_away)) %>% 
  filter(SEASON == 2011 | SEASON == 2012 | SEASON == 2013)

###table for plot
clips_win_table = clips_games %>% 
  filter(SEASON >= 2010 & SEASON <= 2013) %>% 
  group_by(SEASON) %>% 
  summarize(
    wins = sum(clips_w)
  )

####need to stylize plot
clips_win_plot = clips_win_table %>% 
  ggplot(
    aes(x = SEASON, y = wins)
  )+
  geom_line()+
  geom_point(col = ifelse(clips_win_table$SEASON == 2011|clips_win_table$SEASON == 2012|clips_win_table$SEASON == 2013|clips_win_table$SEASON == 2014|clips_win_table$SEASON == 2015|clips_win_table$SEASON == 2016, 'Blue', 'black'),
             size = ifelse(clips_win_table$SEASON == 2011, 6, 3))+
  theme_bw()+
  labs(x = "Season", y = 'Wins', title = "Clippers Outcomes (Regular and Post Season Wins)", subtitle = "Plot begins one season prior to Paul's arrival, his first season is enlarged")



######suns
suns_games = games %>% 
  filter(HOME_TEAM_ID == "1610612756" | VISITOR_TEAM_ID == "1610612756")

suns_games = suns_games %>% 
  mutate(
    suns_w = ifelse((HOME_TEAM_ID == "1610612756" & HOME_TEAM_WINS == 1)|(VISITOR_TEAM_ID == "1610612756" & HOME_TEAM_WINS == 0), 1, 0)
  )

suns_win_table = suns_games %>% 
  filter(SEASON >= 2017 & SEASON <= 2020) %>% 
  group_by(SEASON) %>% 
  summarize(
    wins = sum(suns_w)
  )

####need to stylize plot
suns_win_plot = suns_win_table %>% 
  ggplot(
    aes(x = SEASON, y = wins)
  )+
  geom_line()+
  geom_point(col = ifelse(suns_win_table$SEASON == 2020, 'orange', 'black'),
             size = ifelse(suns_win_table$SEASON == 2020, 6, 3))+
  theme_bw()




hornets_win_table
clips_win_table
suns_win_table



hornets_win_plot
clips_win_plot
suns_win_plot



########################################### general trends for success
## a team needs to score points to win
### lets use a random team like the 76ers to show this
### use whole data set, break up ppg by season to wins

#phila_home_games = games %>% 
 # filter(HOME_TEAM_ID == '1610612755')

#phila_ppg_table = phila_home_games %>% 
 # group_by(SEASON) %>%
  #summarize(N = n(),
   #         ppg = sum(PTS_home)/N,
    #        wins = sum(HOME_TEAM_WINS)
#  )
  
#phila_ppg_plot = phila_ppg_table %>% 
 # ggplot(
  #  aes(x = ppg, y = wins)
  #)+
  #geom_point()+
  #geom_smooth(method = lm)+
#  theme_bw()

####can also try using one season and grouping by teams

# = games %>% 
 # filter(SEASON == 2019 | SEASON == 2018 | SEASON == 2017)

#ppg_201719_table = games_201719 %>% 
 # group_by(VISITOR_TEAM_ID, SEASON) %>% 
#  summarize(N = n(),
 #           ppg = sum(PTS_away)/N,
  #          wins = N-sum(HOME_TEAM_WINS),
   #         apg = sum(AST_away)/N)

#ppg_201719_plot = ppg_201719_table %>%    ######do regression on this
 # ggplot(
  #  aes(x = ppg, y = wins)
  #)+
  #geom_point()+
  #geom_smooth(method = lm, se = F)+
  #theme_bw()+
  #labs(title = "PPG to Wins in Visiting Teams 2017-2019 Seasons")

##### apg to ppg

#apg_201719_plot = ppg_201719_table %>% 
 # ggplot(
  #  aes(x = apg, y = ppg)
  #)+                                        ########do regression on this
  #geom_point()+
  #geom_smooth(method = lm, se = F)+
  #theme_bw()+
  #labs(title  = "APG to PPG in visiting teams 2017-2019 Seasons")

#### apg to wins

#apg_win_plot = ppg_201719_table %>% 
 # ggplot(
  #  aes(x = apg, y = wins)
  #)+                                                 ######## not so great
  #geom_point()+
  #geom_smooth(method = lm, se = F)+
  #theme_bw()+
  #labs(title = "APG to Wins in Visiting Teams 2017-2019 Seasons")

##########
chris = details %>% 
  filter(PLAYER_NAME == "Chris Paul")

#######building data set of wins for every team, every year


####create variable for wins last season, had to use lead because seasons are in reverse order
added_records = full_records %>%
  select(Season, Team, W, L, `W/L%`) %>% 
  mutate(
    last_wins = lead(W)
  )

#use wins last season to predict wins this season
win_regression = lm_robust(W ~ last_wins, added_records)
#with each win from last season, this season wins go up by 0.59
#create graph where x is last season wins, y is this season, highlight clippers and hornets seasons
#highlight NOH 05-07, LAC 11-13


##singular data sets to highlight specific points
##does not allow for legend on graph
NOH_record1 = added_records %>% 
  filter(Season == "2005-06") %>% 
  filter(Team == "New Orleans/Oklahoma City Hornets")

NOH_record2 = added_records %>% 
  filter(Season == '2006-07') %>% 
  filter(Team == "New Orleans/Oklahoma City Hornets")

NOH_record3 = added_records %>% 
  filter(Season == '2007-08') %>% 
  filter(Team == "New Orleans Hornets*")

LAC_record11 = added_records %>% 
  filter(Season == '2011-12') %>% 
  filter(Team == "Los Angeles Clippers*")

LAC_record12 = added_records %>% 
  filter(Season == '2012-13') %>% 
  filter(Team == "Los Angeles Clippers*")

LAC_record13 = added_records %>% 
  filter(Season == "2013-14") %>% 
  filter(Team == "Los Angeles Clippers*")



win_plot = added_records %>% 
  ggplot(
    aes(x = last_wins, y = W, )
  )+
  geom_point(alpha = 0.1)+
  theme_bw()+
  labs(x = "Wins in Previous Season", y = "Wins Next Season")+
  geom_smooth(method = lm, se = FALSE)+
  geom_point(data = NOH_record1, color = "turquoise3", size = 4)+
  geom_point(data = NOH_record2, color = "turquoise3", size = 4)+
  geom_point(data = NOH_record3, color = "turquoise3", size = 4)+
  geom_point(data = LAC_record11, color = "blue", size = 4)+
  geom_point(data = LAC_record12, color = "blue", size = 4)+
  geom_point(data = LAC_record13, color = "blue", size = 4)+
  labs(subtitle = "Chris Paul's first three season on the Honets(turquoise) and the Clippers(blue)",
       title = "Comparing Season Outcomes to Previous Year")
#results: his team showed marginal improvement each year except one, and no regression
  
  




#estimate average ppg difference in games he plays
#create dataset for all games played by our 2 teams in each of their 3 target seasons

#have hornets games, creating variable for hornets points




##join datasets
combined = full_join(hornets_games, clips_games)




##need to add variable for if chris paul played
combined_chris = left_join(combined, chris)

combined_chris = combined_chris %>% 
  mutate(cp = ifelse(is.na(MIN), 0, 1))

combined_chris = combined_chris %>% 
  replace_na(list(MIN = 0, ast10 = 0, min25 = 0, pts18 = 0))


###create new variables
combined_chris = combined_chris %>% 
  mutate(ast10 = ifelse(AST >= 10, 1, 0)) %>% 
  mutate(min30 = ifelse(MIN >= 30, 1, 0)) %>% 
  mutate(min25 = ifelse(MIN >= 25, 1, 0)) %>% 
  mutate(pts18 = ifelse(PTS >= 18, 1, 0))


###take a look at means
combined_chris %>% 
  group_by(cp) %>% 
  summarize(avg_pts = mean(target_pts))

combined_chris %>% 
  filter(cp == 1) %>% 
  summarize(avg_ast = mean(AST),
            avg_min = mean(MIN),
            avg_pts = mean(PTS),
            avg_target = mean(target_pts))

###add target assists? do regression with other predictors, 
#such as 10+ assists and 30 mins per game

###begin regression
lm_robust(data = combined_chris, target_pts ~ cp)

lm_robust(data = combined_chris, target_pts ~ min25 + ast10 + pts18)

tab_cp = combined_chris %>%
  summarize(tidy(
    lm_robust(data = combined_chris, target_pts ~ min25 + ast10 + pts18)
  ))

tab_cp = tab_cp %>% 
  rename("Statline" = term,
         'Team PPG' = outcome)

####investigation into contributing factors
table1 = combined_chris %>% 
  group_by(pts18, ast10) %>% 
  summarize(mean_fgpct = mean(FG_PCT),
            mean_to = mean(TO),
            mean_ast = mean(AST),
            mean_pts = mean(PTS))

table2 = combined_chris %>% 
  group_by(SEASON, cp) %>% 
  summarize(avg_ast = mean(AST),
            avg_pts = mean(PTS),
            avg_fgpct = mean(FG_PCT))

table_avg = combined_chris %>% 
  summarize(mean(PTS, na.rm=T),
            mean(AST, na.rm=T),
            mean(FG_PCT, na.rm=T))

combined_chris %>%
  group_by(cp, min25) %>% 
  summarize(mean(target_pts))

lm_robust(data = combined_chris, ast10 ~ pts18)

sqrt(var(chris$PTS, na.rm = T))
mean(chris$PTS, na.rm=T)




  