library(dplyr)
library(reshape2)
library(ggplot2)
library(lubridate)

#llamar tabla haciendo proyecto
data=read.csv('data/acust2.csv',sep = ';')
data %>% as_tibble()

#convertir fecha en fecha xd
data$FECHA <- lubridate::ymd(as.character(data$FECHA))

#calcular maximo
data %>% as_tibble()
data %>%
  group_by(FECHA) %>%
  summarise(max = max(BI))
