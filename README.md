# Sistemas-Banco-de-dados
Códigos da disciplina de Sistemas de Banco de Dados, do 4° Período.

## Código do GitHub
--git add .
--git commit -m "Texto do commit"
--git push origin main

## Banco de dados local
sqlite3 --version         | se esta funcioando
sqlite3 [nome].db         | cria banco
PRAGMA foreing_keys = ON; | abilita as chaves da tabela
CREATE TABLE nome         | cria tabela  ctrl enter
.table                    | para var tabela
TRUNCATE TABLE nome_da_tabela; | deletar tabela 

id PRIMARY KEY              | CHAVE PRIMARIA, ablitar chave estrangeira
AUTOINCREMENT,



docker-compose up -d       | Rodar o docker


docker exec -it postgres_container psql -U root -d bd_aula01  |Rodar Banco de dados

\dt visualiza tabela
\d visualiza tabela expecifica 