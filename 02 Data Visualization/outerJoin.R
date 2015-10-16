regularSeasonDF <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="SELECT * from REGULARSEASONS"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521/PDBF15DV.usuniversi01134.oraclecloud.internal', USER='cs329e_cdt932', PASS='orcl_cdt932', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE), ))
playOffsBySeries <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="SELECT * from PLAYOFFS2015"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521/PDBF15DV.usuniversi01134.oraclecloud.internal', USER='cs329e_cdt932', PASS='orcl_cdt932', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE), ))
playOffsSummaryDF <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="SELECT * from PLAYOFFSUMMARY2015"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521/PDBF15DV.usuniversi01134.oraclecloud.internal', USER='cs329e_cdt932', PASS='orcl_cdt932', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE), ))


currentSeasonDF <- regularSeasonDF %.% filter(YR == 2014)

playersWhoMadeOffSeason<-left_join(currentSeasonDF, playOffsSummaryDF, by = c('PLAYER','TM'))

playersWhoMadeOffSeason$madePlayoffs<-(!is.na(playersWhoMadeOffSeason$POS.y))


ggplot(playersWhoMadeOffSeason, aes(x=EFG_.x))+
  geom_histogram()+
  stat_bin(width=1, drop = FALSE, right = FALSE, col = "black")+
  labs(title='Effective Field Goal Percentage for Playoff vs Non-Playoff Teams')+
  labs(x="EFG") +
  facet_grid(. ~ madePlayoffs)
