analyser<-function(data_ana){
  
# dependencies
library(igraph)
library(ggplot2)
library(dplyr)
library(ade4)

# ouvrir la liste créer dans le script précédent
  
lien_paires_etudiants1<-data_ana[[1]]
lien_paires_etudiants2<-data_ana[[2]]
etudiant_reg_ann_1<-data_ana[[3]]
etudiant_reg_ann_2<-data_ana[[4]]
etudiants<-data_ana[[5]]

#créer une liste dans laquel on va mettre les résultats de nos analyse

resultats<-list()

############################################################################

## Créer data.frame avec les donnees des étudiants 1 ET 2 

lien_paires_etudiants<-bind_cols(lien_paires_etudiants1,lien_paires_etudiants2[,4:5])

## Enlever les donnees avec des NA

lien_sans_NA<-na.omit(lien_paires_etudiants)

## créer la première matrices pour un un test de mantel

matrice_region<-data.frame(matrix(nrow = 44,ncol = 44,0))

# mettre tous les étudiants avec une région et annee dans la 1ère colonne et rangé

liste_nom<-distinct(as.data.frame(lien_sans_NA$etudiant1))

for(i in 1:43){
  matrice_region[1,i+1]<-liste_nom[i,]
  matrice_region[i+1,1]<-liste_nom[i,]
}

# remplir les intéraction avec des 1 (même région) ou des 0 (pas même région)
for(i in 1:43){
  for(n in 1:43){
    for(m in 1:477){
      if(matrice_region[n+1,i+1]==1){
        break
      }
      else{
        if(lien_sans_NA$etudiant1[m] == matrice_region[1,i+1]){
          if(lien_sans_NA$etudiant2[m] == matrice_region[n+1,1]){
            if(lien_sans_NA$region_administrative...4[m] == lien_sans_NA$region_administrative...6[m]){
              matrice_region[n+1,i+1]<-1
            }
          }
        }
      }
    }
  }
}

## créer la deuxième matrice pour un un test de mantel

matrice_annee<-data.frame(matrix(nrow = 44,ncol = 44,0))

# mettre tous les étudiants avec une région et annee dans la 1ère colonne et rangé

for(i in 1:43){
  matrice_annee[1,i+1]<-liste_nom[i,]
  matrice_annee[i+1,1]<-liste_nom[i,]
}

# remplir les intéraction avec des 1 (même annee) ou des 0 (pas même annee)
for(i in 1:43){
  for(n in 1:43){
    for(m in 1:477){
      if(matrice_annee[n+1,i+1]==1){
        break
      }
      else{
        if(lien_sans_NA$etudiant1[m] == matrice_annee[1,i+1]){
          if(lien_sans_NA$etudiant2[m] == matrice_annee[n+1,1]){
            if(lien_sans_NA$annee_debut...5[m] == lien_sans_NA$annee_debut...7[m]){
              matrice_annee[n+1,i+1]<-1
            }
          }
        }
      }
    }
  }
}

## créer la troisième matrice pour un un test de mantel

matrice_interaction<-data.frame(matrix(nrow = 44,ncol = 44,0))

# mettre tous les étudiants avec une région et annee dans la 1ère colonne et rangé

for(i in 1:43){
  matrice_interaction[1,i+1]<-liste_nom[i,]
  matrice_interaction[i+1,1]<-liste_nom[i,]
}

# remplir les intéraction avec la quantité d'intéraction entre les etudiants
for(i in 1:43){
  for(n in 1:43){
    for(m in 1:477){
      if(lien_sans_NA$etudiant1[m] == matrice_interaction[1,i+1]){
        if(lien_sans_NA$etudiant2[m] == matrice_interaction[n+1,1]){
          matrice_interaction[n+1,i+1]<-lien_sans_NA$nb_liens[m]}
        }
      }
    }
  }

#####################################################
#test de mantel

#intéractions vs region
matrice_interaction<-dist(matrice_interaction[-1,-1])
matrice_region<-dist(matrice_region[-1,-1])

# garder le p-value

p_region<-mantel.rtest(matrice_interaction,matrice_region,nrepet = 999)
resultats[1]<-p_region$pvalue

#intéractions vs annee
matrice_annee<-dist(matrice_annee[-1,-1])

# garder le p-value

p_annee<-mantel.rtest(matrice_interaction,matrice_annee,nrepet = 999)
resultats[2]<-p_annee$pvalue

########################################################

## Faire un plot avec intéraction vs annee puisque corrélation significative
reg<-lm(matrice_interaction ~ matrice_annee)
coeff<-coefficients(reg)

# equation de la abline 
eq = paste0("y = ", round(coeff[2],1), "*x ", round(coeff[1],1))

# créer un objet avec le r2, la fonction de la droite et le p value

s_reg<-summary(reg)
r2<-s_reg$adj.r.squared
p_val<-s_reg$coefficients[2,4]

#créer un objet pour la légende pour mon graphique

rp = vector('expression',3)
rp[1] = substitute(expression(italic(R)^2 == MYVALUE), 
                   list(MYVALUE = format(r2,dig=3)))[2]
rp[2] = substitute(expression(italic(p) == MYOTHERVALUE), 
                   list(MYOTHERVALUE = format(p_val, digits = 2)))[2]
rp[3] = substitute(expression(MYOTHERVALUE2), 
                   list(MYOTHERVALUE2 = format(eq)))[2]

# création et enregistrement du graphique

png("plot.png")
plot(matrice_annee,matrice_interaction,xlab="Session de début (distance)",ylab="Intéractions (distance)")
abline(reg,col="blue")
legend("topleft",legend=rp,bty = 'n')
dev.off()

######################################################

##Faire des beaux histogrammes pour montrer les test de mantels

# Créer un tableau avec l'informations pertinente des 2 requêtes

etudiant_reg_ann<-bind_cols(etudiant_reg_ann_1,etudiant_reg_ann_2[,3:4])

# Enlever les etudiants qui n'ont pas d'annee ou region

etudiant_reg_ann_na<-na.omit(etudiant_reg_ann)

# ajouter des collones 0/1 dans le data.frame sans NA (lien_sans_NA) si les annees ou region ne sont pas pareil dans la collaboration entre les deux étudaints

lien_sans_NA_2<-matrix(nrow=1500,ncol=8,0)
colnames(lien_sans_NA_2)<-c("etudiant1","etudiant2","region_administrative_1","annee_debut_1","region_administrative_2","annee_debut_2","mm_region","mm_annee")
lien_sans_NA_2<-as.data.frame(lien_sans_NA_2)
lien_sans_NA_2[,1:6]<-etudiant_reg_ann_na

for(m in 1:1500){
    if(lien_sans_NA_2$region_administrative_1[m] == lien_sans_NA_2$region_administrative_2[m]){
      lien_sans_NA_2$mm_region[m]<-1}
    if(lien_sans_NA_2$annee_debut_1[m] == lien_sans_NA_2$annee_debut_2[m]){
      lien_sans_NA_2$mm_annee[m]<-1}
}

# créer des barplots region vs interaction

# créer des données utilsable par ggplot 
reg_inter<-lien_sans_NA_2$mm_region
reg_inter<-as.data.frame(reg_inter)

# mettre la data ensemble

data_graph<- data.frame(
  Regions<-c("Pas même région","Même région"),
  Nb_intéractions<-table(reg_inter)
)

#Créer et enregister le barplot

png(filename = "region.png")
ggplot(data_graph) +
  geom_bar( aes(x=Regions, y=Nb_intéractions), stat="identity", fill="skyblue", alpha=0.7)
dev.off()

# créer des barplots annee vs interaction
# créer des données utilsable par ggplot
ann_inter<-lien_sans_NA_2$mm_annee
ann_inter<-as.data.frame(ann_inter)

# mettre la data ensemble

data_graph<- data.frame(
  Sessions<-c("Pas même session","Même session"),
  Nb_intéractions<-table(ann_inter)
)

#Créer et enregister le barplot

png(filename = "annee.png")
ggplot(data_graph) +
  geom_bar( aes(x=Sessions, y=Nb_intéractions), stat="identity", fill="skyblue", alpha=0.7)
dev.off()



################################################## 

#créer une matrice 

matrice_01<-data.frame(matrix(nrow = 162,ncol = 162,0))

# mettre tous les étudiants dans la 1ère colonne et rangé

for(i in 1:161){
  matrice_01[1,i+1]<-etudiants$prenom_nom[i]
  matrice_01[i+1,1]<-etudiants$prenom_nom[i]
}

# remplir les intéraction avec des 1 (intéractions) ou des 0 (pas intéraction)
for(i in 1:161){
  for(n in 1:161){
    for(m in 1:1493){
      if(matrice_01[n+1,i+1]==1){
        break
      }
      else{
        if(lien_paires_etudiants$etudiant1[m] == matrice_01[1,i+1]){
          if( lien_paires_etudiants$etudiant2[m] == matrice_01[n+1,1]){
          matrice_01[n+1,i+1]<-1
          }
        }
      }
      }
    }
}
## créer une matrice utilisable pour créer la toile

matrice_02<-as.matrix(matrice_01[-1,-1])
                   
g<-graph.adjacency(matrice_02)

# faire le graphique en toile des intéractions

V(g)$size=5
png(filename = "interactions.png")
plot(g, vertex.label = NA, edge.arrow.mode = 0, vertes.frame.color= NA)
dev.off()


# calculer distance entre les noeuds

resultats[3]<-distances(g)

# calculer centralité des les noeuds

resultats[4]<-eigen_centrality(g)$value

# calcul de la modularité
wtc=walktrap.community(g)

resultats[5]<-modularity(wtc)

return(resultats)

}