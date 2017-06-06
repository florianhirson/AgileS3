appelez les Hendek !
Livraison chez toi, en moins de 2.

Exemple de creation de site de e-commerce en java : http://wayofcode.fr/site-de-e-commerce-en-java-ee-avec-spring-framework-partie-1/
/


Command line instructions 


Git global setup 

git config --global user.name "Alexandre RICHARD" 


git config --global user.email "alexandre.richard@etudiant.univ-lille1.fr" 



Create a new repository 

git clone https://git-iut.univ-lille1.fr/bonevai/ProjeMode2016-O2.git  

cd ProjeMode2016-O2 touch README.md 

git add README.md 

git commit -m "add README" 

git push -u origin master 


Existing folder 

cd existing_folder 


git init 

git remote add origin https://git-iut.univ-lille1.fr/bonevai/ProjeMode2016-O2.git 


git add . 


git commit git push -u origin master 



Existing Git repository 



cd existing_repo git remote add origin https://git-iut.univ-lille1.fr/bonevai/ProjeMode2016-O2.git 


git push -u origin --all git push -u origin --tags

