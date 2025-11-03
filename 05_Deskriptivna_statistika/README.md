Deskriptivna statistika bioloških varijabli u R-u
================
Lucija Kanjer, e-mail: <lucija.kanjer@biol.pmf.hr>
25/26

## Sadržaj ove vježbe

- izgled distribucije podataka (simetričnost, nagnutost)
- mjere centralne tendencije: aritmetička sredina, medijan
- standardna pogreška (SE - standard error)
- mjere raspršenosti: standardna devijacija, interkvartilni raspon,
  raspon
- primjer oglednog zadatka za kolokvij

## Otvorimo skriptu i učitajmo pakete

``` r
# Instalacija i učitavanje potrebnih paketa
# install.packages("") # nadopuni za nove pakete!

library(dplyr) # manipulacija tablicama
library(ggplot2) # crtanje grafova
library(patchwork) # spajanje više grafova u jedan plot
library(data.table) # deskriptivna statistika po postajama
theme_set(theme_minimal()) # postavljanje teme za sve ggplot grafove
```

## Provjera i postavljanje radnog direktorija

``` r
# Postavljanje radnog direktorija
getwd()
```

    ## [1] "C:/Users/lucij/Documents/APUBI/05_Deskriptivna_statistika"

``` r
setwd("C:/Users/lucij/Documents/APUBI/05_Deskriptivna_statistika")
```

## Dataset rakovi

- Novi set podataka “rakovi.csv” sastoji se od mjerenja duljine, mase i
  broja patogena rakova na dvije postaje: istočnoj (“istok”) i zapadnoj
  (“zapad”).
- U ovoj vježbi cilj nam je opisati distribucije i odrediti deskriptivnu
  statistiku za svaku numeričku varijablu u cijelom setu podataka i
  između dvije istraživanje postaje.

## Učitavanje seta podataka o rakovima u na postaji istok i zapad

``` r
# Učitavanje seta podataka o rakovima u na postaji istok i zapad
rakovi <- read.csv("rakovi.csv")

# Pregledajte set podataka!
str(rakovi)
```

    ## 'data.frame':    200 obs. of  5 variables:
    ##  $ duljina    : num  21.4 19.4 20.4 20.6 20.4 ...
    ##  $ masa       : num  270.6 250.2 89.9 374 106.3 ...
    ##  $ temperatura: num  15.2 20.1 21.3 19.2 23.8 ...
    ##  $ patogeni   : num  7.39 9.02 0.2 3.11 12.39 ...
    ##  $ postaja    : chr  "zapad" "zapad" "zapad" "zapad" ...

``` r
# Pregledajte set podataka!
head(rakovi)
```

    ##   duljina   masa temperatura patogeni postaja
    ## 1   21.37 270.56       15.23     7.39   zapad
    ## 2   19.44 250.23       20.13     9.02   zapad
    ## 3   20.36  89.87       21.31     0.20   zapad
    ## 4   20.63 373.99       19.19     3.11   zapad
    ## 5   20.40 106.34       23.79    12.39   zapad
    ## 6   19.89 156.45       16.08     7.79   zapad

## Izrada histograma

- Histogrami - pregled distribucije kontinuiranih numeričkih varijabli
- Prvo cemo kreirati objekte, a onda ih ispisati sve na jednom plotu

``` r
histogram_duljina <- ggplot(rakovi, aes(x = duljina)) +
  geom_histogram(binwidth = 1, color = "black", fill = "lightgreen") + 
  labs(title = "Histogram duljine rakova", subtitle = "opis: bimodalna")

histogram_masa <- ggplot(rakovi, aes(x = masa)) +
  geom_histogram(binwidth = 50, color = "black", fill = "lightblue") + 
  labs(title = "Histogram mase rakova", subtitle = "opis: lognormalna")

histogram_temperatura <- ggplot(rakovi, aes(x = temperatura)) +
  geom_histogram(binwidth = 3, color = "black", fill = "pink") + 
  labs(title = "Histogram temperature vode", subtitle = "opis: lijevo nagnuta")

histogram_patogeni <- ggplot(rakovi, aes(x = patogeni)) +
  geom_histogram(binwidth = 2, color = "black", fill = "lightyellow") + 
  labs(title = "Histogram patogena na rakovima", subtitle = "opis: desno nagnuta")
```

