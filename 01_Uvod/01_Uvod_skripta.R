# Analize podataka u biološkim istraživanjima - praktikum 2025/26
# Lucija Kanjer lucija.kanjer@biol.pmf.hr

##############################################################

# 1. Uvod i unos podataka u R i RStudio

# Ova skripta će vas upoznati sa radom u R-u i RStudio-u.
# Uključene su korištenje naredbe, ALI MOGU BITI NEPOTPUNE ILI SADRŽE NAMJERNE POGREŠKE:
# Dovršite naredbe i također dodajte komentare za sebe (koristite # za komentiranje)
#
# IZVRŠAVANJE NAREDBI: ctrl + Enter 
#
#############################################################

# Prva naredba: ispis teksta iz skripte u konzolu
print("Hello world!")

# Ovo je primjer komentara cijelog reda
print("Dobar dan svijete!") # ovo je komentar nakon naredbe

# Definiranje objekata (varijabli)
a <- 5
b = 3
ime <- "Lucija"

# Različiti načina ispisa
print(a) # ispis u konzoli
a # ispis u konzoli
print(a + b) # ispis rezultata u konzoli
cat("Ja sam", ime) # ispis više objekata i karaktera odjednom

# Primjer: Definirajte objekt svoje visine i godine rođenja
visina  <-
godina <- 
  
# Ispišite objekte u konzolu!
print()

# Osnovne operacije u R-u
# Zbroj
zbroj <- 5 + 3
print(zbroj)

# Umnožak
umnožak <- 4 * 7
print(umnožak)

# Razlika
razlika <-

# Kvocijent
kvocijent <-

# Kreiranje objekata u R-u - ručni unos
# 1. Varijable
x <- 3.14         # brojčana vrijednost
y <- "DNA"        # tekst (mora ići u navodnike)
z <- TRUE         # logička vrijednost (TRUE/FALSE)

# Provjera tipa podataka
class(x) # prikazuje samo tip varijable
str(x) # struktura: prikazuje tip varijable i što ona sadrži

# Provjerite tip podataka varijabli y i z!

# 2. Vektori
geni <- c("BRCA1", "TP53", "MYC")  # tekstualni vektor gena
print(geni)
duljine <- c(1863, 1179, 1584)     # numerički vektor duljina gena u parovima baza (bp)
print(duljine)

# Učitajte vektor numeričkih vrijednosti od 1 do 1000!

# 3. Matrice - skup vektora istog tipa
# Definiranje matrice
matrix_mikrobi <- matrix(c(85, 47, 37, 10, 65, 50, 28, 8), 
                         nrow = 4, # postavljanje broja redaka u matrici
                         byrow = TRUE) # definiranje popunjavanja matrice po retcima

# Dodavanje naziva redaka i stupaca
rownames(matrix_mikrobi) <- c("Bakterija1", "Bakterija2", "Gljivica1", "Gljivica2")
colnames(matrix_mikrobi) <- c("CFU_kuhinja", "CFU_kupaonica")

print(matrix_mikrobi)
View(matrix_mikrobi)
class(matrix_mikrobi)

# Na temelju gornjeg primjera kreirajte vlastiti matrix 
# s brojnostima vrsta organizama i lokacijama po vlastitom izboru!

# 4. Podatkovni okvir (data frame) - skup vektora različitih tipova
df_mikrobi <- data.frame(
  CFU = c(85, 47, 37, 10, 65, 50, 28, 8), # numerički vektor
  mikrorganizam = c("Bakterija", "Bakterija", "Gljivica", "Gljivica"),  # tekstualni vektor 
  lokacija = c("kuhinja", "kupaonica", "kuhinja", "kupaonica") # tekstualni vektor
)

# Uvid u data frame
print(df_mikrobi) # ispis u konzoli
View(df_mikrobi) # vizualizacija tablice u novom listu

# Rad s datotekama
# Provjeravanje radnog direktorija (working directory)
getwd()

# Postavljanje radnog direktorija
setwd("C:/Users/lucij/Documents/APUBI/01_Uvod/zivotinje")

# Traženje pomoći za naredbe i pakete:
help(setwd)
?setwd
??setwd

# Učitavanje datoteke s podacima u objekt "zivotinje"
zivotinje <- read.table("zivotinje.txt", header = TRUE)

# Kako pogledati svoje podatke?
print(zivotinje) # ispis cijele tablice u konzoli
head(zivotinje) # prikaz "glave" tablice tj. prvih 6 redaka
View(zivotinje) # prikaz u novom tabu pored skripte

# Za dodatne analize moramo instalirati dodatne R pakete
# Instalacija paketa - samo jednom
install.packages("ggplot2")

# Učitavanje paketa u radno okruženje - pri svakom pokretanju R-a
library(ggplot2)

# Primjer izrade grafa pomoću paketa ggplot2
# izrada objekta "graf_visina"
graf_visina <- ggplot(data = zivotinje, aes(x = vrsta, y = visina_cm)) +
  geom_boxplot(aes(fill = skupina)) + 
  labs(title = "Visina životinja",
       x = "vrsta",
       y = "visina (cm)")
# ispis objekta "graf"
graf_visina

# Izmjenite gornji graf tako da se umjesto visine prikazuju podaci za masu!
# Pazite da izmjenitie naslov grafa i nazive osi da odgovaraju novom prikazu.

####################################################################

# Samostalni zadaci

# 1. Kreirajte 3 varijable za visine 3 različite životinje.
# 2. Izračunajte i ispišite umnožak visine životinja koje ste upisali.
# 3. Napravite novu mapu naziva "biljke" te ju postavite kao novi radni direktorij.
# 4. Kreirajte 2 varijable, u jednu spremite ime vrste po vašem izboru, a u drugu broj jedinki te vrste.
# 5. Ispištie tip objekta za novokreirane varijable.
# 6. Kreirajte 2 vektora, u jednom pohranite tekstove, a u drugom brojeve.
# 7. Kreirajte data frame s biološkim podacima po vašem izboru, mora sadržavati 2 numeričke i 2 kategoričke varijable.
# 8. Ispišite strukturu novokreiranog data frame-a.



