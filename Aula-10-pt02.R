# Aula 10
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
library(ggrepel)
library(patchwork)
library(wpp2019)
library(rbcb) 
library(countrycode)
library(lubridate)


lista_datasets <- rbcb::get_series(code = c(ipca = 433, selic = 4390))
lista_datasets$ipca
lista_datasets$selic

df_st <- left_join(lista_datasets$ipca, lista_datasets$selic, by = "date")

df_st %>%
  #filter(year(date) >= 2000) %>%
  filter(date >= as.Date("1998-01-01")) %>%
  ggplot(aes(x = date,
             y = ipca)) +
  geom_line() +  # + geom_point() | para ver pontos nos gráficos de linha
  scale_x_date(date_breaks = "4 years",
               date_labels = "%Y") # consultar domcumentação para codigo do date_labels

df_st %>%
  #filter(year(date) >= 2000) %>%
  filter(date >= as.Date("202-01-01")) %>%
  ggplot(aes(x = date,
             y = ipca)) +
  geom_line() +  # + geom_point() | para ver pontos nos gráficos de linha
  scale_x_date(date_breaks = "4 years",
               date_labels = "%Y") # consultar domcumentação para codigo do date_labels

df_st %>%
  filter(date >= as.Date("2020-01-01")) %>%
  ggplot(aes(x = date, 
             y = ipca)) +
  geom_line() +
  scale_x_date(date_breaks = "1 month",
               date_labels = "%m")
  
df_st %>%
  filter(date >= as.Date("2000-01-01")) %>%
  ggplot(aes(x = date,
             y = ipca)) +
  geom_line(color = "red") +  
  geom_line(aes(y = selic)) +  
  scale_x_date(date_breaks = "4 years",
               date_labels = "%Y") 


usd <- rbcb::get_series(code = c(dolar = 1),
                        start_date = as.Date("2000-01-01"))

usd %>%
  filter(day(date) == 1)


usd_v <- usd %>%
  mutate(inicio_mes = floor_date(date, "month")) %>%
  group_by(inicio_mes) %>%
  filter(date == min(date)) %>%
  ungroup() %>%
  mutate(dolar_anterior = lag(dolar, n = 1),
         variacao = dolar/dolar_anterior - 1) %>%
  select(inicio_mes, variacao)

df_st <- inner_join(df_st, usd_v, by = c("date" = "inicio_mes"))

df_st

df_st %>%
  filter(date >= as.Date("2019-01-01")) %>%
  pivot_longer(cols = c(ipca, selic, variacao),
               names_to = "nome_indicador",
               values_to = "valor") %>%
  ggplot(aes(x = date, 
             y = valor, 
             color = nome_indicador)) + 
  geom_line()


df_2017 <- read_csv2("df_2017.csv")

mean(df_2017$life_expec)

df_2017 %>%
  ggplot(aes(x = life_expec)) +
  geom_histogram(color = "white", 
                 binwidth = 5,
                 boundary = 0)