#### Ispis kombiniranog plota histograma

``` r
# Zadatak: Opisati izgled distrubucije - simetričnost, nagnutost - u subtitle!
# Spajanje 4 grafa u 1 pomoću paketa patchwork
(histogram_duljina + histogram_masa) / (histogram_temperatura + histogram_patogeni)
```

![](README_files/figure-gfm/hist%20combined-1.png)<!-- -->

## Usporedba distribucije varijabli po postajama istok i zapad

Napravit ćemo histograme kao i ranije, ali ćemo ih odvojiti po
grupirajućoj varijabli “postaja” i usporediti jesu li distribucije
ostale iste ili su se izmjenile.

#### Histogram duljine rakova po postajama istok i zapad

``` r
# Crtamo isti histogram kao i ranije, ali koristimo facet_wrap za odvajanje po postajama
histogram_duljina_postaje <- ggplot(rakovi, aes(x = duljina)) +
  geom_histogram(binwidth = 1, color = "black", fill = "lightgreen") + 
  labs(title = "Histogram duljine rakova", subtitle = "opis: simetrična, zvonolika distribucija nalik normalnoj") +
  facet_wrap(~ postaja, nrow = 2) #odvaja histograme po grupirajucoj varijabli postaja

print(histogram_duljina_postaje)
```

![](README_files/figure-gfm/hist%20duljina-1.png)<!-- -->

``` r
# Kako sad izgleda distrubucija? Opišite u subtitle!
```

### Zadatak

- Napravite histograme usporedbe po postajama i za varijable masa,
  temperatura i patogeni!
- Opišite nove izgled distribucije u subtitle!

#### Histogram mase rakova po postajama istok i zapad

``` r
histogram_masa_postaje <- ggplot(rakovi, aes(x = masa)) +
  geom_histogram(binwidth = 50, color = "black", fill = "lightblue") + 
  labs(title = "Histogram mase rakova", subtitle = "opis: nesimetrična, desno nagnuta distribucija nalik lognormalnoj") +
  facet_wrap(~ postaja, nrow = 2) 

print(histogram_masa_postaje)
```

![](README_files/figure-gfm/hist%20masa-1.png)<!-- -->

#### Histogram temperature vode po postajama istok i zapad

``` r
histogram_temperatura_postaje <- ggplot(rakovi, aes(x = temperatura)) +
  geom_histogram(binwidth = 1.5, color = "black", fill = "pink") + 
  labs(title = "Histogram temperature vode", subtitle = "opis: simetrična, uniformna distribucija") +
  facet_wrap(~ postaja, nrow = 2)

print(histogram_temperatura_postaje)
```

![](README_files/figure-gfm/hist%20temp-1.png)<!-- -->

#### Histogram broja patogena po postajama istok i zapad

``` r
histogram_patogeni_postaje <- ggplot(rakovi, aes(x = patogeni)) +
  geom_histogram(binwidth = 2.5, color = "black", fill = "lightyellow") + 
  labs(title = "Histogram patogena na rakovima", subtitle = "opis: nesimetrična, desno nagnuta distribucija, postaja istok ima veću raspršenost") +
  facet_wrap(~ postaja, nrow = 2)

print(histogram_patogeni_postaje)
```

![](README_files/figure-gfm/hist%20patogeni-1.png)<!-- -->

## Deskriptina statistika

**Mjere centralne tendencije**

- Odgovaraju na pitanje: “Koja je tipična vrijednost u populaciji?”
- aritmetička sredina (“ravnotežna točka seta podataka”)
- medijan (vrijednost na sredini uzorka)
- mod (najčešća vrijednost - za kategoričke varijable)

**Mjere raspršenosti**

- Koliko su varijabline vrijednosti u populaciji?
- standardna devijacija (prikazuje se uz aritmetičku sredinu)
- interkvartilni raspon (Q1-Q3)
- raspon min-max

## Deskriptina statistika u R-u

Naredba <code>summary()</code> - pregled kvartila, medijana i
aritmetičke sredine

