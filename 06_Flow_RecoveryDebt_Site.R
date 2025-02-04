library(ggplot2)
library(tidyverse)


# SCRB Site Level Recover NEE Debt (SLM check): ####
setwd('/Users/sm3466/YSE Dropbox/Sparkle Malone/Research/Hurricane_Recovery_Debt')
source('05_Flow_SRS6Fix.R' )

srs6 <- srs6.sites

lrc <- function( QY, SW_IN, AMAX, RECO){
  
  ENP.NEE <- ((QY*SW_IN*AMAX)/(QY*SW_IN + AMAX)) - RECO
  return(ENP.NEE)
}

trc <- function( rb, TA ){
  
  NEE <- rb * exp( 107*( (1/(15 - -46.02)) - (1/(TA - -46.02))))
  
  return(NEE)
}

lrc2 <- function( QY, SW_IN, AMAX, rb, TA){
  
  ENP.NEE <- ((QY*SW_IN*AMAX)/(QY*SW_IN + AMAX)) - (trc(rb, TA)*-1)
  return(ENP.NEE)
}

srs6.carbon <- srs6 %>% mutate(
    NEP.LRC = lrc(QY= QY, SW_IN = SW_IN, AMAX = Amax, RECO= Reco),
    NEP.TRC = trc(rb = rb, TA = TA) *-1,
    NEP.LRC.TRC = case_when( SW_IN <= 0 ~ NEP.TRC,
                             SW_IN > 0 ~ NEP.LRC),
    NEP.LRC.TRC2 = lrc2(QY= QY, SW_IN = SW_IN, AMAX = Amax, rb = rb, TA = TA),
    
    NEE.LRC.gCm2 = (12.0107 *NEP.LRC/ 1000000 * 1800),
    NEE.LRC.TRC.gCm2 = (12.0107 * NEP.LRC.TRC/ 1000000 * 1800),
    NEE.LRC.TRC2.gCm2 = (12.0107 * NEP.LRC.TRC2/ 1000000 * 1800),
    Year = format( TIMESTAMP, format='%Y') )


srs6.Year <- srs6.carbon  %>% reframe(.by=c(TSD, EVENT), 
                                    NEE.LRC.gCm2 = sum( NEE.LRC.gCm2),
                                    NEE.LRC.TRC2.gCm2 = sum( NEE.LRC.TRC2.gCm2),
                                    NEE.LRC.TRC.gCm2 = sum( NEE.LRC.TRC.gCm2), 
                                    TA= mean(TA), SW_IN = sum(SW_IN )) %>% filter( TSD <= 4)


srs6.Year$DEBT.LRC <- srs6.Year$NEE.LRC.gCm2 - srs6.Year$NEE.LRC.gCm2[ srs6.Year$TSD == 0] %>% mean
srs6.Year$DEBT.LRC.TRC <- srs6.Year$NEE.LRC.TRC.gCm2 - srs6.Year$NEE.LRC.TRC.gCm2[ srs6.Year$TSD == 0] %>% mean
srs6.Year$DEBT.LRC.TRC2 <- srs6.Year$NEE.LRC.TRC2.gCm2 - srs6.Year$NEE.LRC.TRC2.gCm2[ srs6.Year$TSD == 0] %>% mean


srs6.debt <- rbind( srs6.Year %>% select( 'TSD', 'DEBT.LRC' ) %>% mutate( DEBT= DEBT.LRC , approach = "LRC") %>% select(TSD, DEBT, approach ),
                   srs6.Year %>% select( 'TSD', 'DEBT.LRC.TRC' ) %>% mutate( DEBT= DEBT.LRC.TRC ,approach = "LRC+TRC")%>% select(TSD, DEBT, approach ),
                   srs6.Year %>% select( 'TSD', 'DEBT.LRC.TRC2' ) %>% mutate(  DEBT= DEBT.LRC.TRC2 , approach = "LRC+TRC2")%>% select(TSD, DEBT, approach ))


# SCRB Site Level Recover NEE Debt (SLM check): ####

source('05_Flow_TS7Fix.R' )

ts7 <- ts7.sites

trc.ts7 <- function( rb, TA ){
  
  NEE <- rb * exp( 118 *( (1/(15 - -46.02)) - (1/(TA - -46.02))))
  
  return(NEE)
}

lrc2b <- function( QY, SW_IN, AMAX, rb, TA){
  
  ENP.NEE <- ((QY*SW_IN*AMAX)/(QY*SW_IN + AMAX)) - (trc.ts7(rb, TA)*-1)
  return(ENP.NEE)
}

