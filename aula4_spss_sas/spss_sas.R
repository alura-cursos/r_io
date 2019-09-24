getwd()
setwd("G:/GitHub/alura/r_io/")

#install.packages('haven')
library(haven)

#### 3. Lendo e escrevendo arquivos SPSS e SAS ####

#### 3.1 Lendo arquivo SPSS/SAS ####
dados_2012 <- read_spss(file = "dados/reclamacao_2012.sav")

View(dados_2012)

dados_2013 <- read_sas('dados/reclamacao_2013.sas')
View(dados_2013)


#### 3.2 Escrevendo arquivo SPSS/SAS ####

## normalizando coluna SEXOCONSUMIDOR
table(dados_2012$SexoConsumidor)

# criando cópia dos dados
dados_2012_limpos <- dados_2012

dados_2012_limpos$SexoConsumidor <- gsub('feminino','F', dados_2012_limpos$SexoConsumidor)
dados_2012_limpos$SexoConsumidor <- gsub('masculino','M',dados_2012_limpos$SexoConsumidor)

table(dados_2012_limpos$SexoConsumidor)

## salvando dados limpos no formato SAV(SPSS)
write_sav(dados_2012, 'dados/reclamacao_2012_limpos.sav')

table(dados_2013$SexoConsumidor)

dados_2013_limpos <- dados_2013

dados_2013_limpos$SexoConsumidor <- gsub('feminino','F',dados_2013_limpos$SexoConsumidor)
dados_2013_limpos$SexoConsumidor <- gsub('masculino','M',dados_2013_limpos$SexoConsumidor)

table(dados_2013_limpos$SexoConsumidor)

write_sas(dados_2013, 'dados/reclamacao_2013_limpos.sas')

rm(dados_2012, dados_2013)



