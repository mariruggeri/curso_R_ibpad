# Aula 09
# Parte 02
# Professor Sillas Gongaza 
# Capítulo 12 - Visualizações de dados (ggplot2)
# http://sillasgonzaga.com/material/cdr/ggplot2.html

library(readxl)
library(tidyverse)
library(ISLR)
library(RColorBrewer)
library(ggthemes)
library(hrbrthemes)
library(treemapify)
library(gapminder)
library(sf)
library(geobr)
library(readxl)
library(janitor)
# novos:

library(ggrepel)
library(patchwork)
library(wpp2019)
library(rbcb) # remotes::install_github('wilsonfreitas/rbcb')
library(countrycode) # install.packages("countrycode")

##

df_feliz_teste <- read_excel("dados/WHR2018Chapter2OnlineData.xls")

glimpse(df_feliz_teste)

# importar a planilha
df_feliz <- read_excel("dados/WHR2018Chapter2OnlineData.xls", sheet = 1)

# limpar o nome das colunas
df_feliz <- janitor::clean_names(df_feliz)

# renomear algumas colunas
df_feliz <- df_feliz %>% 
  rename(life_expec = healthy_life_expectancy_at_birth)

# olhar dados 
glimpse(df_feliz)

# consertar manualmente os nomes de certos paises

df_feliz$country[df_feliz$country == "Bosnia and Herzegovina"] <- "Bosnia & Herzegovina"
df_feliz$country[df_feliz$country == "Czech Republic"] <- "Czechia"
df_feliz$country[df_feliz$country == "Hong Kong S.A.R. of China"] <- "China"
df_feliz$country[df_feliz$country == "Taiwan Province of China"] <- "Taiwan"

# consulte a documentação do dataset
# ?countrycode::codelist 

df_continente <- countrycode::codelist  %>% 
  # selecionar colunas importantes
  select(country = country.name.en, continent, country_code = iso3n) %>% 
  # filtrar fora os paises sem continentes
  filter(!is.na(continent))


# criar dataframe com juncao dos dois
df_feliz <- inner_join(df_feliz, df_continente, by = "country")

# coletar dados de populacao a partir de outro dataset, do pacote wpp2019
data(pop)
df_populacao <- pop %>% 
  select(country_code, `2020`) %>% 
  rename(populacao_2020 = 2)

df_feliz <- df_feliz %>% 
  left_join(df_populacao, by = 'country_code')

# criar dataset apenas para o ano mais recente
df_2017 <- df_feliz %>% 
  filter(year == max(year))

ggplot(df_2017, aes(x = log_gdp_per_capita,
                    y = life_expec)) + geom_point()
