# Analize podataka u biološkim istraživanjima - praktikum 2025/26

# Toni Safner, Lucija Kanjer

###############################################################################

# 10. Multivarijantna statistika u R-u

###############################################################################

# 1. Instalacija i učitavanje potrebnih paketa
library(Hmisc) # napredna obrada podataka, korelacija sa p-vrednostima
library(MASS) # diskriminantna analiza
library(psych) # paket za analize koje se često koriste u psihologiji
library(datasauRus) # paket a primjerima raznih datasetova
library(ggplot2) 
library(ggfortify) # za vizualizaciju rezultata statističkih analiza
library(dplyr) # iz nekog razloga bitno je ovo učitati zadnje u ovoj vježbi

# 2. Učitavanje Iris podataka
# Podaci irisima već su ugrađeni u svaki R, potrebno ih je samo učitati u environment
iris <- iris
View(iris)

colnames(iris) <- c("SepalLength", "SepalWidth", "PetalLength", "PetalWidth", "Species")

# 3. Korelacijske analize
# naredba "cor" prikazuje Pearsonove koeficijente korelacije između numeričkih varijabli.
cor_matrix <- cor(iris %>% select(SepalLength:PetalWidth))
print(cor_matrix)

# naredba "rcorr" iz paketa Hmisc prikazuje nam korelacije i značajnost tih istih korelacija (p-vrijednosti)
p_values<-rcorr(as.matrix(iris[1:4]))
p_values

# Vizualizacija korelacija
# Scatterplot matrica koja prikazuje relacije među svih varijablama obojano za svaku vrstu irisa.
pairs(iris %>% select(SepalLength:PetalWidth),
      pch = 19, #za oblik ispunjenog kružića
      col = c("pink", "lightgreen", "lightblue")[as.numeric(iris$Species)])

# pairs.panels() iz paketa psych
# Poboljšana verzija scatterplot matrice koja uključuje histograme i koeficijente korelacije.
pairs.panels(iris[1:4], gap = 0, pch=21)


#Simpsonov paradox!
#problem sa strukturiranim podatcima (i Irisi su takvi)

# Kroz paket datasauRus se ilustrira situacija gdje korelacija na ukupnom nivou ne odražava realne odnose unutar podgrupa

# Pogledajmo sve datasetove iz paketa datasauRus
ggplot(datasaurus_dozen, aes(x = x, y = y, colour = dataset))+
  geom_point()+
  theme_void()+
  theme(legend.position = "none")+
  facet_wrap(~dataset, ncol = 3)

# Svi datasetovi imaju slične deskriptivne statistike, ali očito mnogo drugačiji izgled!

data<-datasaurus_dozen # učitavanje svih datasetova u objekt "data"
slant<-data[which(data$dataset=="slant_down"),] # odabir dataset "slant_down"
ggplot(slant, aes(x = x, y = y)) + geom_point() # vizualizacija dataseta "slant_down"

# Izračunajmo ponovo korelaciju i značajnost iz datasaet "slant"
rcorr(slant$x,slant$y)
#iako ispada da korelacije nema (p>0.05), izgleda da su podatci strukturirani (više uzoraka)
#a korelacija unutar tih grupa se čini dosta jaka i negativna


# 4. kovarijanca (bilo ce na predavanju - bitno za PCA)
# Kovarijanca mjeri zajedničku varijaciju između parova numeričkih varijabli. 
# Ključna je za PCA jer PCA koristi kovarijacijski matriks za određivanje glavnih komponenti.
cov(iris[,(1:4)])

# 5. Principal Component Analysis (PCA)
# koristi se za smanjenje multidimenzioniranosti podataka i laksš vizualizaciju u 2D prostoru

# prcomp s opcijom scale. = TRUE standardizira podatke kako bi sve varijable imale jednak doprinos
pca_res <- prcomp(iris %>% select(SepalLength:PetalWidth), scale. = TRUE)
print(pca_res)
# rezultat su "loadings" - korelacije izvornih varijabli sa princ. komponentama (PC1, PC2...)

