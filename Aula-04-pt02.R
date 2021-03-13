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

questao_10 <- df %>%
    select(host_id, host_location, availability_30) %>%
    mutate(esgotado = availability_30 == 0) %>%
    filter(esgotado == TRUE)

# [11] Quais os 5 bairros que possuem mais de 100 anúncios com a maior taxa de anúncios esgotados nos próximos 30 dias? Dica: crie duas colunas com summarise, uma usando n() e outra com mean(esgotado) e depois use filter(), arrange() e head()

questao_11 <- df %>%
  mutate(esgotado = availability_30 == 0) %>%
  filter(esgotado == TRUE) %>%
  group_by(neighbourhood, esgotado) %>%
  summarise(qt_anuncio = n(), taxa_esgotado = mean(esgotado)) %>%
  filter(qt_anuncio >= 100) %>%
  arrange(desc(qt_anuncio)) %>%
  head(5)

# [12] Retorne a quantidade de anúncios e reviews (number_of_reviews) por bairro, calcule uma taxa de quantidade de reviews por quantidade de anuncios. Os bairros que possuem mais anuncios são, proporcionalmente, os que tem mais reviews?
  
questao_12 <- df %>%
  group_by(neighbourhood) %>%
  summarise(qt_anuncio = n(), qt_review = sum(number_of_reviews)) %>%
  mutate(tx_review_bairro = qt_review / qt_anuncio) %>%
  filter(qt_anuncio >= 1000) %>%
  arrange(desc(tx_review_bairro))

# [13] Quais são os diferentes tipos de anúncio (quarto, apt, etc.) que existem? (Coluna room_type)

questao_13 <- df %>%
  select(room_type) %>%
  distinct(room_type)

# [14] A quantidade de quartos tem relação com o preço dos apartamentos inteiros?

questao_14 <- df %>%
  select(room_type, bedrooms, price) %>%
  mutate(price = parse_number(price)) %>%
  filter(room_type == "Entire home/apt") %>%
  group_by(bedrooms) %>%
  summarise(preco_medio = mean(price),
            preco_mediano = median(price),
            qtd_anuncios = n())

questao_14_01 <- df %>%
mutate_at(vars(weekly_price, monthly_price, price, 
                 cleaning_fee, extra_people, 
                 security_deposit), 
            parse_number)

# [15] DESAFIO Suponha que você planeja uma viagem para o RJ com mais 1 pessoa de 5 diárias nos… proximos 30 dias. Você e seu grupo têm alguns critérios de escolha:
# Vocês querem ficar em Ipanema, Copacabana ou Leblon.
# Vocês preferem que o host esteja no mesmo bairro.
# Não desejam pagar um depósito de segurança;
# Querem um apartamento inteiro só para vocês que seja “instant bookable”
# A diária já inclua duas pessoas


df_tratado_1 <- df %>%
  select(listing_url, neighbourhood, host_neighbourhood,
         availability_30, minimum_nights, 
         security_deposit, instant_bookable,
         guests_included, price, room_type, number_of_reviews,
         cleaning_fee, review_scores_rating)  %>%
  mutate_at(vars(price,cleaning_fee,security_deposit),parse_number)


questao_15 <- df_tratado_1 %>%
  filter(neighbourhood %in% c("Leblon", "Copacabana", "Ipanema"),
         host_neighbourhood == neighbourhood,
         security_deposit == 0, 
         instant_bookable == TRUE,
         room_type == "Entire home/apt",
         guests_included >= 2) %>%
mutate(preco_tt_viagem = cleaning_fee + price * 5) %>%
select(listing_url, neighbourhood, preco_tt_viagem) %>%
arrange(preco_tt_viagem) %>%
head(5)
  
  
  
 