# Aula 13
# Parte 02
# Professor Sillas Gongaza 
# Capítulo 15 - Modelos
# http://sillasgonzaga.com/material/cdr/modelos.html
# http://sillasgonzaga.com/material/curso_series_temporais/regressao.html

library(tidyverse)

df <- readr::read_csv("https://raw.githubusercontent.com/sillasgonzaga/curso_series_temporais/master/data/Bike-Sharing-Dataset/day.csv")

# dando olhada nos dados
glimpse(df)

df_transf <- df %>% 
  # remover colunas irrelevantes
  select(-c(instant, workingday)) %>% 
  # renomear algumas colunas
  rename(
    estacao = season,
    bikes_total = cnt,
    year = yr, 
    month = mnth
  ) %>% 
  # mudar weekday, que começa a contar do zero
  mutate(weekday = weekday + 1) %>% 
  # transformar a variavel de feriado para texto
  mutate(holiday = as.character(holiday)) %>% 
  # mudar os valores de algumas variaveis
  mutate(
    # substituir o codigo do ano  pelo ano real
    year = lubridate::year(dteday),
    # adicionar um leading zero no mês
    month = str_pad(month, width = 2, side = "left", pad = "0"),
    # converter weathersit para variavel do tipo factor
    weathersit = factor(weathersit,
                        levels = 1:4,
                        labels = c("muito bom", "bom", "ruim", "muito ruim")),
    # converter dia da semana para variavel do tipo factor
    weekday = factor(weekday, 
                     levels = 1:7,
                     labels = c("Dom", "Seg", "Ter", "Qua", "Qui", "Sex", "Sab")),
    # fazer o mesmo para estacao
    estacao = factor(estacao, 
                     levels = 1:4,
                     labels = c("Inverno", "Primavera", "Verão", "Outono")),
    # converter colunas numericas para escala normal (não-normalizada)
    temp = temp * 41,
    atemp = atemp * 50,
    hum = hum * 100,
    windspeed = windspeed * 67
  )

glimpse(df_transf)

df_transf %>% 
  ggplot(aes(x = dteday, y = bikes_total)) +
  geom_line(aes(color = estacao, group = NA)) +
  # adicionar curva de tendencia
  geom_smooth(se = FALSE) +
  theme_bw() +
  # quebrar eixo x em 1 mes
  scale_x_date(date_breaks = "1 month",
               date_labels = "%m/%Y",
               minor_breaks = NULL) +
  # inverter texto do eixo x
  theme(axis.text.x = element_text(angle = 90))

df_estacao <- df_transf %>%
  select(dteday, estacao) %>%
  mutate(estacao_dia_anterior = lag(estacao, 1)) %>%
  filter(estacao != estacao_dia_anterior)


# Abordagem Linhas Verticais

df_transf %>% 
  ggplot(aes(x = dteday, y = bikes_total)) +
  geom_line() +
  # adicionar curva de tendencia
  geom_smooth(se = FALSE) +
  geom_vline(data = df_estacao, 
             aes(xintercept = dteday, 
                 color = estacao)) +
  theme_bw() +
  # quebrar eixo x em 1 mes
  scale_x_date(date_breaks = "1 month",
               date_labels = "%m/%Y",
               minor_breaks = NULL) +
  # inverter texto do eixo x
  theme(axis.text.x = element_text(angle = 90))

# relacao entre dia de semana e bikes alugadas
df_transf %>%
  ggplot(aes(x = weekday, 
             y = bikes_total, fill = holiday)) +
  geom_boxplot()

df_transf %>%
  ggplot(aes(x = weekday, 
             y = casual)) +
  geom_boxplot()

df_transf %>%
  ggplot(aes(x = weekday, 
             y = registered)) +
  geom_boxplot()

df_transf %>%
  ggplot(aes(x = weathersit, 
             y = bikes_total)) +
  geom_boxplot()

