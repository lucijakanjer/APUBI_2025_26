# Analize podataka u biološkim istraživanjima - praktikum 25/26
# Lucija Kanjer lucija.kanjer@biol.pmf.hr

##############################################################

# 4. Grafički prikaz bioloških podataka u R-u -2

# Uključene su sve korištenje naredbe, ALI NEKE SU NEPOTPUNE ILI SADRŽE NAMJERNE POGREŠKE:
# Dovršite naredbe i također dodajte komentare za sebe (koristite # za komentiranje)
#
# IZVRŠAVANJE NAREDBI: ctrl + Enter 
#
#############################################################

# Učitavanje paketa
library(ggplot2) # paket za crtanje grafova
library(dplyr) # paket za manipulaciju tablicama
library(palmerpenguins) # paket o pingvinima

penguins <- penguins

View(penguins)

##############################################################


# Grafički prikazi po tipu varijabli

# 1. Grafički prikazi kategoričkih varijabli

# Barplot za prikaz distribucije pingvina po vrstama.

ggplot(penguins, aes(x = species)) + 
  geom_bar() + 
  theme_minimal()

# Kako prikazati kategorije vrste od najbrojnije do najmanje brojne?
# Moramo pretvoriti kategoričku varijablu "species" u faktor!

penguins$species <- factor(penguins$species, levels = names(sort(table(penguins$species), decreasing = TRUE)))


# 2. Grafički prikazi numeričkih varijabli
# 2.1 Histogram za prikaz distribucije mase tijela pingvina.
ggplot(penguins, aes(x = body_mass_g)) +
  geom_histogram(binwidth = 100, color = "black", fill = "aquamarine") + 
  theme_minimal()

# Poigrajte se s opcijom "binwidth"!
# Što se događa s grafom? Koja vrijednost najbolje pokazuje distrubuciju?

# Napravite histogram za još jednu numeričku varijablu!
# Koja opcija binwidth je najbolja za tu varijablu?


# 3. Prikaz odnosa između dvije kategoričke varijable

# 3.1 Stacked bar plot
ggplot(data = penguins, aes(x = species, fill = sex)) +
  geom_bar() +
  theme_minimal()

# 3.1 Bar plot
ggplot(data = penguins, aes(x = species, fill = sex)) +
  geom_bar(position = "dodge") +
  theme_minimal()

# Relativni odnos
ggplot(data = penguins, aes(x = species, fill = sex)) +
  geom_bar(position = "fill") + 
  theme_minimal()

# Prisjetite se gradiva prošle vježbe i uklonite nedostajuće vrijednosti pa ponovite grafove!

# 4. Prikaz odnosa između dvije numeričke varijable
# 4.1 Točkaskti graf (scatter plot)
ggplot(data = penguins, aes(x = bill_length_mm, y = bill_depth_mm)) +
  geom_point(aes(shape = species, color = species)) +
  theme_minimal()

# 5. Prikaz odnosa između numeričke i kategoričke varijable
# 5.1 Box plot
ggplot(data = penguins, aes(x = species, y = body_mass_g, fill = species)) +
  geom_boxplot() +
  theme_minimal()

# 5.2 Strip chart (jitter)
ggplot(data = penguins, aes(x = species, y = body_mass_g, color = species)) +
  geom_jitter() +
  theme_minimal()

# Kombinacija boxplota i jittera
ggplot(data = penguins, aes(x = species, y = body_mass_g, fill = species)) +
  geom_boxplot() + geom_jitter() +
  theme_minimal()

# 5.3 Violin plot
ggplot(data = penguins, aes(x = species, y = body_mass_g, fill = species)) +
  geom_violin() +
  theme_minimal()

# 5.4 Višestruki histogrami
ggplot(data = penguins, aes(x = body_mass_g, fill = species)) +
  geom_histogram(binwidth = 200, color = "black") +
  facet_wrap( ~ species, ncol = 1, scales = "free_y", strip.position = "right") +
  theme_minimal()

# Zadatak: Napravite višestruki histogram za duljinu peraja!

### Spajanje više grafova u jedan - paket patchwork

#install.packages("patchwork")
library(patchwork)

# prvo spremamo grafove u objekte
barplot <- ggplot(penguins, aes(x = species, fill = species)) + 
  geom_bar() + 
  theme_minimal()

histogram <- ggplot(penguins, aes(x = body_mass_g)) +
  geom_histogram(binwidth = 300, color = "black", fill = "aquamarine") + 
  theme_minimal()

# Ispis barplota jedan pored drugoga
barplot + histogram

# Zadatak: ispišite barplot i histogram jedan ispod drugoga!


### Eksportiranje ggplot grafa kao slike ili PDF dokumenta

ggsave(filename = "histogram.jpg", # naziv JPG slike
       plot = histogram, # koji objekt želimo eksportirati
       width = 8, height = 6, # dimenzije u inčima
       dpi = 300) # dots per inch

ggsave(filename = "histogram.pdf", 
       plot = histogram,
       width = 8, height = 6, 
       device = cairo_pdf) # naziv metode eksporta za PDF

# Gdje se spremila slika grafa?

################################################################

# Zadaci - odaberte i napravite prikladan tip grafa za svaku od slijedećih pitanja

# 1. samo za Gentoo: prikaz razdiobe duljine peraja
# 2. prikaz broja jedinki po otocima
# 3. prikaz ovisnosti duljine peraja o masi pingvina, kategorije obojane po vrsti
# 4. samo za Adelie vrstu: usporedba mase pingvina po spolu, s uklonjenim nedostajućim vrijedonstima te bojama ispune po spolu
# 5. prikaz broja jedinki različitih vrsta pingvina po otocima

# Pomoćna pitanja za provjeru izrade dobrog grafa:
# Je li graf čitljiv i kontrastan?
# Jesu li osi jasno označene i na hrvatskom jeziku?
# Pokazuje li boja informaciju ili samo dekoraciju?

# Dodatni zadatci

# 1. Eksportirajte grafove kao PNG slike
# 2.Instalirajte paket RColorBrewer i promjeniti palete boja na prijašnjim grafovima. 
# Pazite da grafovi budu kontrasni i informativni.