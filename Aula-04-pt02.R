# Aula 04
# Parte 02
# Professora Gabriela Caesar


# [01] Leia o arquivo listings com a função read_csv() e salve no objeto df_anuncios

df <- readr::read_csv("dados/listings.csv")

# [02] Inspecione os dados: funções summary() e glimpse()
summary(df)
glimpse(df)

# [03] A partir do output de glimpse(), explique as diferentes classes de objetos no R.
class(df$price)
class(df$host_has_profile_pic)
class(df$name)

# [04] Observe o problema nas variáveis de preço
class(df$price)
class(df$weekly_price)
class(df$monthly_price)
head(df$price)

# [05] Retorne a url (scrape_url) do anúncio mais caro do airbnb

df_tratado <- df %>%
  select(listing_url, neighbourhood, host_neighbourhood,
         availability_30, minimum_nights, 
         security_deposit, instant_bookable,
         guests_included, price, room_type, number_of_reviews,
         cleaning_fee, review_scores_rating)  %>%
  mutate(price = parse_number(price)) 

class(df_tratado$price)

questao_05 <- df_tratado %>%
  select(listing_url, neighbourhood, price)  %>%
  arrange(desc(price))

# [06] Retorne o nome do host (host_name) que tem a maior quantidade de anúncios

questao_06 <- df %>%
  select(host_id,host_name,host_url, host_listings_count) %>%
  arrange(desc(host_listings_count)) %>%
  head(1)

questao_06_01 <- df %>%
  select(host_id,host_name,host_url, host_listings_count) %>%
  group_by(host_id)  %>%
  summarise(quantidade_linha = n()) %>%
  arrange(desc(quantidade_linha)) %>%
  head(10)

# [07] Retorne a quantidade de hosts por ano em que entrou no airbnb

library(lubridate)

questao_07 <- df %>%
  distinct(host_id, host_name, host_since) %>%
  mutate(ano = year(host_since)) %>%
  count(ano) %>%
  arrange(desc(ano))

# [08] Selecione as colunas name e space e filtre as linhas que contem a palavra praia em space. Dica: Vc pode usar a função str_detect() dentro de filter() ou de mutate()

questao_08 <- df %>%
  select(name, space) %>%
  filter(str_detect(space, "praia"))
  
  
  questao_08_02 <- questao_08 %>%
    summarise(quantidade_linha = n()) 
  
# [09] Imóveis que mencionam a palavra praia são em média mais caros?
    
questao_09 <- df %>%
    select(name, space, price) %>%
    mutate(price = parse_number(price))  %>%
    mutate(tem_praia = str_detect(space, "praia")) %>%
    group_by(tem_praia) %>%
    summarise(media_price = mean(price))

  
# [10] Use mutate() para modificar o dataframe criando uma coluna booleana chamada esgotado informando se o imovel esta indisponivel para os proximos 30 dias (coluna availability_30)
