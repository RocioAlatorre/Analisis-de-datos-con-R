library(tidyverse)

df <- read.csv("Titanicv2.csv")
View(df)

# Resumen
str(df)
summary(df)

# Revisar valores faltantes
colSums(is.na(df))

# Revisar la distribución de los datos
df %>% ggplot(aes(x=Age))+ geom_histogram()

install.packages("moments")
library(moments)
skewness(df$Age, na.rm = TRUE)

# A los valores faltantes en edad se les puede asignar una edad promedio, 
# ya que la distribución de los datos tiene un comportamiento simétrico
df$Age <- df$Age %>%  replace_na(median(df$Age, na.rm = TRUE))

df <- drop_na(df)

# Columnas a revisar: 
# survided (cualitativa), edad (cuantitativa), sexo (cualitativa), 
# pclass (cualitativa), embarked (cualitativa), fare (cuantitativa)

# No se observa ningun patrón especifico en la variable edad
df %>% ggplot(aes(x=Age, fill=Survived)) + geom_histogram(alpha=0.7)

df %>% ggplot(aes(x=Survived, y=Age)) + geom_boxplot()

# Numero de sobrevivientes: Yes = 152 y No = 265
df %>%  count(Survived)

# Agrupar por Survived y por Sex
# Unicamente sobrevivieron las personas del género femenino
df %>% count(Survived, Sex)
 
df %>% ggplot(aes(x=Sex, y=Survived)) + geom_point(position = "jitter")

# A explorar variable Pclass
# Pclass no aporta a la clasificación de sobrevivientes
df %>% ggplot(aes(x=Pclass, y=Survived)) + geom_point(position = "jitter")

df %>% count(Survived, Pclass)

# Vamos a explorar Embarked
# En general Cherbourg y Queenstown no muestran ningun patrón, 
# pero Southampton muestra bastantes que no sobrevivieron
df %>% ggplot(aes(x=Embarked, y=Survived)) + geom_point(position = "jitter")

df %>% count(Survived, Embarked)

# Explorar Fare
# No se observa ningun patrón por el costo del boleto
df %>% ggplot(aes(x=Fare, fill=Survived)) + geom_histogram(alpha=0.7)

