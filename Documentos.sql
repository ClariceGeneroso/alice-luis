-- =====================================================================
-- PROJETO INTEGRADOR: SABOR & CLIC
-- Arquivo: 01_modelo_fisico.sql
-- Descrição: Criação das tabelas, chaves primárias, estrangeiras e restrições
-- =====================================================================

DROP DATABASE IF EXISTS sabor_clic;
CREATE DATABASE sabor_clic CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE sabor_clic;

-- 1. Tabela de Utilizadores (Centraliza Administradores, Clientes e Cozinheiros)
CREATE TABLE usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    senha VARCHAR(255) NOT NULL,
    tipo ENUM('administrador', 'cliente', 'cozinheiro') NOT NULL,
    endereco TEXT, -- Relevante para Clientes
    turno VARCHAR(50), -- Relevante para Cozinheiros
    especialidade VARCHAR(100), -- Relevante para Cozinheiros
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. Tabela de Pratos (Cardápio gerido pelo Administrador)
CREATE TABLE pratos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT,
    preco DECIMAL(10, 2) NOT NULL,
    ativo BOOLEAN DEFAULT TRUE,
    admin_id INT NOT NULL,
    FOREIGN KEY (admin_id) REFERENCES usuarios(id)
);

-- 3. Tabela de Bancadas / Espaços Gastronômicos (Locação)
CREATE TABLE bancadas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT,
    valor_hora DECIMAL(10, 2) NOT NULL,
    disponivel BOOLEAN DEFAULT TRUE
);

-- 4. Tabela de Agendamento de Bancadas
CREATE TABLE agendamentos_bancadas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    bancada_id INT NOT NULL,
    cliente_id INT NOT NULL,
    data_inicio DATETIME NOT NULL,
    data_fim DATETIME NOT NULL,
    status ENUM('pendente', 'confirmado', 'cancelado') DEFAULT 'pendente',
    FOREIGN KEY (bancada_id) REFERENCES bancadas(id),
    FOREIGN KEY (cliente_id) REFERENCES usuarios(id)
);

-- 5. Tabela de Pedidos
CREATE TABLE pedidos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT NOT NULL,
    status ENUM('Aguardando', 'Em Preparo', 'Pronto para Entrega', 'Entregue', 'Cancelado') DEFAULT 'Aguardando',
    tempo_estimado INT, -- Em minutos (definido pelo Cozinheiro)
    data_pedido TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (cliente_id) REFERENCES usuarios(id)
);

-- 6. Tabela de Itens do Pedido (Relação N:N entre Pedidos e Pratos)
CREATE TABLE itens_pedido (
    id INT AUTO_INCREMENT PRIMARY KEY,
    pedido_id INT NOT NULL,
    prato_id INT NOT NULL,
    quantidade INT NOT NULL,
    preco_unitario DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (pedido_id) REFERENCES pedidos(id) ON DELETE CASCADE,
    FOREIGN KEY (prato_id) REFERENCES pratos(id)
);

-- 7. Tabela de Stock / Ingredientes (Preparação para a Trigger de baixa automática)
CREATE TABLE estoque (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome_item VARCHAR(100) NOT NULL,
    quantidade_atual DECIMAL(10, 2) NOT NULL,
    unidade_medida VARCHAR(20) NOT NULL -- ex: kg, unidades, litros
);

-- 8. Tabela de Ficha Técnica (Associa cada Prato aos ingredientes necessários no Stock)
CREATE TABLE ficha_tecnica (
    id INT AUTO_INCREMENT PRIMARY KEY,
    prato_id INT NOT NULL,
    estoque_id INT NOT NULL,
    quantidade_necessaria DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (prato_id) REFERENCES pratos(id) ON DELETE CASCADE,
    FOREIGN KEY (estoque_id) REFERENCES estoque(id)
);