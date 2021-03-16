# Aula 06
# Parte 02
# Professora Gabriela Caesar
# Capítulo 07 - Dados em strings (texto)


nome <- c("joao", "jose", "maria")
sobrenome <- c("souza", "silva", "pereira")

# Separador padrão do paste() é o espaço, mas pode customizar com sep = 
paste(nome, sobrenome) 
paste(nome, sobrenome, sep = "//\\") 

# paste0() sem separador 

url <- "http://www.minhaagenda.com.br/"
dia <- 1:31
mes <- 1
ano <- 2021

paste0(url, dia, mes, ano)

paste0("http://www.minhaagenda.com.br/", 1:31, "/1/2021")

#dir.create(paste0("pasta_da_gabriela", Sys.Date()))

library(stringr)

cnae.texto <- c('10 Fabricação de produtos alimentícios', '11 Fabricação de bebidas',
                '12 Fabricação de produtos do fumo', '13 Fabricação de produtos têxteis',
                '14 Confecção de artigos do vestuário e acessórios',
                '15 Preparação de couros e fabricação de artefatos de couro, artigos para viagem e calçados',
                '16 Fabricação de produtos de madeira',
                '17 Fabricação de celulose, papel e produtos de papel')
cnae <- str_sub(cnae.texto, 0, 2)
texto <- str_sub(cnae.texto, start = 4, end =-1)

celulares <- c("11 2244-4455", "11 4455-6677", "11 9988-7766")
ddd <- str_sub(celulares, 0, 2)
prefixo <- str_sub(celulares, 4,7)

str_replace(celulares, " ", ")")
str_replace_all(celulares, "-", ".")

# Substituir caracteres em um string
cnpj <- c('19.702.231/9999-98', '19.498.482/9999-05', '19.499.583/9999-50', '19.500.999/9999-46', '19.501.139/9999-90')
str_replace_all(cnpj, '\\.|/|-', '')

meu_nome <- "Mariana"

x <- c("Prazer, sou {meu_nome}")
print(x)
str_glue(x)

