# Aula 02
# Professora Gabriela Ceasere

round (1.333) 
round (pi)


resultado <- round(pi)

salario <- 1000
alguel <- 300

sobra_mensal <- salario - alguel

# Comparadores 

100 >1 
100 <1

1 == 1 
1 != 2

# Convertendo String para Número

idade <- "27" 

# Entre aspas é String

idade_n <- as.numeric(idade)
idade_n

# Convertando String para Logial
falso <- "FALSE"
falso <- as.logical(falso)
falso

# Para se organizar
list.files() # Listar arquivos
getwd() # Pegar Diretório
setwd("/Users/marianaruggeri/Documents/CODE/RStudio/") # Setar novo endereço para trabalhar

# Atribuir Data e Hora
Sys.Date()
Sys.time()


aniversario <-"2021-03-12"
aniversario

tempo_faltante <- as.Date(aniversario) - Sys.Date()
tempo_faltante

### %>% 

library(tidyverse)
library(readr)
library(readxl) #excel
library(data.table) #não esta instalado só demonstração


# Upload dos Arquivos na Pasta Dados

agenda_min_com <- readr::read_csv("dados/agendas_ministerio_comunicacoes/Agenda Ministro - 16-06-2020 a 18-02-2021.csv")

glimpse(agenda_min_com)

# Upolad via menu File > Import DataSet > From Text (readr) 
# Browse.. [escolha o caminho/arquivo] > open > import