``` r
summary(rakovi) # cijeli dataset
```

    ##     duljina           masa         temperatura       patogeni     
    ##  Min.   :12.01   Min.   : 32.71   Min.   :15.01   Min.   : 0.000  
    ##  1st Qu.:15.09   1st Qu.: 75.59   1st Qu.:19.43   1st Qu.: 1.930  
    ##  Median :17.16   Median :111.91   Median :21.64   Median : 5.160  
    ##  Mean   :17.53   Mean   :126.86   Mean   :21.12   Mean   : 8.077  
    ##  3rd Qu.:20.09   3rd Qu.:157.18   3rd Qu.:23.45   3rd Qu.:10.405  
    ##  Max.   :22.29   Max.   :573.03   Max.   :24.96   Max.   :52.380  
    ##    postaja         
    ##  Length:200        
    ##  Class :character  
    ##  Mode  :character  
    ##                    
    ##                    
    ## 

``` r
summary(rakovi$duljina) # samo jedna varijabla
```

    ##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    ##   12.01   15.09   17.16   17.53   20.09   22.29

## Simetrične i normalne distribucije

Za podatke koje su normalno i simetrično distribuirani koristimo:

- **aritmetičku sredinu** - kao mjeru centralne tendencije
- **standardnu devijaciju** - kao mjeru raspršenosti podataka u našem
  uzorku
- **standardnu pogrešku** - kao mjeru koliko precizno srednja vrijednost
  našeg uzorka dobro procjenjuje srednju vrijednost prave populacije

Ovakve distribucije mogu dalje koristiti metode **parametrijske
statistike** (npr. t-test, ANOVA, …)

``` r
# Simetrične i normalne distribucije
# Aritmetička sredina za duljinu
mean(rakovi$duljina)
```

    ## [1] 17.5326

``` r
# SD - Standardna devijacija za duljinu
sd(rakovi$duljina)
```

    ## [1] 2.71285

``` r
# SE - Standardna pogreška za duljinu (Standard Error)
sd(rakovi$duljina) / sqrt(length(rakovi$duljina))
```

    ## [1] 0.1918275

## Asimetrične i ne-normalne distribucije

Nemaju normalnu raspodjelu podataka i za njih se **ne preporuča**
opisivati ih aritmetičkom sredinom i standardnom devicijom! Umjesto toga
za njih prikazujemo:

- **medijan** - kao mjeru centralne tendencije
- **interkvartilni raspon** ili **raspon min-max** - kao mjeru
  raspršenosti uzorka

Distrubucije za koje ne očekujemo normalnu distribuciju podataka
koristimo dalje metode **neparametrijske statistike** (npr. Mann-Whitney
U test, Kruskal-Wallis test, Wilcoxonov test, ..)

``` r
# Asimetrične distribucije
# Medijan za masu
median(rakovi$masa)
```

    ## [1] 111.905

``` r
# Interkvartilni range (IQR) za masu
IQR(rakovi$masa)
```

    ## [1] 81.5925

``` r
# Raspon (Range) za temperaturu
range(rakovi$masa)
```

    ## [1]  32.71 573.03

## Deskriptivna statistika po grupirajućoj varijabli “postaja”

``` r
# Deskriptivna statistika po grupirajućoj varijabli "postaja"

# Paket "data.table" - daje lijep tablični prikaz deskritipne statistike
# setDT() naredba preoblikuje dataset da ga mozemo koristiti s paketom data.table
setDT(rakovi)

# Kategoricku grupirajucu varijablu "postaja" moramo pretvoriti u faktor naredbom as.factor()
rakovi$postaja <- as.factor(rakovi$postaja)
str(rakovi$postaja)
```

    ##  Factor w/ 2 levels "istok","zapad": 2 2 2 2 2 2 2 2 2 2 ...

``` r
# Summary - pregled kvartila, medijana i aritmetičke sredine
# za varijablu "duljina"
rakovi[, as.list(summary(duljina)), by = list(postaja)]
```

    ##    postaja  Min. 1st Qu. Median    Mean 3rd Qu.  Max.
    ##     <fctr> <num>   <num>  <num>   <num>   <num> <num>
    ## 1:   zapad 17.01 19.3825  20.09 20.0326  20.665 22.29
    ## 2:   istok 12.01 14.3825  15.09 15.0326  15.665 17.29

