# Aula 05
# Parte 02
# Professora Gabriela Caesar
# Capítulo 06 - Juntando dados

# Criando DataFrame
dados2016 <- data.frame(ano = c(2016, 2016, 2016), 
                        valor = c(938, 113, 1748), 
                        produto = c('A', 'B', 'C'))

dados2017 <- data.frame(valor = c(8400, 837, 10983), 
                        produto = c('H', 'Z', 'X'),
                        ano = c(2017, 2017, 2017))


# Unindo dataframes - cabeçalho igual.
dados.finais <- bind_rows(dados2016, dados2017)
dados.finais

# Cruzamentos de DataFrame com Chaves-Primarias

band_members
band_instruments

tabela_banda <- band_members %>%
    inner_join(band_instruments)

# ideal é definir a Chave

tabela_banda_2 <- inner_join(band_instruments, band_members, by = "name" )

?inner_join()

# cabeçalho diferente

tabela_banda_3 <- inner_join(band_members, band_instruments2, 
                             by = c("name" = "artist"))

# usando left_join para manter as linhas de X 

tabela_banda_4 <- left_join(band_members, band_instruments,
                            by = "name")


# usando right_join para manter as linhas de y

tabela_banda_5 <- right_join(band_members, band_instruments,
                            by = "name")


# usando o full_join

tabela_banda_6 <- full_join(band_members, band_instruments,
                             by = "name")


#########

install.packages("nycflights13")
library(nycflights13)

flights
airports

aeroportos <- airports %>%
  select(faa, name)


voos <- flights %>%
  group_by(origin, dest)  %>%
  summarise(qtd = n()) %>%
  left_join(aeroportos, by = c("origin" = "faa")) %>%
  left_join(aeroportos, by = c("dest" = "faa")) %>%
  rename(origem = name.x, 
         destino = name.y) %>%
  arrange(desc(qtd))

