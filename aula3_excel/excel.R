getwd()
setwd("G:/GitHub/alura/r_io/")

#install.packages('xlsx')
library(xlsx)
#### 2. Lendo e escrevendo planilhas excel ####

#### 2.1 Lendo planilhas excel ####

## carregando planilha. (com erro)
excel <- read.xlsx(file = 'dados/reclamacao_2010_2011.xlsx')

## carregando planilha com index da aba
excel <- read.xlsx(file = 'dados/reclamacao_2010_2011.xlsx',sheetIndex = 1)

## visualizando registros (problema com encoding)
View(excel)

## verificando valores na coluna anoCalendario
table(excel$anocalendario)

#### 2.2 Enconding em planilhas excel ####

## carregando planilha e aba 2010(1) e resolvendo problema do encoding
dados_2010 <- read.xlsx2('dados/reclamacao_2010_2011.xlsx',sheetIndex = 1, stringsAsFactors = F)

View(dados_2010)

## carregando planilha especificando a aba (sheet) pelo nome
dados_2011 <- read.xlsx2('dados/reclamacao_2010_2011.xlsx',sheetIndex = '2011', stringsAsFactors = F)

## verificando valores na coluna anocalendario
table(dados_2010$anocalendario)
table(dados_2011$anocalendario)


#### 2.3 Escrevendo planilhas excel ####

## visualizando nomes colunas
colnames(dados_2010)

## excluindo colunas que não serão utilizadas (X.1)
dados_2010_limpos <- dados_2010[,-17]
colnames(dados_2010_limpos)

## salvando planilha excel
write.xlsx(x = dados_2010_limpos,file = 'dados/reclamacao_2010_2011_limpos.xlsx',row.names = F)

## salvando planilha excel, definindo nome da aba
write.xlsx(x = dados_2010_limpos,file = 'dados/reclamacao_2010_2011_limpos.xlsx',sheetName = '2010',row.names = F)

## visualizando nomes colunas
colnames(dados_2011)

## excluindo colunas que não serão utilizadas (X.1)
dados_2011_limpos <- dados_2011[,-17]
colnames(dados_2011_limpos)

## salvando planilha excel, adicionando uma aba a uma planilha ja existente
write.xlsx(x = dados_2011_limpos,file = 'dados/reclamacao_2010_2011_limpos.xlsx',
           append = T,sheetName = '2011',row.names = F)

## apagando objetos 
rm(dados_2010,dados_2011,excel)
