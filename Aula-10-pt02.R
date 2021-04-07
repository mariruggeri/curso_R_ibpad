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