# ovdje se vidi ukupno objasnjena varijanca svake PC osi
summary(pca_res)

# korelacije između izvedenih varijabli - princ. komponenata (PC)
pairs.panels(pca_res$x)

# Vizualizacija PCA
# PCA scatterplot obojen prema vrstama irisa, s prikazom "loadings" vektora
autoplot(pca_res, data = iris, colour = 'Species',
         loadings = TRUE, loadings.label = TRUE, loadings.label.size = 3)

# Zadatak:
# odvojite dataset iris u 3 tablici, 1 za svaku vrstu i napravite PCA analizu za svaku vrstu irisa.
# Kakav je izled PCA grafa u odnosu na cijeli dataset?


# 6. Diskriminantna analiza (LDA)
# LDA je metoda klasifikacije koja maksimizira razlike između grupa
# Predviđanje pripadnosti podatka nekoj grupi ne temelju ranije poznatih mjerenja

# izračunavanje linearne diskriminantne funkcije za separaciju vrsta irisa
lda_res <- lda(Species ~ SepalLength + SepalWidth + PetalLength + PetalWidth, data = iris)
print(lda_res)
plot(lda_res)

#test "sortiranja" - primjenimo dobivenu diskrim. funkciju ponovo na citav dataset
lda_pred <- predict(lda_res)

#ovo su vjerojatnosti klasifikacije u grupu (samo prvih 6 jedinki - head)
head(lda_pred$posterior)

#koliko ih je tocno sortirao (98%)
mean(lda_pred$class==iris$Species)

table(pred = lda_pred$class, true = iris$Species)


# Vizualizacija LDA
iris$LDA1 <- lda_pred$x[,1]
iris$LDA2 <- lda_pred$x[,2]
head(iris)

ggplot(iris, aes(x = LDA1, y = LDA2, color = lda_pred$class)) +
  geom_point() +
  labs(title = "LDA Scatterplot", x = "LDA1", y = "LDA2") +
  theme_minimal()

# Zadatak:
# Dodajte na graf "predviđene vrste" kao različite oblike točaka, a boje točaka neka budu po stvarnim vrstama.

# 7. K means clustering
# koristi se za treženje u koliko grupa se podaci najbolje klasteriraju
# skaliramo podatke (svedemo ih sve na prosjek = 0 i sd = 1)
scaled_iris <- scale(iris[1:4],)

#određivanje vjerojatnog broja clustera (napravi se k-means za raspon mogucih vrijednosti k)
#za svaki k se zapamti vrijednost suma kvadrata unutar clustera wss (Within-Cluster Sum of Squares)
set.seed(123) #za reproducibilnost
k.max <- 10
wss <- sapply(1:k.max,
              function(k){kmeans(scaled_iris, k, nstart=50,iter.max = 15 )$tot.withinss})
wss

# nacrtamo graf promjene wss sa porastom k
# "koljeno" u ovom grafu - broj clustera
plot(1:k.max, wss,
     type="b", pch = 19, frame = FALSE,
     xlab="Broj clustera - K",
     ylab="Suma kvadrata unutar clustera")

# "koljeno" je na 3 clustera
km<-kmeans(scaled_iris, centers=3, iter.max = 10, nstart = 1)
km

# pogledajmo koliko ima koje vrste u svakom clusteru
iris_km <- cbind(iris, cluster = km$cluster)
head(iris_km)
tab <- table(clust = iris_km$cluster, true = iris_km$Species)
tab

# grafički prikaz clustera (da bi to mogli, moramo koristiti PCA rezultat)
# bojamo po klasteru, oblik je po vrsti
str(iris_km)
iris_km$cluster <- as.factor(iris_km$cluster)
autoplot(pca_res, data = iris_km, colour = 'cluster', shape = 'Species',
         loadings = TRUE, loadings.label = TRUE, loadings.label.size = 3)

# Zadatak:
# Prikažite k-means clustere na LDA grafu.




