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
# 02:04:14