CREATE DATABASE PROYECTO_BASE_DATOS_EDIT1
GO

USE PROYECTO_BASE_DATOS_EDIT1
GO

SET DATEFORMAT DMY
GO

CREATE TABLE DISTRITOS
(ID_distrito CHAR(3) NOT NULL PRIMARY KEY,
nombre_distrito VARCHAR (40) NOT NULL)

CREATE TABLE TRABAJADOR
(DNI_trabajador CHAR (8) NOT NULL PRIMARY KEY,
nombres_tra VARCHAR (25) NOT NULL,
apellidos_tra VARCHAR (25) NOT NULL,
direccion_tra VARCHAR (60) NOT NULL,
edad int NOT NULL,
telefono_tra VARCHAR (12) NOT NULL,
email_tra VARCHAR (35) NOT NULL,
sueldo MONEY NOT NULL,
fecha_inicio_contrato DATE NOT NULL,
fecha_final_contrato DATE NOT NULL,
ID_distrito CHAR (3) NOT NULL REFERENCES DISTRITOS)

CREATE TABLE CLIENTE
(DNI_cliente CHAR (8) NOT NULL PRIMARY KEY,
nombres_cli VARCHAR (25) NOT NULL,
apellidos_cli VARCHAR (25) NOT NULL,
direccion_cli VARCHAR (60) NULL,
telefono_cli CHAR (9) NULL,
email_cli VARCHAR (35) NOT NULL,
ID_distrito CHAR (3) NOT NULL REFERENCES DISTRITOS)

CREATE TABLE ALMACEN
(cod_almacen CHAR (7) NOT NULL PRIMARY KEY,
ID_distrito CHAR (3) NOT NULL REFERENCES DISTRITOS,
direccion VARCHAR (60) NOT NULL,
area_m2 DECIMAL (8,2) NOT NULL,
cant_pisos INT NOT NULL)

CREATE TABLE ALMACENERO
(cod_almacenero CHAR (7) NOT NULL PRIMARY KEY,
cod_almacen CHAR (7) NOT NULL REFERENCES ALMACEN,
DNI_trabajador CHAR (8) NOT NULL REFERENCES TRABAJADOR)

CREATE TABLE TRANSPORTE
(placa VARCHAR (7) NOT NULL PRIMARY KEY,
capacidad_carga CHAR (5) NOT NULL,
modelo VARCHAR (12) NOT NULL,
dimencion_alt_m DECIMAL (2,2) NOT NULL,
dimencion_ancho_m DECIMAL (2,2) NOT NULL,
dimencion_largo_m DECIMAL (2,2) NOT NULL,
peso_vehiculo_kg DECIMAL (8,2) NOT NULL)

CREATE TABLE TRANSPORTISTA
(cod_transportista CHAR (7) NOT NULL PRIMARY KEY,
placa VARCHAR (7) NOT NULL REFERENCES TRANSPORTE,
DNI_trabajador CHAR (8) NOT NULL REFERENCES TRABAJADOR)

CREATE TABLE VENDEDOR
(cod_vendedor CHAR (7) NOT NULL PRIMARY KEY,
DNI_trabajador CHAR (8) NOT NULL REFERENCES TRABAJADOR)

CREATE TABLE VENTA
(num_venta CHAR (8) NOT NULL PRIMARY KEY,
fecha_emision DATE NOT NULL,
DNI_cliente CHAR (8) NOT NULL REFERENCES CLIENTE,
cod_vendedor CHAR (7) NOT NULL REFERENCES VENDEDOR,
estado_boleta VARCHAR (25) NOT NULL)

CREATE TABLE PRODUCTO
(ID_producto CHAR (8) NOT NULL PRIMARY KEY,
nom_producto VARCHAR (30) NOT NULL,
descripcion VARCHAR (60) NOT NULL,
precio_venta MONEY NOT NULL)

CREATE TABLE DETALLE_VENTA
(num_venta CHAR (8) NOT NULL REFERENCES VENTA,
ID_producto CHAR (8) NOT NULL REFERENCES PRODUCTO,
cantidad INT NOT NULL,
importe MONEY NOT NULL)

CREATE TABLE TARJETA_INVENTARIO
(num_tarjeta_inventario CHAR (7) NOT NULL PRIMARY KEY,
cod_almacenero CHAR (7) NOT NULL REFERENCES ALMACENERO,
cod_almacen CHAR (7) NOT NULL REFERENCES ALMACEN)

CREATE TABLE DETALLE_TARJETA_INVENTARIO
(num_tarjeta_inventario CHAR (7) NOT NULL REFERENCES TARJETA_INVENTARIO,
ID_producto CHAR (8) NOT NULL REFERENCES PRODUCTO,
fecha_oper DATE NOT NULL,
ingreso_prod INT NOT NULL,
salidas_prod INT  NOT NULL,
saldo  INT NOT NULL)

CREATE TABLE GUIA_REMISION
(num_guia_remision CHAR (8) NOT NULL PRIMARY KEY,
cod_transportista CHAR (7) NOT NULL REFERENCES TRANSPORTISTA,
DNI_cliente CHAR (8) NOT NULL REFERENCES CLIENTE,
fecha_emision DATE NOT NULL)

CREATE TABLE DETALLE_GUIA_REMISION
(num_guia_remision CHAR (8) NOT NULL REFERENCES GUIA_REMISION,
num_venta CHAR (8) NOT NULL REFERENCES VENTA,
cod_almacen CHAR (7) NOT NULL REFERENCES ALMACEN,
placa VARCHAR (7) NOT NULL REFERENCES TRANSPORTE,
descripsion VARCHAR (45) NOT NULL,
PRIMARY KEY (num_guia_remision, num_venta, cod_almacen, placa))

