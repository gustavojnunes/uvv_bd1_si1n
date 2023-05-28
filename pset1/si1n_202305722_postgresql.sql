--comando para apagar o banco de dados caso ele exista
DROP DATABASE IF EXISTS uvv;

--comando para apagar o usuário caso ele exista
DROP ROLE IF EXISTS gustavo;


--comando para criar o user para criação do banco de dados
CREATE USER gustavo 
	   WITH encrypted password '123'
	   		login
	   		createrole
	   	    createdb;

--comando para criação do banco de dados uvv
CREATE DATABASE uvv
	   WITH 
	   OWNER = gustavo
	   TEMPLATE = template0
	   ENCODING = 'UTF8'
	   LC_COLLATE = 'pt_BR.UTF-8'
	   LC_CTYPE = 'pt_BR.UTF-8'
	   ALLOW_CONNECTIONS = TRUE;

--comando para dar privilegio
GRANT ALL PRIVILEGES ON DATABASE uvv TO gustavo;

--comando para entrar no banco de dados
\c "dbname = uvv user = gustavo password = 123";
	  
--comando para criar um novo esquema chamado lojas
CREATE SCHEMA lojas AUTHORIZATION gustavo;

--comando para identificar qual esquema está sendo usado
SELECT CURRENT_SCHEMA ();

--comando para identificar qual path está sendo usado
SHOW SEARCH_PATH;

--comando para setar 'loja' como path principal a ser usado
SET SEARCH_PATH TO lojas, "$user", public;

--comando para alterar o user que está sendo usado para fazer os comandos
ALTER USER gustavo
SET SEARCH_PATH TO lojas, "$user", public;

--criação da tabela produtos
CREATE TABLE Produtos (
                produto_id NUMERIC(38) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                preco_unitario NUMERIC(10,2),
                detalhes BYTEA,
                imagem BYTEA,
                imagem_mime_type VARCHAR(512),
                imagem_arquivo VARCHAR(512),
                imagem_charset VARCHAR(512),
                imagem_ultima_atualizacao DATE,
                CONSTRAINT produto_id PRIMARY KEY (produto_id)
);
COMMENT ON TABLE Produtos IS 'Tabela que armazena informações do produto';
COMMENT ON COLUMN Produtos.produto_id IS 'id do produto';
COMMENT ON COLUMN Produtos.nome IS 'nome do produto';
COMMENT ON COLUMN Produtos.preco_unitario IS 'preço unitario do produto';
COMMENT ON COLUMN Produtos.detalhes IS 'detalhes do produto';
COMMENT ON COLUMN Produtos.imagem IS 'imagem do produto';
COMMENT ON COLUMN Produtos.imagem_mime_type IS 'formato do arquivo da imagem do produto';
COMMENT ON COLUMN Produtos.imagem_arquivo IS 'arquivo da imagem do produto';
COMMENT ON COLUMN Produtos.imagem_charset IS 'charset da imagem do produto';
COMMENT ON COLUMN Produtos.imagem_ultima_atualizacao IS 'data da ultima atualizacao da imagem';

--criação da tabela lojas
CREATE TABLE Lojas (
                loja_id NUMERIC(38) NOT NULL,
                Nome VARCHAR(255) NOT NULL,
                endereco_fisico VARCHAR(512),
                endereco_web VARCHAR(100),
                latitude NUMERIC,
                longitude NUMERIC,
                logo BYTEA,
                logo_mime_type VARCHAR(512),
                logo_arquivo VARCHAR(512),
                logo_charset VARCHAR(512),
                logo_ultima_atualizacao DATE,
                CONSTRAINT loja_id PRIMARY KEY (loja_id)
);
COMMENT ON TABLE Lojas IS 'Tabela que armazena informações das lojas';
COMMENT ON COLUMN Lojas.loja_id IS 'id da loja';
COMMENT ON COLUMN Lojas.Nome IS 'nome da loja';
COMMENT ON COLUMN Lojas.endereco_fisico IS 'endereço da loja';
COMMENT ON COLUMN Lojas.endereco_web IS 'site da loja';
COMMENT ON COLUMN Lojas.latitude IS 'latitude da loja';
COMMENT ON COLUMN Lojas.longitude IS 'longitude da loja';
COMMENT ON COLUMN Lojas.logo IS 'logo da loja';
COMMENT ON COLUMN Lojas.logo_mime_type IS 'formato do arquivo da logo';
COMMENT ON COLUMN Lojas.logo_arquivo IS 'arquivo da logo';
COMMENT ON COLUMN Lojas.logo_charset IS 'charset da logo';
COMMENT ON COLUMN Lojas.logo_ultima_atualizacao IS 'data da ultima atualização da logo';

--criação da tabela estoques
CREATE TABLE Estoques (
                estoque_id NUMERIC(38) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                quantidade NUMERIC(38) NOT NULL,
                produto_id NUMERIC(38) NOT NULL,
                CONSTRAINT estoque_id PRIMARY KEY (estoque_id)
);
COMMENT ON TABLE Estoques IS 'Tabela que armazena informação sobre os estoques';
COMMENT ON COLUMN Estoques.estoque_id IS 'id do estoque';
COMMENT ON COLUMN Estoques.loja_id IS 'id da loja';
COMMENT ON COLUMN Estoques.quantidade IS 'quantidade dos produtos no estoque';
COMMENT ON COLUMN Estoques.produto_id IS 'id do produto';

