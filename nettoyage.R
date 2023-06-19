# Nettoyer les données
nettoyage<-function(data_d){
  
# dependencies

library(dplyr)
  
## Enlever doublon de l'équipe 8 (celui extrait avec read.csv2)
data_d<-data_d[-c(25,26,27)]
  
## Collaborations ###################################################################################################

### Enlever les colonnes vides
data_d[["X6_collaboration"]]<-data_d[["X6_collaboration"]][,1:4]

### Fusionner les rangées des documents
collaborations <- rbind(data_d[["X1_collaboration"]],data_d[["X2_collaboration"]],data_d[["X3_collaboration"]],data_d[["X4_collaboration"]],data_d[["X5_collaboration"]],data_d[["X6_collaboration"]],data_d[["X7_collaboration"]],data_d[["X8_collaboration"]],data_d[["X9_collaboration"]],data_d[["X10_collaboration"]])

### Supprimer les rangées identiques
collaborations<-distinct(collaborations)

### enlever rangé vide 
collaborations <- collaborations[-c(1173),]


### Corriger nom avec accent

#### étudiant1
collaborations[2114:2118,1]<-"mia_carriere"
collaborations[2099:2103,1]<-"juliette_meilleur"
collaborations[2057:2064,1]<-"eve_dandonneau"

# enlever les collaborations avec sois-même
collaborations <- collaborations[-c(2555,2337,1665),]

### Corriger nom avec accent

####étudiant2
collaborations[c(2086,2121,2143,2040,2107,2129,2078,2048),2]<-"eve_dandonneau"
collaborations[c(2070,2074,2140,2102,2067),2]<-"mia_carriere"
collaborations[c(2069,2117,2073,2066,2139),2]<-"juliette_meilleur"

### Corriger fautes dans noms etudiant1

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

#collaborations$etudiant1[collaborations$etudiant1=="ihuoma_elsie-ebere"]<-"jonathan_rondeau-leclaire"   ####? erreur ?###

collaborations$etudiant1[collaborations$etudiant1=="jonathan_rondeau_leclaire"]<-"jonathan_rondeau-leclaire"

collaborations$etudiant1[collaborations$etudiant1=="justine_lebelle"]<-"justine_labelle"

collaborations$etudiant1[collaborations$etudiant1=="laurianne_plante "]<-"laurianne_plante"

collaborations$etudiant1[collaborations$etudiant1=="laurie_anne_cournoyer"]<-"laurie-anne_cournoyer"

collaborations$etudiant1[collaborations$etudiant1=="louis-phillippe_theriault"]<-"louis-philippe_theriault"

collaborations$etudiant1[collaborations$etudiant1=="louis_philippe_raymond"]<-"louis-philippe_raymond"

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

collaborations$etudiant1[collaborations$etudiant1=="sabrica_leclercq"]<-"sabrina_leclercq"

collaborations$etudiant1[collaborations$etudiant1=="savier_samson"]<-"xavier_samson"

collaborations$etudiant1[collaborations$etudiant1=="sara_jade_lamontagne"]<-"sara-jade_lamontagne"

collaborations$etudiant1[collaborations$etudiant1=="yannick_sageau"]<-"yanick_sageau"

collaborations$etudiant1[collaborations$etudiant1=="yanick_sagneau"]<-"yanick_sageau"



### Corriger fautes dans noms etudiant2

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

collaborations$etudiant2[collaborations$etudiant2=="jonathan_rondeau_leclaire"]<-"jonathan_rondeau-leclaire"

collaborations$etudiant2[collaborations$etudiant2=="justine_lebelle"]<-"justine_labelle"

collaborations$etudiant2[collaborations$etudiant2=="laurianne_plante "]<-"laurianne_plante"

collaborations$etudiant2[collaborations$etudiant2=="laurie_anne_cournoyer"]<-"laurie-anne_cournoyer"

collaborations$etudiant2[collaborations$etudiant2=="louis-phillippe_theriault"]<-"louis-philippe_theriault"

collaborations$etudiant2[collaborations$etudiant2=="louis_philippe_raymond"]<-"louis-philippe_raymond"

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

## Ajouter des Id unique 

collaborations$ID<-seq_along(collaborations[,1])


## Cours ###################################################################################################

### Enlever les colonnes vides
data_d[["X4_cours"]]<-data_d[["X4_cours"]][,1:3]
data_d[["X6_cours"]]<-data_d[["X6_cours"]][,1:3]

### Fusionner les rangées des documents
cours<-rbind(data_d[["X1_cours"]],data_d[["X2_cours"]],data_d[["X3_cours"]],data_d[["X4_cours"]],data_d[["X5_cours"]],data_d[["X6_cours"]],data_d[["X7_cours"]],data_d[["X8_cours"]],data_d[["X9_cours"]],data_d[["X10_cours"]])

### mettre les rangé vrai/faux en T/F booléen
cours$optionnel[cours$optionnel=="VRAI"]<-TRUE
cours$optionnel[cours$optionnel=="FAUX"]<-FALSE
cours$optionnel<-as.logical(cours$optionnel)

### Supprimer les rangées identiques
cours<-distinct(cours)

### nettoyage de finission
cours <- cours[-c(62,3,77,75,68,57,58,23,69,70,79,78,93,52,36,40,80,94),]

## Etudiants ###################################################################################################

### Enlever les colonnes vides
data_d[["X2_etudiant"]]<-data_d[["X2_etudiant"]][,1:8]
data_d[["X3_etudiant"]]<-data_d[["X3_etudiant"]][,1:8]
data_d[["X6_etudiant"]]<-data_d[["X6_etudiant"]][,1:8]
data_d[["X8_etudiant"]]<-data_d[["X8_etudiant"]][,1:8]

### Renommer la colonne fautives
data_d[["X3_etudiant"]]<-data_d[["X3_etudiant"]] %>% rename(
  prenom_nom = prenom_nom.
)

### Fusionner les rangées des documents
etudiants<-rbind(data_d[["X1_etudiant"]],data_d[["X2_etudiant"]],data_d[["X3_etudiant"]],data_d[["X4_etudiant"]],data_d[["X5_etudiant"]],data_d[["X6_etudiant"]],data_d[["X7_etudiant"]],data_d[["X8_etudiant"]],data_d[["X9_etudiant"]],data_d[["X10_etudiant"]])

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
etudiants[89,1]<-"kayla_trempe-kay"
etudiants[151,1]<-"louis-philippe_raymond"
etudiants[85,1]<-"roxanne_bernier"
etudiants[81,1]<-"marie-christine_arseneau"

#enlever doublons avec NA et les rangées vides

etudiants <- etudiants[-c(137,10,194,120,128,193,183,66,23,31,95,36,148,97,182,222,71,37,173,224,16,108,98,41,184,42,76,77,92,116,159,8,46,28,122,29,188,47,144,80,48,186,185,20,50,223,18,51,52,100,19,84,53,54,99,210,17,56,12,57,58,176,26,59,204,62,136,205,11,226,172,171),]

# Ajouter les nom manquant qui sont présent dans collaboration
add <- matrix(nrow=6,ncol = 8)
add[1,1]= "eloise_bernier"
add[2,1]= "gabrielle_moreault"
add[3,1]= "karim_hamzaoui"
add[4,1]= "maude_viens"
add[5,1]= "maxence_comyn"
add[6,1]= "naomie_morin"
colnames(add)<- c("prenom_nom","prenom","nom","region_administrative","regime_coop","formation_prealable","annee_debut","programme")
add<-as.data.frame(add)
etudiants<-rbind(etudiants,add)

## mettre en ordre 
etudiants <- etudiants[order(etudiants$prenom_nom),]

## Créer une liste avec les data.frame nettoyer

data_n<-list(collaborations,cours,etudiants)

return(data_n)

}