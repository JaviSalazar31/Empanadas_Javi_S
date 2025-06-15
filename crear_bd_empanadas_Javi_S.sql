-- Crear base de datos
DROP DATABASE IF EXISTS empanadas_Javi_S;
CREATE DATABASE IF NOT EXISTS empanadas_Javi_S;
USE empanadas_Javi_S;

-- 1. Clientes
DROP TABLE IF EXISTS Clientes;
CREATE TABLE Clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    telefono VARCHAR(20),
    direccion VARCHAR(200)
);

-- 2. Empleados
DROP TABLE IF EXISTS Empleados;
CREATE TABLE Empleados (
    id_empleado INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    puesto VARCHAR(50) NOT NULL
);

-- 3. Sabores
DROP TABLE IF EXISTS Sabores;
CREATE TABLE Sabores (
    id_sabor INT AUTO_INCREMENT PRIMARY KEY,
    descripcion VARCHAR(100) NOT NULL,
    tipo VARCHAR(50), -- Horno o Frita
    precio DECIMAL(8,2) NOT NULL
);

-- 4. Pedidos
DROP TABLE IF EXISTS Pedidos;
CREATE TABLE Pedidos (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    fecha DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    id_cliente INT,
    id_empleado INT,
    tipo_venta VARCHAR(50), -- Delivery o Mostrador
    FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente),
    FOREIGN KEY (id_empleado) REFERENCES Empleados(id_empleado)
);

-- 5. DetallePedidos (subtotal se calcula por vista, no en la tabla)
DROP TABLE IF EXISTS DetallePedidos;
CREATE TABLE DetallePedidos (
    id_detalle INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT,
    id_sabor INT,
    cantidad INT NOT NULL,
    FOREIGN KEY (id_pedido) REFERENCES Pedidos(id_pedido),
    FOREIGN KEY (id_sabor) REFERENCES Sabores(id_sabor)
);

-- 6. Ingredientes
DROP TABLE IF EXISTS Ingredientes;
CREATE TABLE Ingredientes (
    id_ingrediente INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    unidad VARCHAR(20)
);

-- 7. Recetas
DROP TABLE IF EXISTS Recetas;
CREATE TABLE Recetas (
    id_receta INT AUTO_INCREMENT PRIMARY KEY,
    id_sabor INT,
    id_ingrediente INT,
    cantidad_necesaria DECIMAL(8,2),
    FOREIGN KEY (id_sabor) REFERENCES Sabores(id_sabor),
    FOREIGN KEY (id_ingrediente) REFERENCES Ingredientes(id_ingrediente)
);

-- 8. Stock
DROP TABLE IF EXISTS Stock;
CREATE TABLE Stock (
    id_stock INT AUTO_INCREMENT PRIMARY KEY,
    id_ingrediente INT,
    cantidad_actual DECIMAL(10,2),
    FOREIGN KEY (id_ingrediente) REFERENCES Ingredientes(id_ingrediente)
);

-- Vista: detalle del pedido con subtotal calculado
DROP VIEW IF EXISTS VistaDetalleConSubtotal;
CREATE VIEW VistaDetalleConSubtotal AS
SELECT 
    d.id_detalle,
    d.id_pedido,
    d.id_sabor,
    s.descripcion AS sabor,
    d.cantidad,
    s.precio,
    (d.cantidad * s.precio) AS subtotal
FROM DetallePedidos d
JOIN Sabores s ON d.id_sabor = s.id_sabor;
