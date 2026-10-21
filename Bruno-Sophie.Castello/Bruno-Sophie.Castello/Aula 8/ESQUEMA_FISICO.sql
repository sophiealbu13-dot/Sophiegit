-- Active: 1792494987118@@127.0.0.1@3306@mysql
CREATE DATABASE SMARTCOFFE_Sophie

USE SMARTCOFFE_Sophie


CREATE TABLE Pagamento (
Valor INT,
Vencimento datetime,
Forma_pagamento Varchar(60),
Data_pagamento datetime,
Id_Pagamento int primary key auto_increment PRIMARY KEY,
Nome_cliente Varchar(60)
)

CREATE TABLE Funcionarios (
Registro Varchar(60),
Cargo Varchar(60),
Setor Varchar(60),
Nome_cliente Varchar(60),
Curriculo Varchar(60),
Id_Funcionarios int primary key auto_increment PRIMARY KEY
)

CREATE TABLE Pedidos (
Id_Pedidos int primary key auto_increment PRIMARY KEY,
Quantidade INT,
Tipo_entrega Varchar(60),
Data datetime,
Valor INT,
Nome_cliente Varchar(60)
)

CREATE TABLE Delivery (
Endereco Varchar(60),
Nome_cliente Varchar(60),
Id_Delivery int primary key auto_increment PRIMARY KEY,
Numero_pedido INT,
Pagamento INT
)

CREATE TABLE Fidelidade (
Data_cadastro datetime,
Pontos INT,
Pontos_consumo INT,
Beneficios Varchar(60),
Nome_cliente Varchar(60),
Id_Fidelidade int primary key auto_increment PRIMARY KEY
)

CREATE TABLE Produtos (
Nome_cliente Varchar(60),
Marca Varchar(60),
Pre�o INT,
Quantidade INT,
Peso INT,
Id_Produto int primary key auto_increment PRIMARY KEY
)

CREATE TABLE Produto (
Validade datetime,
Nota_fiscal Varchar(60),
Localiza��o Varchar(60),
Nome_produto Varchar(60),
Lote INT,
Id_Estoque int primary key auto_increment PRIMARY KEY
)

CREATE TABLE Cliente (
Data_cadrasro datetime,
Telefone INT,
CPF Varchar(14),
Email Varchar(14),
Nome_cliente Varchar(60),
Id_Cliente int primary key auto_increment PRIMARY KEY
)

CREATE TABLE Realiza (
Id_Pedidos int,
Id_Cliente int,
FOREIGN KEY(Id_Pedidos) REFERENCES Pedidos (Id_Pedidos),
FOREIGN KEY(Id_Cliente) REFERENCES Cliente (Id_Cliente)
)

CREATE TABLE Contem (
Id_Produto int,
Id_Pedidos int,
FOREIGN KEY(Id_Produto) REFERENCES Produtos (Id_Produto),
FOREIGN KEY(Id_Pedidos) REFERENCES Pedidos (Id_Pedidos)
)

CREATE TABLE Possui (
Id_Pagamento int,
Id_Pedidos int,
FOREIGN KEY(Id_Pagamento) REFERENCES Pagamento (Id_Pagamento),
FOREIGN KEY(Id_Pedidos) REFERENCES Pedidos (Id_Pedidos)
)

CREATE TABLE Atende (
Id_Funcionarios int,
Id_Pedidos int,
FOREIGN KEY(Id_Funcionarios) REFERENCES Funcionarios (Id_Funcionarios),
FOREIGN KEY(Id_Pedidos) REFERENCES Pedidos (Id_Pedidos)
)

CREATE TABLE Entrega (
Id_Funcionarios int,
Id_Delivery int,
FOREIGN KEY(Id_Funcionarios) REFERENCES Funcionarios (Id_Funcionarios),
FOREIGN KEY(Id_Delivery) REFERENCES Delivery (Id_Delivery)
)