--criação da tabela clientes
CREATE TABLE Clientes (
                cliente_id NUMERIC(38) NOT NULL,
                email VARCHAR(255) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                telefone1 VARCHAR(20),
                telefone2 VARCHAR(20),
                telefone3 VARCHAR(20),
                CONSTRAINT clientes_id PRIMARY KEY (cliente_id)
);
COMMENT ON TABLE Clientes IS 'Tabela que armazena os dados dos clientes';
COMMENT ON COLUMN Clientes.cliente_id IS 'id do cliente';
COMMENT ON COLUMN Clientes.email IS 'email do cliente';
COMMENT ON COLUMN Clientes.nome IS 'nome do cliente';
COMMENT ON COLUMN Clientes.telefone1 IS 'numero de telefone primario do cliente';
COMMENT ON COLUMN Clientes.telefone2 IS 'numero de telefone secundario do cliente';
COMMENT ON COLUMN Clientes.telefone3 IS 'numero de telefone terciario do cliente';

--criação da tabela pedidos
CREATE TABLE Pedidos (
                pedido_id NUMERIC(38) NOT NULL,
                data_hora TIMESTAMP NOT NULL,
                status VARCHAR(15) NOT NULL,
                cliente_id NUMERIC(38) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                CONSTRAINT pedido_id PRIMARY KEY (pedido_id)
);
COMMENT ON TABLE Pedidos IS 'Tabela que armazena os pedidos das lojas';
COMMENT ON COLUMN Pedidos.pedido_id IS 'id do pedido';
COMMENT ON COLUMN Pedidos.data_hora IS 'data e hora que foi realizado o pedido';
COMMENT ON COLUMN Pedidos.status IS 'status do pedido';
COMMENT ON COLUMN Pedidos.cliente_id IS 'id do cliente';
COMMENT ON COLUMN Pedidos.loja_id IS 'id da loja';

--criação da tabela envios
CREATE TABLE Envios (
                envio_id NUMERIC(38) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                cliente_id NUMERIC(38) NOT NULL,
                endereco_entrega VARCHAR(512) NOT NULL,
                status VARCHAR(15) NOT NULL,
                CONSTRAINT envio_id PRIMARY KEY (envio_id)
);
COMMENT ON TABLE Envios IS 'Tabela que armazena informações dos envios';
COMMENT ON COLUMN Envios.envio_id IS 'id do envio';
COMMENT ON COLUMN Envios.loja_id IS 'id da loja';
COMMENT ON COLUMN Envios.cliente_id IS 'id do cliente';
COMMENT ON COLUMN Envios.endereco_entrega IS 'endereço de entrega';
COMMENT ON COLUMN Envios.status IS 'status do envio';

--criação da tabela pedidos_itens
CREATE TABLE pedidos_itens (
                pedido_id NUMERIC(38) NOT NULL,
                produto_id NUMERIC(38) NOT NULL,
                numero_da_linha NUMERIC(38) NOT NULL,
                preco_unitario NUMERIC(10,2) NOT NULL,
                quantidade NUMERIC(38) NOT NULL,
                envio_id NUMERIC(38),
                CONSTRAINT pedido_id_1 PRIMARY KEY (pedido_id, produto_id)
);
COMMENT ON TABLE pedidos_itens IS 'Tabela que armazena os itens dos pedidos';
COMMENT ON COLUMN pedidos_itens.pedido_id IS 'id do pedido';
COMMENT ON COLUMN pedidos_itens.produto_id IS 'id do produto';
COMMENT ON COLUMN pedidos_itens.numero_da_linha IS 'numero da linha dos items do pedido';
COMMENT ON COLUMN pedidos_itens.preco_unitario IS 'preço unitario do produto';
COMMENT ON COLUMN pedidos_itens.quantidade IS 'quantidade de produtos no pedido';
COMMENT ON COLUMN pedidos_itens.envio_id IS 'id do envio';

--criação das constraints de verificação
ALTER TABLE pedidos ADD CONSTRAINT verify_status_pedidos
CHECK (status IN ('CANCELADO', 'COMPLETO', 'ABERTO', 'PAGO', 'REEMBOLSADO', 'ENVIADO'));

ALTER TABLE envios ADD CONSTRAINT verify_status_envios
CHECK (status IN ('CRIADO', 'ENVIADO', 'TRANSITO', 'ENTREGUE'));

ALTER TABLE lojas
ADD CONSTRAINT verify_enderecos
CHECK ((endereco_fisico IS NOT NULL AND endereco_web IS NULL) OR
       (endereco_fisico IS NULL AND endereco_web IS NOT NULL));

--criação da constraints de foreign key
ALTER TABLE pedidos_itens ADD CONSTRAINT produtos_pedidos_itens_fk
FOREIGN KEY (produto_id)
REFERENCES Produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE Estoques ADD CONSTRAINT produtos_estoques_fk
FOREIGN KEY (produto_id)
REFERENCES Produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE Envios ADD CONSTRAINT lojas_envios_fk
FOREIGN KEY (loja_id)
REFERENCES Lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE Estoques ADD CONSTRAINT lojas_estoques_fk
FOREIGN KEY (loja_id)
REFERENCES Lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE Pedidos ADD CONSTRAINT lojas_pedidos_fk
FOREIGN KEY (loja_id)
REFERENCES Lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE Envios ADD CONSTRAINT clientes_envios_fk
FOREIGN KEY (cliente_id)
REFERENCES Clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE Pedidos ADD CONSTRAINT clientes_pedidos_fk
FOREIGN KEY (cliente_id)
REFERENCES Clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE pedidos_itens ADD CONSTRAINT pedidos_pedidos_itens_fk
FOREIGN KEY (pedido_id)
REFERENCES Pedidos (pedido_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE pedidos_itens ADD CONSTRAINT envios_pedidos_itens_fk
FOREIGN KEY (envio_id)
REFERENCES Envios (envio_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;