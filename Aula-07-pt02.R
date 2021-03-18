# Aula 07
# Parte 02
# Professor Sillas Gongaza 
# Capítulo 07 - Exercicios
# http://sillasgonzaga.com/material/cdr/dados-em-strings-texto.html#exerc%C3%ADcios-4

library(tidyverse)
library(readr)
library(janitor)
library(remotes)


# Utilizando o dataframe abaixo, obtenha o resultado a seguir: Dica: separate(), str_replace_all(), str_trim(), str_sub()

exercicio_1 <- data.frame(
  email = c('joaodasilva@gmail.com', 'rafael@hotmail.com', 'maria@uol.com.br', 'juliana.morais@outlook.com'),
  telefone = c('(61)99831-9482', '32 8976 2913', '62-9661-1234', '15-40192.5812')
)

exercicio_1 %>%
  separate(col = email,
           into = c('login', 'dominio'),
           sep = '@')  %>%
  mutate(dominio = word(dominio, sep = '\\.')) %>%
  separate(col = telefone,
           into = c('ddd','fone'),
           sep = -10)  %>%
  mutate(ddd = str_remove_all(ddd,'\\(|\\)|-'),
         fone = str_replace_all(fone, "\\s|\\.", "-")) %>%
  mutate(fone = ifelse(str_starts(fone, "-"),
                       str_remove(fone, "-"),
                       fone))
    
  
         
?word() # Extrai palavras de uma sentença.
word("Meu nome é Mariana")


# 2 Baixe o pacote literaturaBR. Como ele não está no CRAN, é necessário usar outra função:

install.packages("remotes")

remotes::install_github("sillasgonzaga/literaturaBR")
library(literaturaBR)
df_livros <- literaturaBR::load_all_books()
head(df_livros)
glimpse(df_livros)

unique(df_livros$book_name)

# Quebre cada linha da coluna text em varias, tendo uma palavra por linha, usando separate_rows(), e filtre as linhas da nova coluna que contem apenas letras. Salve em um novo dataframe chamado df_livros_sep.

df_livros <- as_tibble(df_livros)
df_livros

df_livros_sep <- df_livros %>%
  separate_rows(text, sep = " ") %>%
  filter(str_detect(text, "[A-Z]|[a-z]")) %>%
  mutate(text = str_to_lower(text))

df_livros_sep

# Calcule o numero de palavras distintas em proporção à quantidade total de palavras por livro

df_tt <- df_livros_sep %>%
    group_by(book_name) %>%
    summarise(qtd_total = n(),
              qtd_palavras_dist = n_distinct(text)) %>%
    mutate(tx = qtd_palavras_dist / qtd_total * 100)  %>%
    arrange(desc(tx))

# Calcule a proporção de palavras que contem a letra a por livro


df_a <- df_livros_sep %>%
      group_by(book_name) %>%
      filter(str_detect(text, "a")) %>%
      summarise(qtd_total_a = n())

