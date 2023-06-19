## Installes les library

#install.packages("dplyr")
#install.packages("RSQLite,dependencies=T")
#install.packages("readr,dependencies=T")
#install.packages("usethis")
#install.packages("targets")
#install.packages('tarchetypes')
#install.packages("rmarkdown")
#install.packages("tinytex")
#tinytex::install_tinytex()
#install.packages("rticles")

# Dépendances
library(targets)
library(tarchetypes)
source("data_r.R")
source("nettoyage.R")
source("tableau_sql.R")
source("Requetes.R")
source("Analyse.R")

# a vérifier
#source("Rapport/Rapport.Rmd")
# Pipeline

list(
  tar_target(
    name = path,
    command = "./donnees_BIO500",
    format = "file"
  ),
  tar_target(
    name = data,
    command = list.files(path,full.names = TRUE)
  ),
  tar_target(
    name = data_d, # Cible pour l'objet de données
    command = data_r() # Céation des données
  ), 
  tar_target(
    name = data_n, # Cible pour l'objet de données
    command = nettoyage(data_d) # Céation des données
  ),
  tar_target(
    name = con, # Cible pour l'objet de données
    command = tableau_sql(data_n) # Céation des données
  ),
    tar_target(
      name = data_ana, # Cible pour l'objet de données
      command = requetes(con) # Céation des données
  ),
  tar_target(
    name = resultats, # Cible pour l'objet de données
    command = analyser(data_ana) # Céation des données

  ),
   tar_render(
    name = rapport, # Cible du rapport
    path = "rapports/rapports.Rmd" 
 )

)



