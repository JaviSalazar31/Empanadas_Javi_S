-- Vista: Pedidos Detallados
DROP VIEW IF EXISTS Vista_Pedidos_Detallados;
CREATE VIEW Vista_Pedidos_Detallados AS
SELECT p.id_pedido, c.nombre AS cliente, e.nombre AS empleado, p.tipo_venta, p.fecha, s.descripcion AS sabor, dp.cantidad
FROM Pedidos p
JOIN Clientes c ON p.id_cliente = c.id_cliente
JOIN Empleados e ON p.id_empleado = e.id_empleado
JOIN DetallePedidos dp ON p.id_pedido = dp.id_pedido
JOIN Sabores s ON dp.id_sabor = s.id_sabor;

-- Vista: Stock bajo
DROP VIEW IF EXISTS Vista_Stock_Bajo;
CREATE VIEW Vista_Stock_Bajo AS
SELECT i.nombre, s.cantidad_actual
FROM Stock s
JOIN Ingredientes i ON s.id_ingrediente = i.id_ingrediente
WHERE s.cantidad_actual < 1000;

-- Vista: Resumen de pedidos
DROP VIEW IF EXISTS Vista_Resumen_Pedidos;
CREATE VIEW Vista_Resumen_Pedidos AS
SELECT p.id_pedido, c.nombre AS cliente, COUNT(dp.id_sabor) AS cantidad_sabores, SUM(dp.cantidad * s.precio) AS total_estimado
FROM Pedidos p
JOIN Clientes c ON p.id_cliente = c.id_cliente
JOIN DetallePedidos dp ON p.id_pedido = dp.id_pedido
JOIN Sabores s ON dp.id_sabor = s.id_sabor
GROUP BY p.id_pedido;

DELIMITER //
DROP VIEW IF EXISTS ObtenerPrecioSabor;
CREATE FUNCTION ObtenerPrecioSabor(sabor_id INT) RETURNS DECIMAL(8,2)
DETERMINISTIC
BEGIN
    DECLARE resultado DECIMAL(8,2);
    SELECT precio INTO resultado FROM Sabores WHERE id_sabor = sabor_id;
    RETURN resultado;
END //
DELIMITER ;

DELIMITER //
DROP VIEW IF EXISTS CalcularSubtotal;
CREATE FUNCTION CalcularSubtotal(cant INT, precio DECIMAL(8,2)) RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    RETURN cant * precio;
END //
DELIMITER ;

DELIMITER //
DROP VIEW IF EXISTS ListarPedidosPorCliente;
CREATE PROCEDURE ListarPedidosPorCliente(IN cliente_id INT)
BEGIN
    SELECT p.id_pedido, p.fecha, s.descripcion, dp.cantidad
    FROM Pedidos p
    JOIN DetallePedidos dp ON p.id_pedido = dp.id_pedido
    JOIN Sabores s ON dp.id_sabor = s.id_sabor
    WHERE p.id_cliente = cliente_id;
END //
DELIMITER ;

DELIMITER //
DROP VIEW IF EXISTS ActualizarStock;
CREATE PROCEDURE ActualizarStock(
    IN ingrediente_id INT,
    IN nueva_cantidad DECIMAL(10,2)
)
BEGIN
    UPDATE Stock SET cantidad_actual = nueva_cantidad WHERE id_ingrediente = ingrediente_id;
END //
DELIMITER ;

-- Crear tabla de log para eventos
DROP VIEW IF EXISTS LogEventos;
CREATE TABLE IF NOT EXISTS LogEventos (
    id_log INT AUTO_INCREMENT PRIMARY KEY,
    evento TEXT,
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Trigger: registrar evento cuando se agrega un detalle de pedido
DELIMITER //
DROP TRIGGER IF EXISTS trigger_insert_detalle;
CREATE TRIGGER trigger_insert_detalle
AFTER INSERT ON DetallePedidos
FOR EACH ROW
BEGIN
    DECLARE sabor_nombre VARCHAR(100);
    SELECT descripcion INTO sabor_nombre FROM Sabores WHERE id_sabor = NEW.id_sabor;
    INSERT INTO LogEventos (evento) VALUES (CONCAT('Nuevo detalle agregado: ', sabor_nombre, ' x ', NEW.cantidad));
END //
DELIMITER ;

DELIMITER $$

USE `empanadas_javi_s`$$

DROP TRIGGER IF EXISTS `trigger_update_stock`$$

CREATE TRIGGER `trigger_update_stock`
AFTER UPDATE ON `stock`
FOR EACH ROW
BEGIN
    DECLARE nombre_ingrediente VARCHAR(100);
    SELECT nombre INTO nombre_ingrediente
    FROM ingredientes
    WHERE id_ingrediente = NEW.id_ingrediente;

    INSERT INTO logeventos (evento)
    VALUES (
        CONCAT('Stock actualizado para ', nombre_ingrediente,
               ': de ', OLD.cantidad_actual, ' a ', NEW.cantidad_actual)
    );
END$$

DELIMITER ;
