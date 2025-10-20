# Analize podataka u biološkim istraživanjima - praktikum 25/26
# Lucija Kanjer lucija.kanjer@biol.pmf.hr

##############################################################

# 3. Grafički prikaz bioloških podataka u R-u

# Uključene su sve korištenje naredbe, ALI NEKE SU NEPOTPUNE ILI SADRŽE NAMJERNE POGREŠKE:
# Dovršite naredbe i također dodajte komentare za sebe (koristite # za komentiranje)
#
# IZVRŠAVANJE NAREDBI: ctrl + Enter 
#
#############################################################

# Učitavanje seta podataka o pingvinima
install.packages("palmerpenguins")
library(palmerpenguins)

penguins <- penguins

View(penguins)

###############################################################################

# Base R funkcije za grafove

# U base R grafovima svaka funkcija odmah crta graf (nema slojeva kao u ggplotu)

# 1. Histogram
hist(penguins$body_mass_g)

# Uređivanje
hist(penguins$body_mass_g,
     main = "Distribucija mase tijela pingvina",
     xlab = "Masa tijela (g)",
     col = "lightblue",
     border = "black",
     xlim = c(2000, 7000), ylim = c(0, 100))

# 2. Točkasti dijagram (scatter plot)
plot(penguins$bill_length_mm, penguins$bill_depth_mm)

plot(penguins$bill_length_mm, penguins$bill_depth_mm,
     main = "Odnos dužine i dubine kljuna",
     xlab = "Dužina kljuna (mm)",
     ylab = "Dubina kljuna (mm)",
     col = "darkgreen", pch = 19)

# 3. Stupičasti dijagram (bar plot)

# Prvo: Kreiranje tablice za broj pingvina po vrsti
species_count <- table(penguins$species)
print(species_count)

barplot(species_count)

# 5. Pita dijagram
pie(species_count)

# 4. Boxplot
boxplot(body_mass_g ~ sex, data = penguins)

# Zadatak: Uredite naslove osi i promjenite boju ispune na barplot i boxplot grafu!


###############################################################################

# ggplot2 paket - slojevi i estetika

# Učitavanje paketa
library(ggplot2) # paket za crtanje grafova
library(dplyr) # paket za manipulaciju tablicama

# 1. Osnovni graf bez slojeva

ggplot() # osnovna naredba

# Osnovni grafikon - postavljamo estetiku, ali bez sloja
ggplot(data = penguins, aes(x = bill_length_mm, y = bill_depth_mm))

# 2. Dodavanje prvog geometrijskog sloja: scatter plot
ggplot(data = penguins, aes(x = bill_length_mm, y = bill_depth_mm)) +
  geom_point()

# 3. Dodavanje boje kao estetike i većih točaka
ggplot(data = penguins, aes(x = bill_length_mm, y = bill_depth_mm, color = species)) +
  geom_point(size = 3)

# 4. Dodavanje trenda sa geom_smooth()
ggplot(data = penguins, aes(x = bill_length_mm, y = bill_depth_mm, color = species)) +
  geom_point(size = 3) +
  geom_smooth(method = "lm", se = FALSE)  # linearna regresija bez prikaza greške

# 5. Dodavanje naslova i oznaka osi sa slojem labs()
ggplot(data = penguins, aes(x = bill_length_mm, y = bill_depth_mm, color = species)) +
  geom_point(size = 3) +
  geom_smooth(method = "lm") +
  labs(title = "Odnos između dužine i dubine kljuna kod pingvina",
       x = "Dužina kljuna (mm)",
       y = "Dubina kljuna (mm)")

# 6. Podešavanje tema sa slojem theme()
ggplot(data = penguins, aes(x = bill_length_mm, y = bill_depth_mm, color = species)) +
  geom_point(size = 3) +  
  geom_smooth(method = "lm", se = FALSE) +
  labs(title = "Odnos između dužine i dubine kljuna kod pingvina",
       x = "Dužina kljuna (mm)",
       y = "Dubina kljuna (mm)") +
  theme_minimal()  # Minimalna tema za čist izgled

# 7. Finalno prilagođavanje: promjena skale boja i oblici

ggplot(data = penguins, aes(x = bill_length_mm, y = bill_depth_mm, color = species , shape = species)) +
  geom_point(size = 3) +
  geom_smooth(method = "lm", se = FALSE) +
  labs(title = "Odnos između dužine i dubine kljuna kod pingvina",
       x = "Dužina kljuna (mm)",
       y = "Dubina kljuna (mm)") +
  scale_color_manual(values = c("Adelie" = "darkorange", "Chinstrap" = "purple", "Gentoo" = "cyan4")) +
  theme_minimal()

# Zadatak 1
# Prisjetite se gradive prošle vježbe - manipulacija tablicom i napravite 3 grafa po uzoru na gornji:
# svaki graf neka pokazuje odnos duljine i dubine kljuna za 1 vrstu!



# Zadatak 2 
# Nacrtajte grafove sa početka skripte (histogram, scatterplot, barplot i boxplot) pomoću ggplot2 paketa!
# Svaki neka ima različitu temu i boje na grafu! 

# Pomoćna pitanja za provjeru izrade dobrog grafa:
# Je li graf čitljiv i kontrastan?
# Jesu li osi jasno označene i na hrvatskom jeziku?
# Pokazuje li boja informaciju ili samo dekoraciju?

