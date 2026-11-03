-- Active: 1792494987118@@127.0.0.1@3306@biblioteca_soma2_sophie
DROP DATABASE IF EXISTS biblioteca_soma2_Sophie;
CREATE DATABASE biblioteca_soma2_Sophie;
USE biblioteca_soma2_Sophie;

CREATE TABLE usuario (
    id_usuario INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(120) UNIQUE,
    telefone VARCHAR(20),
    ativo BOOLEAN NOT NULL DEFAULT TRUE
);

SELECT * FROM usuario;

CREATE TABLE livro (
    id_livro INT PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(100) NOT NULL,
    autor VARCHAR(100) NOT NULL,
    isbn CHAR(13) NOT NULL,
    ano_publicacao INT NOT NULL,
    quantidade_disponivel INT NOT NULL DEFAULT 0
);
SELECT * FROM livro;

ALTER TABLE livro ADD COLUMN editora VARCHAR(100);

CREATE TABLE emprestimo (
    id_emprestimo INT PRIMARY KEY AUTO_INCREMENT,
    data_emprestimo DATE NOT NULL,
    data_prevista_devolucao DATE NOT NULL,
    data_devolucao DATE,
    status_emprestimo VARCHAR(20) DEFAULT 'ABERTO', CHECK (status_emprestimo IN ('ABERTO', 'DEVOLVIDO', 'ATRASADO')),
    id_usuario INT NOT NULL,
    id_livro INT NOT NULL
);

INSERT INTO usuario (nome, email, telefone, ativo) VALUES
('Alice', 'alice@example.com', '123456789', TRUE),
('Bob', 'bob@example.com', '987654321', TRUE),
('Charlie', 'charlie@example.com', '555555555', TRUE),
('David', 'david@example.com', '111111111', TRUE),
('Eve', 'eve@example.com', '222222222', TRUE);

INSERT INTO livro (titulo, autor, isbn, ano_publicacao, quantidade_disponivel) VALUES
('Livro Corrupt', 'Best-seller', '1234567890123', 2015, 3),
('Livro Verity', 'Colleen Hoover', '9876543210987', 2018, 5),
('Livro Invisivel', 'Eloy Moreno', '5555555555555', 2024, 2),
('Livro Até o Verão Terminar', 'Colleen Hoover', '1111111111111', 2018, 4),
('Livro Desenfreados', 'Kelly M.', '2222222222222', 2024, 1),
('Livro Garota do Lago', 'Charlie Donlea', '3333333333333', 2017, 5);

INSERT INTO emprestimo (data_emprestimo, data_prevista_devolucao, status_emprestimo, id_usuario, id_livro) VALUES
('2026-06-01', '2026-06-15', 'ABERTO', 1, 1),
('2026-06-02', '2026-06-16', 'ABERTO', 2, 2),
('2026-06-03', '2026-06-17', 'ABERTO', 3, 3),
('2026-06-04', '2026-06-18', 'ABERTO', 4, 4),
('2026-06-05', '2026-06-19', 'ABERTO', 5, 5);

SELECT * FROM usuario;

UPDATE usuario 
SET telefone = '111111112' 
WHERE id_usuario = 4;

SELECT * FROM livro, quantidade_disponivel;

UPDATE livro 
SET quantidade_disponivel = 2
WHERE id_livro = '5555555555555';

SELECT * FROM livro, quantidade_disponivel;

UPDATE livro 
SET quantidade_disponivel = 4
WHERE id_livro = '5555555555555',





