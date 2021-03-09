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

# %>% pipe. 

# Select



df <- df %>%
  #select_if(is.numeric) 
  #select(starts_with("vlr"))
  select(-vlrGlosa) %>%
  mutate(vlrDocumento = as.numeric(vlrDocumento))
#filter(sgPartido %in% c("PSDB", "NOVO", "SOLIDARIEDADE", "PTB"))

df %>% 
  select(txNomeParlamentar, vlrLiquido, sgPartido) %>% 
  mutate(txNomeParlamentar = tolower(txNomeParlamentar)) %>% 
  mutate(sgPartido = tolower(sgPartido)) %>%
  tail()

acima_10mil <- df %>% 
  select(cpf, txNomeParlamentar, txtDescricao, vlrDocumento) %>% 
  mutate(vlrDocumento = as.numeric(vlrDocumento)) %>%
  filter(vlrDocumento >= 100000) 

df %>%
  janitor::clean_names()

# ?janitor::clean_names()

gastos_deputado <- df %>% 
  select(cpf, txNomeParlamentar, txtDescricao, vlrDocumento, sgPartido) %>% 
  mutate(vlrDocumento = as.numeric(vlrDocumento)) %>%
  group_by(txNomeParlamentar, sgPartido) %>%
  summarise(soma_total = sum(vlrDocumento),
            qt_nota_fiscal = n(),
            gasto_por_nota_fiscal = soma_total / qt_nota_fiscal) %>%
  arrange(desc(soma_total))

gastos_mensais <- df %>% 
  select(cpf, txNomeParlamentar, txtDescricao, vlrDocumento, sgPartido, numMes) %>% 
  mutate(vlrDocumento = as.numeric(vlrDocumento)) %>%
  group_by(numMes) %>%
  summarise(soma_total = sum(vlrDocumento)) %>%
  arrange(desc(soma_total))

