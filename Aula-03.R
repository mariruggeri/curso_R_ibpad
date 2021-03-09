# Aula 03
# Professora Gabriela Caesar

# Consultar documetação usar "?"

?readr::read_csv()

# Capítulo 04 - Manipulando os Dados

# Criar um Data Frame


uf <- c("AL","BA","CE","MA","PB","PE","PI","RN","SE")
regiao <- "Nordeste"
temperatura <- c(29, 28, 27, 26, 30, 26, 31,30, 33) 
renda <- c(100, 200, 300, 400, 500, 600, 700, 800, 900)

# É necessária a mesma quantidade de linahs no VETOR

uf_nordeste <- data.frame(uf, regiao, temperatura, renda)

# Verificar informação
# Atenção para a grafia dos dados, espaços e tipos diferentes impactam na execução do comando

uf_nordeste$temperatura
uf_nordeste$uf

unique(uf_nordeste$temperatura)
unique(uf_nordeste$renda)

# Para visualizar digitar view(varivavel) no console

vetor_num_repetidos <- c(rep(2,50))

# Coletar informações do vetor com STR
str(uf_nordeste)