ts7.carbon <- ts7 %>% 
  mutate(
    NEP.LRC = lrc(QY= QY, SW_IN = SW_IN, AMAX = Amax, RECO= Reco),
    NEP.TRC = trc(rb = rb, TA = TA) *-1,
    NEP.LRC.TRC = case_when( SW_IN <= 0 ~ NEP.TRC,
                             SW_IN > 0 ~ NEP.LRC),
    NEP.LRC.TRC2 = lrc2b(QY= QY, SW_IN = SW_IN, AMAX = Amax, rb = rb, TA = TA),
    
    NEE.LRC.gCm2 = (12.0107 *NEP.LRC/ 1000000 * 1800),
    NEE.LRC.TRC.gCm2 = (12.0107 * NEP.LRC.TRC/ 1000000 * 1800),
    NEE.LRC.TRC2.gCm2 = (12.0107 * NEP.LRC.TRC2/ 1000000 * 1800),
    Year = format( TIMESTAMP, format='%Y') )


ts7.Year <- ts7.carbon  %>% reframe(.by=c(TSD, EVENT), 
                                      NEE.LRC.gCm2 = sum( NEE.LRC.gCm2),
                                      NEE.LRC.TRC2.gCm2 = sum( NEE.LRC.TRC2.gCm2),
                                      NEE.LRC.TRC.gCm2 = sum( NEE.LRC.TRC.gCm2), 
                                      TA= mean(TA), SW_IN = sum(SW_IN )) %>% filter( TSD <= 4)


ts7.Year$DEBT.LRC <- ts7.Year$NEE.LRC.gCm2 - ts7.Year$NEE.LRC.gCm2[ ts7.Year$TSD == 0] %>% mean
ts7.Year$DEBT.LRC.TRC <- ts7.Year$NEE.LRC.TRC.gCm2 - ts7.Year$NEE.LRC.TRC.gCm2[ ts7.Year$TSD == 0] %>% mean
ts7.Year$DEBT.LRC.TRC2 <- ts7.Year$NEE.LRC.TRC2.gCm2 - ts7.Year$NEE.LRC.TRC2.gCm2[ ts7.Year$TSD == 0] %>% mean


ts7.debt <- rbind( ts7.Year %>% select( 'TSD', 'DEBT.LRC' ) %>% mutate( DEBT= DEBT.LRC , approach = "LRC") %>% select(TSD, DEBT, approach ),
ts7.Year %>% select( 'TSD', 'DEBT.LRC.TRC' ) %>% mutate( DEBT= DEBT.LRC.TRC ,approach = "LRC+TRC")%>% select(TSD, DEBT, approach ),
ts7.Year %>% select( 'TSD', 'DEBT.LRC.TRC2' ) %>% mutate(  DEBT= DEBT.LRC.TRC2 , approach = "LRC+TRC2")%>% select(TSD, DEBT, approach ))

ts7.debt %>% filter( approach != 'LRC+TRC2') %>% ggplot( aes(x=TSD, y= DEBT, shape=approach) ) + geom_point() +
  geom_smooth( col="black") +theme(text = element_text(size = 25), legend.title = element_blank()) +
  theme_bw() + 
  xlab('Years Following Disturbance') + 
  ylab( 'C Debt (Mt)') +
  geom_vline(xintercept=0, linetype="dashed", color = "red") + theme(text = element_text(size = 20)) +
  geom_hline(yintercept=0, linetype="dashed", color = "grey")

ts7.debt %>% filter( approach != 'LRC+TRC2') %>% ggplot( aes(x=TSD, y= cumsum(DEBT), shape=approach) ) + geom_point() +
  geom_smooth( col="black") +theme(text = element_text(size = 25), legend.title = element_blank()) +
  theme_bw() +
  xlab('Years Following Disturbance') + 
  ylab( 'Cumulative C Debt (Mt)') +
  geom_vline(xintercept=0, linetype="dashed", color = "red") + theme(text = element_text(size = 20)) +
  geom_hline(yintercept=0, linetype="dashed", color = "grey")


srs6.debt %>% filter( approach != 'LRC+TRC2') %>% ggplot( aes(x=TSD, y= DEBT, shape=approach) ) + geom_point() +
  geom_smooth( col="black") +theme(text = element_text(size = 25), legend.title = element_blank()) +
  theme_bw() +
  xlab('Years Following Disturbance') + 
  ylab( 'C Debt (Mt)') +
  geom_vline(xintercept=0, linetype="dashed", color = "red") + theme(text = element_text(size = 20)) +
  geom_hline(yintercept=0, linetype="dashed", color = "grey")

srs6.debt %>% filter( approach != 'LRC+TRC2') %>% ggplot( aes(x=TSD, y= cumsum(DEBT), shape=approach) ) + geom_point() +
  geom_smooth( col="black") +theme(text = element_text(size = 25), legend.title = element_blank()) +
  theme_bw() +
  xlab('Years Following Disturbance') + 
  ylab( 'Cumulative C Debt (Mt)') +
  geom_vline(xintercept=0, linetype="dashed", color = "red") + theme(text = element_text(size = 20)) +
  geom_hline(yintercept=0, linetype="dashed", color = "grey")


# There may be an issue with the cumulative debt calc. CHeck this