INSERT INTO DISTRITOS VALUES
(001, 'Ancón'),(002, 'Ate'),(003, 'Barranco'),(004, 'Carabayllo'),(005, 'Cercado de Lima'),
(006, 'Chaclacayo'),(007, 'Chorrillos'),(008, 'Cieneguilla'),(009, 'Comas'),(010, 'El Agustino'),
(011, 'Independencia'),(012, 'Jesús María'),(013, 'La Molina'),(014, 'La Victoria'),(015, 'Lince'),
(016, 'Los Olivos'),(017, 'Lurigancho'),(018, 'Lurín'),(019, 'Magdalena del Mar'),(020, 'Pueblo Libre'),
(021, 'Miraflores'),(022, 'Pachacámac'),(023, 'Pucusana'),(024, 'Puente Piedra'),(025, 'Punta Hermosa'),
(026, 'Punta Negra'),(027, 'Rímac'),(028, 'San Bartolo'),(029, 'San Borja'),(030, 'San Isidro'),
(031, 'San Juan de Lurigancho'),(032, 'San Juan de Miraflores'),(033, 'San Luis'),
(034, 'San Martín de Porres'),(035, 'San Miguel'),(036, 'Santa Anita'),(037, 'Santa María del Mar'),
(038, 'Santa Rosa'),(039, 'Santiago de Surco'),(040, 'Surquillo'),(041, 'Villa El Salvador'),
(042, 'Villa María del Triunfo');

INSERT INTO TRABAJADOR VALUES
('12345678', 'Carlos', 'Pérez Gómez', 'Av. La Molina 123', 21, '987654321', 'carlos.perez@example.com', 350.00, '15/01/2023', '15/01/2025', 013),
('23456789', 'María', 'López Sánchez', 'Calle Las Flores 456', 19, '998877665', 'maria.lopez@example.com', 420.00, '01/05/2022', '01/05/2025', 021),
('34567890', 'Luis', 'Martínez Ruiz', 'Jr. Puno 789', 25, '912345678', 'luis.martinez@example.com', 380.00, '20/03/2021', '20/03/2025', 005),
('45678901', 'Ana', 'García Torres', 'Av. Brasil 1590', 40, '923456789', 'ana.garcia@example.com', 310.00, '01/10/2022', '01/10/2024', 014),
('56789012', 'Jorge', 'Rodríguez Flores', 'Calle Alcázar 350', 25, '934567890', 'jorge.rodriguez@example.com', 400.00, '15/06/2023', '25/06/2024', 009),
('67890123', 'Elena', 'Hernández Díaz', 'Jr. Independencia 100', 28, '945678901', 'elena.hernandez@example.com', 360.00, '30/11/2021', '30/11/2025', 011),
('78901234', 'Fernando', 'Ramos Rivas', 'Av. Javier Prado 2200', 19, '956789012', 'fernando.ramos@example.com', 390.00, '01/07/2020', '01/07/2024', 016),
('89012345', 'Gabriela', 'Jiménez Castro', 'Calle San Martín 400', 23, '967890123', 'gabriela.jimenez@example.com', 370.00, '14/02/2022', '14/02/2025', 027),
('90123456', 'Raúl', 'Vargas Salazar', 'Av. Perú 505', 29, '978901234', 'raul.vargas@example.com', 430.00, '01/08/2023', '01/08/2024', 034),
('01234567', 'Patricia', 'Morales Romero', 'Jr. Ayacucho 760', 31, '989012345', 'patricia.morales@example.com', 410.00, '01/12/2021', '01/12/2024', 003),
('09315692', 'Pedro Juan', 'Ortega Perez', 'AV. Las Gorriones 420', 25, '959632788', 'pedritoperez@outlook.com', 850.00, '10/12/2022', '10/12/2025', 002);

INSERT INTO CLIENTE VALUES
('87654321', 'Andrea', 'Flores Medina', 'Av. Primavera 150', '987654321', 'andrea.flores@example.com', 039),
('76543210', 'Mario', 'González Pérez', 'Calle Los Olivos 200', '998877665', 'mario.gonzalez@example.com', 016),
('65432109', 'Carmen', 'Mendoza Ríos', 'Jr. San Carlos 300', '912345678', 'carmen.mendoza@example.com', 010),
('54321098', 'Diego', 'Ramírez Torres', 'Av. Angamos 1234', '923456789', 'diego.ramirez@example.com', 030),
('43210987', 'Lucía', 'Vega Flores', 'Calle Lima 500', '934567890', 'lucia.vega@example.com', 013),
('32109876', 'Ricardo', 'Núñez Castro', 'Jr. Belén 250', '945678901', 'ricardo.nunez@example.com', 005),
('21098765', 'Marta', 'Reyes León', 'Av. Sucre 890', '956789012', 'marta.reyes@example.com', 029),
('10987654', 'José', 'Castro Delgado', 'Calle Bolívar 150', '967890123', 'jose.castro@example.com', 012),
('09876543', 'Sofía', 'Paredes Ruiz', 'Jr. Libertad 400', '978901234', 'sofia.paredes@example.com', 014),
('98765432', 'Alberto', 'Ponce Jiménez', 'Av. Grau 600', '989012345', 'alberto.ponce@example.com', 001);

INSERT INTO ALMACEN VALUES
('ALM001', 016, 'Av. Universitaria 1234', 1500.00, 3),
('ALM002', 009, 'Jr. Tupac Amaru 567', 2000.50, 2),
('ALM003', 034, 'Av. 28 de Julio 890', 1836.56, 4),
('ALM004', 005, 'Calle Manco Capac 123', 2211.57, 2),
('ALM005', 027, 'Av. Pizarro 456', 1741.21, 2);

