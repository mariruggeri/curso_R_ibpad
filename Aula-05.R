# Aula 05
# Parte 01
# Professora Gabriela Caesar

library(tidyverse)

tb_01 <- relig_income %>%
  pivot_longer(-religion,
               names_to = "income",
               values_to = "n_respondentes")

# outra forma -> nome da coluna
tb_01_02 <- relig_income %>%
    pivot_longer(`<$10k`:`Don't know/refused`, 
                 names_to = "income",
                 values_to = "n_respondentes")

# outra forma -> indice da coluna
tb_01_03 <- relig_income %>%
  pivot_longer(2:11, 
               names_to = "income",
               values_to = "n_respondentes")

tb_02 <- us_rent_income %>%
  pivot_wider(names_from = "variable",
              values_from =c("estimate", "moe"))

tb_03 <- table3 %>%
  separate(rate, into = c("casos", "populacao"), sep = "/")

tb_04 <- table5 %>%
  unite(ano, c(century,year), sep = "", remove = FALSE) %>%
  separate(rate, into = c("casos", "populacao"), sep = "/")


# criar dataframe de exemplo

exemplo <- tibble(grupo = c("a", "a", "b", "b"),
                 y = c("1,2", "3;4", "1,2,3", "4"))

#exemplo %>%
#   separate(y, into = c("v1", "v2", "v3"), sep = ",")

exemplo %>%
    separate_rows(y, sep = ";")


## Exercícios 5.3

# [01] Transforme a table1 para a table2 usando pivot_longer()
# cases está em coluna e tem que virar linha

questao_1 <- table1 %>%
    pivot_longer(cols = c("cases","population"),
                 names_to = "type",
                 values_to = "count")

# [02] Transforme a table2 para a table1 usando pivot_wider()

questao_2 <- table2 %>%
    pivot_wider(names_from = "type",
                values_from = "count")

# [03] Transforme a table5 para a table1 e para a table2

questao_3 <- table5 %>%
  unite(ano, c(century,year), sep = "", remove = TRUE) %>%
  separate(rate, into = c("casos", "populacao"), sep = "/")

questao_3_1 <- questao_3 %>%
  pivot_longer(cols = c("casos","populacao"),
               names_to = "type",
               values_to = "count")

