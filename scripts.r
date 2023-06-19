## Installes les library 

#install.packages("dplyr")
#install.packages("RSQLite,dependencies=T")
#install.packages("readr,dependencies=T")
#install.packages("usethis")

library(dplyr)
library(RSQLite)
library(readr)
library(usethis)

## Créer nos tableaux sql

con<-dbConnect(SQLite(),dbnames="./assets/data/reseau.db")

dbSendQuery(con,"
CREATE TABLE etudiants (
  prenom_nom  CHAR,
  prenom	CHAR,
  nom	CHAR,
  region_administrative	CHAR,
  regime_coop	BOOLEAN,
  formation_prealable	CHAR,
  annee_debut	CHAR,
  programme CHAR
);")

dbSendQuery(con,"
  CREATE TABLE collaborations (
    etudiant1	CHAR,
    etudiant2 CHAR,
    sigle CHAR,
    session CHAR,
    FOREIGN KEY (etudiant1) REFERENCES etudiants(prenom_nom),
    FOREIGN KEY (etudiant2) REFERENCES etudiants(prenom_nom),
    FOREIGN KEY (sigle) REFERENCES cours(sigle)
  );
")

dbSendQuery(con,"
  CREATE TABLE cours (
    sigle CHAR,
    optionnel BOLEAN,
    credits INTEGER,
    FOREIGN KEY (sigle) REFERENCES collaborations(sigle)
  );
")

## Aller chercher les données

#unzip("~/BIO_500/donnees_BIO500_2022.zip")

  #en utilisant l'outil GITHUB
setwd("~/BIO_500/donnees_BIO500")

temp = list.files(pattern="*.csv")
list2env(
  lapply(setNames(temp, make.names(gsub("*.csv$", "", temp))), 
         read.csv2), envir = .GlobalEnv)

temp = list.files(pattern="*8_")
list2env(
  lapply(setNames(temp, make.names(gsub("*.csv$", "", temp))), 
         read.csv), envir = .GlobalEnv)

rm(temp)

# Nettoyer les données

## Collaborations ###################################################################################################

### Enlever les colonnes vides
X6_collaboration<-X6_collaboration[,1:4]

### Fusionner les rangées des documents
collaborations <- rbind(X1_collaboration,X2_collaboration,X3_collaboration,X4_collaboration,X5_collaboration,X6_collaboration,X7_collaboration,X8_collaboration,X9_collaboration,X10_collaboration)

### Supprimer les documents individuelles
rm(X1_collaboration,X2_collaboration,X3_collaboration,X4_collaboration,X5_collaboration,X6_collaboration,X7_collaboration,X8_collaboration,X9_collaboration,X10_collaboration)

### Supprimer les rangées identiques
collaborations<-distinct(collaborations)

### enlever rangé vide
collaborations <- collaborations[-c(1173),]


### Corriger nom avec accent (À CHANGER, encore des erreurs)

#### étudiant1
collaborations[2114:2118,1]<-"mia_carriere"
collaborations[2099:2103,1]<-"juliette_meilleur"
collaborations[2057:2064,1]<-"eve_dandonneau"

####étudiant2
collaborations[c(2086,2121,2143,2040,2107,2129,2078,2048),2]<-"eve_dandonneau"
collaborations[c(2070,2074,2140,2102,2067),2]<-"mia_carriere"
collaborations[c(2069,2117,2073,2066,2139),2]<-"juliette_meilleur"

### Corriger fautes dans noms etudiant1 (À CHANGER)

collaborations$etudiant1[collaborations$etudiant1=="amelie_harbeck_bastien"]<-"amelie_harbeck-bastien"

collaborations$etudiant1[collaborations$etudiant1=="arianne_beaulac"]<-"ariane_barrette"

collaborations$etudiant1[collaborations$etudiant1=="arianne_barette"]<-"ariane_barrette"

collaborations$etudiant1[collaborations$etudiant1=="cassandra_gobin"]<-"cassandra_godin"

collaborations$etudiant1[collaborations$etudiant1=="catherine_viel_lapointe"]<-"catherine_viel-lapointe"

collaborations$etudiant1[collaborations$etudiant1=="edouard_nadon-baumier"]<-"edouard_nadon-beaumier"  

collaborations$etudiant1[collaborations$etudiant1=="francis_bolly"]<-"francis_boily"  

collaborations$etudiant1[collaborations$etudiant1=="francis_bourrassa"]<-"francis_bourassa"  

collaborations$etudiant1[collaborations$etudiant1=="frederick_laberge"]<-"frederic_laberge" 

collaborations$etudiant1[collaborations$etudiant1=="ihuoma_elsie_ebere"]<-"ihuoma_elsie-ebere"

collaborations$etudiant1[collaborations$etudiant1=="ihuoma_elsie_ebere"]<-"ihuoma_elsie-ebere"

collaborations$etudiant1[collaborations$etudiant1=="ihuoma_elsie-ebere"]<-"jonathan_rondeau-leclaire"   ####? erreur ?###

collaborations$etudiant1[collaborations$etudiant1=="jonathan_rondeau_leclaire"]<-"jonathan_rondeau-leclaire"

collaborations$etudiant1[collaborations$etudiant1=="justine_lebelle"]<-"justine_labelle"

collaborations$etudiant1[collaborations$etudiant1=="laurianne_plante "]<-"laurianne_plante"

collaborations$etudiant1[collaborations$etudiant1=="laurie_anne_cournoyer"]<-"laurie-anne_cournoyer"

collaborations$etudiant1[collaborations$etudiant1=="louis-phillippe_theriault"]<-"louis-philippe_theriault"

collaborations$etudiant1[collaborations$etudiant1=="madyson_mcclean"]<-"madyson_mclean"

collaborations$etudiant1[collaborations$etudiant1=="mael_guerin"]<-"mael_gerin"

collaborations$etudiant1[collaborations$etudiant1=="marie_christine_arseneau"]<-"marie-christine_arseneau"

collaborations$etudiant1[collaborations$etudiant1=="marie_burghin"]<-"marie_bughin"

collaborations$etudiant1[collaborations$etudiant1=="marie_eve_gagne"]<-"marie-eve_gagne"

collaborations$etudiant1[collaborations$etudiant1=="noemie_perrier-mallette"]<-"noemie_perrier-malette" 

collaborations$etudiant1[collaborations$etudiant1=="peneloppe_robert"]<-"penelope_robert"

collaborations$etudiant1[collaborations$etudiant1=="philippe_barette"]<-"philippe_barrette" 

collaborations$etudiant1[collaborations$etudiant1=="philippe_bourrassa"]<-"philippe_bourassa" 

collaborations$etudiant1[collaborations$etudiant1=="phillippe_bourassa"]<-"philippe_bourassa"

collaborations$etudiant1[collaborations$etudiant1=="philippe_leonard_dufour"]<-"philippe_leonard-dufour"

collaborations$etudiant1[collaborations$etudiant1=="raphael_charlesbois"]<-"raphael_charlebois"

collaborations$etudiant1[collaborations$etudiant1=="sara_jade_lamontagne"]<-"sara-jade_lamontagne"

collaborations$etudiant1[collaborations$etudiant1=="yannick_sageau"]<-"yanick_sageau"

collaborations$etudiant1[collaborations$etudiant1=="yanick_sagneau"]<-"yanick_sageau"

### Corriger fautes dans noms etudiant2 (À CHANGER)

collaborations$etudiant2[collaborations$etudiant2=="amelie_harbeck_bastien"]<-"amelie_harbeck-bastien"

collaborations$etudiant2[collaborations$etudiant2=="arianne_beaulac"]<-"ariane_barrette"

collaborations$etudiant2[collaborations$etudiant2=="arianne_barette"]<-"ariane_barrette"

collaborations$etudiant2[collaborations$etudiant2=="cassandra_gobin"]<-"cassandra_godin"

collaborations$etudiant2[collaborations$etudiant2=="catherine_viel_lapointe"]<-"catherine_viel-lapointe"

collaborations$etudiant2[collaborations$etudiant2=="edouard_nadon-baumier"]<-"edouard_nadon-beaumier"  

collaborations$etudiant2[collaborations$etudiant2=="francis_bolly"]<-"francis_boily"  

collaborations$etudiant2[collaborations$etudiant2=="francis_bourrassa"]<-"francis_bourassa"  

collaborations$etudiant2[collaborations$etudiant2=="frederick_laberge"]<-"frederic_laberge" 

collaborations$etudiant2[collaborations$etudiant2=="ihuoma_elsie_ebere"]<-"ihuoma_elsie-ebere"

collaborations$etudiant2[collaborations$etudiant2=="ihuoma_elsie_ebere"]<-"ihuoma_elsie-ebere"

collaborations$etudiant2[collaborations$etudiant2=="ihuoma_elsie-ebere"]<-"jonathan_rondeau-leclaire"   ####? erreur ?###

collaborations$etudiant2[collaborations$etudiant2=="jonathan_rondeau_leclaire"]<-"jonathan_rondeau-leclaire"

collaborations$etudiant2[collaborations$etudiant2=="justine_lebelle"]<-"justine_labelle"

collaborations$etudiant2[collaborations$etudiant2=="laurianne_plante "]<-"laurianne_plante"

collaborations$etudiant2[collaborations$etudiant2=="laurie_anne_cournoyer"]<-"laurie-anne_cournoyer"

collaborations$etudiant2[collaborations$etudiant2=="louis-phillippe_theriault"]<-"louis-philippe_theriault"

collaborations$etudiant2[collaborations$etudiant2=="madyson_mcclean"]<-"madyson_mclean"

collaborations$etudiant2[collaborations$etudiant2=="mael_guerin"]<-"mael_gerin"

collaborations$etudiant2[collaborations$etudiant2=="marie_christine_arseneau"]<-"marie-christine_arseneau"

collaborations$etudiant2[collaborations$etudiant2=="marie_burghin"]<-"marie_bughin"

collaborations$etudiant2[collaborations$etudiant2=="marie_eve_gagne"]<-"marie-eve_gagne"

collaborations$etudiant2[collaborations$etudiant2=="noemie_perrier-mallette"]<-"noemie_perrier-malette" 

collaborations$etudiant2[collaborations$etudiant2=="peneloppe_robert"]<-"penelope_robert"

collaborations$etudiant2[collaborations$etudiant2=="philippe_barette"]<-"philippe_barrette" 

collaborations$etudiant2[collaborations$etudiant2=="philippe_bourrassa"]<-"philippe_bourassa" 

collaborations$etudiant2[collaborations$etudiant2=="phillippe_bourassa"]<-"philippe_bourassa"

collaborations$etudiant2[collaborations$etudiant2=="philippe_leonard_dufour"]<-"philippe_leonard-dufour"

collaborations$etudiant2[collaborations$etudiant2=="raphael_charlesbois"]<-"raphael_charlebois"

collaborations$etudiant2[collaborations$etudiant2=="sara_jade_lamontagne"]<-"sara-jade_lamontagne"

collaborations$etudiant2[collaborations$etudiant2=="yannick_sageau"]<-"yanick_sageau"

collaborations$etudiant2[collaborations$etudiant2=="yanick_sagneau"]<-"yanick_sageau"

## Enlever les doublon à nouveau et mettre en ordre

collaborations<-distinct(collaborations)

collaborations <- collaborations[order(collaborations$etudiant1),]


## Cours ###################################################################################################

### Enlever les colonnes vides
X4_cours<-X4_cours[,1:3]
X6_cours<-X6_cours[,1:3]

### Fusionner les rangées des documents
cours<-rbind(X1_cours,X2_cours,X3_cours,X4_cours,X5_cours,X6_cours,X7_cours,X8_cours,X9_cours,X10_cours)

### Supprimer les documents individuelles
rm(X1_cours,X2_cours,X3_cours,X4_cours,X5_cours,X6_cours,X7_cours,X8_cours,X9_cours,X10_cours)

### mettre les rangé vrai/faux en T/F booléen
cours$optionnel[cours$optionnel=="VRAI"]<-TRUE
cours$optionnel[cours$optionnel=="FAUX"]<-FALSE
cours$optionnel<-as.logical(cours$optionnel)

### Supprimer les rangées identiques
cours<-distinct(cours)

### nettoyage de finission
cours <- cours[-c(62),]

## Etudiants ###################################################################################################

### Enlever les colonnes vides
X2_etudiant<-X2_etudiant[,1:8]
X3_etudiant<-X3_etudiant[,1:8]
X6_etudiant<-X6_etudiant[,1:8]
X8_etudiant<-X8_etudiant[,1:8]

### Renommer la colonne fautives
X3_etudiant<-X3_etudiant %>% rename(
  prenom_nom = prenom_nom.
)

### Fusionner les rangées des documents
etudiants<-rbind(X1_etudiant,X2_etudiant,X3_etudiant,X4_etudiant,X5_etudiant,X6_etudiant,X7_etudiant,X8_etudiant,X9_etudiant,X10_etudiant)

### Supprimer les documents individuelles
rm(X1_etudiant,X2_etudiant,X3_etudiant,X4_etudiant,X5_etudiant,X6_etudiant,X7_etudiant,X8_etudiant,X9_etudiant,X10_etudiant)

### mettre les rangé vrai/faux en T/F booléen
etudiants$regime_coop[etudiants$regime_coop=="VRAI"]<-TRUE
etudiants$regime_coop[etudiants$regime_coop=="FAUX"]<-FALSE
etudiants$regime_coop<-as.logical(etudiants$regime_coop)

#Changer case vide pour NA

etudiants[etudiants==""]<-NA

#Enlever les colonnes identiques

etudiants<-distinct(etudiants)

### correction des noms
etudiants[112,1]<-"eve_dandonneau"
etudiants[225,1]<-"penelope_robert"
etudiants[195,1]<-"catherine_viel-lapointe"

#enlever doublons avec NA et les rangées vides
etudiants <- etudiants[-c(137,120,128,193,183,66,23,31,95,36,148,97,182,222,71,37,173,224,16,39,98,41,184,42,76,77,92,116,159,8,46,28,79,29,188,47,30,80,48,186,13,20,50,223,18,51,52,100,19,84,53,54,99,210,17,56,12,57,58,176,26,59,204,62,136,205,11,226,172),]

## mettre en ordre 
etudiants <- etudiants[order(etudiants$prenom_nom),]

# Exercices du cours ##################################################################################################


## Remplir les tables sql avec nos données

dbWriteTable(con, append = TRUE, name = "etudiants", value = etudiants, row.names = FALSE)
dbWriteTable(con, append = TRUE, name = "cours", value = cours, row.names = FALSE)
dbWriteTable(con, append = TRUE, name = "collaborations", value = collaborations, row.names = FALSE)

## Nombre de lien par étudiants

sql_requete <- "
SELECT  etudiant1, count(etudiant2) AS nb_liens
FROM collaborations
GROUP BY etudiant1
ORDER BY nb_liens;"
lien_etudiants <- dbGetQuery(con, sql_requete)
head(lien_etudiants)

## Nombre de liens par paire d'étudiants

sql_requete <- "
SELECT  etudiant1, etudiant2, count(etudiant2) AS nb_liens
FROM collaborations
GROUP BY etudiant1, etudiant2
ORDER BY nb_liens;"
lien_paires_etudiants <- dbGetQuery(con, sql_requete)
head(lien_paires_etudiants)

## Enregister résultats

write.csv2(lien_etudiants, "C:/Users/yanic/OneDrive/Documents/Rdata_bio500//lien_etudiants.csv",row.names=F)
write.csv2(lien_paires_etudiants, "C:/Users/yanic/OneDrive/Documents/Rdata_bio500//lien_paires_etudiants.csv",row.names=F)

## Calculer nb étudiants, lien et la connectance du reseau

nrow(lien_etudiants)-1
sum(lien_paires_etudiants[c(-1),3])
mean(lien_etudiants[c(-1),2])
var(lien_etudiants[c(-1),2])


###### QUESTION !!! 
##Comment bien nettoyer ?
#étudiant double, mais un avec NA et sans NA
#Collaboration ne peut pas avoir de primary key, sinon doublon
#cours peuvent être facultatif ou non
## comment faire le Décompte de liens par paire d'étudiants
## Comment calculer la connectance 
###erreurs a vérifier
#cassandra godin
#rosalie gagnon

