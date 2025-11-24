# Analize podataka u biološkim istraživanjima - praktikum 2025/26
# Lucija Kanjer lucija.kanjer@biol.pmf.hr

###############################################################################

# 6. Linearna regresija

###############################################################################

# Učitajte potrebne pakete
library(ggplot2) # grafovi

# Postavljanje radnog direktorija
getwd()
setwd()

# Učitavanje podataka o ribama!
ribe

### Ispitivanje razdiobe (distribucije) podataka

# 1. Histogram
hist(ribe$duljina_cm)

hist(ribe$starost_riba)

# Koju razliku primjećujete u izgledima histogram?

# 2. Q-Q plot
qqnorm(ribe$duljina_cm, main = "Q-Q plot za duljinu ribe")
qqline(ribe$duljina_cm, col = "red")

qqnorm(ribe$starost_riba, main = "Q-Q plot za starost ribe")
qqline(ribe$starost_riba, col = "red")

# Koju razliku primjećujete u izgledima Q-Q plota?

# 3. Shapiro-Wilk test
shapiro.test(ribe$duljina_cm)

shapiro.test(ribe$starost_riba)

# Za koju varijablu je Shapiro-Wilk test značajan? Što to znači?


# Zadaci

# 1.Napravite ispitivanje normalnosti za varijablu "brzina_plivanja". Je li varijabla normalno distribuirana?
# 2.Napravite ispitivanje normalnosti za varijablu "broj_jaja". Je li varijabla normalno distribuirana? Napravite dokument izvještaja.


###############################################################################

# Linearni modeli - na podacima o drvnom otpadu u jezerima

# Učitajte podatke iz CSV datoteke
# Podaci sadrže informacije o gustoći drveća, kabina i krupnom drvenom otpadu
jezera <- read.csv()

# Pogledajte prvih nekoliko redaka podataka kako biste razumjeli strukturu
head()

# Varijable:
# jezero - 16 jezera u Sjevernoj Americi
# obalno_drvece - gustoća obalnog drveća po kilometru (km−1)
# drvni_otpad - površina drvnog otpada u m2 po kilometru (m2 km−1)
# kolibe - gustoća ljudskih koliba po kilometru (no. km−1)


# Vizualizacija podataka

# Kako gustoća obalnog drveća utječe na količinu drvnog otpada?

# Scatter plot odnosa drvnog otpada i gustoće obalnog drveća
ggplot(jezera, aes(x = obalno_drvece, y = drvni_otpad)) +            
  geom_point() +                                      
  geom_smooth() +
  theme_minimal()

# Što prikazuje linija na scatterplotu?

# Prilagodimo liniju trenda!

### Linearna regresija
# nezavisna varijabla: obalno_drvece
# zavisna varijabla: drvni_otpad

# Linearni Model: Utjecaj gustoće obalnog drveća na količinu drvnog otpada
model_drvece <- lm(drvni_otpad ~ obalno_drvece, data = jezera)

# Ispis sažetka modela za interpretaciju koeficijenata
summary(model_drvece)

# Grafička dijagnostika modela
par(mfrow = c(2, 2)) #postavljanje ispisa grafova u gridu 2x2
plot(model_drvece)

# Pogledajte rezidualne grafikone kako biste provjerili pretpostavke linearnog modela!

# Dodatno - sume kvadrata i stupnjevi slobode

anova(model_drvece)
# Koje su vrijednosti sume kvadrata za model, a koji za pogršku?
# Koliko ima stupnjeva slobode?


predict(model_drvece, data.frame(obalno_drvece = c(1500)), interval = "confidence")

## Zadatak: Kako gustoća ljudskih koliba utječe na količinu drvnog otpada?

# Napravite scatterplot odnosa drvnog otpada i koliba
# Kreirajte novi model "model_kolibe" sa zavisnom varijablom: drvni_otpad i nezavisnom varijablom: kolibe
# Napravite grafičku dijagnostiku modela: kakva je normalnost reziduala? Jesu li varijance reziduala konstantne?
# Ispišite summary modela kolibe, ispišite sume kvadrata i stupnjeve slobode.

# Što kad reziduali krše pretpostavku normalnosti?
# Transformacija podataka

# Stvaranje novog vektora "log_kolibe"
jezera$log_kolibe <- log10(jezera$kolibe+1)

# Zašto dodajemo +1 prilikom logaritmiranja?

# Napravimo novi model s logaritmiranim podacima za kolibe!
model_log_kolibe <- lm()

# Grafička dijagnostika modela!
par(mfrow = c(2, 2))
plot(model_log_kolibe)

summary(model_log_kolibe)


