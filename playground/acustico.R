library(dplyr)
library(reshape2)
library(ggplot2)
library(lubridate)

#llamar tabla haciendo proyecto
data=read.csv('data/acust2.csv',sep = ';')
data %>% as_tibble()

#convertir fecha en fecha xd
data$FECHA <- lubridate::ymd(as.character(data$FECHA))
data %>% as_tibble()

#calcular maximo diario
maximos=data %>%
  group_by(FECHA) %>%
  summarise(max = max(BI)) 
maximos

#graficar
maximos %>% 
  ggplot(aes(x=FECHA, y=max)) + geom_bar(stat="identity")

#calcular promedio diario
media=data %>%
  group_by(FECHA) %>%
  summarise(mean = mean(BI)) 
media

#graficar
media %>% 
  ggplot(aes(x=FECHA, y=mean)) + geom_bar(stat="identity")

#calcular maximo diario
rangohorario=data %>%
  group_by(FECHA) %>%
  summarise(max = max(BI)) 
maximos

#calcular maximo mensual por rango horario
#1convertir UTC en HORASCL
dataconvertida <- data %>% 
  mutate(HORARIO = ifelse(address == '',work_address,address))
dataconvertida

data$HORARIO <- lubridate::ymd(as.character(data$FECHA))

maximos=data %>%
  group_by(FECHA) %>%
  summarise(max = max(BI)) 
maximos