df_transf %>%
  ggplot(aes(x = estacao, 
             y = bikes_total,
             fill = month)) +
  geom_boxplot()


df_transf %>%
  ggplot(aes(x = estacao, 
             y = bikes_total,
             fill = as.character(year))) +
  geom_boxplot()

df_transf %>%
  ggplot(aes(x = temp, 
             y = atemp)) +
  geom_point()

df_transf %>%
  ggplot(aes(x = temp, 
             y = bikes_total)) +
  geom_point() + 
  geom_hline(yintercept = 4000, linetype = "dashed") +
  geom_vline(xintercept = 30, linetype = "dashed", color = "red") +
  geom_smooth(method = "lm") +
  facet_wrap(vars(weekday), scales = "free_y")
  
#cor
cor(df_transf$atemp, df_transf$temp)

df_transf %>%
  select(temp, atemp, hum, windspeed, bikes_total)%>%
  cor()

# modelo simples
# sintaxe: lm(variavel resposta ~variavel regressora, data = df)
# sintaxe: lm(y ~ x, data = df)

modelo_simples <- lm(bikes_total ~ temp, data = df_transf)
modelo_simples

# Y = B0 + B1X1 (são os coeficientes do modelo simples)
# bikes = 1215 + 162 * temperatura

# sintaxe : lm(y ~x, data = df)

modelo_2 <- lm(bikes_total ~ temp + estacao, data = df_transf)

modelo_2

# bikes = 745,8 + 152temp + 848Primavera + 490Verao + 1342Out

# predict(modelo, novo dataframe)

predict(modelo_simples, data.frame(temp = 32.43))

summary(modelo_simples)
summary(modelo_2)

library(broom)
glance(modelo_simples)
glance(modelo_2)

df_transf$variavel_aleatoria <- rnorm(nrow(df_transf))

modelo_3 <- lm(bikes_total ~ . - dteday - atemp - casual - registered,
               data = df_transf)


modelo_3
summary(modelo_3)

modelo_4 <- lm(bikes_total ~ . - dteday - atemp - casual - registered - variavel_aleatoria,
               data = df_transf)


modelo_4
summary(modelo_4)

# install.packages('forecast', dependencies = TRUE)

library(forecast)

checkresiduals(modelo_4)


df_transf_3 <- df_transf %>%
  mutate(bikes_dia_anterior = lag(bikes_total))

modelo_5 <- lm(bikes_total ~ . - dteday - atemp - casual - registered - variavel_aleatoria,
               data = df_transf_3)

checkresiduals(modelo_5)


df_transf %>%
    select(dteday, bikes_total) %>%
    arrange(bikes_total)

df_transf %>%
    mutate(sandy = dteday == as.Date("2012-10-29"))


modelo_6 <- lm(bikes_total ~ . - dteday - atemp - casual - registered - variavel_aleatoria,
               data = df_transf)

summary(modelo_6)

# construir novos modelos


library(lubridate)

df_treino <- df_transf %>%
  filter(dteday < as.Date("2012-12-01"))

df_teste <- df_transf %>%
  filter (dteday >= as.Date("2012-12-01"))

modelo_a <- lm(bikes_total ~ temp, data = df_treino)

modelo_b <- lm(bikes_total ~ . - dteday - atemp - casual - registered - variavel_aleatoria,
               data = df_treino)

pred_a <- predict(modelo_a, df_teste)
pred_b <- predict(modelo_b, df_teste)
real <- df_teste$bikes_total

# mape
mean(abs(pred_a - real/real))
mean(abs(pred_b - real/real))

df_teste$previsao <- pred_b

df_teste %>%
    select(dteday, bikes_total, previsao) %>%
    ggplot(aes(x = previsao, y = bikes_total)) +
    geom_point()

df_teste %>%
  select(dteday, bikes_total, previsao) %>%
  pivot_longer(cols = c(bikes_total, previsao)) %>%
  ggplot(aes(x = dteday, y = value, color = name)) +
  geom_line() +
  geom_point()
  