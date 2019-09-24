## verificando diretorio
getwd()
setwd("G:/GitHub/alura/r_io")

#### 4. Lendo e Escrevendo arquivos CSV ####

#### 4.1 Lendo arquivos CSV com funções nativas do R ####

## lendo arquivo csv com função nativa do R (separador padrão dessa função é a v�?rgula) (leitura errada)
dados_2014 <- read.csv('dados/reclamacao_2014.csv')

View(dados_2014)

## lendo arquivo csv com função nativa do R definindo o separador (leitura correta)
dados_2014 <- read.csv('dados/reclamacao_2014.csv', sep = ';',stringsAsFactors = F)

View(dados_2014)

## lendo arquivo csv com função nativa do R (separador padrão dessa função é o ponto-v�?rgula )
dados_2015 <- read.csv2('dados/reclamacao_2015.csv')
dados_2015 <- read.csv2('dados/reclamacao_2015.csv',sep = ',',stringsAsFactors = F)

View(dados_2015)

#### 4.2 Lendo arquivos CSV com pacote data.table ####
#install.packages('data.table')
library(data.table)

## lendo arquivos com função fread (essa função reconhece o separador automaticamente)
dados_2016 <- fread('dados/reclamacao_2016.csv')


#### 4.3 Encoding em arquivos CSV ####

## problemas com acentua��es
View(dados_2014)
View(dados_2015)
View(dados_2016)
#dados_2014$DescCNAEPrincipal[1]
#dados_2015$DescCNAEPrincipal[303]
#dados_2016$DescCNAEPrincipal[10]

## resolvendo problemas com acentua��es (encoding)
dados_2014 <- read.csv2('dados/reclamacao_2014_.csv', encoding = 'Latin-1',stringsAsFactors = F)
View(dados_2014)

dados_2015 <- read.csv('dados/reclamacao_2015_.csv',encoding = 'UTF-8',stringsAsFactors = F)
View(dados_2015)

dados_2016 <- fread('dados/reclamacao_2016_.csv',encoding = 'UTF-8')
View(dados_2016)


#### 4.4 Escrevendo arquivos CSV com funções nativas do R ####

## alterando valores na coluna Atendida
table(dados_2014$Atendida)

dados_2014_limpos          <- dados_2014
dados_2014_limpos$Atendida <- gsub('nao','N',dados_2014_limpos$Atendida)
dados_2014_limpos$Atendida <- gsub('sim','S',dados_2014_limpos$Atendida)

table(dados_2014_limpos$Atendida)

## gravando arquivos com parametros padrões
write.csv(x = dados_2014_limpos, 'dados/reclamacao_2014_limpos.csv')

## gravando arquivos alterando parametro
write.csv(x = dados_2014_limpos, 'dados/reclamacao_2014_limpos.csv',row.names = F)

## gravando arquivos alterando SEPARADOR (a função não aceita essa alteração)
write.csv(x = dados_2014_limpos, 'dados/reclamacao_2014_limpos.csv',row.names = F, sep = '|')



table(dados_2015$Atendida)

dados_2015_limpos          <- dados_2015
dados_2015_limpos$Atendida <- gsub('nao','N',dados_2015_limpos$Atendida)
dados_2015_limpos$Atendida <- gsub('sim','S',dados_2015_limpos$Atendida)

table(dados_2015_limpos$Atendida)

write.csv2(x = dados_2015, 'dados/reclamacao_2015_limpos.csv')
write.csv2(x = dados_2015, 'dados/reclamacao_2015_limpos.csv',row.names = F)
write.csv2(x = dados_2015, 'dados/reclamacao_2015_limpos.csv',row.names = F,sep = '|')

#### 4.5 Escrevendo arquivos CSV com pacote data.table ####

table(dados_2016$Atendida)

dados_2016_limpos          <- dados_2016
dados_2016_limpos$Atendida <- gsub('nao','N',dados_2016_limpos$Atendida)
dados_2016_limpos$Atendida <- gsub('sim','S',dados_2016_limpos$Atendida)
table(dados_2016_limpos$Atendida)


fwrite(dados_2016_limpos,'dados/reclamacao_2016_limpos.csv',row.names = F)

## quando h� campos textuais � importante utilizar o parametro QUOTE. 
fwrite(dados_2016_limpos,'dados/reclamacao_2016_limpos.csv',row.names = F,quote = T)

## a fun��o FWRITE aceita mudar o separador do arquivo. 
fwrite(dados_2016_limpos,'dados/reclamacao_2016_limpos.csv',row.names = F,quote = T, sep = '_')


#### 4.6 Comparando funções nativas do R e data.table ####

system.time(
  dados <- read.csv('dados/reclamacao_2014.csv', encoding = 'UTF-8',sep = ';',stringsAsFactors = F)
)

system.time(
  dados <- read.csv2('dados/reclamacao_2014.csv', encoding = 'UTF-8',stringsAsFactors = F)
)

system.time(
  dados <- fread('dados/reclamacao_2014.csv', encoding = 'UTF-8',stringsAsFactors = F)
)

rm(dados,dados_2014,dados_2015,dados_2016)






