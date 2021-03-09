# Aula 03 parte 02
# Professora Gabriela Caeser

# Estruturas de Controle de Fluxo

# If e Else
variavel <- 600
if( variavel >= 500 ) {
  "maior"#executa uma tarefa se operação resultar TRUE
} else {
  "menor"#executa outra tarefa se operação resultar FALSE
}


# IfElse
ifelse(variavel >= 500, 'executa essa tarefa se TRUE', 'executa outra se FALSE')


# If/Else aninhados

a <- 9823

if(a >= 10000) {
  b <- 'VALOR ALTO'
} else if(a < 10000 & a >= 1000) {
  b <- 'VALOR MEDIO' 
} else if(a < 1000) {
  b <- 'VALOR BAIXO'
}

b


# Estrutura de Repetição

# For

for(i in c(1, 2, 3, 4, 5)) {
  print(i^2)
}

# 

lista.de.arquivos <- list.files('dados/') #lista todos os arquivos de uma pasta
is.vector(lista.de.arquivos)

for(i in lista.de.arquivos) {
  print(paste('ARQUIVO LIDO:', i))
  #exemplo: read_delim(i, delim = "|")
}


for(i in 1:1000){
  if((i %% 29 == 0) & (i %% 3 == 0)){
    print(i)
  }
}

####

library(tidyverse)

numeros <- 1:100
min(numeros)
max(numeros)
mean(numeros)
median(numeros)
head(numeros)
tail(numeros)
glimpse(numeros)

# Funções

soma_10 <- function(f){
  f + 10
}

soma_10(20)


calcula_imc <- function(peso, alt){
  peso / alt ^ 2
}

calcula_imc(80, 1.60)




