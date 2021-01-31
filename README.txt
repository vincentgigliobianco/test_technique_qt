# README.txt:

# Ce README.txt contient les instructions pour voir et lancer le code R et Python
# que j'ai utilisé


I. Partie Statistiques descriptives R
J'ai réalisé ce travail avec une version linux Ubuntu sous VM.
Je me suis basé sur un script R Markdown pour réaliser la partie Statistiques descriptives.

Ce script est composé du code R et des commentaires sur toutes les sorties qui m'ont été utiles pour rendre le document de réponses au test.


Pour lancer le script R Markdown, il faut :


1. Ouvrir Rstudio puis ouvrir le fichier "test_quantmetry/stats_descriptives_R/quantmetry_test_technique.Rproj" 
2. Ouvrir le fichier "test_technique_quantmetry_VGigliobianco.Rmd"
3. Lancer l'exécution du script R Markdown en cliquant sur l'icône Knit
On peut générer soit un document Word .docx ou un .html grâce au menu déroulant lorsqu'on clique sur l'icône Knit.
ATTENTION, pour générer un .pdf, il faut au préalable lancer la commande: tinytex::install_tinytex()

NB) Le script R Markdown génère en fin de script le fichier "all_data_before_ml.csv" dans le dossier "../ml_python/data"
pour être utilisé pour la partie Machine Learning.


II. Partie Machine learning avec Python version 3.7.3

1. Se déplacer dans le dossier "test_quantmetry/ml_python"
2. Créer l'environnement Conda "test_quantmetry" avec la commande:
conda env create -f environment_test_quantmetry.yml
Si besoin activer l'environnement avec: conda activate test_quantmetry

4. Faire: jupyter lab ou Jupyter notebook
5. Ouvrir le notebook "modeles_ML_orphee.ipynb"


