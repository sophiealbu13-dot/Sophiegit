-- Active: 1794917650052@@127.0.0.1@3306@projeto_assistencia_tecnica
DROP DATABASE projeto_assistencia_tecnica;
-- Criação do Banco de Dados 
CREATE DATABASE IF NOT EXISTS projeto_assistencia_tecnica;
USE projeto_assistencia_tecnica;




CREATE TABLE clientes (
    id_clientes INT AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(120) NOT NULL,
    telefone VARCHAR(20) NOT NULL,
    cpf VARCHAR(14) NOT NULL,
    CONSTRAINT pk_clientes PRIMARY KEY (id_clientes),
    CONSTRAINT uq_clientes_email UNIQUE (email),
    CONSTRAINT uq_clientes_telefone UNIQUE (telefone),
    CONSTRAINT uq_clientes_cpf UNIQUE (cpf)
);

INSERT INTO clientes (nome, email, telefone, cpf) VALUES
('Laura C', 'laura.c@example.com', '123456789', NULL),
('Leonardo', 'leonardo@example.com', '987654321', NULL),
('Pablo', 'pablo@example.com', '555555555', NULL),
('Sophie', 'sophie@example.com', '111111111', NULL),
('Bruno', 'bruno@example.com', '222222222', NULL);


CREATE TABLE tecnicos (
    id_tecnicos INT AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    turno VARCHAR(20) NOT NULL,
    setor VARCHAR(60),
    especialidade VARCHAR(40) NOT NULL,
    status VARCHAR(15) NOT NULL DEFAULT 'ATIVO',
    CONSTRAINT pk_tecnicos PRIMARY KEY (id_tecnicos),
    CONSTRAINT chk_tecnicos_status CHECK (status IN ('ATIVO', 'INATIVO'))
);

INSERT INTO tecnicos (nome, email, telefone, cpf) VALUES
('Bruno', 'bruno@example.com', '222222222', NULL),
('Roberto', 'roberto@example.com', '123456789', NULL),
('Suzana', 'suzana@example.com', '987654321', NULL),
('Tegner', 'tegner@example.com', '555555555', NULL);


CREATE TABLE pecas (
    id_pecas INT AUTO_INCREMENT,
    descricao_pecas VARCHAR(120) NOT NULL,
    fabricante VARCHAR(60),
    valor_peca DECIMAL(10,2) NOT NULL,
    quantidade_estoque INT NOT NULL DEFAULT 0,
    CONSTRAINT pk_pecas PRIMARY KEY (id_pecas),
    CONSTRAINT chk_pecas_estoque CHECK (quantidade_estoque >= 0)
);

INSERT INTO pecas (id_pecas, descricao_pecas, fabricante, valor_peca, quantidade_estoque) VALUES
('14685477361211131', 'Placa', 'Micron', R$1000, 3652),
('14665461361311131', 'Parafuso', 'PINGOOD', R$85, 56981),
('15675400361514336', 'Bateria', 'BYD ', R$420, 2568),
('14685477771211111', 'Compressor', 'Forward', R$330, 4103),
('35685477361279832', 'Carcaça', 'ZAGG', R$900, 15549),
('77685477661214931', 'Sensores', 'Bosch Sensortec', R$99,90, 5614);



CREATE TABLE equipamentos (
    id_equipamentos INT AUTO_INCREMENT,
    tipo VARCHAR(100) NOT NULL,
    numero_serie VARCHAR(60) NOT NULL,
    marca VARCHAR(60),
    modelo VARCHAR(60) NOT NULL,
    estado_entrada VARCHAR(60),
    id_clientes INT NOT NULL,
    CONSTRAINT pk_equipamentos PRIMARY KEY (id_equipamentos),
    CONSTRAINT uq_equipamentos_serie UNIQUE (numero_serie),
    CONSTRAINT fk_equipamentos_clientes FOREIGN KEY (id_clientes) REFERENCES clientes(id_clientes)
);

