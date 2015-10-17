#regularSeasonDF <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="SELECT * from REGULARSEASONS"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521/PDBF15DV.usuniversi01134.oraclecloud.internal', USER='cs329e_cdt932', PASS='orcl_cdt932', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE), ))
#playOffsBySeries <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="SELECT * from PLAYOFFS2015"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521/PDBF15DV.usuniversi01134.oraclecloud.internal', USER='cs329e_cdt932', PASS='orcl_cdt932', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE), ))
#playOffsSummaryDF <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="SELECT * from PLAYOFFSUMMARY2015"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521/PDBF15DV.usuniversi01134.oraclecloud.internal', USER='cs329e_cdt932', PASS='orcl_cdt932', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE), ))


semijoinRegular<- regularSeasonDF %>% filter(YR == 2014) %>% semi_join(playOffsSummaryDF, by = c('PLAYER','TM')) %>% group_by(TM) %>% summarise(EFG=mean(as.numeric(as.character(EFG_))))

antijoinRegular<- regularSeasonDF %>% filter(YR == 2014) %>% anti_join(playOffsSummaryDF, by = c('PLAYER','TM')) %>% group_by(TM) %>% summarise(EFG=mean(as.numeric(as.character(EFG_))))


grid.arrange(
ggplot(semijoinRegular, aes(c(0),EFG))+
  geom_boxplot()+
labs(title='Playoff Teams') +
  labs(y="EFG Team Average") ,

ggplot(antijoinRegular, aes(c(0),EFG))+
  geom_boxplot()+
labs(title='Non-Playoff Teams') +
  labs(y="EFG Team Average") ,

ncol=2)


