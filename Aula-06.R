# Aula 06
# Parte 01
# Professora Gabriela Caesar
# Capítulo 06 - Juntando dados
# DataSet do Kaggle


# [00] Questão
library(tidyverse)
library(janitor)

# [01] Questão 01

hero_powers <- readr::read_csv("dados/super_hero_powers.csv", na = c("", "-", "NA"))

hero_info <- readr::read_csv("dados/heroes_information.csv", na = c("", "-", "NA"))

glimpse(hero_powers)
glimpse(hero_info)

# [02] Use a função janitor::clean_names() para limpar os nomes das colunas.


hero_powers <- hero_powers %>%
  clean_names()


hero_info <- hero_info %>%
  clean_names()

# [03] No caso de hero_info, remova a primeira coluna.

hero_info <- hero_info %>%
  select(-x1)

# [04] Em hero_powers, converta todas as colunas com exceção da primeira para o tipo logical.

glimpse(hero_powers)

hero_powers %>% mutate_at(vars(-hero_names), as.numeric)

# [05] Em hero_info, na coluna publisher, observe quantas editoras diferentes existem no dataset.

hero_info %>%
  distinct(publisher)

unique(hero_info$publisher)

hero_info %>%
  select(publisher) %>%
  mutate(publisher = ifelse(publisher == "Marvel Comics", "Marvel",
                      ifelse(publisher == "DC Comics", "DC",
                             "Outros")))

hero_info %>%
  select(publisher) %>%
  mutate(publisher = case_when(
    publisher == "Marvel Comics" ~ "Marvel",
    publisher == "DC Comics" ~ "DC",
    TRUE ~ "Outros"))

# [06] Em hero_info, quais raças (coluna race) são exclusivas de cada editora?

hero_info %>%
  select(publisher , race) %>%
  filter(!is.na(race)) %>%
  distinct() %>%
  count(race) %>%
  filter(n == 1) %>%
  arrange(n) 

# [07] Em hero_info, quais cores de olhos (coluna eye_color) são mais comuns para cada sexo (coluna gender)? Filtre o top 3 para cada sexo.

hero_info %>%
    select(eye_color, gender) %>%
    na.omit() %>%
    count(gender, eye_color) %>%
    arrange(desc(n)) %>%
    group_by(gender) %>%
     slice_head(n = 3)
  
# [08] Em hero_powers, calcule o percentual de heróis que possui cada habilidade descrita nas colunas

hero_powers %>%
  summarise_if(is.logical, mean)

# [09] Repita o item anterior, usando uma abordagem mais tidy: converta o formato do dataframe hero_powers para o formato long.

hero_powers_tidy <- hero_powers %>%
    pivot_longer(cols = -hero_names, 
                 names_to = "power",
                 values_to = "have_power") %>%
    group_by(power) %>%
    summarise(media = mean(have_power)) %>%
    arrange(desc(media))

# [10] Junte os dois dataframes em um só, chamado hero. A função a ser usada é inner_join().

hero <- hero_info %>%
    inner_join(hero_powers, by = c("name" = "hero_names"))

# [11] No dataframe hero, calcule o percentual de herois de cada editora que são telepatas.

hero %>%
  select(publisher, telepathy) %>%
  group_by(publisher) %>%
  summarise(perc = mean(telepathy),
            qtd = n()) %>%
  arrange(desc(qtd)) %>%
  slice_head(n = 20)

# [12] No dataframe hero, selecione as colunas name, publisher, flight e weight, filtre os heróis que podem voar e retorne os 10 de maior peso.

hero %>%
  select(name, publisher, flight, weight) %>%
  filter(flight == TRUE) %>%
  slice_max(n = 10, order_by = weight)

# [13] Salve o dataframe chamado hero no arquivo herois_completo.csv usando a função readr::write_csv().

# getwd()
# dir.create()
# set()
# Sys.Date()

readr::write_csv(hero, "herois_completo.csv")