-- =====================================================================
-- PROJETO INTEGRADOR: SABOR & CLIC
-- Arquivo: 02_insercoes_basicas.sql
-- Descrição: Inserção de dados básicos para funcionamento inicial do sistema
-- =====================================================================

USE sabor_clic;

-- 1. Inserção de Utilizadores (Administrador, Clientes e Cozinheiros)
-- Nota: Em ambiente real, as senhas devem estar hasheadas (ex: bcrypt). Aqui usamos valores textuais para teste.
INSERT INTO usuarios (nome, email, senha, tipo, endereco, turno, especialidade) VALUES
('Carlos Gestor', 'admin@saborclic.com', 'admin123', 'administrador', 'Rua Principal, 100', NULL, NULL),
('Ana Cliente', 'ana@email.com', 'cliente123', 'cliente', 'Avenida Paulista, 500 - Ap 42', NULL, NULL),
('Bruno Cozinheiro', 'bruno.chef@saborclic.com', 'cozinha123', 'cozinheiro', NULL, 'Manhã', 'Massas e Molhos');

-- 2. Inserção de Pratos (Cardápio gerido pelo Administrador - ID 1)
INSERT INTO pratos (nome, descricao, preco, ativo, admin_id) VALUES
('Nhoque Artesanal ao Sugo', 'Nhoque fresco de batata com molho de tomate rústico e manjericão.', 32.50, TRUE, 1),
('Hambúrguer Artesanal Sabor & Clic', 'Blend de carne 180g, queijo cheddar artesanal, bacon crocante e molho da casa.', 28.90, TRUE, 1),
('Risoto de Cogumelos', 'Arroz arbóreo com mix de cogumelos frescos e finalizado com parmesão.', 45.00, TRUE, 1);

-- 3. Inserção de Bancadas / Espaços Gastronômicos
INSERT INTO bancadas (nome, descricao, valor_hora, disponivel) VALUES
('Bancada Profissional 1 - Confeitaria', 'Equipada com batedeira planetária, forno industrial e bancada em inox.', 50.00, TRUE),
('Bancada Profissional 2 - Fogão Quente', 'Equipada com fogão de 6 bocas, fritadeira e exaustor de alta potência.', 65.00, TRUE),
('Bancada de Montagem de Pratos', 'Espaço otimizado para finalização de embalagens e delivery.', 35.00, TRUE);

-- 4. Inserção de Itens no Stock (Ingredientes)
INSERT INTO estoque (nome_item, quantidade_atual, unidade_medida) VALUES
('Batata', 50.00, 'kg'),
('Farinha de Trigo', 30.00, 'kg'),
('Molho de Tomate', 20.00, 'litros'),
('Carne Bovina (Blend)', 15.00, 'kg'),
('Queijo Cheddar', 10.00, 'kg'),
('Arroz Arbóreo', 12.00, 'kg'),
('Cogumelos Frescos', 5.00, 'kg');

-- 5. Inserção na Ficha Técnica (Associa os Pratos aos Ingredientes do Stock)
-- Exemplo para o Nhoque (Prato ID 1): Usa Batata (ID 1) e Farinha (ID 2) e Molho (ID 3)
INSERT INTO ficha_tecnica (prato_id, estoque_id, quantidade_necessaria) VALUES
(1, 1, 0.30), -- 300g de batata
(1, 2, 0.10), -- 100g de farinha
(1, 3, 0.15), -- 150ml de molho
-- Exemplo para o Hambúrguer (Prato ID 2): Usa Carne (ID 4) e Queijo (ID 5)
(2, 4, 0.18), -- 180g de carne
(2, 5, 0.05), -- 50g de queijo
-- Exemplo para o Risoto (Prato ID 3): Usa Arroz (ID 6) e Cogumelos (ID 7)
(3, 6, 0.20), -- 200g de arroz
(3, 7, 0.08); -- 80g de cogumelos