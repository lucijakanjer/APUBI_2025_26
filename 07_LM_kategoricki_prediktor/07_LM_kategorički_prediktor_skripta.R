# Analize podataka u biološkim istraživanjima - praktikum 2025/26
# Lucija Kanjer lucija.kanjer@biol.pmf.hr

###############################################################################

# 7. Linearni modeli s kategoričkim prediktorom

###############################################################################

# Učitavanje paketa i postavljanje teme
library(ggplot2)
set_theme(theme_minimal())

# 1. PRIMJER: Katagorički prediktor s dvije razine (grupe)

# Podaci o istraživanju na vodozemcima
# Exposure - izloženost vodezemaca PCB-u (Low/High)
# GeneExpression - ekspresija gena CYP1A1 povezanog s metaboliziranjem toksina
# CytokineLevel - razina citokina kao imunološki odgovor vodozemaca

# Učitavanje podataka u objekt amphibians
amphibians

# Postoji li razlika u ekspresiji gena CYP1A1 kod vodozemaca pri niskoj i visikoj izloženosti PCB-u?

# Vizualizacija - Napraviti sami!

# 1.1 Linearni model za ovisnost ekspresije gena CYP1A1 o izloženosti PCB-u
model_gene_expression <- lm()
summary()

# Grafička dijagnostika - provjera pretpostavki normalnosti i homoskedastičnosti reziduala
plot(model_gene_expression, which = 2, main = "Provjera normalnosti reziduala")
plot(model_gene_expression, which = 1, main = "Provjera homoskedastičnosti reziduala")

# 1.2 Alternativni način: t-test
t.test(GeneExpression ~ Exposure, data = amphibians)

# Zadatak: Postoji li razlika u razini citokina kod vodozemaca pri niskoj i visikoj izloženosti PCBu?
# Napravite linarni model, interpretirajte ga te provjerite pretpostavke modela!

# Što napraviti kad homoskedastičnost (jednakost varijanci) reziduala nije zadovoljena?

amphibians$LogCytokineLevel <- log10(amphibians$CytokineLevel)

model_log_cytokine <- lm(LogCytokineLevel ~ Exposure, data = amphibians)
summary(model_log_cytokine)
par(mfrow = c(2, 2))
plot(model_log_cytokine)

###############################################################################

# 2. Kategorički prediktor s 3 ili više razina

# Dataset: utjecaj toplinskog šoka od 42C na klijance Arabidopsis thaliana
# klijanci: kontrola - cijelo vrijeme na 25C, predtretman - na 37C, bez_predtretmana - klijanci bez toplinskog predtretmana
# pi_Abs: prvi parametar za fotosintetsku učinkovitost
# FvFm: drugi parametar za fotosintetsku učinkovitost
# DREB2A: ekspresija gena DREB2A povezanog s toplinskom aklimatizacijom
# HSFA3: ekspresija gena HSFA3 povezanog s toplinskom aklimatizacijom

# Učitavanje podataka u objekt fotosinteza
fotosinteza

# Postoji li razlika u fotosintetskoj učinkovitosti (Pi_ABS) između klijanaca sa i bez predtrtmana te kontrolne skupine?

# Vizualizacija - napraviti sami!

# 2.1 Postavljanje, rezultati i dijagnostika linearnog modela
model_Pi_Abs 
summary()

plot(model, which = 1, main = "Provjera homoskedastičnosti reziduala")
plot(model, which = 2, main = "Provjera normalnosti reziduala")

# 2.2 Alternatini način: ANOVA
anova_Pi_Abs <- aov(Pi_Abs ~ klijanci, data = fotosinteza)
summary()

# Zadaci

# Postoji li razlika u fotosintetskoj učinkovitosti (FvFm) između klijanaca sa i bez predtrtmana te kontrolne skupine?
# Postoji li razlika u ekspresiji gena DREB2A između klijanaca sa i bez predtrtmana te kontrolne skupine?
# Postoji li razlika u ekspresiji gena HSFA3 između klijanaca sa i bez predtrtmana te kontrolne skupine?



