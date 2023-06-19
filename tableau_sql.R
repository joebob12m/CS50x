## Créer nos tableaux sql

tableau_sql<-function(data_n){

  # dependencies  
library(RSQLite)

# extraire data frame de la liste
collaborations<-data_n[[1]]
cours<-data_n[[2]]
etudiants<-data_n[[3]]

# Créer table sql
  
con<-dbConnect(SQLite(),"./reseau.db")

dbSendQuery(con,"
CREATE TABLE etudiants (
  prenom_nom  CHAR,
  prenom	CHAR,
  nom	CHAR,
  region_administrative	CHAR,
  regime_coop	BOOLEAN,
  formation_prealable	CHAR,
  annee_debut	CHAR,
  programme CHAR,
  PRIMARY KEY (prenom_nom)
);")

dbSendQuery(con,"
  CREATE TABLE collaborations (
    etudiant1	CHAR,
    etudiant2 CHAR,
    sigle CHAR,
    session CHAR,
    ID INTEGER,
    FOREIGN KEY (etudiant1) REFERENCES etudiants(prenom_nom),
    FOREIGN KEY (etudiant2) REFERENCES etudiants(prenom_nom),
    FOREIGN KEY (sigle) REFERENCES cours(sigle),
    PRIMARY KEY (ID)
  );
")

dbSendQuery(con,"
  CREATE TABLE cours (
    sigle CHAR,
    optionnel BOLEAN,
    credits INTEGER,
    FOREIGN KEY (sigle) REFERENCES collaborations(sigle),
    PRIMARY KEY (sigle)
  );
")

## Remplir les tables sql avec nos données (injection)

dbWriteTable(con, append = TRUE, name = "etudiants", value = etudiants, row.names = FALSE)
dbWriteTable(con, append = TRUE, name = "cours", value = cours, row.names = FALSE)
dbWriteTable(con, append = TRUE, name = "collaborations", value = collaborations, row.names = FALSE)

return(con)
}