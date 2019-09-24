## verificando o diret�rio de trabalho
getwd()
setwd("G:/GitHub/alura/r_io/")


#### 1. Lendo e escrevendo arquivos JSON ####

#### 1.2 Lendo arquivos JSON (lib JSONLITE) ####
#install.packages('jsonlite')
library(jsonlite)
## lendo arquivo json com lib JSONLITE (com erro)
reclamacao_2009  <- fromJSON('dados/reclamacao_2009.json')

## lendo arquivo json com lib JSONLITE e com READLINES (nessa execução salva em um dataframe)

## carregando os dados em formato de string
reclamacao_string <- paste(readLines('dados/reclamacao_2009.json'), collapse="")

## carregando os dados no formato JSON para DATA FRAME
reclamacao_2009 <- fromJSON(reclamacao_string) 

#### 1.3 Lendo arquivos JSON (lib RJSONIO) ####
#install.packages('RJSONIO')
library(RJSONIO)

## lendo arquivo json com encoding  (os dados são salvos em formato de lista)
reclamacao_2009_2  <- RJSONIO::fromJSON('dados/reclamacao_2009.json')

## visualizando lista (posição 1)
reclamacao_2009_2[1]

#### 1.4 Enconding em arquivos JSON ####
## lendo arquivo json com encoding
reclamacao_2009_2  <- RJSONIO::fromJSON('dados/reclamacao_2009.json', encoding = 'utf-8')
reclamacao_2009_2[1]

## lendo arquivo json com encoding correto
reclamacao_2009_2  <- RJSONIO::fromJSON('dados/reclamacao_2009.json', encoding = 'latin1')
reclamacao_2009_2[1]


#### 1.5 Convertendo JSON para data frame ####
#install.packages('data.table')
library(data.table)

## converter json para data frame (com erro)
dados_2009 <- rbindlist(l = reclamacao_2009_2)

## converter json para data frame
dados_2009 <- rbindlist(l = reclamacao_2009_2,fill = T)

## visualizando dados
View(dados_2009)

## apagando objetos que não serão mais utilizados
rm(reclamacao_2009, reclamacao_2009_2,reclamacao_string)

#### 1.6 Escrevendo arquivos JSON ####

## verificando valores da coluna UF
table(dados_2009$UF)

## filtando registros (excluindo UF com N/D)
dados_2009_limpos <- dados_2009[dados_2009$UF != 'N/D',]

## convertendo data frame para json (JSONLITE)
sub_json <- jsonlite::toJSON(dados_2009_limpos)

## salvando arquivo json
write(sub_json,'dados/reclamacao_2009_limpos.json')

## convertendo data frame para json (JSONLITE)
sub_json <- RJSONIO::toJSON(dados_2009_limpos)

## salvando arquivo json
write(sub_json,'dados/reclamacao_2009_limpos.json')


#### 1.7 Comparando as libs RJSONIO e JSONLITE ####

## comparando tempo de leitura leitura
system.time(
  reclamacao_2009 <- jsonlite::fromJSON(paste(readLines('dados/reclamacao_2009.json'), collapse=""))
)

system.time(
  reclamacao_2009_2  <- RJSONIO::fromJSON('dados/reclamacao_2009.json')
)

## comparando formato de armazenamento

## convertendo data frame para json (JSONLITE)
jsonlite <- jsonlite::toJSON(dados_2009_limpos[1:10,])
jsonlite

## convertendo data frame para json (RJSONIO)
rjsonio <- RJSONIO::toJSON(dados_2009_limpos[1:10,])
rjsonio

## convertendo data frame para json (JSONLITE) com formata��o
jsonlite <- jsonlite::toJSON(dados_2009_limpos[1:10,],pretty = T)
jsonlite

write(rjsonio,'rjsonio_2009.json')

## convertendo data frame para json (RJSONIO) com formatação
rjsonio <- RJSONIO::toJSON(dados_2009_limpos[1:10,], pretty = T)
rjsonio

write(jsonlite,'jsonlite_2009.json')


rm(rjsonio,jsonlite, reclamacao_2009,reclamacao_2009_2, dados_2009)

