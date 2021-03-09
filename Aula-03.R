# Aula 03
# Professora Gabriela Caesar

# Consultar documetação usar "?"

?readr::read_csv()

# Capítulo 04 - Manipulando os Dados

# Criar um Data Frame


uf <- c("AL","BA","CE","MA","PB","PE","PI","RN","SE")
regiao <- "Nordeste"
temperatura <- c(29, 28, 27, 26, 30, 26, 31,30, 33) 
renda <- c(100, 200, 300, 400, 500, 600, 700, 800, 900)

# É necessária a mesma quantidade de linahs no VETOR

uf_nordeste <- data.frame(uf, regiao, temperatura, renda)

# Verificar informação
# Atenção para a grafia dos dados, espaços e tipos diferentes impactam na execução do comando

uf_nordeste$temperatura
uf_nordeste$uf

unique(uf_nordeste$temperatura)
unique(uf_nordeste$renda)

# Para visualizar digitar view(varivavel) no console

vetor_num_repetidos <- c(rep(2,50))

# Coletar informações do vetor com STR
str(uf_nordeste)

########

library(tidyverse)

df <- readr::read_csv2("dados/Ano-2020.csv")

# df <- readr::read_csv2("dados/Ano-2020.csv", n_max = 10) 
# para importar só 10 linhas no data frame
# ?read_csv2() --> para ver os parâmetros da função

glimpse(df)

# Confirmar informações no DataFrame
is.na(df$cpf)
is.na(df$ideCadastro)
is.na(df$txNomeParlamentar)

# Salvando informação em uma linha
linha_3 <- df[3,]

# linha_3 <- df[3:10,] ---> Para pegar a informação de um conjunto de linhas

# Quando preenchido retorna TRUE e vazio FALSE
complete.cases(df$cpf)