INSERT INTO ALMACENERO VALUES
('ALMCE01', 'ALM001', '12345678'),
('ALMCE02', 'ALM002', '23456789'),
('ALMCE03', 'ALM003', '34567890'),
('ALMCE04', 'ALM004', '45678901'),
('ALMCE05', 'ALM005', '56789012');

INSERT INTO TRANSPORTE VALUES
('ABC1234', '1800', 'Hino 300', 2.50, 2.00, 6.00, 3000),
('XYZ5678', '2000', 'Isuzu NKR', 2.70, 2.20, 6.50, 3000);

INSERT INTO TRANSPORTISTA VALUES
('TRANS01', 'ABC1234', '67890123'),
('TRANS02', 'XYZ5678', '78901234');

INSERT INTO VENDEDOR VALUES
('VEN001', '90123456'),
('VEN002', '01234567'),
('VEN003', '34567890');

INSERT INTO VENTA VALUES
('VNT00001', '01/01/2023', '87654321', 'VEN001', 'Emitida'),
('VNT00002', '02/01/2023', '76543210', 'VEN002', 'Emitida'),
('VNT00003', '03/01/2023', '65432109', 'VEN003', 'Emitida'),
('VNT00004', '04/01/2023', '54321098', 'VEN001', 'Emitida'),
('VNT00005', '05/01/2023', '43210987', 'VEN002', 'Emitida'),
('VNT00006', '06/01/2023', '32109876', 'VEN003', 'Emitida'),
('VNT00007', '07/01/2023', '21098765', 'VEN001', 'Emitida'),
('VNT00008', '08/01/2023', '10987654', 'VEN002', 'Emitida'),
('VNT00009', '09/01/2023', '09876543', 'VEN003', 'Emitida'),
('VNT00010', '10/01/2023', '98765432', 'VEN001', 'Emitida'),
('VNT00011', '11/01/2023', '87654321', 'VEN002', 'Emitida'),
('VNT00012', '12/01/2023', '76543210', 'VEN003', 'Emitida'),
('VNT00013', '13/01/2023', '65432109', 'VEN001', 'Emitida'),
('VNT00014', '14/01/2023', '54321098', 'VEN002', 'Emitida'),
('VNT00015', '15/01/2023', '43210987', 'VEN003', 'Emitida'),
('VNT00016', '16/01/2023', '32109876', 'VEN001', 'Emitida'),
('VNT00017', '17/01/2023', '21098765', 'VEN002', 'Emitida'),
('VNT00018', '18/01/2023', '10987654', 'VEN003', 'Emitida'),
('VNT00019', '19/01/2023', '09876543', 'VEN001', 'Emitida'),
('VNT00020', '20/01/2023', '98765432', 'VEN002', 'Pendiente');
 
 INSERT INTO PRODUCTO VALUES
('PROD0001', 'Smartphone', 'Teléfono inteligente con pantalla táctil', 1200.90),
('PROD0002', 'Tablet', 'Dispositivo portátil con pantalla táctil', 450.00),
('PROD0003', 'Laptop', 'Computadora portátil', 2100.00),
('PROD0004', 'Smartwatch', 'Reloj inteligente con funciones avanzadas', 350.00),
('PROD0005', 'Auriculares inalámbricos', 'Altavoz portátil con conectividad inalámbrica', 89.99),
('PROD0006', 'Auriculares con cable', 'Altavoz portátil con conectividad por cable', 89.99),
('PROD0007', 'Cámara de acción', 'Cámara resistente para capturar momentos extremos', 249.99),
('PROD0008', 'Drone', 'Dron con cámara para fotografía y videografía aérea', 699.99),
('PROD0009', 'XBOX', 'Sistema de entretenimiento para videojuegos', 2999.99),
('PROD0010', 'Impresora', 'Impresora con funciones de escaneo y copiado', 500.00),
('PROD0011', 'Monitor de computadora', 'Pantalla para visualización de contenido de computadora', 249.99),
('PROD0012', 'Teclado mecánico', 'Teclado con interruptores mecánicos', 99.99),
('PROD0013', 'Mouse inalámbrico', 'Ratón con conectividad inalámbrica ', 50.00),
('PROD0014', 'Tarjeta de memoria', 'Dispositivo de almacenamiento', 29.99),
('PROD0015', 'Batería externa', 'Batería portátil', 39.99),
('PROD0016', 'Adaptador de corriente USB-C', 'Cargador rápido para dispositivos', 60.00),
('PROD0017', 'Funda para portátil', 'Funda protectora para computadoras portátiles', 29.99),
('PROD0018', 'Teclado portátil', 'Teclado plegable conectable por Bluetooth', 159.99),
('PROD0019', 'Estuche para auriculares', 'Estuche compacto para guardar auriculares de forma segura', 19.99),
('PROD0020', 'Cable HDMI', 'Cable para transmitir audio y video de alta calidad', 32.00);

INSERT INTO DETALLE_VENTA VALUES
('VNT00001', 'PROD0001', 3, 3602.70),
('VNT00002', 'PROD0002', 2, 900.00),
('VNT00003', 'PROD0003', 5, 10500.00),
('VNT00004', 'PROD0004', 1, 350.00),
('VNT00005', 'PROD0005', 4, 599.96),
('VNT00006', 'PROD0006', 3, 269.97),
('VNT00007', 'PROD0007', 2, 499.98),
('VNT00008', 'PROD0008', 1, 699.99),
('VNT00009', 'PROD0009', 5, 14999.95),
('VNT00010', 'PROD0010', 3, 1500.00),
('VNT00011', 'PROD0011', 4, 999.96),
('VNT00012', 'PROD0012', 1, 99.99),
('VNT00013', 'PROD0013', 2, 100.00),
('VNT00014', 'PROD0014', 3, 89.97),
('VNT00015', 'PROD0015', 1, 39.99),
('VNT00016', 'PROD0016', 5, 300.00),
('VNT00017', 'PROD0017', 1, 29.99),
('VNT00018', 'PROD0018', 3, 479.97),
('VNT00019', 'PROD0019', 2, 39.98),
('VNT00020', 'PROD0020', 1, 32.00);