``` r
# Izmjenite gornju naredbu da umjesto summary vrijednosti standarne devijacije
```

``` r
# Sličnu tablicu možemo generirati pomoću "dplyr" objekta
# Podsjetimo se pipe operatora i vježbe "Ras s podacima"!
summary_duljina_postaje <- rakovi %>%
  group_by(postaja) %>%
  summarise(
    minimum = min(duljina),
    Q1 = quantile(duljina, 0.25),
    medijan = median(duljina),
    prosjek = mean(duljina),
    Q3 = quantile(duljina, 0.75),
    maximun = max(duljina),
    stdev = sd(duljina)  # Dodajemo SD
  )
```

``` r
print(summary_duljina_postaje)
```

    ## # A tibble: 2 × 8
    ##   postaja minimum    Q1 medijan prosjek    Q3 maximun stdev
    ##   <fct>     <dbl> <dbl>   <dbl>   <dbl> <dbl>   <dbl> <dbl>
    ## 1 istok      12.0  14.4    15.1    15.0  15.7    17.3  1.04
    ## 2 zapad      17.0  19.4    20.1    20.0  20.7    22.3  1.04

``` r
# Izvoz u tablicu
write.csv(summary_duljina_postaje, #naziv R objekta
          "summary_duljina_postaje.csv", #naziv nove CSV datoteke 
          row.names = FALSE, quote = FALSE) #postavke
```

## Grafički prikazi deskriptivne statistike

Boxplot usporedbe deskriptivne statistike s violin i jitter prikazom
distribucija.

``` r
boxplot_duljina <- ggplot(rakovi, aes(x = postaja, y = duljina)) +
  geom_violin(aes(fill = postaja), alpha = 0.5, color = "white") + 
  geom_boxplot() + 
  geom_jitter(aes(color = postaja)) +
  stat_summary(fun = mean, geom = "point", position = position_dodge(width = 0.75), shape = 18, size = 5) +
  labs(x = "", y = "Duljina (cm)")

boxplot_masa <- ggplot(rakovi, aes(x = postaja, y = masa)) +
  geom_violin(aes(fill = postaja), alpha = 0.5, color = "white") + 
  geom_boxplot() + 
  geom_jitter(aes(color = postaja)) +
  stat_summary(fun = mean, geom = "point", position = position_dodge(width = 0.75), shape = 18, size = 5) +
  labs(x = "", y = "Masa (g)")

boxplot_temperatura <- ggplot(rakovi, aes(x = postaja, y = temperatura)) +
  geom_violin(aes(fill = postaja), alpha = 0.5, color = "white") + 
  geom_boxplot() + 
  geom_jitter(aes(color = postaja)) +
  stat_summary(fun = mean, geom = "point", position = position_dodge(width = 0.75), shape = 18, size = 5) +
  labs(x = "", y = "Temperatura (°C)")

boxplot_patogeni <- ggplot(rakovi, aes(x = postaja, y = patogeni)) +
  geom_violin(aes(fill = postaja), alpha = 0.5, color = "white") + 
  geom_boxplot() + 
  geom_jitter(aes(color = postaja)) +
  stat_summary(fun = mean, geom = "point", position = position_dodge(width = 0.75), shape = 18, size = 5) +
  labs(x = "", y = "Patogeni")
```

``` r
# Prikaz svih plotova na jednom plotu
(boxplot_duljina + boxplot_masa) / (boxplot_temperatura + boxplot_patogeni)
```

![](README_files/figure-gfm/boxplot%20patchwork-1.png)<!-- -->

### Izvještaj deskriptivne statistike za istraživanje na rakovima

**Duljina uzorkovanih rakova** ima simetričnu zvonoliku distribuciju
nalik normalnoj što je vidljivo s histograma i boxplot prikaza. Grafovi
također pokazuju da distribucije duljina imaju podjednaku raspršenost
podataka na istočnoj i zapadnoj postaji. Prosječna duljina uzorkovanih
rakova s postaje istok iznosila je 15.67 cm sa standardnom devijacijom
od 1.04 cm. Prosječna duljina uzorkovanih rakova na zapadnoj postaji
bila je veća nego na istočnoj postaji te je iznosila 20.67 cm sa
standardnom devijacijom od 1.04 cm.

