-- Clientes
INSERT INTO Clientes (nombre, telefono, direccion) VALUES ('Carlos Díaz', '341 678-1234', 'Av. Rivadavia 1234, Rosario');
INSERT INTO Clientes (nombre, telefono, direccion) VALUES ('Lucía Fernández', '11 3123-4567', 'Calle 9 de Julio 456, CABA');
INSERT INTO Clientes (nombre, telefono, direccion) VALUES ('Martín Pérez', '261 456-7890', 'Mendoza 789, Mendoza');

-- Empleados
INSERT INTO Empleados (nombre, puesto) VALUES ('Diego Gómez', 'Cajero');
INSERT INTO Empleados (nombre, puesto) VALUES ('Sofía Romero', 'Repartidor');

-- Sabores
INSERT INTO Sabores (descripcion, tipo, precio) VALUES ('Carne', 'Horno', 500.00);
INSERT INTO Sabores (descripcion, tipo, precio) VALUES ('Pollo', 'Frita', 480.00);
INSERT INTO Sabores (descripcion, tipo, precio) VALUES ('J&Q', 'Horno', 520.00);
INSERT INTO Sabores (descripcion, tipo, precio) VALUES ('Humita', 'Frita', 490.00);

-- Ingredientes
INSERT INTO Ingredientes (nombre, unidad) VALUES ('Carne picada', 'gr');
INSERT INTO Ingredientes (nombre, unidad) VALUES ('Pollo desmenuzado', 'gr');
INSERT INTO Ingredientes (nombre, unidad) VALUES ('Jamón', 'gr');
INSERT INTO Ingredientes (nombre, unidad) VALUES ('Queso', 'gr');
INSERT INTO Ingredientes (nombre, unidad) VALUES ('Choclo', 'gr');
INSERT INTO Ingredientes (nombre, unidad) VALUES ('Cebolla', 'gr');

-- Pedidos
INSERT INTO Pedidos (id_cliente, id_empleado, tipo_venta) VALUES (1, 1, 'Mostrador');
INSERT INTO Pedidos (id_cliente, id_empleado, tipo_venta) VALUES (2, 2, 'Delivery');
INSERT INTO Pedidos (id_cliente, id_empleado, tipo_venta) VALUES (3, 1, 'Mostrador');

-- DetallePedidos
INSERT INTO DetallePedidos (id_pedido, id_sabor, cantidad) VALUES (1, 1, 3);
INSERT INTO DetallePedidos (id_pedido, id_sabor, cantidad) VALUES (1, 2, 2);
INSERT INTO DetallePedidos (id_pedido, id_sabor, cantidad) VALUES (2, 3, 1);
INSERT INTO DetallePedidos (id_pedido, id_sabor, cantidad) VALUES (3, 4, 4);

-- Recetas
INSERT INTO Recetas (id_sabor, id_ingrediente, cantidad_necesaria) VALUES (1, 1, 100);
INSERT INTO Recetas (id_sabor, id_ingrediente, cantidad_necesaria) VALUES (1, 6, 30);
INSERT INTO Recetas (id_sabor, id_ingrediente, cantidad_necesaria) VALUES (2, 2, 100);
INSERT INTO Recetas (id_sabor, id_ingrediente, cantidad_necesaria) VALUES (2, 6, 25);
INSERT INTO Recetas (id_sabor, id_ingrediente, cantidad_necesaria) VALUES (3, 3, 50);
INSERT INTO Recetas (id_sabor, id_ingrediente, cantidad_necesaria) VALUES (3, 4, 50);
INSERT INTO Recetas (id_sabor, id_ingrediente, cantidad_necesaria) VALUES (4, 5, 80);
INSERT INTO Recetas (id_sabor, id_ingrediente, cantidad_necesaria) VALUES (4, 4, 20);

-- Stock
INSERT INTO Stock (id_ingrediente, cantidad_actual) VALUES (1, 5000);
INSERT INTO Stock (id_ingrediente, cantidad_actual) VALUES (2, 4000);
INSERT INTO Stock (id_ingrediente, cantidad_actual) VALUES (3, 2000);
INSERT INTO Stock (id_ingrediente, cantidad_actual) VALUES (4, 3000);
INSERT INTO Stock (id_ingrediente, cantidad_actual) VALUES (5, 2500);
INSERT INTO Stock (id_ingrediente, cantidad_actual) VALUES (6, 3500);