INSERT INTO TARJETA_INVENTARIO VALUES
('TARJ001', 'ALMCE01', 'ALM001'),
('TARJ002', 'ALMCE02', 'ALM002'),
('TARJ003', 'ALMCE03', 'ALM003'),
('TARJ004', 'ALMCE04', 'ALM004'),
('TARJ005', 'ALMCE05', 'ALM005');

INSERT INTO DETALLE_TARJETA_INVENTARIO VALUES
('TARJ001', 'PROD0001', '10/06/2024', 100, 20, 80),
('TARJ002', 'PROD0002', '10/06/2024', 50, 10, 40),
('TARJ003', 'PROD0003', '11/06/2024', 80, 30, 50),
('TARJ004', 'PROD0004', '11/06/2024', 30, 5, 25),
('TARJ005', 'PROD0005', '12/06/2024', 40, 15, 25);

INSERT INTO GUIA_REMISION VALUES
('GR000001', 'TRANS01', '09876543', '10/06/2024'),
('GR000002', 'TRANS02', '21098765', '11/06/2024'),
('GR000003', 'TRANS01', '43210987', '12/06/2024'),
('GR000004', 'TRANS01', '76543210', '13/06/2024'),
('GR000005', 'TRANS02', '98765432', '14/06/2024');

INSERT INTO DETALLE_GUIA_REMISION VALUES
('GR000001', 'VNT00009', 'ALM001', 'ABC1234', 'Descripción'),
('GR000002', 'VNT00007', 'ALM002', 'XYZ5678', 'Descripción'),
('GR000003', 'VNT00015', 'ALM003', 'ABC1234', 'Descripción'),
('GR000004', 'VNT00012', 'ALM004', 'ABC1234', 'Descripción'),
('GR000005', 'VNT00010', 'ALM005', 'XYZ5678', 'Descripción');

--Tablas
SELECT*FROM DISTRITOS;
SELECT*FROM TRABAJADOR;
SELECT*FROM CLIENTE;
SELECT*FROM ALMACEN;
SELECT*FROM ALMACENERO;
SELECT * FROM TRANSPORTE;
SELECT * FROM TRANSPORTISTA;
SELECT * FROM VENDEDOR;
SELECT * FROM VENTA;
SELECT * FROM PRODUCTO;
SELECT * FROM DETALLE_VENTA;
SELECT * FROM TARJETA_INVENTARIO;
SELECT * FROM DETALLE_TARJETA_INVENTARIO;
SELECT * FROM GUIA_REMISION;
SELECT * FROM DETALLE_GUIA_REMISION;

-- Restricciones 
-- 1. El stock de productos debe mantenerse en un mínimo de 1 unidad. No se permite un valor inferior.
 ALTER TABLE DETALLE_TARJETA_INVENTARIO
ADD CONSTRAINT CHK_MIN_STOCK_PRODUCTO CHECK (saldo >= 1);

-- 2. Si el stock de productos llega a la cantidad mínima de 5 unidades, se mostrará una advertencia sobre la falta de stock.
CREATE TRIGGER TRG_ADVERTENCIA_MIN_STOCK 
ON DETALLE_TARJETA_INVENTARIO
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS (SELECT * FROM inserted WHERE saldo = 5)
    BEGIN
        PRINT 'Advertencia: El stock de productos ha llegado a la cantidad mínima de 5 unidades.';
    END
END;
GO

-- 3. El precio de los productos no debe ser menor a 5
ALTER TABLE PRODUCTO
ADD CONSTRAINT CHK_PRECIO_MINIMO CHECK (precio_venta >= 5);
GO

-- 4. La edad mínima y máxima para ser un trabajador es 18 y 50 respectivamente.
ALTER TABLE TRABAJADOR
ADD CONSTRAINT CHK_EDAD_TRABAJADOR CHECK (EDAD >= 18 AND EDAD <= 50);
GO

-- 5. La numero máximo de pisos para un almacen es 5
ALTER TABLE AlMACEN
ADD CONSTRAINT CHK_PISOS_ALMACEN CHECK (cant_pisos <= 5);
GO

-- 6. El ID de los distritos deben ser únicos
ALTER TABLE DISTRITOS
ADD CONSTRAINT UNQ_ID_DISTRITO UNIQUE (id_distrito);
GO

-- 7. El stock de los productos debe ser mayor igual a 0
ALTER TABLE DETALLE_TARJETA_INVENTARIO
ADD CONSTRAINT CHK_MIN_STOCK_POSITIVE CHECK (saldo >= 0);
GO

-- 8. La cantidad de productos en una boleta debe ser mayor igual a 0
ALTER TABLE DETALLE_VENTA
ADD CONSTRAINT CHK_MIN_CANTIDAD_PRODUCTOS CHECK (cantidad >= 0);
GO

--------------------------------------------------------------------------------------------------------
-- 1. Verificar la restricción de stock mínimo de productos (CHK_MIN_STOCK_PRODUCTO)
SELECT * FROM DETALLE_TARJETA_INVENTARIO WHERE saldo < 1;

-- 2. No es necesario verificar, ya que esta restricción es manejada por un trigger que muestra una advertencia cuando el stock llega a 5 unidades.
-- :)