INSERT INTO equipamentos (id_equipamentos, tipos, numero_serie, marca,modelo, estado_entrada, id_clientes) VALUES
('146854773612111313', 'Placa Principal, Placa de Carga, Placas flexíveis','156', 'Micron', 'ABERTO', 14685477361211131),
('146654613613111315', 'Parafuso Phillips, Pentalobe, Tri-point e Torx','164','PINGOOD', 'ABERTO', 14665461361311131),
('156754003615143362', 'Baterias íon de lítio, polímero de lítio e silício-carbono','147', 'BYD ', 'ABERTO', 15675400361514336),
('146854777712111114', 'Compressor Bomba de Ar Portátil Interphone, Compressor de Ar Portátil Xiaomi ','129','Forward', 'ABERTO', 14685477771211111),
('356854773612798321', 'Carcaça Tampa traseira, Aro lateral, Carcaça completa', '136', 'ZAGG', 'ABERTO', 35685477361279832),
('776854776612149315', 'Sensores Acelerômetro, Giroscópio, Magnetômetro, Barômetro', '171','Bosch Sensortec', 'ABERTO', 77685477661214931);

CREATE TABLE chamados (
    id_chamados INT AUTO_INCREMENT,
    data_atendimento DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    defeito_relatado VARCHAR(120) NOT NULL,
    diagnostico VARCHAR(120),
    valor_servico DECIMAL(10,2) DEFAULT 0.00,
    status_chamados VARCHAR(20) NOT NULL DEFAULT 'ABERTO',
    id_equipamentos INT NOT NULL,
    id_tecnicos INT,
    CONSTRAINT pk_chamados PRIMARY KEY (id_chamados),
    CONSTRAINT chk_chamados_status CHECK (status_chamados IN ('ABERTO', 'EM_ATENDIMENTO', 'FINALIZADO')),
    CONSTRAINT fk_chamados_equipamentos FOREIGN KEY (id_equipamentos) REFERENCES equipamentos(id_equipamentos),
    CONSTRAINT fk_chamados_tecnicos FOREIGN KEY (id_tecnicos) REFERENCES tecnicos(id_tecnicos)
);

INSERT INTO chamados (id_chamados, data_atendimento, defeito_relatado, diagnostico, valor_servico, tatus_chamados, id_equipamentos, id_tecnicos ) VALUES
('3612111310', '14685477361211131', NULL, NULL, NULL, 'ABERTO', 146854773612111313, 168),
('3612111311', '2026-06-16', NULL, NULL, NULL, 'ABERTO', 146654613613111315, 162),
('3612111312', '2026-06-17', NULL, NULL, NULL, 'ABERTO', 156754003615143362, 163),
('3612111313', '2026-06-18', NULL, NULL, NULL, 'ABERTO', 146854777712111114, 164),
('3612111314', '2026-06-18', NULL, NULL, NULL, 'ABERTO', 356854773612798321, 154),
('3612111315', '2026-06-18', NULL, NULL, NULL, 'ABERTO', 776854776612149315, 124);



CREATE TABLE chamados_pecas (
    id_chamados INT NOT NULL,
    id_pecas INT NOT NULL,
    quantidade INT NOT NULL DEFAULT 1,
    valor_unitario DECIMAL(10,2) NOT NULL,
    CONSTRAINT pk_chamados_pecas PRIMARY KEY (id_chamados, id_pecas),
    CONSTRAINT chk_chamados_pecas_qtd CHECK (quantidade > 0),
    CONSTRAINT fk_cp_chamados FOREIGN KEY (id_chamados) REFERENCES chamados(id_chamados),
    CONSTRAINT fk_cp_pecas FOREIGN KEY (id_pecas) REFERENCES pecas(id_pecas)
);

INSERT INTO chamados_pecas (id_chamados, id_pecas, quantidade,valor_unitario) VALUES
('3612111310', '14665461361311131', NULL, NULL, NULL),
('3612111311', '14665461361311131', NULL, NULL, NULL),
('3612111312', '15675400361514336', NULL, NULL, NULL),
('3612111313', '35685477361279832', NULL, NULL, NULL),
('3612111314', '14685477771211111', NULL, NULL, NULL),
('3612111315', '77685477661214931', NULL, NULL, NULL);