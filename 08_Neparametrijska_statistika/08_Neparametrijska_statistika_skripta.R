# Analize podataka u biološkim istraživanjima - praktikum 2025/26
# Lucija Kanjer lucija.kanjer@biol.pmf.hr

###############################################################################

# 8. Neparametrijska statistika i statitstika kategoričkih podataka

###############################################################################

# Učitavanje paketa
library(tidyr)
library(ggplot2)
set_theme(theme_minimal())

# Neparametrijska statistika

# Pokus 1: Uspjeh klijanja sjemenki bez gnojiva (kontrola) i s gnojivom

# Učitavanje dataseta
biljke_pokus1 <- read.csv("biljke_pokus1.csv")

# Pogledajte tablicu!


# Kreiranje tablice u dugačkom (long) formatu - za crtanje plotova
biljke_pokus1$id <- c(1:15)

biljke_pokus1_long <- pivot_longer(biljke_pokus1, cols = c(kontrola, gnojivo), names_to = "tretman", values_to = "proklijalo")

# Vizualizacija podataka iz pokusa 1

# Histogrami


# Ima li statistički značajne razlike između grupa kontrola i gnojivo?
# Koristimo test koji nema pretpostavku o distribuciji podataka.

# Kreiranje tablice u širokom (wide) formatu - za testiranje
biljke_pokus1_wide <- pivot_wider(biljke_pokus1_long, names_from = tretman, values_from = proklijalo)

# Wilcoxon-Mann-Whitney test za neovisne uzorke
wilcox.test(grupa1, grupa2)


# Pokus 2: broj plodova prije i poslije dodatka gnojiva

# Učitajte dataset!
biljke_pokus2 <- read.csv()

# Vizualizacija
# Zadatak: pretvorite tablicu u long format i napravite boxplot i histogram!


# Wilcoxonov test za uparene uzorke
wilcox.test(prije, poslije, paired = )

# Ima li statistički značajne razlike između broja plodova na biljci prije i nakon dodatka gnojiva?


### Statistika kategoričkih podataka

# Pokus 3: Broj uspješno klijanih sjemenki pod tri različita tretmana

# Učitajte dataset!
biljke_pokus3 <- read.csv()

print()

# Vizualizacija podataka
ggplot(biljke_pokus3, aes(x = gnojiva, y = proklijano)) +
  geom_bar(stat = "identity", position = "dodge") +
  geom_hline(aes(yintercept = ocekivano), color = "red", linetype = "dashed") +
  theme_minimal()

# hi-kvadrat test
chisq.test(promatrano, p = ocekivano / sum(ocekivano))


# Pokus 4: Udio uspješno klijanih sjemenki pod određenim uvjetima

# Učitavanje dataseta
biljke_pokus4 <- read.csv()

print(biljke_pokus4)

# Binomialni test
binom.test(uspjesi, pokušaji, p = vjerojatnost)

# Je li postotak uspjeha značajno različit od očekivanog?


# Samostalni zadaci:
# Tema: Utjecaj različitih prehrana na težinu miševa

# Zadatak 1
# Učitajte tablicu "misevi_zadatak1.csv"
# Napravite boxplot podataka
# Napravite histograme za varijable.
# Jesu li težine miševa pod prehranom A i prehranom B značajno različite?

# Zadatak 2
# Učitajte tablicu "misevi_zadatak2.csv"
# Napravite boxplot podataka
# Napravite histograme za varijable.
# Postoji li značajna razlika između težina miševa prije i poslije promjene prehrane?

# Zadatak 3
# Učitajte tablicu "misevi_zadatak3.csv"
# Napravite barplot.
# Promatrani broj miševa s poboljšanjem težine pod tri različite prehrane:
# Postoji li značajna razlika između promatranih i očekivanih rezultata?

# Zadatak 4
# Učitajte tablicu "misevi_zadatak4.csv"
# Od 15 miševa pod određenom prehranom, njih 10 je pokazalo poboljšanje težine.
# Je li postotak poboljšanja značajno različit od očekivanih 50%?
