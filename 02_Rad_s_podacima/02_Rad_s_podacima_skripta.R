# Analize podataka u biološkim istraživanjima - praktikum 2024
# Lucija Kanjer lucija.kanjer@biol.pmf.hr

##############################################################

# 3. Rad s podacima i objektima

# Uključene su sve korištenje naredbe, ALI NEKE SU NEPOTPUNE ILI SADRŽE NAMJERNE POGREŠKE:
# Dovršite naredbe i također dodajte komentare za sebe (koristite # za komentiranje)
#
# IZVRŠAVANJE NAREDBI: ctrl + Enter 
#
#############################################################

### Učitavanje datoteka
# Podsjetimo se naredbi za provjeru i postavljanje radnog direktorija!
getwd() #gdje smo?
setwd("C:/Users/lucij/Documents/APUBI") #izmjeniti za vaše računalo!
getwd() #provjera jesmo li dobro postavili

# Učitavanje Excel tablica
# Za Excel prvo moramo učitati paket "readxl"
#install.packages("readxl") # instalacija paketa readxl
library(readxl) # učitavanje paketa

# Učitavanje Excel tablice o kornjačama
kornjace <- read_excel("03_Rad_s_podacima/kornjace_tidy.xlsx")
View(kornjace) # ili klik na objekt u environmentu

# Pregled prvih redaka podataka
head(kornjace)

# Pregled zadnjih redaka podataka
tail(kornjace)

# Tipovi podataka - provjera strukture
str(kornjace)

### FAKTORI

# Nominalne kategoričke varijable - nominalni faktori
kornjace$rescue_centre <- factor(kornjace$rescue_centre)

# Ordinalne kategoričke varijable - ordinalnalni faktori
kornjace$age <- factor(kornjace$age,
                       levels = c("Juvenile", "Sub-adult", "Adult"),
                       ordered = TRUE)

# Provjera
str(kornjace)
levels(kornjace$age)
levels(kornjace$rescue_centre)

# Izvlačenje pojedinačnih stupaca i redaka iz data frame-a

# Stupac predstavlja varijable
dob_kornjaca <- kornjace$age  #data.frame$stupac
print(dob_kornjaca)
class(dob_kornjaca)

# Drugi način izvlačenja stupaca iz data frame-a
ime_kornjaca <- kornjace[,3]
print(ime_kornjaca)
class(ime_kornjaca)

# Koja je razlika između ova dva načina izvlačenja stupaca?


# Redak predstavlja uzorke
kornjaca_S1 <- kornjace[1, ] # data.frame[redak, stupac]
print(kornjaca_S1)

# Izdvojite lokaciju kornjača kao vektor u poseban objekt!
# Pokušajte na isti način izdvojiti pojedinačnu vrijednost imena kornjače S5!

################################################################################

# PITANJE: "Koja je prosječna duljina uzorkovanih kornjača po dobi iz Plavog svijeta izražena u milimetrima?

# Učitavanje tidyverse paketa za manipulaciju podacima
library(tidyverse)

# Korak 1: Odabir relevantnih varijabli (stupaca)
kornjace_selected <- select(kornjace, # podaci
                            age, # varijabla 1
                            rescue_centre, # varijabla 2
                            length_cm)# varijabla 3
head(kornjace_selected)

# Korak 2: Filtriranje kornjaca (redaka) iz centra Blue World Institute
kornjace_blue <- filter(kornjace_selected, # podaci
                          rescue_centre == "Blue World Institute") # uvjet filtriranja
print(kornjace_blue)

# Korak 3: Kreiranje nove varijable koja sadrži duljinu izraženu u milimetrima
kornjace_length_mm <- mutate(kornjace_blue, # podaci
                           length_mm = length_cm * 10) # kreiranje nove varijable
head(kornjace_length_mm)

# Korak 4: Zadavanje grupiranja i prikaza rezultata po otocima
kornjace_grouped <- group_by(kornjace_length_mm, # podaci
                             age) # varijabla po pokoj želimo grupirati
print(kornjace_grouped)

# Korak 5: Kreiranje finalne sumariziranje tablice rezultata
kornjace_result <- summarise(kornjace_grouped, # podaci
                             average_length = mean(length_mm)) # nova varijabla za prosjek

# Ispis konačnog rezultata
View(kornjace_result)

# Kako bi mogli izračunati rezultat juvenilne kornjače moramo ukloniti nedostajuće podatke
# Uklanjanje uzoraka s nedostajućim podacima
kornjace_cleaned <- na.omit(kornjace_length_mm)
print(kornjace_cleaned)

# Ponovimo korake 4 i 5 s novom tablicom
# Korak 4: Zadavanje grupiranja i prikaza rezultata po otocima
kornjace_grouped <- group_by(kornjace_cleaned, age)

# Korak 5: Kreiranje finalne sumariziranje tablice rezultata
kornjace_result <- summarise(kornjace_grouped, average_length = mean(length_mm))

# Ispis konačnog rezultata
View(kornjace_result)

### Zadatak
# Koristeći gornje funkcije za manipulaciju podacima, odgovorite na pitanje: 
# Koja je prosječna duljina uzorkovanih kornjača iz Aquariuma Pula po lokacijama?



# Korištenje pipe operatora za smanenje količine koda
kornjace_result_pipe <- kornjace %>% #podaci
  select(age, rescue_centre, length_cm) %>% #odabir relevantnih varijabli
  filter(rescue_centre == "Blue World Institute") %>% #filtriranje samo kornjaca iz Plavog Svijeta
  mutate(length_mm = length_cm * 10) %>% #kreiranje nove varijable
  na.omit() %>% #uklanjanje nedostajućih vrijednosti
  group_by(age) %>% #grupiranje po dobi
  summarise(average_length = mean(length_mm)) #sumariziraj kao prosjek

View(kornjace_result_pipe)

### Zadatak
# Koristeći pipe operator, odgovorite na pitanje: 
# Koja je prosječna duljina kornjača iz Aquariuma Pula po lokacijama?




