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

# calcular maximo mensual por rango horario
# 1convertir UTC en HORASCL
# https://stackoverflow.com/questions/1395117/how-do-you-convert-dates-times-from-one-time-zone-to-another-in-r
data %>% as_tibble()
dataconvertida <- data %>% 
  mutate(FECHAHORA = with_tz(ymd_hms(substr(ARCHIVO, 1, 15), tz='UTC'), tzone = "America/Santiago"))

resumen_horario = dataconvertida %>% 
  mutate(mes = month(FECHAHORA), ) %>%
  group_by(mes, hora, minuto) %>%
  # group_by(month(FECHAHORA),hour(FECHAHORA),minute(FECHAHORA)) %>%
  summarise(max = max(BI))

# loop for generate graphics
for (j in 1:12){
  gg = resumen_horario %>% 
    filter(mes == j) %>% 
    ggplot(aes(x=,y=))
  ggsave(gg, paste0("grafos/mes_", j,".png"), dpi=300)
}
