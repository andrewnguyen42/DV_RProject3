#regularSeasonDF <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="SELECT * from REGULARSEASONS"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521/PDBF15DV.usuniversi01134.oraclecloud.internal', USER='cs329e_cdt932', PASS='orcl_cdt932', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE), ))
#playOffsBySeries <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="SELECT * from PLAYOFFS2015"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521/PDBF15DV.usuniversi01134.oraclecloud.internal', USER='cs329e_cdt932', PASS='orcl_cdt932', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE), ))
#playOffsSummaryDF <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="SELECT * from PLAYOFFSUMMARY2015"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521/PDBF15DV.usuniversi01134.oraclecloud.internal', USER='cs329e_cdt932', PASS='orcl_cdt932', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE), ))

joinedPlayoffsRegular <- regularSeasonDF %>% filter(YR == 2014) %>% inner_join(playOffsSummaryDF, by = c('PLAYER','TM'))


ggplot() +
  coord_cartesian() + 
  scale_x_continuous() +
  scale_y_continuous() +
  labs(title="Playoffs Minutes vs Regular Season Minutes",y="Playoffs Minutes",x="Regular Season Minutes",color="Team")+
  layer(data=joinedPlayoffsRegular,
        mapping=aes(x=as.numeric(MP.x),y=as.numeric(MP.y),color=TM),
        stat="identity",
        stat_params=list(),
        geom="point",
        geom_params=list(),
        position = position_jitter(width=0.5, height=0)
  )
