# Analize podataka u biološkim istraživanjima - praktikum 2025/26
# Lucija Kanjer lucija.kanjer@biol.pmf.hr

###############################################################################

# Deskriptivna statistka bioloških varijabli u R-u

###############################################################################

# Postavljanje radnog direktorija
getwd()
setwd()

# Učitavanje potrebnih paketa
library(dplyr) # za manipulaciju tablicama
library(ggplot2) # za crtanje grafova
theme_set(theme_minimal()) # postavljanje teme za sve ggplot grafove

# Učitavanje seta podataka o rakovima u na postaji istok i zapad
rakovi <- read.csv("rakovi.csv")

# Pregledajte set podataka!
str(rakovi)
head(rakovi)

# Histogrami - pregled distribucije kontinuiranih numeričkih varijabli
# Prvo cemo kreirati objekte, a onda ih ispisati sve na jednom plotu

histogram_duljina <- ggplot(rakovi, aes(x = duljina)) +
  geom_histogram(binwidth = 1, color = "black", fill = "lightgreen") + 
  labs(title = "Histogram duljine rakova", subtitle = "opis: ")

print(histogram_duljina)

histogram_masa <- ggplot(rakovi, aes(x = masa)) +
  geom_histogram(binwidth = 50, color = "black", fill = "lightblue") + 
  labs(title = "Histogram mase rakova", subtitle = "opis: ")

print(histogram_masa)

histogram_temperatura <- ggplot(rakovi, aes(x = temperatura)) +
  geom_histogram(binwidth = 1, color = "black", fill = "pink") + 
  labs(title = "Histogram temperature vode", subtitle = "opis: ")

print(histogram_temperatura)

histogram_patogeni <- ggplot(rakovi, aes(x = patogeni)) +
  geom_histogram(binwidth = 2, color = "black", fill = "lightyellow") + 
  labs(title = "Histogram broja patogena na rakovima", subtitle = "opis: ")

print(histogram_patogeni)

# Spajanje 4 grafa u 1 pomoću paketa patchwork
library(patchwork) # za spajanje grafova
(histogram_duljina + histogram_masa) / (histogram_temperatura + histogram_patogeni)

# Zadatak: Opisati izgled distrubucije - simetričnost, nagnutost - u subtitle!


# Usporedba distribucije varijabli po postajama istok i zapad

# Crtamo isti histogram kao i ranije, ali koristimo facet_wrap za odvajanje po postajama
histogram_duljina_postaje <- ggplot(rakovi, aes(x = duljina)) +
  geom_histogram(binwidth = 1, color = "black", fill = "lightgreen") + 
  labs(title = "Histogram duljine rakova", subtitle = "opis: ") +
  facet_wrap(~ postaja, nrow = 2) #odvaja histograme po grupirajucoj varijabli postaja

print(histogram_duljina_postaje)

# Kako sad izgleda distrubucija? Opišite u subtitle!

# Napravite histograme usporedbe po postajama i za varijable masa, temperatura i patogeni!
# Opišite nove izgled distribucije u subtitle!

histogram_masa_postaje

histogram_temperatura_postaje

histogram_patogeni_postaje

# Deskriptina statistika

# Naredba summary() - pregled kvartila, medijana i aritmetičke sredine
summary(rakovi) # cijeli dataset
summary(rakovi$duljina) #samo jedna varijabla

# Simetrične i normalne distribucije
# Aritmetička sredina za duljinu
mean(rakovi$duljina)

# SD - Standardna devijacija za duljinu
sd(rakovi$duljina)

# SE - Standardna pogreška za duljinu (Standard Error)
sd(rakovi$duljina) / sqrt(length(rakovi$duljina))

# Asimetrične distribucije
# Medijan za masu
median(rakovi$masa)

# Interkvartilni range (IQR) za masu
IQR(rakovi$masa)

# Raspon (Range) za temperaturu
range(rakovi$masa)

# Deskriptivna statistika po grupirajućoj varijabli "postaja"

# Paket "data.table" - daje lijep tablični prikaz deskritipne statistike
library(data.table)
# setDT() naredba preoblikuje dataset da ga mozemo koristiti s paketom data.table
setDT(rakovi)

# Kategoricku grupirajucu varijablu "postaja" moramo pretvoriti u faktor naredbom as.factor()
rakovi$postaja <- as.factor(rakovi$postaja)
str(rakovi$postaja)

# Summary - pregled kvartila, medijana i aritmetičke sredine za varijablu "duljina"
rakovi[, as.list(summary(patogeni)), by = list(postaja)]

# Izmjenite gornju naredbu da umjesto summary prikazuje vrijednosti standarne devijacije!

# Sličnu tablicu možemo generirati pomoću "dplyr" objekta
# Podsjetimo se pipe operatora i vježbe "Rad s podacima"!
summary_duljina_postaje <- rakovi %>%
  group_by(postaja) %>%
  summarise(
    minimum = min(duljina),
    Q1 = quantile(duljina, 0.25),
    medijan = median(duljina),
    prosjek = mean(duljina),
    Q3 = quantile(duljina, 0.75),
    maximun = max(duljina),
    stdev = sd(duljina) 
  )

print(summary_duljina_postaje)

# Izvoz u tablicu
write.csv(summary_duljina_postaje, # naziv R objekta
          "summary_duljina_postaje.csv", # naziv nove CSV datoteke 
          row.names = FALSE, quote = FALSE) # postavke

# Grafički prikazi deskriptivne statistike

# Boxplot usporedbe s violin i jitter prikazom distribucija

boxplot_duljina <- ggplot(rakovi, aes(x = postaja, y = duljina)) +
  geom_violin(aes(fill = postaja), alpha = 0.5, color = "white") + 
  geom_boxplot() + 
  geom_jitter(aes(color = postaja)) +
  stat_summary(fun = mean, geom = "point", position = position_dodge(width = 0.75), shape = 18, size = 5) +
  labs(x = "", y = "Duljina (cm)")

boxplot_duljina

boxplot_masa <- ggplot(rakovi, aes(x = postaja, y = masa)) +
  geom_violin(aes(fill = postaja), alpha = 0.5, color = "white") + 
  geom_boxplot() + 
  geom_jitter(aes(color = postaja)) +
  stat_summary(fun = mean, geom = "point", position = position_dodge(width = 0.75), shape = 18, size = 5) +
  labs(x = "", y = "Masa (g)")

boxplot_masa

boxplot_temperatura <- ggplot(rakovi, aes(x = postaja, y = temperatura)) +
  geom_violin(aes(fill = postaja), alpha = 0.5, color = "white") + 
  geom_boxplot() + 
  geom_jitter(aes(color = postaja)) +
  stat_summary(fun = mean, geom = "point", position = position_dodge(width = 0.75), shape = 18, size = 5) +
  labs(x = "", y = "Temperatura (°C)")

boxplot_temperatura

boxplot_patogeni <- ggplot(rakovi, aes(x = postaja, y = patogeni)) +
  geom_violin(aes(fill = postaja), alpha = 0.5, color = "white") + 
  geom_boxplot() + 
  geom_jitter(aes(color = postaja)) +
  stat_summary(fun = mean, geom = "point", position = position_dodge(width = 0.75), shape = 18, size = 5) +
  labs(x = "", y = "Patogeni")

# Prikaz svih plotova na jednom plotu
(boxplot_duljina + boxplot_masa) / (boxplot_temperatura + boxplot_patogeni)

###############################################################################






