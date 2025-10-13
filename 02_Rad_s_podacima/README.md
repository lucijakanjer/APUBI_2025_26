Rad s objektima i podacima u R-u
================
dr. sc. Lucija Kanjer, e-mail: <lucija.kanjer@biol.pmf.hr>
2025/26

## Sadržaj današnje vježbe

Excel

- pretvaranje neuredne (*untidy*) u urednu (*tidy*) tablicu

R

- učitavanje Excel tablica
- faktori u R-u - način rada s kategoričkim varijablama
- odabir samo određenih varijabli iz seta podataka - naredba
  <code>select()</code>
- filtriranje uzoraka oadranih karakteristika - naredba
  <code>filter()</code>
- kreiranje nove varijable - naredba <code>mutate()</code>
- grupiranje rezultata po varijablama - naredba <code>group_by()</code>
- prikaz rezultata prosjeka varijabli po grupama - <code>naredba
  summarize()</code>
- uklanjanje nedostajućih vrijednosti - naredba <code>na.omit()</code>
- pisanje koda s pipe opetatorom (<code>%\>%</code>)

## Tipovi tablica u analizi podataka

**Tablice za vizualizaciju podataka** - koriste se u radovima,
izvještajima itd.

- Lako su čitljive ljudima, ne sadrže mnogo podataka, ne više od jedne
  stranice.
- Poruka tablice jasno je vidljiva, npr. prosjek jedne grupe je veći od
  ostalih.
- Sve vrijednosti jedne varijable su prikazane u istim mjernim
  jedinicama i s istim brojem decimalnih mjesta.

**Tablice za analizu podataka**

- Nazivaju se još *raw table* i *dataset*.
- Služe kao **uredno** spremište svih podataka na jednom mjestu.
- Koriste se kao *input* za računalne analize pa moraju biti
  napravljenje da ih **programi** koje korisrimo **mogu čitati**.
- U analizi podataka ovakve tablice se slažu u tzv. *tidy* tj. urednom
  formatu

## Data set KORNJAČE

U sklopu istraživanja raznolikosti mikrobioma glavatih želvi, skupljenji
su podaci o 27 jedinki koje dolaze iz centara za oporavak Plavi Svijet i
Aquarium Pula. Zabilježeni su podaci o dobi, duljini, širini i lokaciji
kornjača. Iz uzorka mikrobioma izolirana je ukupna DNA te izmjerena
njena koncentracija. Više o projektu možete vidjeti na linku:
<https://www.turtlebiome.biol.pmf.hr/>