-- 3. Verificar la restricción de precio mínimo de productos (CHK_PRECIO_MINIMO)
SELECT * FROM PRODUCTO WHERE precio_venta < 5;

-- 4. Verificar edad mínima y máxima para ser un trabajador (CHK_EDAD_TRABAJADOR)
SELECT * FROM TRABAJADOR WHERE EDAD < 18 AND EDAD > 50; 

-- 5. Verificar numero máximo de pisos para un almacen.
SELECT * FROM ALMACEN WHERE cant_pisos > 5;

-- 6. Verificar la restricción de ID de distritos sea unica
SELECT id_distrito, COUNT(*) AS cantidad FROM DISTRITOS GROUP BY id_distrito HAVING COUNT(*) > 1;

-- 7. Verificar la restricción de stock positivo de productos (CHK_MIN_STOCK_POSITIVE)
SELECT * FROM DETALLE_TARJETA_INVENTARIO WHERE saldo < 0;

-- 8. Verificar la restricción de cantidad mínima de productos en una venta (CHK_MIN_CANTIDAD_PRODUCTOS)
SELECT * FROM DETALLE_VENTA WHERE cantidad < 0;

--------------------------------------------------------------------------------------------------------
--Procedimientos

-- 1. Crear un Pedido
CREATE OR ALTER PROCEDURE CrearPedido
    @ClienteID CHAR(8),
    @Productos XML
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @PedidoID CHAR(8);
    DECLARE @MaxID INT;
    
    SELECT @MaxID = ISNULL(MAX(CAST(SUBSTRING(num_venta, 4, 5) AS INT)), 0) FROM VENTA;
    SET @PedidoID = 'VNT' + RIGHT('00000' + CAST(@MaxID + 1 AS VARCHAR(5)), 5);

    INSERT INTO VENTA (num_venta, fecha_emision, DNI_cliente, cod_vendedor, estado_boleta)
    VALUES (@PedidoID, GETDATE(), @ClienteID, 'VEN001', 'Pendiente');

    INSERT INTO DETALLE_VENTA (num_venta, ID_producto, cantidad, importe)
    SELECT 
        @PedidoID,
        Productos.value('(ID_producto)[1]', 'CHAR(8)'),
        Productos.value('(Cantidad)[1]', 'INT'),
        Productos.value('(Cantidad)[1]', 'INT') * P.precio_venta
    FROM @Productos.nodes('/Productos/Producto') AS XmlData(Productos)
    INNER JOIN PRODUCTO P ON P.ID_producto = Productos.value('(ID_producto)[1]', 'CHAR(8)');

    SELECT @PedidoID AS PedidoID;
END
GO

-- 2. Generar Comprobante de Pago y Guía de Remisión
CREATE OR ALTER PROCEDURE GenerarComprobanteYGuia
    @PedidoID CHAR(8)
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @GuiaID CHAR(8);
    DECLARE @ClienteID CHAR(8);
    DECLARE @TransportistaID CHAR(7);
    DECLARE @MaxGuiaID INT;

    SELECT @ClienteID = DNI_cliente FROM VENTA WHERE num_venta = @PedidoID;
    SELECT TOP 1 @TransportistaID = cod_transportista FROM TRANSPORTISTA ORDER BY NEWID();
    SELECT @MaxGuiaID = ISNULL(MAX(CAST(SUBSTRING(num_guia_remision, 3, 6) AS INT)), 0) FROM GUIA_REMISION;
    SET @GuiaID = 'GR' + RIGHT('000000' + CAST(@MaxGuiaID + 1 AS VARCHAR(6)), 6);
    INSERT INTO GUIA_REMISION (num_guia_remision, cod_transportista, DNI_cliente, fecha_emision)
    VALUES (@GuiaID, @TransportistaID, @ClienteID, GETDATE());
    INSERT INTO DETALLE_GUIA_REMISION (num_guia_remision, num_venta, cod_almacen, placa, descripsion)
    SELECT 
        @GuiaID,
        @PedidoID,
        'ALM001', 
        T.placa,
        'Envío de productos del pedido ' + @PedidoID
    FROM TRANSPORTISTA TR
    INNER JOIN TRANSPORTE T ON TR.placa = T.placa
    WHERE TR.cod_transportista = @TransportistaID;
    UPDATE VENTA SET estado_boleta = 'Emitida' WHERE num_venta = @PedidoID;
    SELECT @PedidoID AS ComprobanteID, @GuiaID AS GuiaID;
END
GO

-- 3. Actualizar el Estado del Producto (Sin cambios)
CREATE OR ALTER PROCEDURE ActualizarEstadoProducto
    @PedidoID CHAR(8),
    @ProductoID CHAR(8),
    @Estado VARCHAR(25)
AS
BEGIN
    SET NOCOUNT ON;
    IF EXISTS (SELECT 1 FROM DETALLE_VENTA WHERE num_venta = @PedidoID AND ID_producto = @ProductoID)
    BEGIN
        UPDATE VENTA
        SET estado_boleta = @Estado
        WHERE num_venta = @PedidoID;
        SELECT 'Estado del producto actualizado correctamente' AS Resultado;
    END
    ELSE
    BEGIN
        SELECT 'El producto no existe en el pedido especificado' AS Resultado;
    END
END
GO
-------------------------------------------------------------
-- 1. Procedimiento de eliminar cliente
CREATE PROCEDURE EliminarCliente
    @DNI_cliente CHAR(8)
