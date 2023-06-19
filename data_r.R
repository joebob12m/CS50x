
## Aller chercher les données

# unzip le document reçu en classe

#unzip("./donnees_BIO500_2022.zip")

data_r<-function(){
  
#mettre wd dans le dossier des bases de données 
  
# ancien :setwd("C:/Users/yanic/OneDrive/Documents/BIO_500/donnees_BIO500")
  #nouveau
setwd("~/BIO_500/donnees_BIO500")
  
#énumérer tous les documents avec .csv

temp <- list.files(pattern="*.csv")

# créer une liste

data_d<-list()

# Mettre dans la liste toutes les bases de données

data_d<-lapply(setNames(temp, make.names(gsub("*.csv$", "", temp))), 
         read.csv2)

# Créer une liste avec les base de donnée de l'équipe 8

temp <- list.files(pattern="*8_")

# Ajouter les documents de l'équipe 8, mais avec read.csv à la place de read.csv2

data_d <- append(data_d,lapply(setNames(temp, make.names(gsub("*.csv$", "", temp))), 
         read.csv))

# remettre le bon wd

# ancien : setwd("C:/Users/yanic/OneDrive/Documents/BIO_500/")

#nouveau
setwd("~/BIO_500")

return(data_d)
}