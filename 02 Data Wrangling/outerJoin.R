#regularSeasonDF <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="SELECT * from REGULARSEASONS"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521/PDBF15DV.usuniversi01134.oraclecloud.internal', USER='cs329e_cdt932', PASS='orcl_cdt932', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE), ))
#playOffsBySeries <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="SELECT * from PLAYOFFS2015"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521/PDBF15DV.usuniversi01134.oraclecloud.internal', USER='cs329e_cdt932', PASS='orcl_cdt932', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE), ))
#playOffsSummaryDF <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="SELECT * from PLAYOFFSUMMARY2015"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521/PDBF15DV.usuniversi01134.oraclecloud.internal', USER='cs329e_cdt932', PASS='orcl_cdt932', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE), ))


playersWhoMadeOffSeason <- regularSeasonDF %>% filter(YR == 2014) %>% left_join(playOffsSummaryDF, by = c('PLAYER','TM')) %>% mutate(madePlayoffs=!is.na(POS.y))


ggplot(playersWhoMadeOffSeason, aes(x=as.numeric(as.character(EFG_.x))))+
  geom_histogram(aes(y=(..count..)/tapply(..count..,..PANEL..,sum)[..PANEL..])) +
  labs(title="Effective Field Goal Percentage for Playoff vs Non-Playoff Players (normalized)",x="Effective Field-Goal Percentage",y=NULL) +
  facet_grid(. ~ madePlayoffs)
