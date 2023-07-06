-- -- Crear la base de datos
-- CREATE DATABASE trabajoFinal;

-- Usar la base de datos
USE trabajoFinal;

-- Tabla de métodos de pago
CREATE TABLE metodos_pago (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  api_key VARCHAR(200) NOT NULL,
  api_secret VARCHAR(200) NOT NULL
);

-- Tabla de categorías de productos
CREATE TABLE categorias (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL
);

-- Tabla de productos
CREATE TABLE productos (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  descripcion TEXT,
  precio DECIMAL(10, 2) NOT NULL,
  stock INT NOT NULL,
  categoria_id INT,
  FOREIGN KEY (categoria_id) REFERENCES categorias(id)
);

-- Tabla de imágenes de productos
CREATE TABLE imagenes (
  id INT AUTO_INCREMENT PRIMARY KEY,
  producto_id INT NOT NULL,
  url VARCHAR(200) NOT NULL,
  FOREIGN KEY (producto_id) REFERENCES productos(id)
);

-- Tabla de clientes
CREATE TABLE clientes (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  email VARCHAR(100) NOT NULL,
  direccion VARCHAR(200) NOT NULL
);

-- Tabla de carritos de compra
CREATE TABLE carritos (
  id INT AUTO_INCREMENT PRIMARY KEY,
  cliente_id INT NOT NULL,
  producto_id INT NOT NULL,
  cantidad INT NOT NULL,
  FOREIGN KEY (cliente_id) REFERENCES clientes(id),
  FOREIGN KEY (producto_id) REFERENCES productos(id)
);

-- Tabla de valoraciones de productos
CREATE TABLE valoraciones (
  id INT AUTO_INCREMENT PRIMARY KEY,
  producto_id INT NOT NULL,
  cliente_id INT NOT NULL,
  puntuacion INT NOT NULL,
  comentario TEXT,
  fecha_valoracion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (producto_id) REFERENCES productos(id),
  FOREIGN KEY (cliente_id) REFERENCES clientes(id)
);

-- Tabla de promociones
CREATE TABLE promociones (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  descripcion TEXT,
  fecha_inicio DATE NOT NULL,
  fecha_fin DATE NOT NULL,
  descuento DECIMAL(10, 2) NOT NULL
);

-- Tabla de direcciones de envío
CREATE TABLE direcciones_envio (
  id INT AUTO_INCREMENT PRIMARY KEY,
  cliente_id INT NOT NULL,
  direccion VARCHAR(200) NOT NULL,
  ciudad VARCHAR(100) NOT NULL,
  codigo_postal VARCHAR(20) NOT NULL,
  pais VARCHAR(100) NOT NULL,
  FOREIGN KEY (cliente_id) REFERENCES clientes(id)
);

-- Tabla de pedidos
CREATE TABLE pedidos (
  id INT AUTO_INCREMENT PRIMARY KEY,
  cliente_id INT NOT NULL,
  fecha_pedido TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  direccion_entrega VARCHAR(200) NOT NULL,
  metodo_pago_id INT NOT NULL,
  estado VARCHAR(50) NOT NULL,
  FOREIGN KEY (cliente_id) REFERENCES clientes(id),
  FOREIGN KEY (metodo_pago_id) REFERENCES metodos_pago(id)
);

-- Tabla de detalles del pedido
CREATE TABLE detalles_pedido (
  id INT AUTO_INCREMENT PRIMARY KEY,
  pedido_id INT NOT NULL,
  producto_id INT NOT NULL,
  cantidad INT NOT NULL,
  precio_unitario DECIMAL(10, 2) NOT NULL,
  FOREIGN KEY (pedido_id) REFERENCES pedidos(id),
  FOREIGN KEY (producto_id) REFERENCES productos(id)
);