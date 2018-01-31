library(plyr)

mushrooms_raw <- read.csv('C:\\Users\\Brian\\Desktop\\GradClasses\\Spring18\\607\\assignments\\agaricus-lepiota.csv', header=FALSE, stringsAsFactors=FALSE)
names <- read.csv('C:\\Users\\Brian\\Desktop\\GradClasses\\Spring18\\607\\assignments\\names.csv', header=FALSE, stringsAsFactors=FALSE, row.names=1, col.names=0:12)

names <- t(names)
names(mushrooms_raw) <- colnames(names)

my_columns <- c('classes', 'odor', 'population', 'habitat')
mushrooms_reduced <- subset(mushrooms_raw, select=my_columns)

#"unlist" code adapted from "Henry" on Stackoverflow
process_names <- function(data, to_mod, column){
  mod_names <- strsplit(data[,column], '=')
  mod_names[sapply(mod_names, length)==0] <- NULL
  abbreviations <- unlist(mod_names)[2*(1:length(mod_names))]
  full_names <- unlist(mod_names)[2*(1:length(mod_names))-1]
  return(mapvalues(to_mod[,column], from=abbreviations, to=full_names))
}


for(column in my_columns){
  mushrooms_reduced[,column] <- process_names(names, mushrooms_reduced, column)
}
