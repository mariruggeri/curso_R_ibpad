# Aula 09
# Parte 01
# Professor Sillas Gongaza 
# Capítulo 11 - Estruturas complexas de dados
# http://sillasgonzaga.com/material/cdr/estruturas-complexas-de-dados.html

vetor <- c(1,2, "c", 4)

class(vetor)

vetor[1]*2  # Erro Esperado: Error in vetor[1] * 2 : argumento não-numérico para operador binário

as.numeric(vetor) # Aviso: NAs introduzidos por coerção 

# Usando Listas

lista <- list(1,2,"c", 4)

class(lista)

# Referencia-se elementos com colchetes dupulos

lista[[1]]
lista[[3]]

class(lista[[1]])
class(lista[[3]])

# lista preserva o tipo original dos itens.

###

data_frame <- head(iris)
elemento_unico_inteiro <- 1
um_na <- NA
vetor_string <- letters[1:5]
modelo_regressao <- lm(mpg ~ wt, data = mtcars)

minha_lista <- list("tabela" = data_frame, 
                    "numero" = elemento_unico_inteiro, 
                    # este elemento abaixo não vai possuir um nome
                    "indefinido" = um_na, 
                    "letras" = vetor_string,
                    "regressao" = modelo_regressao)

# Conferindo o output: 
minha_lista
class(minha_lista)
class(minha_lista[[5]])
class(minha_lista$letras)

library(purrr)
library(tidyverse)

map(minha_lista, class)

meu_vetor <- c(1,-3, 5, -10)

abs(meu_vetor)
class(abs(meu_vetor))

lista_numeros <- list(1, -3, 5, -10)
class(lista_numeros)

abs(lista_numeros) # Erro in abs :  non-numeric argument to mathematical function

map(lista_numeros, abs)
class(map(lista_numeros,abs))

map_dbl(lista_numeros, abs)

# usando com o pipe
lista_numeros %>% map_dbl(abs)

###

l <- list(v1 = c(1,3,5),
          v2 = c(2.0004789, 4.0010418, 6.89413),
          v3 = c(7,8,9))

map(l, round, 3)
map(l, round, digits = 2)

map(l, sqrt)

l %>% map(sum)

l %>% map(sqrt) %>% map(sum)

map(l, function(x){x^2/3 * 2/7})

map(l, function(y) y %>% sqrt() %>% sum())
mpa(l, function(z) sum(sqrt(z)))

# sintaxe de formula
# genéricoL map(NOME_LISTA, ~, .x)

map(l, ~ (.x^2)/3 * 2/7)

map(l, ~ .x^2)
map(l, ~ .^2)

### PROJETO

library(tidyverse)
library(lubridate)

arquivo <- "dados/archive/AEP_hourly.csv"
arquivo_2 <- "dados/archive/COMED_hourly.csv"

df <- readr::read_csv(arquivo_2)
nome_estacao <- str_sub(colnames(df)[2], 1, -4)

df %>%
  rename(consumo = 2) %>%
  mutate(mes = month(Datetime),
         estacao = nome_estacao) %>%
  group_by(mes, estacao) %>%
  summarise(consumo_medio = mean(consumo))

retorna_consumo_mensal <- function(nome_arquivo) {
  df <- readr::read_csv(arquivo)
  nome_estacao <- str_sub(colnames(df)[2], 1, -4)
  df %>%
    rename(consumo = 2) %>%
    mutate(mes = month(Datetime),
           estacao = nome_estacao) %>%
    group_by(mes, estacao) %>%
    summarise(consumo_medio = mean(consumo))
}

arquivo <- "dados/archive/DAYTON_hourly.csv"
retorna_consumo_mensal(arquivo)


vetor_nomes_arquivos <- list.files("dados/archive",
                                   full.names = TRUE,
                                   pattern = "_hourly.csv$")  


list_dfs <- map(vetor_nomes_arquivos, retorna_consumo_mensal)

map(list_dfs, class)

df_exercicio <- bind_rows(list_dfs)

readr::write_csv2(df_exercicio, "exercicio_consumo_mensal_medio.csv")
