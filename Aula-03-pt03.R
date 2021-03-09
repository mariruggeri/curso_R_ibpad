# Aula 03
# Professora Gabriela Caesar
# parte 03

library(tidyverse)


df <- readr::read_csv2("dados/Ano-2020.csv")

glimpse(df)
colnames(df)
head(df)
tail(df)

df[10:100,]

unique(df$sgPartido)

df[72,3]

df[1000:1010, c('sgPartido', 'cpf')]
