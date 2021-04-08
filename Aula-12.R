# Aula 12
# Parte 01
# Professor Sillas Gongaza 
# Capítulo 12 - Visualizações de dados (ggplot2) /
# Capítulo 13 - Visualizações Interativas
# Exercícios de Fixação
# http://sillasgonzaga.com/material/cdr/ggplot2.html

library(tidyverse)

herois <- read_csv("herois_completo.csv")

herois <- herois %>%
  mutate(height = height/100,
         weight = weight * 0.45)

herois %>%
  ggplot(aes(x = height,
             y = weight,
             color = publisher)) +
  geom_point() +
  geom_vline(xintercept = 0, linetype = "dashed") +
  geom_hline(yintercept = 0, linetype = "dashed")

herois_pesados <- herois %>%
  filter(height > 0 & weight > 0)

# conferir herois pesados
herois_pesados %>%
  select(publisher, name, height, weight) %>%
  arrange(weight)

herois_leves <- herois %>%
  filter(height < 0 & weight < 0)

# conferir herois leves
herois_leves %>%
  select(publisher, name, height, weight) %>%
  arrange(weight)


# Exercicio 02

herois %>%
  filter(height <= 5) %>%
  ggplot(aes(x = height)) +
  geom_histogram(color = "white",
                 binwidth = 0.05, 
                 boundary = 0) +
  scale_x_continuous(breaks = c(0, 1, 2, 3, 4, 5))

herois_pesados %>%
  filter(height <= 3) %>%
  ggplot(aes(x = height)) +
  geom_histogram(color = "white",
                 binwidth = 0.05, 
                 boundary = 0) +
  scale_x_continuous(breaks = seq(0, 3, 0.20))

# Exercício 03

herois_pub <- herois_pesados %>%
  mutate(publisher = ifelse(publisher == "Marvel Comics", "Marvel",
                            ifelse(publisher == "DC Comics", "DC",
                                   "Outros")))

herois_pub %>%
  ggplot(aes(x = publisher, y = weight)) +
  geom_boxplot()

IQR(herois_pesados$weight)

quantile(herois_pesados$weight)

mediana <- median(herois_pesados$weight)
q3 <- quantile(herois_pesados$weight, .75)
limite_max_iqr <- q3 + 1.5 * IQR(herois_pesados$weight)

herois_pub %>%
    ggplot(aes(x = weight)) +
    geom_histogram(color = "white") +
    geom_vline(xintercept = c(mediana, q3, limite_max_iqr),
               linetype = "dashed")

herois_pesados %>%
    ggplot(aes(x = log(weight))) +
    geom_histogram()

# Exerício 04

herois_pub %>%
    group_by(publisher) %>%
    summarise(qtd_personagens = n())

herois_pub %>%
    count(publisher,  name = "qtd") %>%
    ggplot(aes(x = fct_reorder(publisher, qtd, .desc = TRUE),
               y = qtd,
               fill = publisher)) +
    geom_col() +
  geom_text(aes(label = qtd), vjust = 1.5, color = "white") 
  

herois_pesados %>%
  group_by(publisher) %>%
  summarise(qtd_personagens = n())

herois_pesados %>%
  count(publisher,  name = "qtd") %>%
  ggplot(aes(x = publisher, y = qtd)) +
  geom_col()


# Exercício 05
herois_pub %>%
  count(publisher,alignment, name = "qtd") %>%
  filter(!is.na(alignment)) %>%
  ggplot(aes(x = fct_reorder(publisher, qtd, .desc = TRUE),
             y = qtd,
             fill = alignment)) +
  geom_col(position = "dodge") +
  geom_text(aes(label = qtd), vjust = 0, color = "grey") 


# Exercício 06

herois_pub %>%
  count(publisher,alignment, name = "qtd") %>%
  filter(!is.na(alignment)) %>%
  ggplot(aes(x = fct_reorder(publisher, qtd, .desc = TRUE),
             y = qtd,
             fill = alignment)) +
  geom_col(position = "fill")

herois_pub %>%
  count(publisher, alignment, name = "qtd") %>%
  filter(!is.na(alignment)) %>%
  group_by(publisher) %>%
  mutate(qtd_total = sum(qtd),
         prop = qtd/qtd_total) %>%
  ggplot(aes(x = publisher, y = prop, fill = alignment)) +
  geom_col(position = "dodge")
  

# Exercício 07

herois_agg <- herois_pub %>%
  pivot_longer(cols = agility:omniscient,
               names_to = "nome_poder",
               values_to = "tem_poder") %>%
  group_by(publisher, name) %>%
  summarise(qtd_poderes = sum(tem_poder))

# Exercício 08
  
herois_agg %>%
  group_by(publisher) %>%
  slice_max(order_by = qtd_poderes, n = 5) %>%
  ggplot(aes(y = name, x = qtd_poderes, fill = publisher)) +
  geom_col() +
  facet_wrap(vars(publisher), scales = "free_y") +
  theme(legend.position = "bottom")

herois_agg %>%
  ggplot(aes(x = qtd_poderes, fill = publisher)) +
  geom_density(alpha = 0.3)
    