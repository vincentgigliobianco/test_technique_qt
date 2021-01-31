# Fonction qui dit si une variable est un facteur ou non
fun_is_factor = function(df,name_var){
  return(is.factor(df[[name_var]]))
}

# Distributions univariées des variables explicatives
fun_build_1d_plot = function(name_var,df){
  
  # Quel est le format de la variable a plotter
  decision = fun_is_factor(df,name_var)
  # le cas ou la variable est catégorielle
  if (decision){# - catégorielles
      g <- ggplot(df,aes_string(x = name_var)) +
      geom_bar(fill = "#0072B2", color = "black") +
      ggtitle(paste0("Distribution de ", name_var)) 
  }
  else{# continues
    g <- ggplot(df,aes_string(x = name_var)) +
    geom_histogram(color = "black",fill = "blue", bins=15) +
    labs(title = paste0("Distribution de ",name_var)) 
  }
  return(g)
}


fun_build_2d_plot =function(df,name_var_1,name_var_2){
  # Quel est le format de la variable a plotter
  decision_1 = fun_is_factor(df,name_var_1)
  decision_2 = fun_is_factor(df,name_var_2)
  # si les deux variables sont catégorielles
  if (decision_1 & decision_2){
    # g <-ggplot(df, aes_string(x = "embauche", y=name_var, fill=name_var)) +
    g <-ggplot(df, aes_string(y = name_var_2, x=name_var_1, fill="embauche")) +
    geom_bar(stat="identity") +
    theme(legend.title=element_blank())
  } else { # le cas ou elle est continue
    # g <- ggplot(df, aes_string(x = "embauche", y=name_var)) +
      g <- ggplot(df, aes_string(x = name_var_2, y=name_var_1)) +
      geom_boxplot(varwidth=T, fill="plum")
  }
  return(g)
}

# % des embauchés pour chaque variable catégorielle 
fun_pct_embauche_by_categ <- function(name_var){
  tab_temp = table(df_filter_nomissing$embauche,df_filter_nomissing[,name_var])
  # install.packages("gmodels")
  # library(gmodels)
  # CrossTable(df_eval$decision, df_eval$strate_var_score) 
  return (prop.table(tab_temp,2))
}

fun_crosstable_with_embauche <- function(name_var){
  ct <- CrossTable(df_filter_nomissing[, name_var],df_filter_nomissing$embauche, prop.t=F, prop.chisq=F,  
                   dnn = c(name_var, "embauche"))
  return(pander(ct,digits=1))
}

fun_build_3dplot = function(df,varX,varY){
  g = ggplot(df, aes_string(varX, varY)) +
    geom_raster(aes_string(fill = "pct")) + 
    scale_fill_gradientn(colours=c("yellow","red"))
  return(g)
}

fun_chi2 <- function(name_var){
  mytable <- table(df_filter_nomissing[, name_var],df_filter_nomissing$embauche)
  chi2 <- chisq.test(mytable, correct=TRUE)
  return(pander(chi2))
}


quartiles <- function(x) {
  quartiles_values <- ceiling(quantile(x, probs = seq(0, 1, by = 0.25)))
  interv_1 <- paste0("'[",quartiles_values[1],"-",quartiles_values[2],"[',")
  interv_2 <- paste0("'[",quartiles_values[2],"-",quartiles_values[3],"[',")
  interv_3 <- paste0("'[",quartiles_values[3],"-",quartiles_values[4],"[',")
  interv_4 <- paste0("'[",quartiles_values[4],"-",quartiles_values[5],"['")
  labels_to_use_expr <- paste0("labels_to_use <- c(",interv_1,interv_2,interv_3,interv_4,")")
  eval(parse(text = labels_to_use_expr))
  quartiles_values <- cut(x, breaks=c(quantile(x, probs = seq(0, 1, by = 0.25))), 
                          labels = labels_to_use, include.lowest=TRUE)
  return(quartiles_values)
}


# ApplyQuintiles <- function(x) {
#   cut(x, breaks=c(quantile(df$orders, probs = seq(0, 1, by = 0.20))), 
#       labels=c("0-20","20-40","40-60","60-80","80-100"), include.lowest=TRUE)
# }

deciles <- function(x) {
  deciles_values <- ceiling(quantile(x, probs = seq(0, 1, by = 0.1)))
  interv_1 <- paste0("'[",deciles_values[1],"-",deciles_values[2],"[',")
  interv_2 <- paste0("'[",deciles_values[2],"-",deciles_values[3],"[',")
  interv_3 <- paste0("'[",deciles_values[3],"-",deciles_values[4],"[',")
  interv_4 <- paste0("'[",deciles_values[4],"-",deciles_values[5],"[',")
  interv_5 <- paste0("'[",deciles_values[5],"-",deciles_values[6],"[',")
  interv_6 <- paste0("'[",deciles_values[6],"-",deciles_values[7],"[',")
  interv_7 <- paste0("'[",deciles_values[7],"-",deciles_values[8],"[',")
  interv_8 <- paste0("'[",deciles_values[8],"-",deciles_values[9],"[',")
  interv_9 <- paste0("'[",deciles_values[9],"-",deciles_values[10],"[',")
  interv_10 <- paste0("'[",deciles_values[10],"-",deciles_values[11],"['")
  labels_to_use_expr <- paste0("labels_to_use <- c(",interv_1,interv_2,interv_3,interv_4,interv_5,interv_6,interv_7,interv_8,interv_9,interv_10,")")
  eval(parse(text = labels_to_use_expr))
  deciles_values <- cut(x, breaks=c(quantile(x, probs = seq(0, 1, by = 0.1))), 
                        labels = labels_to_use, include.lowest=TRUE)
  
  return (deciles_values)
}


fun_crosstable_each_other <- function(name_var_1,name_var_2){
  ct <- CrossTable(df_filter_nomissing[, name_var_1],df_filter_nomissing[, name_var_2], prop.t=F, prop.chisq=F,  
                   dnn = c(name_var_1, name_var_2))
  return(pander(ct,digits=1))
}

fun_chi2_each_other <- function(name_var_1,name_var_2){
  mytable <- table(df_filter_nomissing[, name_var_1],df_filter_nomissing[, name_var_2])
  chi2 <- chisq.test(mytable, correct=TRUE)
  return(pander(chi2))
}

