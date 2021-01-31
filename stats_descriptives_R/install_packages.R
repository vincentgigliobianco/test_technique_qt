# Vérification si des packages n'existent pas
# alors installation des packages 

packages <- c("knitr","dplyr","ggplot2","Hmisc","corrplot","reshape2","pander","descr","nlme","gridExtra","stringr")
if (length(setdiff(packages, rownames(installed.packages()))) > 0) {
  print ("Installation des packages")
  install.packages(setdiff(packages, rownames(installed.packages())))  
}


