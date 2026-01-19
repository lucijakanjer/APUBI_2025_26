# Analize podataka u biološkim istraživanjima - praktikum 2025/26
# Lucija Kanjer lucija.kanjer@biol.pmf.hr

###############################################################################

# 11. Samostalni zadatak - Tema: morfologija dijatomeja

###############################################################################

## Paketi
library(Hmisc) # napredna obrada podataka, korelacija sa p-vrednostima
library(MASS) # diskriminantna analiza
library(psych) # paket za analize koje se često koriste u psihologiji
library(ggplot2) # grafovi
library(ggfortify) # za vizualizaciju rezultata statističkih analiza
library(dplyr) # iz nekog razloga bitno je ovo učitati zadnje u ovoj vježbi

## 1. Priprema podataka za analizu

# a) Skinite tablicu diatoms.csv sa GitHuba
# b) Napravite novu mapu naziva "prezime_ime_diatoms" i u nju spremite tablicu "diatoms.csv"
# c) Postavite mapu "prezime_ime_diatoms" kao radni direktorij
# d) Učitajte tablicu "diatoms.csv u R objekt "diatoms"

# 2. Pogledajte dataset i odgovorite na pitanja:
# a) Koje varijable su numeričke? Koliko ih ima?
# b) Koja je grupirajuća kategorička varijabla?
# c) Koliko i koje vrijednosti ima?


## 3. Grafički prikazi podataka

# a) Napravite histograme za varijable "length_um" i "striae" po grupama. Koristite paket ggplot2 i sloj facet_wrap u 3 reda

# Primjer:
ggplot(data, aes(x = variable)) +
  geom_histogram(color = "black", fill = "lightgreen") + 
  labs(title = "variable_name") +
  facet_wrap(~ group, nrow = 3) +
  theme_minimal()
# b) Koja varijabla ima normalnu distribuciju, a koja nema?


## 4. Parametrijska i neparametrijska statistika

# Iz objekta diatoms uklonite vrijednosti za grupu G2 i spremite tablicu u novi objekt diatoms_rm
# Primjer:
new_data <- filter(data, variable != "value") # != znači "nije jednako"

# Testirajte razlike srednjih vrijednosti duljine stanica između grupa G1 i G3. Ako je varijabla normalna koristite t-test, a ako nije Wilcoxonov test.
# Koja je nulta hipoteza ovog testa?
# S obzirom na rezultate testa, odbacujemo ili ne odbacujemo nultu hipotezu?
# Biološki interpretirajte rezultate ovog testa.

# Napravite tablice diatoms_G1 i diatoms_G3 u koje ćete filtrirati samo grupe G1 i G3

# Testirajte razlike srednjih vrijednosti strija između grupa G1 i G3. Ako je varijabla normalna koristite t-test, a ako nije Wilcoxonov test.
# Koja je nulta hipoteza ovog testa?
# S obzirom na rezultate testa, odbacujemo ili ne odbacujemo nultu hipotezu?
# Koje je biološko značenje ovog testiranja?

# Napravite ANOVA-u za širinu stanica između svih grupa.
# Ako je ANOVA značajna, napravite Tukey post hoc test.
# Protumačite rezultate ANOVA i Tukey Post-Hoc testa!


## 5. Linearna regresija

# Filtirajte tablicu da sadržava samo podatke o vrsti G1.
# Napravite linearnu regresiju za G1 između varijabli "length_um" i "narrowness".
# Napravite grafičku dijagnostiku i summary modela. 
# Jesu li pretpostavke normalnosti reziduala i jednakosti varijanci zadovoljene?
# Koliki je postotak varijacije objašnjen modelom? Je li model statistički značajan?


## 6. Multivarijatna statistika

# Napravite korelacijsku tablicu numeričkih varijabli iz ovog dataseta sa p-vrijednostima (paket Hmisc)
# Koje varijable su korelirane značajno, a koje nisu?
# Napravite LDA analizu.
# Napravite test sortiranja tj. predikciju i spremite u objekt "LDA_pred"
# Izračunajte kolika je uspješnost sortiranja?
# Napravite tablicu u kojoj se vidi točno i predviđeno sortiranje.
# Iz objekta "diatoms_sort" izvucite podatke o LD1, LD2 osima te class i zalijepite u originalnu tablicu diatoms
# Prikažite LDA graf, neka boje budu po pravim grupama, a oblici po predviđenim grupama.