**Masa uzorkovanih rakova** ima nesimetričnu, desno nagnutu distrubuciju
nalik lognormalnoj. Masa rakova na istočnoj postaji imala je medijalnu
vrijednost od 86.96 g s interkvartilnim rasponom od 66.97 do 113.40 g.
Masa rakova sa zapadne postaje bila je viša od istočih s medijalnom
vrijednosti od 143.37 g te interkvartilnim rasponom od 110.42 do 186.96
g.

**Temperatura vode** izmjerena tijekom **uzorkovanja** rakova ima
simetričnu, uniformnu distribuciju velike raspršenosti. Temperatura na
postaji istok prosječno je iznosila 22.64 °C, s minimalnom vrijednosti
od 20.04 °C, a maksimalnom 24.96 °C. Temperatura na zapadnoj postaji
imala je nižu prosječnu vrijednost od 19.59 °C, ali veći raspon, krećuči
se od minimalno 15.01 °C do 24.80 °C.

**Broj patogena na uzorkovanim rakovima** ima izrazito nesimetričnu,
desno nagnutu distribuciju nalik eksponencijalnoj za obje postaje, s
time da istočna postaja ima veću raspršenost podataka. Medijalna
vrijednost broja patogena na rakovima s istočne postaje iznosila je 7, s
interkvartilnim rasponom od 2 do 15 patogena. Medijalna vrijednost broja
patogena na rakovima sa zapadne postaje bile je niža i iznosila 4 s
interkvartilnim rasponom od 1 do 7 patogena.

## Ogledni zadatak za Kolokvij 1

Upute:

- Kod za rješenje svakog zadatka mora biti napisan u skripti ispod tog
  zadatka.
- Kod mora biti napisan jedan ispod drugoga po redoslijedu izvršavanja.
- Suvišan (krivi) kod mora biti izbrisan.
- Sve naredbe koje možete, napišite preko koda, a ne klikanjem npr.
  postavljanje radnog direktorija.

**CILJ**: U setu podataka o pingvinima (“pingvini.xlsx”) napravite
usporedbu MASE pingvina po VRSTAMA!

1.  Napravite novu mapu naziva “samostalni_zadatak” unutar svoje
    postojeće mape i postavite ju kao radni direktorij. Provjerite jeste
    li dobro postavili radni direktorij.
2.  Učitajte tablicu u radno okruženje i pogledajte podatke.
3.  Napravite objekt koji sadrži samo podatke o vrsti i masi pingvina.
    Koristite ga za rješavanje ostalih zadataka.
4.  Grafički prikažite broj pingvina svake vrste. Koristite odgovarjući
    graf za prikaz kategoričke varijable, obojajte po vrsti i napišite
    osi na hrvatskom jeziku.
5.  Napravite histogram za masu pingvina svake vrste. Neka budu
    prikazani na jednom plotu.
6.  Opišite kako izgleda distribucija podataka o masi svake vrste s
    obzirom na simetričnost i nagnutost.
7.  Izračunajte deskriptivnu statistiku za masu (min, max, Q1, Q3,
    medijan i aritmetička sredina) svake vrste pingvina.
8.  Izračunajte standardnu devijaciju i standardnu pogrešku mase za
    svaku vrstu pingvina.
9.  S obzirom izgled distribucije, je li bolje koristiti aritmetičku
    sredinu ili medijan za prikaz centralne tendencije mase?
10. Boxplot prikazom prikažite mase uzorkovanih pingvina između vrsta s
    dodanom oznakom aritmetičke sredine.
11. Na temelju SVIH odrađenih grafika i izračuna deskriptivne statistike
    opišite i protumačite kako se ponaša masa pingvina za svaku vrstu u
    ovom istraživanju!

*Pazite da donositie zaključke za ovaj uzorak pingvina, a ne za
populaciju općenito!*
