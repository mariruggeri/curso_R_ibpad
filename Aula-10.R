# Aula 10
# Parte 01
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
library(ggrepel)
library(patchwork)
library(wpp2019)
library(rbcb) 
library(countrycode)
library(lubridate)

df_feliz <- read_csv2("df_feliz.csv")
df_2017 <- read_csv2("df_2017.csv")

df_2017 %>% filter(is.na(log_gdp_per_capita)) # conferir os 6 países excluidos do gráfico

ggplot(df_2017, aes(x = log_gdp_per_capita,
                    y = life_expec)) + geom_point()


## outra forma
ggplot(df_2017) + 
  geom_point(aes( x = log_gdp_per_capita,
                  y = life_expec,
                  color = continent,
                  size = populacao_2020))
###

df_america <- df_2017 %>%
  filter(continent == "Americas")

ggplot(df_america) + 
  geom_point(aes( x = log_gdp_per_capita,
                  y = life_expec,
                  color = country,
                  alpha = 0.3,
                  size = populacao_2020))


### 

df_2017 %>% 
  ggplot(aes( x = log_gdp_per_capita,
              y = life_expec)) +
  geom_point() +
  geom_smooth(method = 'lm')


df_oceania <- df_2017 %>%
  filter(continent == "Oceania")

df_oceania %>%
  ggplot(aes( x = log_gdp_per_capita,
              y = life_expec,
              color = country)) +
  geom_point() +
  geom_smooth(method = 'lm')

### 

df_2017 %>%
  ggplot(aes( x = log_gdp_per_capita,
              y = life_expec,
              color = continent)) +
  geom_point() +
  geom_smooth(method = 'lm')

df_2017 %>%
  ggplot(aes( x = log_gdp_per_capita,
              y = life_expec,)) +
  geom_point(aes(color = continent)) +
  geom_smooth(method = 'lm')


df_feliz %>%
  group_by(continent) %>%
  summarise(expec_media = mean(life_expec)) %>%
  ggplot(aes( y = continent, 
              x = expec_media,
              fill = continent)) +
  geom_col(alpha = 0.5)


df_feliz %>%
    filter(year > 2005) %>%
    group_by(year) %>%
    summarise(expec_media = mean(life_expec),
              qtd_paises = n()) %>%
    ggplot(aes(x = year, 
           y = expec_media)) +
    geom_col()



df_feliz %>%
  filter(year == 2007 | year == 2017) %>%
  mutate(year = as.character(year)) %>% # para transformar uma variavel numerica em categórica
  group_by(continent, year) %>%
  summarise(expec_media = mean(life_expec)) %>%
  ggplot(aes(x = continent, 
             y = expec_media,
             fill = year)) +
  geom_col(position = "dodge") # posição do gráfico 'stack' é em cima / 'dodge' é lado a lado
            

df_brazil <- df_feliz %>%
  filter(country == "Brazil")

df_brazil %>%
  group_by(year) %>%
  summarise(expec_media = mean(life_expec)) %>%
  ggplot(aes(x = year, 
             y = expec_media)) +
  geom_col()

df_2017 %>%
  group_by(continent) %>%
  summarise(pop_total = sum(populacao_2020)) %>%
  ggplot(aes(x = fct_reorder(continent,pop_total, .desc = TRUE), # .desc reordena decrescente 
             y = pop_total,
             fill = continent)) +
  geom_col()

df_2017 %>%
  group_by(continent) %>%
  summarise(expec_media = mean(life_expec),
    pop_total = sum(populacao_2020)) %>%
  ggplot(aes(x = fct_reorder(continent,pop_total, .desc = TRUE), # .desc reordena decrescente 
             y = expec_media)) +
  geom_col()


###
