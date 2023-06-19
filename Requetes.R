requetes<-function(con){

# dependencies
  
library(RSQLite)
  
  
#Connection au réseau sql
  
con<-dbConnect(SQLite(),"./reseau.db")
  
## Requête pour avoir deux tableaux avec les paires d'étudiant, le nombre de lien entre ceux-ci, la région et la session de début.
# La différence entre les deux tableaux : 1)la région et annee de etudiant1 2) la region et annee de etudiant2
  
  sql_requete <- "
SELECT  etudiant1, etudiant2, count(etudiant2) AS nb_liens, region_administrative, annee_debut
FROM collaborations
FULL OUTER JOIN etudiants ON collaborations.etudiant1 = etudiants.prenom_nom
GROUP BY etudiant1, etudiant2
ORDER BY nb_liens;"
lien_paires_etudiants1 <- dbGetQuery(con, sql_requete)
  
sql_requete <- "
SELECT  etudiant1, etudiant2, count(etudiant2) AS nb_liens, region_administrative, annee_debut
FROM collaborations
FULL OUTER JOIN etudiants ON collaborations.etudiant2 = etudiants.prenom_nom
GROUP BY etudiant1, etudiant2
ORDER BY nb_liens;"
lien_paires_etudiants2 <- dbGetQuery(con, sql_requete)


## Requête pour avoir deux tableaux avec toutes les collaborations, la région et la session de début
# La différence entre les deux tableaux : 1)la région et annee de etudiant1 2) la region et annee de etudiant2


sql_requete <- "
SELECT  etudiant1, etudiant2, region_administrative, annee_debut
FROM collaborations
FULL OUTER JOIN etudiants ON collaborations.etudiant1 = etudiants.prenom_nom;"
etudiant_reg_ann_1 <- dbGetQuery(con, sql_requete)
head(etudiant_reg_ann_1)

sql_requete <- "
SELECT  etudiant1, etudiant2, region_administrative, annee_debut
FROM collaborations
FULL OUTER JOIN etudiants ON collaborations.etudiant2 = etudiants.prenom_nom;"
etudiant_reg_ann_2 <- dbGetQuery(con, sql_requete)
head(etudiant_reg_ann_2)

#Requètes pour la liste d'étudiants

sql_requete <- "
SELECT  prenom_nom
FROM etudiants;"
etudiants <- dbGetQuery(con, sql_requete)
head(etudiants)

# Créer une liste pour la return

data_ana<-list(lien_paires_etudiants1,lien_paires_etudiants2,etudiant_reg_ann_1,etudiant_reg_ann_2,etudiants)

return(data_ana)
  
}
