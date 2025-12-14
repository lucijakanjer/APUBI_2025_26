# Analize podataka u biološkim istraživanjima - praktikum 2025/26
# Lucija Kanjer lucija.kanjer@biol.pmf.hr

###############################################################################

# 9. Linearni modeli s više prediktora i njihovim interakcijama

###############################################################################

## A) PRIPREMA PODATAKA ##

#a1) učitavanje paketa #
#install.packages("emmeans")
#install.packages("ggplot2")
library(emmeans)
library(ggplot2)

# a2) učitavanje tablice sa web izvora #
dat <- read.csv("https://stats.idre.ucla.edu/wp-content/uploads/2019/03/exercise.csv")
head(dat)

#a3) pretvori kategoričke varijable u faktore #
dat$prog <- factor(dat$prog,labels=c("jog","swim","read"))
dat$gender <- factor(dat$gender,labels=c("male","female"))

##B) PONOVIMO: LINEARNI MODEL S JEDNIM KONTINUIRANIM PREDIKTOROM ## 

#b1) linearni model ovisnosti gubitka mase o vremenu vježbanja #
cont <- lm(loss~hours,data=dat)
summary(cont)

#b5) crtanje regresijskog pravca pomoću paketa emmeans #
(mylist <- list(hours=seq(0,4,by=0.4)))
emmip(cont,~hours,at=mylist, CIs=TRUE)

##C) LINEARNI MODEL S 2 KONTINUIRANA PREDIKTORA I NJIHOVOM INTERAKCIJOM ##

#c1) linearni model gubitka mase o vremenu i trudu vježbanja #
contcont <- lm(loss~hours*effort,data=dat)
summary(contcont)

# definiranje visoke, niske i srednje razine truda #
effa <- mean(dat$effort) + sd(dat$effort)
eff <- mean(dat$effort)
effb <- mean(dat$effort) - sd(dat$effort)

# zaokruživanje razine truda na jedno decimalno mjesto
(effar <- round(effa,1))
(effr <- round(eff,1))
(effbr <- round(effb,1))

#kreiranje liste razina truda
mylist <- list(effort=c(effbr,effr,effar))

#crtanje regresijskog pravca za svaku razinu truda
(mylist <- list(hours=seq(0,4,by=0.4),effort=c(effbr,effr,effar)))
emmip(contcont,effort~hours,at=mylist, CIs=TRUE)


##D) LINEARNI MODEL S 1 KATEGORIČKIM i 1 KONTINUIRANIM PREDIKTOROM ##
class(dat$gender)#provjera je li spremljeno kao faktor
levels(dat$gender)#provjera kategorija
#d1) jednostavni model kad je muški spol referentna kategorija
catm <- lm(loss~gender,data=dat)
summary(catm)
#d2)promjeni razine kategorija tako da ženski spol bude razina 1 (referentna grupa)
dat$gender <- relevel(dat$gender, ref="female")
levels(dat$gender)

#d3) izrada modela
contcat <- lm(loss~hours*gender,data=dat)
summary(contcat)

#d7) plot using emmip
(mylist <- list(hours=seq(0,4,by=0.4),gender=c("female","male")))
emmip(contcat, gender ~hours, at=mylist,CIs=TRUE)


##E) LINEARNI MODEL S 2 KATEGORIČKA PREDIKTORA I NJIHOVOM INTERAKCIJOM ##
#e1)
#promjeni razine kategorija tako da čitanje bude razina 1 (referentna grupa)
dat$prog <- relevel(dat$prog, ref="read")
#promjeni razine kategorija tako da ženski spol bude razina 1 (referentna grupa)
dat$gender <- relevel(dat$gender, ref="female")

#e2) izrada modela
catcat <- lm(loss~gender*prog,data=dat)
summary(catcat)

#e4) izrada grafa interakcija pomoću paketa emmeans
emmip(catcat, prog ~ gender,CIs=TRUE)

#e5) spremanje grafa u objekt za crtanje drugačijeg prikaza pomoću ggplota
catcatdat <- emmip(catcat, gender ~ prog, CIs=TRUE, plotit=FALSE)
head(catcatdat)

#e6) napravi predložak grafa koji se sprema u objekt "p"
(p <- ggplot(data=catcatdat, aes(x=prog,y=yvar, fill=gender)) + geom_bar(stat="identity",position="dodge"))
#dodaj error bars
(p1 <- p + geom_errorbar(position=position_dodge(.9),width=.25, aes(ymax=UCL, ymin=LCL),alpha=0.3))
#promjeni nazive osi i legende
(p2 <- p1  + labs(x="Program", y="Weight Loss", fill="Gender"))
#opcionalna promjena boja ispune i teme
(p3 <- p2 + scale_fill_manual(name="Gender",values=c(female="lightpink",male="skyblue"))+ theme_minimal())

