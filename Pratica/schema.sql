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
INSERT INTO participante (nome, email, telefone) VALUES ('Ketley','rafael@unipam','555555555');
INSERT INTO participante (nome, email, telefone) VALUES ('Gabriel','gabriel@ufm','666666666');
INSERT INTO participante (nome, email, telefone) VALUES ('Joao','joao@uff','777777777');

-- Inserir evento
INSERT INTO evento (nome, descricao, local, data) VALUES ('Fenamilho','milho','Patos', '21/02/2025');
INSERT INTO evento (nome, descricao, local, data) VALUES ('Fena','grao','Uberlandia','10/09/2023');
INSERT INTO evento (nome, descricao, local, data) VALUES ('Fafa','farofa','feira', '07/12/2025');


-- Inserir inscricao
INSERT INTO inscricao (data_inscricao, status, evento_id, participante_id) VALUES ('20/02/2025', 'confirmada', 1, 1);
INSERT INTO inscricao (data_inscricao, status, evento_id, participante_id) VALUES ('09/09/2023', 'confirmada', 2, 2);
INSERT INTO inscricao (data_inscricao, status, evento_id, participante_id) VALUES ('06/12/2025', 'confirmada', 3, 3);


-- Inserir pagamento
INSERT INTO pagamento (valor, data_pagamento, status, inscricao_id) VALUES ('250', '20/02/2025', 'pago', 1);
INSERT INTO pagamento (valor, data_pagamento, status, inscricao_id) VALUES ('250', '09/09/2023', 'pago', 2);
INSERT INTO pagamento (valor, data_pagamento, status, inscricao_id) VALUES ('250', '06/12/2025', 'pago', 3);
