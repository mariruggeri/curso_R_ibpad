# Aula 04
# Professora Gabriela Caesar

library(tidyverse)
df <- readr::read_csv2("dados/Ano-2020.csv")


# Exerícios 4.5.1 

# Quais foram os deputados com mais despesas na cota parlamentar (considerando a coluna vlrDocumento)?

resposta_1 <- df %>%
  mutate(vlrDocumento = as.numeric(vlrDocumento)) %>%
  group_by(txNomeParlamentar, sgPartido) %>%
  summarise(soma_vlr = sum(vlrDocumento)) %>%
  arrange(desc(soma_vlr)) %>%
  head(3)
  
# Quais foram as 5 empresas mais contratadas (considerando a coluna textCNPJCPF)?

resposta_2 <- df %>%
  mutate(vlrDocumento = as.numeric(vlrDocumento)) %>%
  group_by(txtCNPJCPF, txtFornecedor) %>%
  summarise(soma_vlr = sum(vlrDocumento)) %>%
  arrange(desc(soma_vlr)) %>%
  head(5)

resposta_2_2 <- df %>%
    filter(txtCNPJCPF %in% c("075.756.510/0015-9", "020.128.620/0016-0"))

resposta_2_3 <- df %>%
  filter(txtCNPJCPF == "020.128.620/0016-0") %>%
  group_by(txNomeParlamentar, sgPartido) %>%
  mutate(vlrDocumento = as.numeric(vlrDocumento)) %>%
  summarise(soma_vlr = sum(vlrDocumento)) %>%
  arrange(desc(soma_vlr)) %>%
  head(10)

resposta_2_4 <- df %>%
  filter(txtCNPJCPF == "020.128.620/0016-0") %>%
  group_by(sgPartido) %>%
  mutate(vlrDocumento = as.numeric(vlrDocumento)) %>%
  summarise(soma_vlr = sum(vlrDocumento)) %>%
  arrange(desc(soma_vlr)) %>%
  head(5)

resposta_2_5 <- df %>% 
  filter(sgPartido == "PSL") %>%
  filter(txtCNPJCPF == "020.128.620/0016-0") %>%
  group_by(txNomeParlamentar) %>%
  mutate(vlrDocumento = as.numeric(vlrDocumento)) %>%
  summarise(soma_vlr = sum(vlrDocumento)) %>%
  arrange(desc(soma_vlr)) %>%
  head(10)

gastao <- df %>% 
  filter(sgPartido == "PSL") %>%
  filter(txtCNPJCPF == "020.128.620/0016-0") %>%
  group_by(txNomeParlamentar) %>%
  mutate(vlrDocumento = as.numeric(vlrDocumento)) %>%
  summarise(soma_vlr = sum(vlrDocumento)) %>%
  arrange(desc(soma_vlr)) %>%
  head(1)

todo_psl <- df %>% 
  filter(sgPartido == "PSL") %>%
  filter(txtCNPJCPF == "020.128.620/0016-0") %>%
  group_by(sgPartido) %>%
  mutate(vlrDocumento = as.numeric(vlrDocumento)) %>%
  summarise(soma_vlr = sum(vlrDocumento)) %>%
  arrange(desc(soma_vlr)) %>%
  head(1)

parte_todo <- (gastao$soma_vlr) / (todo_psl$soma_vlr) 
  
# Qual foi o gasto médio dos deputados, por UF, com a cota parlamentar (considerando a coluna vlrDocumento)?

resposta_3 <- df %>%
  mutate(vlrDocumento = as.numeric(vlrDocumento)) %>%
  group_by(sgUF) %>%
  summarise(soma_vlr = sum(vlrDocumento), media_vlr = mean(vlrDocumento)) %>%
  arrange(desc(soma_vlr))
  
qt_deputados <- df %>% 
  filter(!str_detect(txNomeParlamentar, "LIDERANÇA|LIDMIN")) %>%
  distinct(txNomeParlamentar, sgUF)  %>%
  group_by(sgUF) %>%
  summarise(qt = n()) %>%
  arrange(desc(qt))


resposta_3_g <- df %>%
  mutate(vlrDocumento = as.numeric(vlrDocumento)) %>%
  group_by(sgUF) %>%
  summarise(soma_vlr = sum(vlrDocumento), media_vlr = mean(vlrDocumento)) %>%
  left_join(qt_deputados, by = "sgUF") %>%
  mutate(media_gasto = soma_vlr / qt) %>%
  arrange(desc(media_gasto)) 
    
# Quais categorias de gastos registraram mais despesas nas lideranças (considerando a coluna txtDescricao)?
  
resposta_4 <- df %>%
  mutate(vlrDocumento = as.numeric(vlrDocumento)) %>%
  filter(str_detect(txNomeParlamentar, "LIDERANÇA|LIDMIN")) %>%
  group_by(txtDescricao) %>%
  summarise(soma_vlr = sum(vlrDocumento)) %>%
  arrange(desc(soma_vlr)) %>%
  head(5)

# Quantas linhas da coluna com o PDF da nota fiscal estão com NA (considerando a coluna urlDocumento)?
  
resposta_5 <- df %>%
  filter(is.na(urlDocumento)) %>%
  nrow()
#  count(urlDocumento)

# Qual foi o mês com menos gastos (considerando a coluna numMes) 

resposta_6 <- df %>%
  mutate(vlrDocumento = as.numeric(vlrDocumento)) %>%
  group_by(numMes) %>%
  summarise(soma_nota = sum(vlrDocumento)) %>%
  arrange(soma_nota)

