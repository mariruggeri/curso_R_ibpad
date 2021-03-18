# Aula 07
# Parte 03
# Professor Sillas Gongaza 
# Capítulo 08 - Trabalhando com datas
# http://sillasgonzaga.com/material/cdr/trabalhando-com-datas.html

library(tidyverse)


x <- c("2014-07-15", "2018/03/20", "2019-12-31", "20170511")

class(x)

as.Date(x)

library(lubridate)

as_date(x)
class(as_date(x))

# 8.1 Gerar um vetor sequencial de datas

?seq.Date

seq.Date(from = as_date("2021-01-01"),
         to = as_date("2021-12-31"),
         length.out = 365)

seq.Date(from = as_date("2021-01-01"),
         to = as_date("2021-12-31"),
         by = "10 days")

seq.Date(from = as_date("2021-01-01"),
         to = as_date("2021-12-31"),
         by = "3 weeks")

seq.Date(from = as_date("2021-01-01"),
         to = as_date("2021-12-31"),
         by = "3 months")

seq.Date(from = as_date("2021-01-01"),
         length.out = 6,
         by = "1 week")

today()
wday(today())

datas_niver <- seq.Date(from = as_date("1984-03-12"),
                        by = "1 year",
                        length.out = 37)

wday(datas_niver) %>%
  table()

table(wday(datas_niver)) 

datas_brasil <- c("1/12/2021", "20/11/2020", "30121999", "17-03-2000")
dmy(datas_brasil)

class(dmy_hms("30-09-2019 14:58:39"))