AS
BEGIN
    BEGIN TRY
        -- Verificar si el cliente tiene ventas asociadas
        IF EXISTS (SELECT 1 FROM VENTA WHERE DNI_cliente = @DNI_cliente)
        BEGIN
            RAISERROR ('El cliente tiene ventas asociadas y no puede ser eliminado.', 16, 1);
            RETURN;
        END
        
        -- Eliminar el cliente
        DELETE FROM CLIENTE WHERE DNI_cliente = @DNI_cliente;
    END TRY
    BEGIN CATCH
        -- Manejo de errores
        DECLARE @ErrorMessage NVARCHAR(4000);
        DECLARE @ErrorSeverity INT;
        DECLARE @ErrorState INT;

        SELECT 
            @ErrorMessage = ERROR_MESSAGE(),
            @ErrorSeverity = ERROR_SEVERITY(),
            @ErrorState = ERROR_STATE();

        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END;
GO
-- 2. Procedimiento de agregar producto

CREATE PROCEDURE AgregarProducto
    @ID_producto CHAR(8),
    @nom_producto VARCHAR(30),
    @descripcion VARCHAR(60),
    @precio_venta MONEY
AS
BEGIN
    BEGIN TRY
        -- Verificar si el producto ya existe
        IF EXISTS (SELECT 1 FROM PRODUCTO WHERE ID_producto = @ID_producto)
        BEGIN
            RAISERROR ('El producto ya existe en la base de datos.', 16, 1);
            RETURN;
        END
        
        -- Insertar el producto
        INSERT INTO PRODUCTO (ID_producto, nom_producto, descripcion, precio_venta)
        VALUES (@ID_producto, @nom_producto, @descripcion, @precio_venta);
    END TRY
    BEGIN CATCH
        -- Manejo de errores
        DECLARE @ErrorMessage NVARCHAR(4000);
        DECLARE @ErrorSeverity INT;
        DECLARE @ErrorState INT;

        SELECT 
            @ErrorMessage = ERROR_MESSAGE(),
            @ErrorSeverity = ERROR_SEVERITY(),
            @ErrorState = ERROR_STATE();

        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END;
GO

-- 3. Procedimiento de asignar transportista a una guia de remision
CREATE PROCEDURE AsignarTransportistaAGuiaRemision
    @num_guia_remision CHAR(8),
    @cod_transportista CHAR(7)
AS
BEGIN
    BEGIN TRY
        -- Verificar si la guía de remisión existe
        IF NOT EXISTS (SELECT 1 FROM GUIA_REMISION WHERE num_guia_remision = @num_guia_remision)
        BEGIN
            RAISERROR ('La guía de remisión no existe.', 16, 50005); -- Error del usuario definido
            RETURN;
        END

        -- Verificar si el transportista existe
        IF NOT EXISTS (SELECT 1 FROM TRANSPORTISTA WHERE cod_transportista = @cod_transportista)
        BEGIN
            RAISERROR ('El transportista no existe.', 16, 50006); -- Error del usuario definido
            RETURN;
        END
        
        -- Asignar el transportista a la guía de remisión
        UPDATE GUIA_REMISION
        SET cod_transportista = @cod_transportista
        WHERE num_guia_remision = @num_guia_remision;
    END TRY
    BEGIN CATCH
        -- Manejo de errores
        DECLARE @ErrorMessage NVARCHAR(4000);
        DECLARE @ErrorSeverity INT;
        DECLARE @ErrorState INT;

        SELECT 
            @ErrorMessage = ERROR_MESSAGE(),
            @ErrorSeverity = ERROR_SEVERITY(),
            @ErrorState = ERROR_STATE();

        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END;
GO
-----------------------------------------------------------------------------
--BACKUP

-- Backup completo
BACKUP DATABASE PROYECTO_BASE_DATOS_EDIT1
TO DISK = 'C:\Users\TuUsuario\Desktop\PROYECTO_BASE_DATOS_EDIT1.bak'
WITH FORMAT,
MEDIANAME = 'PROYECTO_BASE_DATOS_EDIT1_backup',
NAME = 'PROYECTO_BASE_DATOS_EDIT1_full_backup';

-- Backup diferencial
BACKUP DATABASE PROYECTO_BASE_DATOS_EDIT1 
TO DISK = 'C:\Users\TuUsuario\Desktop\PROYECTO_BASE_DATOS_EDIT1_diff.bak' 
WITH DIFFERENTIAL;

-----------------------------------------------------------------------------
--DICCIONARIO DE DATOS

CREATE PROCEDURE sp_GetDiccionarioDatos
AS
BEGIN
    SELECT 
        d.object_id,
        a.name [table], 
        b.name [column], 
        c.name [type], 
        CASE 
            WHEN c.name = 'numeric' OR  c.name = 'decimal' OR c.name = 'float'  THEN b.precision
            ELSE null
        END [Precision], 
        b.max_length, 
        CASE 
            WHEN b.is_nullable = 0 THEN 'NO'
            ELSE 'SI'
        END [Permite Nulls],
        CASE 
            WHEN b.is_identity = 0 THEN 'NO'
            ELSE 'SI'
        END [Es Autonumerico],	
        ep.value [Descripcion], 
        f.ForeignKey, 
        f.ReferenceTableName, 
        f.ReferenceColumnName
    FROM 
        sys.tables a   
    INNER JOIN 
        sys.columns b ON a.object_id= b.object_id 
    INNER JOIN 
        sys.systypes c ON b.system_type_id= c.xtype 
    INNER JOIN 
        sys.objects d ON a.object_id= d.object_id 
    LEFT JOIN 
        sys.extended_properties ep ON d.object_id = ep.major_id AND b.column_Id = ep.minor_id
    LEFT JOIN 
        (SELECT 
            f.name AS ForeignKey,
            OBJECT_NAME(f.parent_object_id) AS TableName,
            COL_NAME(fc.parent_object_id,fc.parent_column_id) AS ColumnName,
            OBJECT_NAME (f.referenced_object_id) AS ReferenceTableName,
            COL_NAME(fc.referenced_object_id,fc.referenced_column_id) AS ReferenceColumnName
        FROM 
            sys.foreign_keys AS f
        INNER JOIN 
            sys.foreign_key_columns AS fc ON f.OBJECT_ID = fc.constraint_object_id)  f 
    ON f.TableName = a.name AND f.ColumnName = b.name
    WHERE 
        a.name <> 'ysdiagrams' 
    ORDER BY 
        a.name, b.column_Id;
