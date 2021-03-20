# Aula 08
# Parte 02
# Professor Sillas Gongaza 
# Capítulo 10 - Obtendo dados
# http://sillasgonzaga.com/material/cdr/obtendo-dados.html


# Via API - site exemplo (https://www.okanebox.com.br/)

library(httr)
library(jsonlite)

url <- "http://www.okanebox.com.br/api/acoes/hist/ABEV3/20210101/20210315/"


abev3 <- GET(url)

content(abev3, as = "text") %>%
  fromJSON() %>%
  as_tibble() %>%
  mutate(DATPRG = str_sub(DATPRG, 1, 10))



url2 <-  "http://www.okanebox.com.br/api/acoes/hist/{acao}/{datainicial}/{datafinal}/"
url2 <- str_glue(url2)

baixar_dados_acao <- function(codigo, data_inicial, data_final){
  urlf <- "http://www.okanebox.com.br/api/acoes/hist/{codigo}/{data_inicial}/{data_final}/"
  urlf <- str_glue(urlf)
  resposta <- GET(urlf)
  
  content(resposta, as = "text") %>%
    fromJSON() %>%
    as_tibble() %>%
    mutate(DATPRG = str_sub(DATPRG, 1, 10))
}

baixar_dados_acao("PETR4", "20210101", "20210301")

library(rvest)

urlw <- "https://pt.wikipedia.org/wiki/Campeonato_Brasileiro_de_Futebol_de_2018_-_Série_A" %>%
  read_html()

# ou direto sem o pipe
# urlw <- read_html("https://pt.wikipedia.org/wiki/Campeonato_Brasileiro_de_Futebol_de_2018_-_Série_A")

tb <- html_table(urlw, fill = TRUE)
tb[[6]]

?html_table
