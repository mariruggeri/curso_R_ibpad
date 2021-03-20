# Aula 08
# Parte 01
# Professor Sillas Gongaza 
# Capítulo 08 - Trabalhando com datas
# http://sillasgonzaga.com/material/cdr/trabalhando-com-datas.html

library(tidyverse)
library(lubridate)

yq(c("202101", "202102", "202103"))

my("082017")

datas_brasil <- c("1/12/2021", "20/11/2020", "30121999", "17-03-2000")

calss(datas_brasil) 

datas_brasil <- dmy(datas_brasil)
datas_brasil
class(datas_brasil)

datas_brasil_chr <- c("01/12/2019 13:51:15",
                      "20/01/2018 00:00:00",
                      "30011990 080000",
                      "17-03-2000 203000")

datas_brasil <- dmy_hms(datas_brasil_chr)

datas_brasil_chr
datas_brasil

class(datas_brasil_chr)
class(datas_brasil)

# 8.3 Extrair componentes de uma data

wday(datas_brasil)
?wday

wday(datas_brasil, label = TRUE, abbr = FALSE)

# dia
day(datas_brasil)
# mes
month(datas_brasil)
# ano
year(datas_brasil)
# semana do ano
week(datas_brasil)
# dias do ano
yday(datas_brasil)

# extrair componentes das horas
hour(datas_brasil)
minute(datas_brasil)
second(datas_brasil)

# 8.4 Operações matemáticas com datas

# adicionar dias nas datas

?ddays

datas_brasil + ddays(7)
datas_brasil + ddays(90)

# adicionar 1 ano
datas_brasil + dyears(1)

# adicionar horas
datas_brasil + dhours(5)

# Calcular a diferença de tempo entre duas datas:

data1 <- as_date("2021/01/15")
data2 <- as_date("2021/03/18")

data3 <- data2 - data1
data3

datatempo1 <- dmy_hms("01/09/1993 20:00:00")
datatempo2 <- dmy_hms("18-03-2021 19:46:15")

datatempo3 <- datatempo2 - datatempo1
datatempo3

datatempo4 <- dmy_hms("18-03-2021 12:00:00")
datatempo5 <- dmy_hms("18-03-2021 19:46:15")

datatempo6 <- datatempo5 - datatempo4
datatempo6

?difftime

difftime(data2, data1, units =  "days")
difftime(datatempo5,datatempo4, units =  "days")

class(difftime(datatempo2, datatempo1, units = "hours"))

difftime(datatempo5,datatempo4, units =  "days") %>% as.numeric()
# outra forma sem o pipe
as.numeric(difftime(datatempo5, datatempo4, units = "days"))

as.numeric(difftime(datatempo2, datatempo1, units = "days"))/365

# Arredondar datas

?floor_date

floor_date(datas_brasil, "week")
floor_date(datas_brasil, "month")
floor_date(datas_brasil, "bimonth")
floor_date(datas_brasil, "quarter")
floor_date(datas_brasil, "halfyear")
floor_date(datas_brasil, "year")

?ceiling_date
# atenção que retorna o primeiro no dia seguinte.

ceiling_date(datas_brasil, "week")
ceiling_date(datas_brasil, "month")
ceiling_date(datas_brasil, "bimonth")
ceiling_date(datas_brasil, "quarter")
ceiling_date(datas_brasil, "halfyear")
ceiling_date(datas_brasil, "year")

# para retornar o ultimo fazer uma operação
ceiling_date(datas_brasil, "week") - ddays(1)
ceiling_date(datas_brasil, "month") - ddays(1)
ceiling_date(datas_brasil, "bimonth") - ddays(1)
ceiling_date(datas_brasil, "quarter") - ddays(1)
ceiling_date(datas_brasil, "halfyear") - ddays(1)
ceiling_date(datas_brasil, "year") - ddays(1)


df_vacinas <- data.frame (
  data = seq.Date(from = as.Date("2020-11-18"),
                             to = as.Date("2021-03-18"),
                             by = "1 day") )

?runif

set.seed(1)
df_vacinas$pessoas <- round(runif(121, 0, 1000))

df_vacinas %>%
  mutate(mes = floor_date(data, "month")) %>%
  group_by(mes) %>%
  summarise(total_pessoas = sum(pessoas), 
            media_diaria = mean(pessoas))


#########
# Capítulo 09 - Escrevendo dados
# http://sillasgonzaga.com/material/cdr/escrevendo-dados.html


readr::write_csv2(df_vacinas, "vacinacao.csv")


# csv não é excel.
# Para gerar arquivo para o excel, instalar a biblioteca writexl
# Executar a função write_xlsx


install.packages("writexl")
library(writexl)


?write_xlsx

write_xlsx(df_vacinas, "vacinas para excel.xlsx")