![](https://github.com/lucijakanjer/APUBI_2025_26/blob/main/02_Rad_s_podacima/slike/kornjace_photo.jpg)

## *Untidy* tablica

- Otvorite datoteku “kornjace_untidy.xlsx”

![](https://github.com/lucijakanjer/APUBI_2025_26/blob/main/02_Rad_s_podacima/slike/kornjace_untidy.jpg)

## Sredite tablicu u *tidy* format!

- 1 varijabla = 1 stupac tablice
- 1 uzorak (opažanje) = 1 redak tablice
- 1 vrijednost = 1 kućica tablice

**Pazite!** U biologiji je često 1 uzorak = 1 jedinka, ali i ne mora
biti tako! Ako np. uzorkujemo jedinku više puta, onda svako uzorkovanje
= 1 opažanje i predstavlja 1 redak u tablici.

![](https://github.com/lucijakanjer/APUBI_2025_26/blob/main/02_Rad_s_podacima/slike/tidy_rules.jpg)

## Najčešće greške

- Imena stupaca nisu varijable, nego vrijednosti.
- Spajanje dvije varijable u isti stupac.
- Spajanje ćelija istih vrijednosti u tablici.
- Spajanje naziva stupaca/redova.
- Puštanje praznih redova i stupaca.
- Kreiranje više tablica u istom dokumentu.

## Preporuke

- maknuti sve boje,
- maknuti svo formatiranje (podebljani font, kurziv, crte između
  tablica),
- ne pisati razmak u imenima stupaca (varijabli),
- pisati imena varijabli istim stilom,
- uobičajeni stilovi pisanja varijabli u R-u: <code>ime_varijable</code>
  i <code>ImeVarijable</code>,
- pišite puna imena varijabli, a ne skraćenice (npr. M i F može značite
  *male* i *female*, a može značiti i *mother* i *father*).

## Rezultat - *tidy* tablica kornjača!

![](https://github.com/lucijakanjer/APUBI_2025_26/blob/main/02_Rad_s_podacima/slike/kornjace_tidy.jpg)

## Rad s podacima u R-u

### Tidyverse skup paketa

![](https://github.com/lucijakanjer/APUBI_2025_26/blob/main/02_Rad_s_podacima/slike/tidyverse.png)

- **Tidyverse** je skup međusobno povezanih R paketa osmišljenih za
  olakšavanje **rada s podacima**.
- Osnovna filozofija Tidyverse-a je **“tidy” (uredan) oblik podataka**,
  gdje su podaci organizirani u tabličnom formatu (**redovi
  predstavljaju opažanja**, a **stupci varijable**).
- Omogućava intuitivno i efikasno manipuliranje, analiziranje i
  vizualiziranje podataka.
- Istovjetne naredbe ponekad su dostupne i u *base R*-u, ali tidyverse
  je češće korišten u praksi i pruža puno više mogućnosti za rad s
  podacima.

### Osnovni paketi u Tidyverse-u

![](https://github.com/lucijakanjer/APUBI_2025_26/blob/main/02_Rad_s_podacima/slike/tidyverse_packages.png)

- **ggplot2** – Napredna i fleksibilna vizualizacija podataka.
- **dplyr** – Efikasna manipulacija podacima (filtriranje, sortiranje,
  agregacija).
- **tidyr** – Transformacija podataka u “tidy” format.
- **readr** – Učitavanje podataka iz tekstualnih datoteka (CSV, TSV).
- **tibble** – Poboljšani rad s tablicama, alternativa data.frame-u.

## Otvorite skriptu “02_Rad_s_podacima_skripta.R”!

### Učitavanje datoteka

- Podsjetimo se naredbi za provjeru i postavljanje radnog direktorija!

``` r
getwd() #gdje smo?
```

    ## [1] "C:/Users/lucij/Documents/APUBI/03_Rad_s_podacima"

``` r
setwd("C:/Users/lucij/Documents/APUBI") #izmjeniti za vaše računalo!
getwd() #provjera jesmo li dobro postavili
```

    ## [1] "C:/Users/lucij/Documents/APUBI"

## Učitavanje Excel tablica

- Za Excel prvo moramo instalirati i učitati paket “readxl”
- <code>install.packages(“readxl”)</code> - ako paket nije instaliran

``` r
library(readxl) # učitavanje paketa
```

### Učitavanje tablice o kornjačama

``` r
kornjace <- read_excel("kornjace_tidy.xlsx")
View(kornjace) # ili klik na objekt u environmentu
```

![](https://github.com/lucijakanjer/APUBI_2025_26/blob/main/02_Rad_s_podacima/slike/kornjace_view.jpg)

``` r
# Pregled prvih redaka podataka
head(kornjace)
```

    ## # A tibble: 6 × 13
    ##   sample_ID turtle_ID turtle_name age      length_cm width_cm sampling_date
    ##   <chr>     <chr>     <chr>       <chr>        <dbl>    <dbl> <chr>        
    ## 1 S1        TB175     Maksimus    Juvenile      45.2     44.2 28.7.2020.   
    ## 2 S2        TB181     CC_VIS_2001 Juvenile      42       37   29.6.2020.   
    ## 3 S3        TB183     CC_VIS_2002 Juvenile      31       29   11.8.2020.   
    ## 4 S4        TB185     CC_VIS_2003 Juvenile      31       28   20.8.2020.   
    ## 5 S5        TB189     Valbiska    Juvenile      30       27.5 5.11.2020.   
    ## 6 S6        TB195     FS35        Juvenile      45       41   10.12.2020.  
    ## # ℹ 6 more variables: rescue_centre <chr>, location <chr>, latitude <dbl>,
    ## #   longitude <dbl>, DNA_concentration <dbl>, DNA_quality <chr>

``` r
# Pregled zadnjih redaka podataka
tail(kornjace)
```

    ## # A tibble: 6 × 13
    ##   sample_ID turtle_ID turtle_name  age       length_cm width_cm sampling_date
    ##   <chr>     <chr>     <chr>        <chr>         <dbl>    <dbl> <chr>        
    ## 1 S22       TB177     Špela        Sub-adult      68         67 3.8.2020.    
    ## 2 S23       TB191     FS94         Sub-adult      67.5       66 30.11.2020.  
    ## 3 S24       TB197     FS25         Adult          70         67 19.12.2020.  
    ## 4 S25       TB199     FS60         Adult          73         68 19.12.2020.  
    ## 5 S26       TB215     Karlo Albano Adult          73         73 25.3.2021.   
    ## 6 S27       TB223     Bova         Adult          70         64 8.6.2021.    
    ## # ℹ 6 more variables: rescue_centre <chr>, location <chr>, latitude <dbl>,
    ## #   longitude <dbl>, DNA_concentration <dbl>, DNA_quality <chr>

``` r
# Tipovi podataka - provjera strukture
str(kornjace)
```

    ## tibble [27 × 13] (S3: tbl_df/tbl/data.frame)
    ##  $ sample_ID        : chr [1:27] "S1" "S2" "S3" "S4" ...
    ##  $ turtle_ID        : chr [1:27] "TB175" "TB181" "TB183" "TB185" ...
    ##  $ turtle_name      : chr [1:27] "Maksimus" "CC_VIS_2001" "CC_VIS_2002" "CC_VIS_2003" ...
    ##  $ age              : chr [1:27] "Juvenile" "Juvenile" "Juvenile" "Juvenile" ...
    ##  $ length_cm        : num [1:27] 45.2 42 31 31 30 45 36 55 35.5 40.5 ...
    ##  $ width_cm         : num [1:27] 44.2 37 29 28 27.5 41 34 53.5 33 38 ...
    ##  $ sampling_date    : chr [1:27] "28.7.2020." "29.6.2020." "11.8.2020." "20.8.2020." ...
    ##  $ rescue_centre    : chr [1:27] "Aquarium Pula" "Blue World Institute" "Blue World Institute" "Blue World Institute" ...
    ##  $ location         : chr [1:27] "Porer island" "Vis island" "Vis island" "Vis island" ...
    ##  $ latitude         : num [1:27] 15.2 16.9 17.1 13.9 13.8 ...
    ##  $ longitude        : num [1:27] 44.1 42.8 43 44.8 45 ...
    ##  $ DNA_concentration: num [1:27] 31.5 27.1 20.7 100.1 87.6 ...
    ##  $ DNA_quality      : chr [1:27] "good" "good" "good" "good" ...

## Faktori

- način zapisivanja kategoričkih varijabli u R-u
- često treba ručno pretvoriti iz tekstualnog (*character*) tipa u
  faktor
- mogu biti nominalni (kalsa *factor*) ili ordinalni (klasa *ordered
  factor*)

``` r
# Nominalne kategoričke varijable - nominalni faktori
kornjace$rescue_centre <- factor(kornjace$rescue_centre)

# Ordinalne kategoričke varijable - ordinalnalni faktori
kornjace$age <- factor(kornjace$age,
                       levels = c("Juvenile", "Sub-adult", "Adult"),
                       ordered = TRUE)

# Provjera struktura
str(kornjace)
```

    ## tibble [27 × 13] (S3: tbl_df/tbl/data.frame)
    ##  $ sample_ID        : chr [1:27] "S1" "S2" "S3" "S4" ...
    ##  $ turtle_ID        : chr [1:27] "TB175" "TB181" "TB183" "TB185" ...
    ##  $ turtle_name      : chr [1:27] "Maksimus" "CC_VIS_2001" "CC_VIS_2002" "CC_VIS_2003" ...
    ##  $ age              : Ord.factor w/ 3 levels "Juvenile"<"Sub-adult"<..: 1 1 1 1 1 1 1 1 1 1 ...
    ##  $ length_cm        : num [1:27] 45.2 42 31 31 30 45 36 55 35.5 40.5 ...
    ##  $ width_cm         : num [1:27] 44.2 37 29 28 27.5 41 34 53.5 33 38 ...
    ##  $ sampling_date    : chr [1:27] "28.7.2020." "29.6.2020." "11.8.2020." "20.8.2020." ...
    ##  $ rescue_centre    : Factor w/ 2 levels "Aquarium Pula",..: 1 2 2 2 2 2 2 2 2 2 ...
    ##  $ location         : chr [1:27] "Porer island" "Vis island" "Vis island" "Vis island" ...
    ##  $ latitude         : num [1:27] 15.2 16.9 17.1 13.9 13.8 ...
    ##  $ longitude        : num [1:27] 44.1 42.8 43 44.8 45 ...
    ##  $ DNA_concentration: num [1:27] 31.5 27.1 20.7 100.1 87.6 ...
    ##  $ DNA_quality      : chr [1:27] "good" "good" "good" "good" ...

``` r
# Provjera levela (kategorija)
levels(kornjace$age)
```

    ## [1] "Juvenile"  "Sub-adult" "Adult"

``` r
levels(kornjace$rescue_centre)
```

    ## [1] "Aquarium Pula"        "Blue World Institute"

## Izvlačenje pojedinačnih stupaca i redaka iz data frame-a

- Stupac predstavlja varijable
- Redak predstavlja uzorke

**Prvi način izvlačenja stupaca iz data frame-a**

``` r
dob_kornjaca <- kornjace$age  #data.frame$stupac
print(dob_kornjaca)
```

    ##  [1] Juvenile  Juvenile  Juvenile  Juvenile  Juvenile  Juvenile  Juvenile 
    ##  [8] Juvenile  Juvenile  Juvenile  Juvenile  Juvenile  Juvenile  Juvenile 
    ## [15] Juvenile  Juvenile  Juvenile  Juvenile  Sub-adult Sub-adult Sub-adult
    ## [22] Sub-adult Sub-adult Adult     Adult     Adult     Adult    
    ## Levels: Juvenile < Sub-adult < Adult

``` r
class(dob_kornjaca)
```

    ## [1] "ordered" "factor"

**Drugi način izvlačenja stupaca iz data frame-a**

``` r
ime_kornjaca <- kornjace[,3]
print(ime_kornjaca)
```

    ## # A tibble: 27 × 1
    ##    turtle_name   
    ##    <chr>         
    ##  1 Maksimus      
    ##  2 CC_VIS_2001   
    ##  3 CC_VIS_2002   
    ##  4 CC_VIS_2003   
    ##  5 Valbiska      
    ##  6 FS35          
    ##  7 Apox          
    ##  8 CC_LOŠINJ_2102
    ##  9 Zlata         
    ## 10 Noemi         
    ## # ℹ 17 more rows

``` r
class(ime_kornjaca)
```

    ## [1] "tbl_df"     "tbl"        "data.frame"

### Koja je razlika između ova dva načina izvlačenja stupaca?

- Prvi način izvlači stupac u vektor
- drugi način izvlači stupac u *data frame*

#### Izvlačenja redaka

``` r
kornjaca_S1 <- kornjace[1, ] # data.frame[redak, stupac]
print(kornjaca_S1)
```

    ## # A tibble: 1 × 13
    ##   sample_ID turtle_ID turtle_name age      length_cm width_cm sampling_date
    ##   <chr>     <chr>     <chr>       <ord>        <dbl>    <dbl> <chr>        
    ## 1 S1        TB175     Maksimus    Juvenile      45.2     44.2 28.7.2020.   
    ## # ℹ 6 more variables: rescue_centre <fct>, location <chr>, latitude <dbl>,
    ## #   longitude <dbl>, DNA_concentration <dbl>, DNA_quality <chr>

#### Izdvojite lokaciju kornjača kao vektor u poseban objekt!

``` r
lokacija_kornjaca <- kornjace$location
print(lokacija_kornjaca)
```

    ##  [1] "Porer island"     "Vis island"       "Vis island"       "Vis island"      
    ##  [5] "Krk island"       "Susak island"     "Mali Lošinj"      "Lošinj island"   
    ##  [9] "Mali Lošinj"      "Veli Lošinj"      "Mali Lošinj"      "Lošinj island"   
    ## [13] "Medulin"          "Mali Lošinj"      "Mali Lošinj"      "Susak island"    
    ## [17] "Trstenika island" "Mali Lošinj"      "Zadar"            "Lastovo island"  
    ## [21] "Korčula island"   "Barbariga"        "Susak island"     "Susak island"    
    ## [25] "Susak island"     "Dugi island"      "Vis island"

#### Pokušajte na isti način izdvojiti pojedinačnu vrijednost imena kornjače S5!

``` r
kornjaca_S5_name <- kornjace[5,3] # data.frame[redak, stupac]
print(kornjaca_S5_name)
```

    ## # A tibble: 1 × 1
    ##   turtle_name
    ##   <chr>      
    ## 1 Valbiska

## PITANJE: “Koja je prosječna duljina uzorkovanih kornjača po dobi iz Plavog svijeta izražena u milimetrima?”

``` r
# Učitavanje tidyverse paketa za manipulaciju podacima
library(tidyverse)
```

    ## ── Attaching core tidyverse packages ──────────────────────── tidyverse 2.0.0 ──
    ## ✔ dplyr     1.1.4     ✔ readr     2.1.5
    ## ✔ forcats   1.0.0     ✔ stringr   1.5.1
    ## ✔ ggplot2   4.0.0     ✔ tibble    3.3.0
    ## ✔ lubridate 1.9.4     ✔ tidyr     1.3.1
    ## ✔ purrr     1.1.0     
    ## ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
    ## ✖ dplyr::filter() masks stats::filter()
    ## ✖ dplyr::lag()    masks stats::lag()
    ## ℹ Use the conflicted package (<http://conflicted.r-lib.org/>) to force all conflicts to become errors

- Kako bi odgovorili na to pitanje, najlakše je stvoriti novi tablicu u
  kojoj ćemo **odabrati** samo one varijable koje su nam potrebne za
  izračun: age, rescue_centre i length_cm.

### Korak 1: Odabir relevantnih varijabli (stupaca) - naredba <code>select()</code>

- Naredba **<code>select()</code>** je funkcija iz dplyr paketa koja
  služi za odabir (selektiranje) specifičnih stupaca iz data frame-a.
  Pomaže u fokusiranju samo na one varijable (stupce) koje su potrebne
  za analizu, a ignorira ostatak podataka.
- Primjer: **<code>select(podaci, varijabla1, varijabla2, …)</code>**

``` r
kornjace_selected <- select(kornjace, # podaci
                            age, # varijabla 1
                            rescue_centre, # varijabla 2
                            length_cm)# varijabla 3
head(kornjace_selected)
```

    ## # A tibble: 6 × 3
    ##   age      rescue_centre        length_cm
    ##   <ord>    <fct>                    <dbl>
    ## 1 Juvenile Aquarium Pula             45.2
    ## 2 Juvenile Blue World Institute      42  
    ## 3 Juvenile Blue World Institute      31  
    ## 4 Juvenile Blue World Institute      31  
    ## 5 Juvenile Blue World Institute      30  
    ## 6 Juvenile Blue World Institute      45

### Korak 2: Filtriranje kornjaca (redaka) iz centra Blue World Institute - naredba <code>filter()</code>

- **<code>filter()</code>** je funkcija iz dplyr paketa koja služi za
  filtriranje redova u *data frame*-u.
  - Zadržava samo one redove koji zadovoljavaju specificirane uvjete.
  - **Čitljivost** - Jasno izražava uvjete u kodu.
  - **Fleksibilnost** - Moguće kombinirati više uvjeta korištenjem
    logičkih operatora (&, \|).

![](https://github.com/lucijakanjer/APUBI_2025_26/blob/main/02_Rad_s_podacima/slike/filter.png)
Slika preuzeta s: <https://allisonhorst.com/r-packages-functions>

``` r
kornjace_blue <- filter(kornjace_selected, # podaci
                          rescue_centre == "Blue World Institute") # uvjet filtriranja
print(kornjace_blue)
```

    ## # A tibble: 19 × 3
    ##    age       rescue_centre        length_cm
    ##    <ord>     <fct>                    <dbl>
    ##  1 Juvenile  Blue World Institute      42  
    ##  2 Juvenile  Blue World Institute      31  
    ##  3 Juvenile  Blue World Institute      31  
    ##  4 Juvenile  Blue World Institute      30  
    ##  5 Juvenile  Blue World Institute      45  
    ##  6 Juvenile  Blue World Institute      36  
    ##  7 Juvenile  Blue World Institute      55  
    ##  8 Juvenile  Blue World Institute      35.5
    ##  9 Juvenile  Blue World Institute      40.5
    ## 10 Juvenile  Blue World Institute      32  
    ## 11 Juvenile  Blue World Institute      40  
    ## 12 Juvenile  Blue World Institute      31  
    ## 13 Juvenile  Blue World Institute      NA  
    ## 14 Juvenile  Blue World Institute      26  
    ## 15 Juvenile  Blue World Institute      27  
    ## 16 Sub-adult Blue World Institute      67.5
    ## 17 Adult     Blue World Institute      70  
    ## 18 Adult     Blue World Institute      73  
    ## 19 Adult     Blue World Institute      70

### Korak 3: Kreiranje nove varijable koja sadrži duljinu izraženu u milimetrima - naredba <code>mutate()</code>

- **<code>mutate()</code>** je funkcija iz dplyr paketa koja služi za
  kreiranje novih stupaca (varijabli) ili modifikaciju postojećih unutar
  data frame-a.
- Pomaže u dodavanju izmjenjenih varijabli bez potrebe za kreiranjem
  novog data frame-a.
- koristit ćemo funkciju **<code>mutate()</code>** kako bi kreirali novu
  varijablu koja prikazuje masu pingvina u kilogramima umjesto u
  gramima.

![](https://github.com/lucijakanjer/APUBI_2025_26/blob/main/02_Rad_s_podacima/slike/mutate.png)
Slika preuzeta s: <https://allisonhorst.com/r-packages-functions>

``` r
kornjace_length_mm <- mutate(kornjace_blue, # podaci
                           length_mm = length_cm * 10) # kreiranje nove varijable
head(kornjace_length_mm)
```

    ## # A tibble: 6 × 4
    ##   age      rescue_centre        length_cm length_mm
    ##   <ord>    <fct>                    <dbl>     <dbl>
    ## 1 Juvenile Blue World Institute        42       420
    ## 2 Juvenile Blue World Institute        31       310
    ## 3 Juvenile Blue World Institute        31       310
    ## 4 Juvenile Blue World Institute        30       300
    ## 5 Juvenile Blue World Institute        45       450
    ## 6 Juvenile Blue World Institute        36       360

### Korak 4: Zadavanje grupiranja i prikaza rezultata po otocima

- **<code>group_by()</code>** je funkcija iz dplyr paketa koja omogućava
  grupiranje podataka prema jednoj ili više varijabli.
- Koristi se često u kombinaciji s funkcijama poput
  **<code>summarise()</code>** za izvođenje agregatnih operacija unutar
  svake grupe.

``` r
kornjace_grouped <- group_by(kornjace_length_mm, # podaci
                             age) # varijabla po pokoj želimo grupirati
print(kornjace_grouped)
```

    ## # A tibble: 19 × 4
    ## # Groups:   age [3]
    ##    age       rescue_centre        length_cm length_mm
    ##    <ord>     <fct>                    <dbl>     <dbl>
    ##  1 Juvenile  Blue World Institute      42         420
    ##  2 Juvenile  Blue World Institute      31         310
    ##  3 Juvenile  Blue World Institute      31         310
    ##  4 Juvenile  Blue World Institute      30         300
    ##  5 Juvenile  Blue World Institute      45         450
    ##  6 Juvenile  Blue World Institute      36         360
    ##  7 Juvenile  Blue World Institute      55         550
    ##  8 Juvenile  Blue World Institute      35.5       355
    ##  9 Juvenile  Blue World Institute      40.5       405
    ## 10 Juvenile  Blue World Institute      32         320
    ## 11 Juvenile  Blue World Institute      40         400
    ## 12 Juvenile  Blue World Institute      31         310
    ## 13 Juvenile  Blue World Institute      NA          NA
    ## 14 Juvenile  Blue World Institute      26         260
    ## 15 Juvenile  Blue World Institute      27         270
    ## 16 Sub-adult Blue World Institute      67.5       675
    ## 17 Adult     Blue World Institute      70         700
    ## 18 Adult     Blue World Institute      73         730
    ## 19 Adult     Blue World Institute      70         700

### Korak 5: Kreiranje finalne sumarizirane tablice rezultata

- **<code>summarise()</code>** ili **<code>summarize()</code>** je
  funkcija iz dplyr paketa koja se koristi za sažimanje podataka na
  temelju agregatnih operacija.
- Najčešće se koristi u kombinaciji s **<code>group_by()</code>** kako
  bi se izračunale sumarizirane statistike unutar grupa.

``` r
kornjace_result <- summarise(kornjace_grouped, # podaci
                             average_length = mean(length_mm)) # nova varijabla za prosjek

# Ispis konačnog rezultata
print(kornjace_result)
```

    ## # A tibble: 3 × 2
    ##   age       average_length
    ##   <ord>              <dbl>
    ## 1 Juvenile              NA
    ## 2 Sub-adult            675
    ## 3 Adult                710

#### Zašto nam se ne prikazuju podaci za juvenilne kornjače?

- Jer nismo uklonili nedostajuće vrijednosti!
- Koristiti funkciju na.omit().

### Funkcija **<code>na.omit()</code>**

- **<code>na.omit()</code>** funkcija iz *base* R-a koja se koristi za
  **uklanjanje redaka s nedostajućim vrijednostima (NA)** iz data
  frame-a ili vektora.
- Vraća filtrirani data frame bez redaka s *NA* vrijednostima.

``` r
kornjace_cleaned <- na.omit(kornjace_length_mm)
print(kornjace_cleaned)
```

    ## # A tibble: 18 × 4
    ##    age       rescue_centre        length_cm length_mm
    ##    <ord>     <fct>                    <dbl>     <dbl>
    ##  1 Juvenile  Blue World Institute      42         420
    ##  2 Juvenile  Blue World Institute      31         310
    ##  3 Juvenile  Blue World Institute      31         310
    ##  4 Juvenile  Blue World Institute      30         300
    ##  5 Juvenile  Blue World Institute      45         450
    ##  6 Juvenile  Blue World Institute      36         360
    ##  7 Juvenile  Blue World Institute      55         550
    ##  8 Juvenile  Blue World Institute      35.5       355
    ##  9 Juvenile  Blue World Institute      40.5       405
    ## 10 Juvenile  Blue World Institute      32         320
    ## 11 Juvenile  Blue World Institute      40         400
    ## 12 Juvenile  Blue World Institute      31         310
    ## 13 Juvenile  Blue World Institute      26         260
    ## 14 Juvenile  Blue World Institute      27         270
    ## 15 Sub-adult Blue World Institute      67.5       675
    ## 16 Adult     Blue World Institute      70         700
    ## 17 Adult     Blue World Institute      73         730
    ## 18 Adult     Blue World Institute      70         700

Ponovimo korake 4 i 5 s novom tablicom!

``` r
# Korak 4: Zadavanje grupiranja i prikaza rezultata po otocima
kornjace_grouped <- group_by(kornjace_cleaned, age)

# Korak 5: Kreiranje finalne sumariziranje tablice rezultata
kornjace_result <- summarise(kornjace_grouped, average_length = mean(length_mm))

# Ispis konačnog rezultata
print(kornjace_result)
```

    ## # A tibble: 3 × 2
    ##   age       average_length
    ##   <ord>              <dbl>
    ## 1 Juvenile            359.
    ## 2 Sub-adult           675 
    ## 3 Adult               710

## Odgovor na postavljeno pitanje pitanje s početka

Prosječna duljina uzorkovanih kornjača iz Plavog svijeta iznosila je
358.6 mm za juvenilne kornjače, 675.0 mm za sub-adultne kornjače i 710.0
mm za adultne kornjače.

## **Zadatak** - Koristeći gornje funkcije za manipulaciju podacima, odgovorite na pitanje: **Koja je prosječna duljina uzorkovanih kornjača iz Aquariuma Pula po lokacijama?**

``` r
# Rješenje
# Korak 1: Selektiranje relevantnih varijabli
kornjace_selected_2 <- select(kornjace, length_cm, rescue_centre, location)
# # Korak 2: Filtriranje uzoraka (redaka) vrste "Gentoo"
kornjace_aquarium <- filter(kornjace_selected_2, rescue_centre == "Aquarium Pula")
#Korak 3: Uklanjanje nedostajućih vrijednosti
kornjace_cleaned_2 <- na.omit(kornjace_aquarium)
# Korak 4: Zadavanje grupiranja i prikaza rezultata po spolu
kornjace_grouped_2 <- group_by(kornjace_cleaned_2, location)
# Korak 5: Kreiranje finalne sumariziranje tablice rezultata
kornjace_result_2 <- summarise(kornjace_grouped_2, average_length = mean(length_cm))

print(kornjace_result_2)
```

    ## # A tibble: 8 × 2
    ##   location       average_length
    ##   <chr>                   <dbl>
    ## 1 Barbariga                68  
    ## 2 Dugi island              73  
    ## 3 Korčula island           67  
    ## 4 Lastovo island           68  
    ## 5 Mali Lošinj              37.8
    ## 6 Medulin                  26  
    ## 7 Porer island             45.2
    ## 8 Zadar                    62

## Kako smanjiti količinu napisanog koda? - **Pipe operator (%\>%)**

- Pipe operator (%\>%) dolazi iz magrittr paketa (dio Tidyverse-a) i
  koristi se za povezivanje više funkcija na čitljiviji način.
- Omogućuje prosljeđivanje rezultata iz jedne funkcije kao ulaz u
  sljedeću funkciju bez potrebe za ugnježđivanjem.

Prednosti:

- Čitljivost – Kod je linearan i lakši za razumijevanje.
- Modularnost – Lako povezivanje različitih operacija bez pretrpavanja.
- Fleksibilnost – Može se koristiti s većinom funkcija.

#### Primjer pisanja koda pomoći pipe operatora

``` r
# Korištenje pipe operatora za smanenje količine koda
kornjace_result_pipe <- kornjace %>% #podaci
  select(age, rescue_centre, length_cm) %>% #odabir relevantnih varijabli
  filter(rescue_centre == "Blue World Institute") %>% #filtriranje samo kornjaca iz Plavog Svijeta
  mutate(length_mm = length_cm * 10) %>% #kreiranje nove varijable
  na.omit() %>% #uklanjanje nedostajućih vrijednosti
  group_by(age) %>% #grupiranje po dobi
  summarise(average_length = mean(length_mm)) #sumariziraj kao prosjek

print(kornjace_result_pipe)
```

    ## # A tibble: 3 × 2
    ##   age       average_length
    ##   <ord>              <dbl>
    ## 1 Juvenile            359.
    ## 2 Sub-adult           675 
    ## 3 Adult               710

## **Zadatak** - Koristeći pipe operator, odgovorite na pitanje: **Koja je prosječna duljina kornjača iz Aquariuma Pula po lokacijama?**

``` r
# Rješenje
kornjace_result_pipe_2 <- kornjace %>% #podaci
  select(length_cm, rescue_centre, location) %>% #odabir relevantnih varijabli
  filter(rescue_centre == "Aquarium Pula") %>% #filtriranje samo kornjaca iz Plavog Svijeta
  na.omit() %>% #uklanjanje nedostajućih vrijednosti
  group_by(location) %>% #grupiranje po dobi
  summarise(average_length = mean(length_cm)) #sumariziraj kao prosjek

print(kornjace_result_pipe_2)
```

    ## # A tibble: 8 × 2
    ##   location       average_length
    ##   <chr>                   <dbl>
    ## 1 Barbariga                68  
    ## 2 Dugi island              73  
    ## 3 Korčula island           67  
    ## 4 Lastovo island           68  
    ## 5 Mali Lošinj              37.8
    ## 6 Medulin                  26  
    ## 7 Porer island             45.2
    ## 8 Zadar                    62

## Dodatni izvori

- <https://openscapes.org/blog/2020-10-12-tidy-data/>
- <https://www.datacamp.com/tutorial/factors-in-r>
- <https://r4ds.had.co.nz/factors.html>

## Kviz za ponavljanje

Link na kviz:
<https://forms.cloud.microsoft/e/9SfYdhmPE6?origin=lprLink>

Ili:

![](https://github.com/lucijakanjer/APUBI_2025_26/blob/main/02_Rad_s_podacima/slike/kviz_vj2.png)
