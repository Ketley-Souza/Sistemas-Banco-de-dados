PRAGMA foreign_keys = ON;

-- Tabela participante
CREATE TABLE participante(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE,
    telefone TEXT
);

-- Tabela evento
CREATE TABLE evento(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT NOT NULL,
    descricao TEXT,
    local TEXT NOT NULL,
    data TEXT NOT NULL
);

-- Tabela pagamento
CREATE TABLE pagamento(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    valor REAL,
    data_pagamento TEXT NOT NULL,
    status TEXT,
    inscricao_id INTEGER NOT NULL UNIQUE,
    FOREIGN KEY (inscricao_id) REFERENCES inscricao(id) ON DELETE CASCADE
);

-- Tabela inscricao
CREATE TABLE inscricao(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    data_inscricao TEXT NOT NULL,
    status TEXT,
    evento_id INTEGER NOT NULL,
    participante_id INTEGER NOT NULL,
    FOREIGN KEY (evento_id) REFERENCES evento(id) ON DELETE SET NULL,
    FOREIGN KEY (participante_id) REFERENCES participante(id) ON DELETE SET NULL
);


-- Inserir participante
INSERT INTO participante (nome, email, telefone) VALUES ('Rafael','rafael@unipam','leafar');
INSERT INTO participante (nome, email, telefone) VALUES ('Gabriel','gabriel@uftm','leirbag');
INSERT INTO participante (nome, email, telefone) VALUES ('Cecilia','cecilia@filho','cecilia');

-- Inserir evento
INSERT INTO evento (nome, descricao, local, data) VALUES ('Rafael','rafael@unipam','leafar');
INSERT INTO evento (nome, descricao, local, data) VALUES ('Gabriel','gabriel@uftm','leirbag');
INSERT INTO evento (nome, descricao, local, data) VALUES ('Cecilia','cecilia@filho','cecilia');

-- Inserir inscricao
INSERT INTO inscricao (data, status, evento_id, participante_id) VALUES ('Gabriel Marinho', '999999999', 3);
INSERT INTO inscricao (data, status, evento_id, participante_id) VALUES ('Cecilia Marinho', '999999999', 4);
INSERT INTO inscricao (data, status, evento_id, participante_id) VALUES ('Joaquim Marinho', '999999999', 5);

-- Inserir pagamento
INSERT INTO inscricao (valor, data_pagamento, status, inscricao_id) VALUES ('Gabriel Marinho', '999999999', 3);
INSERT INTO inscricao (valor, data_pagamento, status, inscricao_id) VALUES ('Cecilia Marinho', '999999999', 4);
INSERT INTO inscricao (valor, data_pagamento, status, inscricao_id) VALUES ('Joaquim Marinho', '999999999', 5);



/* 

● Participante
○ id (PK, inteiro autoincrement) *
○ nome (texto, NOT NULL)         *
○ email (texto, NOT NULL, UNIQUE) *
○ telefone (texto)  *

● Evento
○ id (PK, inteiro autoincrement)
○ nome (texto, NOT NULL)
○ descricao (texto)
○ local (texto, NOT NULL)
○ data (texto, NOT NULL)

● Pagamento
○ id (PK, inteiro autoincrement)
○ id_inscricao (FK -> Inscricao.id, UNIQUE para garantir 1:1)
○ valor (real)
○ data_pagamento (texto)
○ status (texto — ex.: "pago", "pendente")
Obs: Regra 1:1 usada aqui: cada Inscricao tem no máximo um Pagamento.

● Inscricao (tabela associativa — resolve N:M Evento↔Participante):
○ id (PK, inteiro autoincrement)
○ id_evento (FK -> Evento.id, NOT NULL)
○ id_participante (FK -> Participante.id, NOT NULL)
○ data_inscricao (texto)
○ status (texto — ex.: "confirmada", "cancelada")

*/