END;

--Ejecucion
EXEC sp_GetDiccionarioDatos;

-----------------------------------------------------------------------
--Procedimientos con transacciones explicitas

--1.Procedimiento para Actualizar el Precio de un Producto

CREATE PROCEDURE UpdateProductStock
    @ProductID VARCHAR(50),
    @Quantity INT
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        -- Verificar el stock actual
        DECLARE @CurrentStock INT;
        SELECT @CurrentStock = saldo FROM DETALLE_TARJETA_INVENTARIO WHERE ID_producto = @ProductID;

        -- Asegurarse de que el nuevo stock no sea menor que 0
        IF @CurrentStock + @Quantity < 0
        BEGIN
            RAISERROR('El stock de productos no puede ser menor a 0', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END;

        -- Actualizar el stock del producto
        UPDATE DETALLE_TARJETA_INVENTARIO
        SET saldo = saldo + @Quantity
        WHERE ID_producto = @ProductID;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT;
        SELECT @ErrorMessage = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState = ERROR_STATE();

        -- RAISEERROR con severidad 16 (Errores del usuario que pueden ser corregidos)
        IF @ErrorSeverity = 16
        BEGIN
            RAISERROR (@ErrorMessage, 16, 1);
        END
        -- RAISEERROR con severidad 11 (Errores de software)
        ELSE IF @ErrorSeverity = 11
        BEGIN
            RAISERROR (@ErrorMessage, 11, 1);
        END
        ELSE
        BEGIN
            RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
        END
    END CATCH
END;

--Seleccionar el ID_producto y la cantidad que se quiere sumar o restar de stock
EXEC UpdateProductStock @ProductID = 'PROD0002', @Quantity = 20;

--Visualiza el cambio
SELECT saldo
FROM DETALLE_TARJETA_INVENTARIO
WHERE ID_producto = 'PROD0002';

----------------------------------------------------------------------
--Procedimiento con Trigger
--1.Procedimiento para agregar un nuevo trabajador
CREATE TRIGGER trg_AddNewWorker
ON TRABAJADOR
INSTEAD OF INSERT
AS
BEGIN
    BEGIN TRY
        -- Verificar las restricciones de edad y stock mínimo
        IF (SELECT edad FROM inserted) < 18 OR (SELECT edad FROM inserted) > 50
        BEGIN
            THROW 51000, 'La edad del trabajador debe estar entre 18 y 50 años.', 1;
            RETURN;
        END

        -- Insertar el trabajador
        BEGIN TRANSACTION;
        INSERT INTO TRABAJADOR (DNI_trabajador, nombres_tra, apellidos_tra, direccion_tra, edad, telefono_tra, email_tra, sueldo, fecha_inicio_contrato, fecha_final_contrato, ID_distrito)
        SELECT i.DNI_trabajador, i.nombres_tra, i.apellidos_tra, i.direccion_tra, i.edad, i.telefono_tra, i.email_tra, i.sueldo, i.fecha_inicio_contrato, i.fecha_final_contrato, i.ID_distrito
        FROM inserted i;
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        -- Manejo de errores
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT;
        SELECT 
            @ErrorMessage = ERROR_MESSAGE(),
            @ErrorSeverity = ERROR_SEVERITY(),
            @ErrorState = ERROR_STATE();

        THROW; -- Re-lanzar el error capturado
    END CATCH
END;

--Insertar datos del nuevo trabajador
INSERT INTO TRABAJADOR (DNI_trabajador, nombres_tra, apellidos_tra, direccion_tra, edad, telefono_tra, email_tra, sueldo, fecha_inicio_contrato, fecha_final_contrato, ID_distrito)
VALUES ('12345278', 
		'Juancito', 
		'Pérez', 
		'Calle 123', 
		19, 
		'1234567890', 
		'juan.perez@example.com', 
		50000.00, 
		'2022-01-01', 
		'2025-01-01', 
		001);

--Verificar la creacion del nuevo trabajador
SELECT * FROM TRABAJADOR WHERE DNI_trabajador = '12345278';

-------------------------------------------------------------------
--Cursor

-- Definimos el procedimiento almacenado para generar la factura detallada
CREATE PROCEDURE GenerarFacturaDetallada
    @num_venta CHAR(8)
AS
BEGIN
    -- Declaración de variables para cliente y vendedor
    DECLARE 
        @DNI_cliente CHAR(8),
        @nombres_cli VARCHAR(25),
        @apellidos_cli VARCHAR(25),
        @direccion_cli VARCHAR(60),
        @telefono_cli CHAR(9),
        @email_cli VARCHAR(35),
        @nombre_distrito_cli VARCHAR(40),

        @cod_vendedor CHAR(7),
        @nombres_ven VARCHAR(25),
        @apellidos_ven VARCHAR(25),
        @direccion_ven VARCHAR(60),
        @telefono_ven VARCHAR(12),
        @email_ven VARCHAR(35),
        @nombre_distrito_ven VARCHAR(40),

        @ID_producto CHAR(8),
        @nom_producto VARCHAR(30),
        @descripcion VARCHAR(60),
        @cantidad INT,
        @importe MONEY

    -- Cursor para la información del cliente y vendedor
    DECLARE cliente_vendedor_cursor CURSOR FOR
    SELECT 
        c.DNI_cliente, c.nombres_cli, c.apellidos_cli, c.direccion_cli, c.telefono_cli, c.email_cli, d.nombre_distrito,
        v.cod_vendedor, t.nombres_tra, t.apellidos_tra, t.direccion_tra, t.telefono_tra, t.email_tra, d2.nombre_distrito
    FROM 
        VENTA v
        INNER JOIN CLIENTE c ON v.DNI_cliente = c.DNI_cliente
        INNER JOIN DISTRITOS d ON c.ID_distrito = d.ID_distrito
        INNER JOIN VENDEDOR ven ON v.cod_vendedor = ven.cod_vendedor
        INNER JOIN TRABAJADOR t ON ven.DNI_trabajador = t.DNI_trabajador
        INNER JOIN DISTRITOS d2 ON t.ID_distrito = d2.ID_distrito
    WHERE 
        v.num_venta = @num_venta

    -- Cursor para los detalles de la venta
    DECLARE detalle_venta_cursor CURSOR FOR
    SELECT 
        dv.ID_producto, p.nom_producto, p.descripcion, dv.cantidad, dv.importe
    FROM 
        DETALLE_VENTA dv
        INNER JOIN PRODUCTO p ON dv.ID_producto = p.ID_producto
    WHERE 
        dv.num_venta = @num_venta

    -- Abrimos y obtenemos datos del cursor cliente_vendedor_cursor
    OPEN cliente_vendedor_cursor
    FETCH NEXT FROM cliente_vendedor_cursor INTO 
        @DNI_cliente, @nombres_cli, @apellidos_cli, @direccion_cli, @telefono_cli, @email_cli, @nombre_distrito_cli,
        @cod_vendedor, @nombres_ven, @apellidos_ven, @direccion_ven, @telefono_ven, @email_ven, @nombre_distrito_ven

    IF @@FETCH_STATUS = 0
    BEGIN
        PRINT '----- Factura Detallada -----'
        PRINT 'Cliente: ' + @nombres_cli + ' ' + @apellidos_cli
        PRINT 'Dirección: ' + @direccion_cli + ', ' + @nombre_distrito_cli
        PRINT 'Teléfono: ' + @telefono_cli
        PRINT 'Email: ' + @email_cli
        PRINT '-----------------------------'
        PRINT 'Vendedor: ' + @nombres_ven + ' ' + @apellidos_ven
        PRINT 'Dirección: ' + @direccion_ven + ', ' + @nombre_distrito_ven
        PRINT 'Teléfono: ' + @telefono_ven
        PRINT 'Email: ' + @email_ven
        PRINT '-----------------------------'
        PRINT 'Productos:'
        PRINT 'ID Producto  |  Nombre  |  Descripción  |  Cantidad  |  Importe'

        -- Abrimos y obtenemos datos del cursor detalle_venta_cursor
        OPEN detalle_venta_cursor
        FETCH NEXT FROM detalle_venta_cursor INTO @ID_producto, @nom_producto, @descripcion, @cantidad, @importe

        WHILE @@FETCH_STATUS = 0
        BEGIN
            PRINT @ID_producto + ' | ' + @nom_producto + ' | ' + @descripcion + ' | ' + CAST(@cantidad AS VARCHAR) + ' | ' + CAST(@importe AS VARCHAR)
            FETCH NEXT FROM detalle_venta_cursor INTO @ID_producto, @nom_producto, @descripcion, @cantidad, @importe
        END

        -- Cerramos y liberamos el cursor detalle_venta_cursor
        CLOSE detalle_venta_cursor
        DEALLOCATE detalle_venta_cursor
    END

    -- Cerramos y liberamos el cursor cliente_vendedor_cursor
    CLOSE cliente_vendedor_cursor
    DEALLOCATE cliente_vendedor_cursor
END
GO

-- Ejemplo de uso
EXEC GenerarFacturaDetallada @num_venta = 'VNT00002';


--2.Cursor para Verificar Stock antes de Procesar Pedido

CREATE PROCEDURE VerificarStockAntesDePedido
AS
BEGIN
    DECLARE @ID_producto VARCHAR(10);
    DECLARE @cantidad_pedido INT;
    DECLARE @ultimo_num_venta CHAR(8);

    -- Obtener el último número de venta
    SELECT @ultimo_num_venta = MAX(num_venta)
    FROM VENTA;

    DECLARE stock_cursor CURSOR FOR
        SELECT ID_producto, cantidad
        FROM DETALLE_VENTA
        WHERE num_venta = @ultimo_num_venta;

    OPEN stock_cursor;
    FETCH NEXT FROM stock_cursor INTO @ID_producto, @cantidad_pedido;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        -- Verificar si el stock es suficiente
        DECLARE @stock_actual INT;
        SELECT @stock_actual = saldo
        FROM DETALLE_TARJETA_INVENTARIO
        WHERE ID_producto = @ID_producto;

        IF @stock_actual < @cantidad_pedido
        BEGIN
            -- Generar un error controlado
            DECLARE @mensaje_error NVARCHAR(100);
            SET @mensaje_error = 'Stock insuficiente para el producto ' + @ID_producto;
            RAISERROR (@mensaje_error, 16, 1);
        END

        FETCH NEXT FROM stock_cursor INTO @ID_producto, @cantidad_pedido;
    END

    CLOSE stock_cursor;
    DEALLOCATE stock_cursor;
END;

EXEC VerificarStockAntesDePedido;