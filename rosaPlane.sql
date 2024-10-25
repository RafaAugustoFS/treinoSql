CREATE DATABASE rosaplane;

USE rosaplane;

CREATE TABLE destinos(
	id_destino INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nome_destino VARCHAR(60),
    pais VARCHAR(30),
    descricao VARCHAR(100)
);
CREATE TABLE pacotes(
	id_pacote INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    id__destino INT,
    FOREIGN KEY (id__destino) REFERENCES destinos(id_destino),
    nome_pacote VARCHAR(30),
    preco DOUBLE,
    data_inicio DATE,
    data_termino DATE
);
CREATE TABLE clientes(
	id_cliente INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    nome_cliente VARCHAR(50),
    email VARCHAR(50),
    telefone VARCHAR(15),
    endereco VARCHAR(60)
);
CREATE TABLE reservas(
	id_reserva INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    id__cliente INT,
    id__pacote INT,
    FOREIGN KEY(id__cliente) REFERENCES clientes(id_cliente),
    FOREIGN KEY(id__pacote) REFERENCES pacotes(id_pacote),
    data_reserva DATE,
    numero_pessoas INT,
    status_reserva ENUM('CONFIRMADA', 'PENDENTE','CANCELADA')
);

INSERT INTO destinos(nome_destino, pais, descricao)
VALUES 
('Bahia', 'Brasil', 'Venha conhecer as praias do nordeste'),
('Belo Horizonte','Brasil', 'Venha conhecer um estádio histórico'),
('Buenos Aires','Argentina', 'Venha conhecer a neve');

INSERT INTO pacotes(id__destino, nome_pacote, preco, data_inicio, data_termino)
VALUES 
(1, 'Nordeste', 8000.00, '2024-10-30', '2024-11-05'),
(2, 'Minas', 4000.00, '2024-10-30', '2024-11-05'),
(3, 'Neve', 6000.00, '2024-10-30', '2024-11-05');

INSERT INTO clientes( nome_cliente, email, telefone, endereco)
VALUES 
('Rafael Augusto', 'rafa@gmail.com', '1155445566557', 'Taboão da Serra'),
('Ana Beatriz', 'bea@gmail.com', '1155445566557', 'Panorama'),
('Gaby Britto', 'gabao@gmail.com', '11554566557', 'Itatuba');

INSERT INTO reservas(id__cliente, id__pacote, data_reserva, numero_pessoas, status_reserva)
VALUES 
(1,3, '2024-10-25', 3, 'Confirmada'),
(3,2, '2024-10-25', 3, 'Pendente'),
(2,1, '2024-10-25', 3, 'Confirmada');

-- número de pessoas que viajaram conosco
CREATE VIEW visualizar_total_pessoas AS
SELECT SUM(numero_pessoas) AS qtdTotal FROM reservas;
SELECT * FROM visualizar_total_pessoas;

-- verificar o Nome do cliente e o email
CREATE VIEW clientes_email AS
SELECT clientes.id_cliente, clientes.nome_cliente, clientes.email FROM clientes;
SELECT * FROM clientes_email;

-- verificar o cliente e dados do seu pedido
CREATE VIEW cliente_pedido AS
SELECT clientes.nome_cliente, reservas.data_reserva, pacotes.nome_pacote, nome_destino FROM clientes
INNER JOIN reservas ON clientes.id_cliente = reservas.id__cliente
INNER JOIN pacotes ON pacotes.id_pacote = reservas.id__pacote
INNER JOIN destinos ON destinos.id_destino = pacotes.id__destino;
SELECT * FROM cliente_pedido;
