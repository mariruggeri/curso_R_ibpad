# Aula 07
# Parte 01
# Professor Sillas Gongaza 
# Capítulo 07 - Dados em strings (texto)

library(tidyverse)

?runif

set.seed(123)
df_idades <- tibble(
  idade = round(runif(28, 18,100))
)

# Dúvida do Aluno no ClassRoom.
# Alteração de print para return depis de uar o MAP

faixa_etaria <- function(a) {
  if(a <= 29) {
    return("0 a 29")
  } else if(a >= 30 & a <= 59) {
    return("30 a 59")
  } else if(a >= 60 & a <= 89) {
    return("60 a 89")
  } else if(a >= 90){
    return("90 ou mais")
  }
}


df_idades %>%
  mutate(faixa_idade = faixa_etaria(idade))

faixa_etaria(42)
faixa_etaria(5)
faixa_etaria(c(5,42))

map(c(5, 42), faixa_etaria)

df_idades %>%
  mutate(faixa_idade = map_chr(idade,faixa_etaria))

# map_chr retorna vetor.


### cut() | Quebra vetor númérico em intervalos 

?cut 

df_idades$idade
cut(df_idades$idade,
    breaks = c(0,29,59,89, Inf),
    include.lowest = TRUE,
    labels = c("0 a 29", "30 a 59","60 a 89", "90 ou mais"),
    ordered_result = TRUE)

df_idades %>%
    mutate(faixa_idade = cut(idade,
                             breaks = c(0,18,24,34,44,54,64, Inf),
                             labels = c("até 17", "18 a 24", "25 a 34", "35 a 44", "45 a 54", "55 a 64", "65 ou mais"),
                             include.lowest = TRUE))

# ( == intervalo aberto
# [ == intervalo fechado

# (29,59] == x > 29 & x <= 59 (include.lowest = FALSE)
# [29,59] (include.lowest = TRUE)

### contar ocorrencias de um caracter

celulares <- c("11 2244-4455", "11 4455-6677", "11 9988-7766")

str_count(celulares, "7")
str_count(celulares, "4")

### verificar se possui determinado caracter?
str_count(celulares, "7") >0

### função que refaz a lógica acima
str_detect(celulares, "7")

## verifica o primeiro caracter / verifica o ultimo 
str_starts(celulares, "1")
str_ends(celulares, "1")


### preencher campos numéricos
cpfs <- as.character(c("000.000.159-36","943.159.852-36","832.547.232-44","574.376.222-89","451.052.012-30"))


str_length(cpfs)
str_pad(cpfs, width = 18, side = "left", pad = "0")


### remover espaços

x <- c("      inicio",
       "final      ",
       "      ambos      ",
       "    no       meio        ")
x

x2 <- str_trim(x)
x3 <- str_squish(x) # opção mais inteligente

x4 <- str_remove_all(x, " ") # muito "bruta"

cnpj <- c('19.702.231/9999-98', 
          '19.498.482/9999-05', 
          '19.499.583/9999-50', 
          '19.500.999/9999-46', 
          '19.501.139/9999-90')


parse_number(cnpj)

# regex | http://sillasgonzaga.com/material/cdr/dados-em-strings-texto.html#regex

str_remove_all(cnpj, '\\.')

str_remove_all(cnpj, '/') %>%
  str_remove_all('-') %>%
  str_remove_all('\\.')


str_replace_all(cnpj, '\\.|/|-', '')

str_extract_all(cnpj, '\\d')



textos <- c("Fulano", "fulano", "abcdeF", "01584", 
            "abc456", "123def", "OI", "meuemail@gmail.com",
            "www.google.com", "Meu nome é Fulano")


str_subset(textos, "a")
str_subset(textos, "i") # Case Senstive. 

textos[str_starts(textos, "F")] # com [] retorna o valor em texto, e não lógico.

str_subset(textos, "^F")

str_subset(textos, '[0-9]')

str_subset(textos, "^[0-9]") # Começa com Número

str_subset(textos,'[0-9]$') # filtrar strings que terminam número


