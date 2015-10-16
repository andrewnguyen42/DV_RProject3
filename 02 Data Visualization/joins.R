regularSeasonDF <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="SELECT * from REGULARSEASONS"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521/PDBF15DV.usuniversi01134.oraclecloud.internal', USER='cs329e_cdt932', PASS='orcl_cdt932', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE), ))
playOffsBySeries <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="SELECT * from PLAYOFFS2015"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521/PDBF15DV.usuniversi01134.oraclecloud.internal', USER='cs329e_cdt932', PASS='orcl_cdt932', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE), ))
playOffsSummaryDF <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="SELECT * from PLAYOFFSUMMARY2015"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521/PDBF15DV.usuniversi01134.oraclecloud.internal', USER='cs329e_cdt932', PASS='orcl_cdt932', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE), ))

currentSeasonDF <- regularSeasonDF %.% filter(YR == 2014)

joinedPlayoffsRegular<-inner_join(currentSeasonDF, playOffsSummaryDF, by = c('PLAYER','TM'))

ggplot() +
  coord_cartesian() + 
  scale_x_continuous() +
  scale_y_log10() +
  labs(title="Mass of Discovered Planets Over Time",y="Mass of Planet (Jupiter Mass)",x="Year Published",color="Method of Discovery")+
  layer(data=df2,
        mapping=aes(x=as.numeric(as.character(DATE_0)),y=as.numeric(as.character(MASS)),color=PLANETDISCMETH),
        stat="identity",
        stat_params=list(),
        geom="point",
        geom_params=list(),
        position = position_jitter(width=0.5, height=0)
  )
