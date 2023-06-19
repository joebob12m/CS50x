# Building
#### Video Demo:  https://youtu.be/vdRKJzL0MIw
#### Description: 
Collecting data on collaboration between student at my university and making analysis to create an article (I study in biology,so this could be usefull !). Sorry if the comments are in french, the person I did this project with is not the best in english ...

Description of files :

data_r.R : takes all of the files ending in .csv from a floder and reads them into a list

nettoyage.R : takes that list and cleans all of the data the wasn't written right, all of mistakes have to be fixed for the analysis to work, so each name tipped wrong was written again, vrai/faux from french was changed to TRUE/FALSE (bool), every data typed in twice was deleted to no falsify the statistics of our data, we added the names that were missing ...

tableau_qll.R : using sqlite, we took all of the data that had now been cleaned and made a data base out of it in 3 table : students, collaborations and course (sorry, it's in french again in the file). 

Requetes.R : then we made requests to go get the data we needed in the way we needed it to make the analysis.

Analyse.R : Here we make the analysis, it's complicated, but we basically wanted to see how students collaborated in their homeworks, so we built a web of collaborations and we made a mantel test to see if the year the students started university and the place the students came from had an influence on their rate of collaborations. Then we made 4 graphs out of those analysis, we also made a couple other less important analysis on the data. 

rapports.rmd : Then we took all of those graphs and put then in an original article where we disscuss our analysis. All sources were cited at the end of the file.
